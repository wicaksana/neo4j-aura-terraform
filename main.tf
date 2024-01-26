terraform {
  required_version = ">= 0.12"
}

data "http" "aura_authentication" {
  url                 = "https://api.neo4j.io/oauth/token"
  method              = "POST"
  request_headers     = {
                          "Authorization" = "Basic ${base64encode(join(":", [var.client_id, var.client_secret]))}"
                          "Content-Type" = "application/x-www-form-urlencoded"
                        }
  request_body        = "grant_type=client_credentials"
}

data "http" "get_instances" {
  url                 = "https://api.neo4j.io/v1/instances"
  method              = "GET"
  request_headers     = {
                          "Authorization" = "Bearer ${jsondecode(data.http.aura_authentication.response_body).access_token}"
                      }
}