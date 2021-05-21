FROM hashicorp/terraform:0.15.4
RUN apk update && apk --no-cache add \
    zsh \
    curl
RUN curl \
    -L https://github.com/99designs/aws-vault/releases/download/v6.3.1/aws-vault-linux-amd64 \
    -o /usr/local/bin/aws-vault && \
    chmod +x /usr/local/bin/aws-vault
ENV AWS_VAULT_BACKEND file
WORKDIR /root/workdir
COPY modules modules
RUN mkdir -p /root/workdir/.terraform.d/plugin-cache
ENV TF_PLUGIN_CACHE_DIR /root/workdir/.terraform.d/plugin-cache
COPY docker/setup.tf.json setup.tf.json
RUN /bin/terraform init && \
    rm -f setup.tf.json
COPY docker/_zshrc /root/.zshrc
ENTRYPOINT ["/bin/terraform"]
