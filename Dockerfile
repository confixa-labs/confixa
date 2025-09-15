# # -------- Stage 1: Prepare chart and schema --------
#   ARG MARKETPLACE_TOOLS_TAG=0.12.6
#   FROM marketplace.gcr.io/google/c2d-debian11 AS build

#   ARG CHART_NAME=Confixa
#   ARG REGISTRY
#   ARG TAG

#   RUN apt-get update && apt-get install -y --no-install-recommends gettext

#   # Copy chart into the expected layout
#   COPY charts/helm /tmp/${CHART_NAME}

#   COPY metadata.json /data/metadata.json

#   # Copy schema.yaml
#   COPY schema.yaml /tmp/schema.yaml

#   # Package chart (preserves top-level directory name)
#   RUN cd /tmp && tar -czvf /tmp/${CHART_NAME}.tgz ${CHART_NAME}

#   # Substitute REGISTRY and TAG into schema.yaml
#   RUN envsubst < /tmp/schema.yaml > /tmp/schema.yaml.new \
#   && mv /tmp/schema.yaml.new /tmp/schema.yaml

#   # -------- Stage 2: Deployer image --------
#   FROM gcr.io/cloud-marketplace-tools/k8s/deployer_helm:${MARKETPLACE_TOOLS_TAG}

#   ARG CHART_NAME=Confixa

#   COPY --from=build /tmp/${CHART_NAME}.tgz /data/chart/
#   COPY --from=build /tmp/schema.yaml /data/
#   # FIX: Copy metadata.json from build stage
#   COPY --from=build /data/metadata.json /data/

#   # Create the values directory that the deployer expects
#   RUN mkdir -p /data/values

#   # -------- FIX: Override the problematic print_config.py script --------
#   COPY fixed_print_config.py /bin/print_config.py
#   RUN chmod +x /bin/print_config.py

#   ENV WAIT_FOR_READY_TIMEOUT=1800
#   ENV TESTER_TIMEOUT=1800

#   # Add label to track the fix
#   LABEL version="fixed-broken-pipe" \
#     description="Fixed BrokenPipeError in print_config.py"

# -------- Stage 1: Prepare chart and schema --------
ARG MARKETPLACE_TOOLS_TAG=0.12.6
FROM marketplace.gcr.io/google/c2d-debian11 AS build

ARG CHART_NAME=confixa
ARG REGISTRY
ARG TAG

RUN apt-get update && apt-get install -y --no-install-recommends gettext

# Copy chart into the expected layout
COPY charts/helm /tmp/${CHART_NAME}

# Copy metadata.json to build stage
COPY metadata.json /tmp/metadata.json

# Copy schema.yaml
COPY schema.yaml /tmp/schema.yaml

# Package chart (preserves top-level directory name)
RUN cd /tmp && tar -czvf /tmp/${CHART_NAME}.tgz ${CHART_NAME}

# Substitute REGISTRY and TAG into schema.yaml
RUN envsubst < /tmp/schema.yaml > /tmp/schema.yaml.new \
&& mv /tmp/schema.yaml.new /tmp/schema.yaml

# -------- Stage 2: Deployer image --------
FROM gcr.io/cloud-marketplace-tools/k8s/deployer_helm:${MARKETPLACE_TOOLS_TAG}

ARG CHART_NAME=confixa

# Copy all required files to /data/
COPY --from=build /tmp/${CHART_NAME}.tgz /data/chart/
COPY --from=build /tmp/schema.yaml /data/
COPY --from=build /tmp/metadata.json /data/

# Create required directories
RUN mkdir -p /data/values

# -------- FIX: Override the problematic print_config.py script --------
COPY fixed_print_config.py /bin/print_config.py
RUN chmod +x /bin/print_config.py

# Set required environment variables for marketplace deployer
ENV WAIT_FOR_READY_TIMEOUT=1800
ENV TESTER_TIMEOUT=1800

# Add required labels
LABEL com.googleapis.cloudmarketplace.product.service.name="services/confixa-new.endpoints.confixa-public.cloud.goog"
LABEL com.googleapis.cloudmarketplace.product.version="1.2.0"
