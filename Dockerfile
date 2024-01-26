FROM hashicorp/terraform:1.7.1

RUN apk add --no-cache curl jq

ENTRYPOINT ["/bin/terraform"]

