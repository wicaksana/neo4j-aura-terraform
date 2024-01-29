terraform {
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

data "http" "create_aura_instance" {
  url                 = "https://api.neo4j.io/v1/instances"
  method              = "POST"
  request_headers     = {
                          "Authorization" = "Bearer ${jsondecode(data.http.aura_authentication.response_body).access_token}"
                          "Content-Type"  = "application/json"
                      }
  request_body        = jsonencode({
                          "version": var.aura_version,
                          "region": var.aura_region,
                          "memory": var.aura_memory,
                          "name": var.aura_name,
                          "type": var.aura_type,
                          "tenant_id": var.aura_tenant_id,
                          "cloud_provider": var.aura_cloud_provider
                        })
}