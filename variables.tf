variable "aura_version" {
    type    = string
    description = "Neo4j Aura version"
    default = "5"
    nullable = false
    
    validation {
        condition = contains(
            ["5"],
            var.aura_version
        )
        error_message = "Invalid Aura version."
    }
}

variable "aura_cloud_provider" {
    type = string
    description = "Choose the cloud provider (options: gcp,aws,azure)"
    nullable = false

    validation {
        condition = contains(
            ["gcp", "aws", "azure"],
            var.aura_cloud_provider
        )
        error_message = "Invalid cloud provider (options: gcp,aws,azure)."
    }
}

# TODO validation
variable "aura_region" {
    type = string
    description = "The region where the instance is hosted. Please refer to your Aura Tenants instance configurations, returned by the GET /tenants/{tenantId} endpoint, for a list of valid regions for your tenant"
    nullable = false
}

# TODO validation 
variable "aura_memory" {
    type = string
    description = "The size of the instance memory in GB. Please refer to your Aura Tenants instance configurations, returned by the GET /tenants/{tenantId} endpoint, for a list of valid sizes for your tenant"
    nullable = false
}

# TODO validation
variable "aura_name" {
    type = string
    description = "Aura instance name"
    nullable = false
}

variable "aura_type" {
    type = string
    description = "Aura type"
    nullable = false

    validation {
        condition = contains(
            [
                "free-db",
                "enterprise-db", 
                "enterprise-ds",
                "professional-db",
                "professional-ds"
            ],
            var.aura_type
        )
        error_message = "Invalid Aura type."
    }
}

# TODO validation
variable "aura_tenant_id" {
    type = string
    description = "Neo4j Aura tenant ID"
    nullable = false
}

variable client_id {}

variable client_secret {
    sensitive = true
}