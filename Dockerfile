FROM gcr.io/google.com/cloudsdktool/cloud-sdk:latest
LABEL maintainer "Rajesh Gupta <rajesh.nitc@gmail.com>"

ARG TERRAFORM_VERSION=0.14.4

RUN set -xe && \
    apt-get update && \
    # install packages
    apt-get install -y unzip && \ 
    # install terraform
    curl -k https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_linux_amd64.zip && \
    unzip terraform_linux_amd64.zip && mv terraform /usr/local/bin/ && \
    rm -r terraform_linux_amd64.zip && \
    # update ca-certificates
    openssl s_client -showcerts -servername github.com -connect github.com:443 </dev/null 2>/dev/null | sed -n -e '/BEGIN\ CERTIFICATE/,/END\ CERTIFICATE/ p'  > github-com.pem && \
    cat github-com.pem | tee -a /etc/ssl/certs/ca-certificates.crt && \
    rm github-com.pem

# COPY entrypoint.sh /entrypoint.sh
# RUN chmod +x ./entrypoint.sh
# ENTRYPOINT ["./entrypoint.sh"]
