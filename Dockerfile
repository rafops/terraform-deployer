FROM hashicorp/terraform:0.15.4
COPY modules /root/workdir/modules
WORKDIR /root/workdir
RUN /bin/terraform -chdir=modules/setup init
ENTRYPOINT ["/bin/terraform"]
