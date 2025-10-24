# -------- Stage 1: Prepare chart and schema --------
ARG MARKETPLACE_TOOLS_TAG=0.12.6
FROM marketplace.gcr.io/google/c2d-debian11 AS build

ARG CHART_NAME=confixa
ARG REGISTRY
ARG TAG

RUN apt-get update && apt-get install -y --no-install-recommends gettext

# Copy chart as 'chart' directory without confixa wrapper
COPY charts/helm /tmp/chart

# Copy other files
COPY metadata.json /tmp/metadata.json
COPY schema.yaml /tmp/schema.yaml

# Package just the 'chart' directory, not wrapped in confixa/
RUN cd /tmp && tar -czvf /tmp/${CHART_NAME}.tar.gz chart

# Substitute REGISTRY and TAG into schema.yaml
RUN envsubst < /tmp/schema.yaml > /tmp/schema.yaml.new \
&& mv /tmp/schema.yaml.new /tmp/schema.yaml

# -------- Stage 2: Deployer image --------
FROM gcr.io/cloud-marketplace-tools/k8s/deployer_helm:${MARKETPLACE_TOOLS_TAG}

ARG CHART_NAME=confixa

COPY --from=build /tmp/${CHART_NAME}.tar.gz /data/chart/
COPY --from=build /tmp/schema.yaml /data/
COPY --from=build /tmp/metadata.json /data/

RUN mkdir -p /data/values

# Copy fixed scripts
COPY fixed_print_config.py /bin/print_config.py
RUN chmod +x /bin/print_config.py

COPY install_app_crd.py /bin/install_app_crd.py
RUN chmod +x /bin/install_app_crd.py

# CRITICAL FIX: Add preprocessing script for marketplace compatibility
COPY preprocess_values.sh /bin/preprocess_values.sh
RUN chmod +x /bin/preprocess_values.sh

# Add wrapper script that runs preprocessing before deployment
COPY deploy_wrapper.sh /bin/deploy_wrapper.sh
RUN chmod +x /bin/deploy_wrapper.sh

# Environment variables
ENV WAIT_FOR_READY_TIMEOUT=1800
ENV TESTER_TIMEOUT=1800

# Required marketplace labels
LABEL com.googleapis.cloudmarketplace.product.service.name="services/confixa-new.endpoints.confixa-public.cloud.goog"
LABEL com.googleapis.cloudmarketplace.product.version="1.2.2"

# Override entrypoint to use our wrapper
ENTRYPOINT ["/bin/deploy_wrapper.sh"]
