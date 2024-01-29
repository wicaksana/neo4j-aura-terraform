# output "new_instance_status" {
#     value = data.http.create_aura_instance.response_body
# }

output "new_instance_status" {
    value = jsondecode(restapi_object.aura_instance.api_response)
}