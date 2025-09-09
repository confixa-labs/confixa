#!/usr/bin/env python3
"""
Google Marketplace Usage Reporter - Hourly Monitoring with Daily Consolidated Reporting
Runs every hour to check service health and reports daily usage when active
"""

import os
import json
import requests
import logging
import hashlib
import time
import uuid
from datetime import datetime, timezone, timedelta
from google.oauth2 import service_account
from google.auth.transport.requests import Request
from pathlib import Path

# Configure logging
logging.basicConfig(
    level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s"
)
logger = logging.getLogger(__name__)


class HourlyUsageReporter:
    def __init__(self):
        # Get entitlement data from environment
        self.entitlement_id = os.environ.get("ENTITLEMENT_ID")
        self.consumer_id = os.environ.get("CONSUMER_ID")
        self.plan_id = os.environ.get("PLAN_ID", "default")

        # Marketplace configuration
        self.project_id = os.environ.get("MARKETPLACE_PROJECT_ID")
        self.service_name = os.environ.get("MARKETPLACE_SERVICE_NAME")  # Full service name
        self.metric_name = os.environ.get("METRIC_NAME", "usage_time")  # Your metric name
        
        # Service account path - look in same directory as script
        script_dir = Path(__file__).parent
        self.service_account_path = os.environ.get(
            "GOOGLE_APPLICATION_CREDENTIALS", 
            str(script_dir / "service-account-key.json")
        )

        # Usage configuration
        self.usage_unit = os.environ.get("USAGE_UNIT", "cluster")

        # Generate cluster ID
        self.cluster_id = self.get_cluster_id()

        # API endpoint - using correct Service Control API
        self.usage_url = f"https://servicecontrol.googleapis.com/v1/services/{self.service_name}:report"

        # Validate configuration
        self.validate_config()

        logger.info(f"🚀 Hourly Usage Reporter initialized")
        logger.info(f"📋 Entitlement: {self.entitlement_id}")
        logger.info(f"📋 Consumer: {self.consumer_id}")
        logger.info(f"📋 Cluster: {self.cluster_id}")
        logger.info(f"📋 Service Name: {self.service_name}")
        logger.info(f"📋 Service Account: {self.service_account_path}")

    def validate_config(self):
        """Validate required configuration."""
        required_vars = [
            ("ENTITLEMENT_ID", self.entitlement_id),
            ("CONSUMER_ID", self.consumer_id),
            ("MARKETPLACE_PROJECT_ID", self.project_id),
            ("MARKETPLACE_SERVICE_NAME", self.service_name),
        ]

        missing = [name for name, value in required_vars if not value]
        if missing:
            raise ValueError(f"Missing required environment variables: {missing}")

        if not Path(self.service_account_path).exists():
            raise FileNotFoundError(
                f"Service account file not found: {self.service_account_path}"
            )

    def get_cluster_id(self):
        """Generate stable cluster ID."""
        # Method 1: From environment variable
        cluster_id = os.environ.get("CLUSTER_ID")
        if cluster_id:
            return cluster_id

        # Method 2: Try to get from Kubernetes
        try:
            import subprocess

            result = subprocess.run(
                [
                    "kubectl",
                    "get",
                    "namespace",
                    "kube-system",
                    "-o",
                    "jsonpath={.metadata.uid}",
                ],
                capture_output=True,
                text=True,
                timeout=10,
            )

            if result.returncode == 0 and result.stdout.strip():
                k8s_uid = result.stdout.strip()
                return f"k8s-{k8s_uid[:8]}"
        except Exception as e:
            logger.warning(f"Could not get Kubernetes cluster UID: {e}")

        # Method 3: Generate from consumer ID and hostname
        try:
            import socket

            hostname = socket.gethostname()
            cluster_hash = hashlib.md5(
                f"{self.consumer_id}-{hostname}".encode()
            ).hexdigest()[:8]
            return f"cluster-{cluster_hash}"
        except Exception:
            # Method 4: Fallback
            consumer_suffix = (
                self.consumer_id[-8:]
                if len(self.consumer_id) >= 8
                else self.consumer_id
            )
            return f"cluster-{consumer_suffix}"

    def get_access_token(self):
        """Get Google Cloud access token."""
        try:
            credentials = service_account.Credentials.from_service_account_file(
                self.service_account_path,
                scopes=["https://www.googleapis.com/auth/cloud-platform"],
            )
            request = Request()
            credentials.refresh(request)
            return credentials.token
        except Exception as e:
            logger.error(f"Failed to get access token: {e}")
            return None

    def is_service_active(self):
        """Check if the service is currently active and healthy."""
        try:
            # Method 1: Check running pods with your app label
            import subprocess

            result = subprocess.run(
                [
                    "kubectl",
                    "get",
                    "pods",
                    "-l",
                    "app=confixa",  # Your app label
                    "--all-namespaces",
                    "--field-selector=status.phase=Running",
                    "-o",
                    "json",
                ],
                capture_output=True,
                text=True,
                timeout=15,
            )

            if result.returncode == 0:
                pods_data = json.loads(result.stdout)
                running_pods = len(pods_data.get("items", []))
                
                if running_pods > 0:
                    logger.info(f"✅ Service is active - {running_pods} pods running")
                    return True
                else:
                    logger.info("❌ Service is inactive - no running pods found")
                    return False
            else:
                logger.warning("⚠️ Could not check pod status, assuming inactive")
                return False

        except Exception as e:
            logger.error(f"❌ Error checking service health: {e}")
            return False

    def calculate_daily_usage(self):
        """Calculate daily usage amount - always 1 unit per day for per-day SKU."""
        # For per-day billing: always report 1 unit per day regardless of hours active
        base_usage = 1

        # You can modify this logic if you have different plan tiers
        plan_usage = {
            "basic": 1,
            "standard": 1,
            "pro": 1,      # Still 1 unit per day, but different price tier
            "premium": 1,  # Still 1 unit per day, but different price tier  
            "enterprise": 1,
        }

        plan_type = (
            self.plan_id.lower().split("-")[0]
            if "-" in self.plan_id
            else self.plan_id.lower()
        )

        usage = plan_usage.get(plan_type, base_usage)
        
        logger.info(f"📊 Daily usage for {plan_type} plan: {usage} cluster-day")
        return usage

    def create_usage_report(self):
        """Create usage report payload for the current day (00:00:00Z to 23:59:59Z UTC)."""
        current_time = datetime.now(timezone.utc)
        
        # Report for the current day (full day coverage in UTC)
        report_date = current_time.date()
        start_time = datetime.combine(report_date, datetime.min.time(), timezone.utc)
        end_time = datetime.combine(report_date, datetime.max.time().replace(microsecond=999999), timezone.utc)
        
        # Calculate usage amount (always 1 for per-day SKU)
        usage_amount = self.calculate_daily_usage()

        # Generate operation ID with date (same ID for same day = deduplication)
        date_str = report_date.strftime('%Y-%m-%d')
        # Use cluster_id + date for consistent daily operation ID
        operation_id = f"{self.cluster_id}-{date_str}"

        # Create the correct payload structure for Google Service Control API
        payload = {
            "operations": [
                {
                    "operationId": operation_id,
                    "operationName": "Daily Usage Report",
                    "consumerId": self.consumer_id,  # This should be the USAGE_REPORTING_ID from Google
                    "startTime": start_time.strftime('%Y-%m-%dT%H:%M:%SZ'),  # Full day start in UTC
                    "endTime": end_time.strftime('%Y-%m-%dT%H:%M:%S.%fZ')[:-3] + 'Z',  # Full day end in UTC
                    "metricValueSets": [
                        {
                            "metricName": f"{self.service_name.split('.')[0]}/{self.metric_name}",
                            "metricValues": [
                                {
                                    "int64Value": str(usage_amount)
                                }
                            ]
                        }
                    ],
                    "userLabels": {
                        "cloudmarketplace.googleapis.com/resource_name": self.cluster_id,
                        "cloudmarketplace.googleapis.com/container_name": "confixa",
                        "environment": os.environ.get("ENVIRONMENT", "prod"),
                        "region": os.environ.get("REGION", "us-central1"),
                        "plan_id": self.plan_id,
                        "entitlement_id": self.entitlement_id
                    }
                }
            ]
        }

        logger.info(f"📊 Created daily usage report")
        logger.info(f"📋 Usage Amount: {usage_amount} cluster-day")
        logger.info(f"📋 Report Date: {date_str} (00:00:00Z - 23:59:59.999999Z UTC)")
        logger.info(f"📋 Operation ID: {operation_id}")
        logger.info(f"📋 Consumer ID: {self.consumer_id}")

        return payload

    def submit_usage_report(self, max_retries=3):
        """Submit usage report with retry logic."""
        access_token = self.get_access_token()
        if not access_token:
            logger.error("❌ Could not get access token")
            return False

        headers = {
            "Authorization": f"Bearer {access_token}",
            "Content-Type": "application/json",
        }

        payload = self.create_usage_report()

        current_hour = datetime.now().strftime("%H:%M")
        logger.info(f"🕐 Submitting daily report at {current_hour}")
        logger.info(f"📊 Reporting usage for cluster: {self.cluster_id}")
        logger.info(f"📤 API Endpoint: {self.usage_url}")

        # Retry with exponential backoff
        for attempt in range(max_retries):
            try:
                response = requests.post(
                    self.usage_url, headers=headers, json=payload, timeout=30
                )

                logger.info(f"📤 API Response: {response.status_code}")

                if response.status_code == 200:
                    try:
                        response_data = response.json()
                        
                        # Check for reportErrors in the response
                        report_errors = response_data.get("reportErrors", [])
                        
                        if not report_errors:
                            # Complete success
                            logger.info("✅ Usage report submitted successfully")
                            logger.info(f"📋 Service Config ID: {response_data.get('serviceConfigId', 'N/A')}")
                            return True
                        else:
                            # Partial success - some operations failed
                            logger.warning("⚠️ Partial success - some operations failed")
                            for error in report_errors:
                                operation_id = error.get("operationId", "unknown")
                                status = error.get("status", {})
                                error_code = status.get("code", "unknown")
                                error_message = status.get("message", "unknown error")
                                logger.error(f"❌ Operation {operation_id} failed: [{error_code}] {error_message}")
                            
                            # Consider partial success as failure for retry logic
                            return False
                            
                    except json.JSONDecodeError:
                        logger.warning("⚠️ Received HTTP 200 but couldn't parse JSON response")
                        logger.info(f"📋 Response text: {response.text}")
                        return True  # Assume success if we can't parse but got 200

                elif response.status_code == 400:
                    # Bad request - log details and don't retry
                    logger.error(f"❌ Bad request (400): {response.text}")
                    try:
                        error_data = response.json()
                        logger.error(
                            f"📋 Error details: {json.dumps(error_data, indent=2)}"
                        )
                    except:
                        pass
                    return False

                elif response.status_code in [429, 500, 502, 503, 504]:
                    # Retryable errors
                    wait_time = (2**attempt) + (attempt * 0.1)
                    logger.warning(
                        f"⚠️  Retryable error {response.status_code}, waiting {wait_time:.1f}s (attempt {attempt + 1}/{max_retries})"
                    )

                    try:
                        error_data = response.json()
                        logger.warning(
                            f"📋 Error details: {json.dumps(error_data, indent=2)}"
                        )
                    except:
                        logger.warning(f"📋 Error response: {response.text}")

                    if attempt < max_retries - 1:
                        time.sleep(wait_time)
                        continue

                else:
                    logger.error(f"❌ Non-retryable error: {response.status_code}")
                    logger.error(f"📋 Response: {response.text}")
                    return False

            except requests.exceptions.Timeout:
                logger.warning(
                    f"⏱️  Request timeout (attempt {attempt + 1}/{max_retries})"
                )
                if attempt < max_retries - 1:
                    time.sleep(2**attempt)
                    continue

            except Exception as e:
                logger.error(
                    f"❌ Exception during submission (attempt {attempt + 1}/{max_retries}): {e}"
                )
                if attempt < max_retries - 1:
                    time.sleep(2**attempt)
                    continue

        logger.error(f"❌ All retry attempts failed")
        return False

    def run(self):
        """Main entry point - check service health and submit daily usage report if active."""
        current_time = datetime.now()
        logger.info(f"🕐 Usage reporter started at {current_time.strftime('%Y-%m-%d %H:%M:%S UTC')}")
        
        # First, check if service is active
        if not self.is_service_active():
            logger.info("🚫 Service is inactive - skipping report submission (no billing)")
            logger.info("💡 This is correct behavior: inactive hours don't send reports to avoid cancelling charges")
            return True  # Exit successfully without sending report
        
        # Service is active - submit daily usage report
        logger.info("📊 Service is active - submitting daily usage report")
        success = self.submit_usage_report()

        if success:
            logger.info("🎉 Daily usage reporting completed successfully")
            logger.info("💰 Google will bill for 1 cluster-day (regardless of hours active today)")
        else:
            logger.error("💥 Daily usage reporting failed - billing may be interrupted")

        return success

    def status(self):
        """Get current status information."""
        current_time = datetime.now(timezone.utc)

        status_info = {
            "cluster_id": self.cluster_id,
            "entitlement_id": self.entitlement_id,
            "consumer_id": self.consumer_id,
            "plan_id": self.plan_id,
            "current_time": current_time.isoformat(),
            "current_date": current_time.strftime("%Y-%m-%d"),
            "current_hour": current_time.strftime("%H:%M"),
            "usage_amount": self.calculate_daily_usage(),
            "usage_unit": self.usage_unit,
            "usage_url": self.usage_url,
            "marketplace_project": self.project_id,
            "service_name": self.service_name,
            "metric_name": f"{self.service_name.split('.')[0] if self.service_name else 'unknown'}/{self.metric_name}",
            "service_account_path": self.service_account_path,
            "service_active": self.is_service_active()
        }

        return status_info


def main():
    """Main entry point."""
    try:
        reporter = HourlyUsageReporter()

        # Handle command line arguments
        import sys

        if len(sys.argv) > 1 and sys.argv[1] == "status":
            # Print status information
            status = reporter.status()
            print(json.dumps(status, indent=2))
            return
            
        elif len(sys.argv) > 1 and sys.argv[1] == "payload":
            # Show the actual request payload that would be sent
            payload = reporter.create_usage_report()
            print("Request payload that would be sent to Google:")
            print(json.dumps(payload, indent=2))
            return

        # Run the usage reporting
        success = reporter.run()

        if success:
            exit(0)
        else:
            exit(1)

    except Exception as e:
        logger.error(f"💥 Fatal error: {e}")
        import traceback

        logger.error(traceback.format_exc())
        exit(1)


if __name__ == "__main__":
    main()