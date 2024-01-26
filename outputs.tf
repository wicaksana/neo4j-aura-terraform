output "existing_instances" {
    value = data.restapi_object.existing_instances.api_data
}

output "aura_token" {
    value = "${data.external.aura_authentication.result}"
}