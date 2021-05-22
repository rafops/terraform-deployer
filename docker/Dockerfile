FROM hashicorp/terraform:0.15.4

# Install system dependencies
RUN apk update && apk --no-cache add \
    zsh

# Cache Terraform dependencies with specific version constraints
RUN mkdir -p /root/.terraform.d/plugin-cache
ENV TF_PLUGIN_CACHE_DIR /root/.terraform.d/plugin-cache
COPY docker/versions.tf.json versions.tf.json
RUN terraform init && rm -f versions.tf.json

# Copy ZSH configuration
COPY docker/_zshrc /root/.zshrc

WORKDIR /root/workdir
ENTRYPOINT ["/bin/terraform"]
