terraform {
    required_providers {
      restapi = {
        source = "mastercard/restapi"
        version = "1.18.2"
      }
    }
    required_version = ">= 0.12"
}

data "external" "aura_authentication" {
    program = ["sh", "${path.module}/aura_authentication.sh"]
    query = {
        client_id = var.client_id
        client_secret = var.client_secret
    }
}

provider "restapi" {
    # alias                   = "restapi_headers"
    uri                     = "https://api.neo4j.io/"
    write_returns_object    = true
    debug                   = true

    headers = {
        "Authorization" = "Bearer ${data.external.aura_authentication.result.access_token}"
    }
}

data "restapi_object" "existing_instances" {
  path = "/v1/instances"
  results_key = "data"
  search_key = "cloud_provider"
  search_value = "gcp"
}
