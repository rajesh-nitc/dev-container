FROM gcr.io/google.com/cloudsdktool/cloud-sdk:latest

ARG TERRAFORM_VERSION=0.14.4

RUN apt-get update && \
    # install packages
    apt-get install -y unzip && \ 
    # install terraform
    curl -k https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_linux_amd64.zip && \
    unzip terraform_linux_amd64.zip && mv terraform /usr/local/bin/ && \
    rm -r terraform_linux_amd64.zip && \
    # update ca-certificates
    openssl s_client -showcerts -servername github.com -connect github.com:443 </dev/null 2>/dev/null | sed -n -e '/BEGIN\ CERTIFICATE/,/END\ CERTIFICATE/ p'  > github-com.pem && \
    cat github-com.pem | tee -a /etc/ssl/certs/ca-certificates.crt

# docker run -d -v C:\Users\rajesh.gupta\Work\shared:/shared my-image bash
