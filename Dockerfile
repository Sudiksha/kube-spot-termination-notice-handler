FROM python:3-alpine

ARG KUBE_VERSION=1.12.0
ENV HOME=/srv
WORKDIR /srv

RUN apk -v --update add --no-cache \
      curl ca-certificates \
      && \
    pip install awscli

RUN curl -f -s -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    kubectl version --client

# Copy entrypoint.sh
COPY entrypoint.sh .

# Set permissions on the file.
RUN chmod +x entrypoint.sh


CMD ["/srv/entrypoint.sh"]
