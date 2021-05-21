FROM hashicorp/terraform:0.15.4
WORKDIR /root/workdir
COPY modules modules
RUN mkdir -p /root/workdir/.terraform.d/plugin-cache
ENV TF_PLUGIN_CACHE_DIR /root/workdir/.terraform.d/plugin-cache
COPY docker/setup.tf.json setup.tf.json
RUN /bin/terraform init
RUN rm -f setup.tf.json
ENTRYPOINT ["/bin/terraform"]
