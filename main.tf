terraform {
  required_providers {
    restapi = {
      source = "mastercard/restapi"
      version = "1.18.2"
    }
  }
  required_version = ">= 0.12"
}

data "http" "aura_authentication" {
  url                 = "https://api.neo4j.io/oauth/token"
  method              = "POST"
  request_headers     = {
                          "Authorization" = "Basic ${base64encode(join(":", [var.client_id, var.client_secret]))}"
                          "Content-Type"  = "application/x-www-form-urlencoded"
                        }
  request_body        = "grant_type=client_credentials"
}

provider "restapi" {
  alias = "aura_restapi"
  uri = "https://api.neo4j.io/"
  write_returns_object = true
  debug = true 

  headers = {
    "Authorization" = "Bearer ${jsondecode(data.http.aura_authentication.response_body).access_token}"
    "Content-Type"  = "application/json"
  }
}

resource "restapi_object" "aura_instance" {
  provider = restapi.aura_restapi
  path = "/v1/instances"
  id_attribute = "data/id"
  create_method = "POST"
  destroy_method = "DELETE"
  destroy_path = "/v1/instances/{id}"
  data = jsonencode({
            "version": var.aura_version,
            "region": var.aura_region,
            "memory": var.aura_memory,
            "name": var.aura_name,
            "type": var.aura_type,
            "tenant_id": var.aura_tenant_id,
            "cloud_provider": var.aura_cloud_provider
          })
}