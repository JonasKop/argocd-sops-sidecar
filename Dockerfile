FROM ubuntu:22.04@sha256:965fbcae990b0467ed5657caceaec165018ef44a4d2d46c7cdea80a9dff0d1ea

RUN apt-get update && \
    apt-get upgrade && \
    apt-get install -y wget tar && \
    wget -c https://github.com/FiloSottile/age/releases/download/v1.1.1/age-v1.1.1-linux-amd64.tar.gz -O - | tar -xz -C /tmp/ && \
    mv /tmp/age/age* /usr/local/bin/ && \
    wget https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux.amd64  && \
    chmod +x sops* && \
    mv sops* /usr/local/bin/sops && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN groupadd -r argocd && useradd --no-log-init -r -g argocd argocd
USER argocd

COPY ./sops-parser.sh /bin/sops-parser
