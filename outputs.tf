output "new_instance_status" {
    value = data.http.create_aura_instance.response_body
}