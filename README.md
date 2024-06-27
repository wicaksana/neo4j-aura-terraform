# neo4j-aura-terraform

This is a Terraform project to manage Neo4j Aura instance lifecycle (supported: create and delete the instance).
Limitation: currently only supports GCP. AWS & Azure will come later.

## How

### Create an Instance

You need to generate the client id and client secret from Neo4j Aura console. Please refer to this [doc](https://neo4j.com/docs/aura/platform/api/authentication/).

Using Terraform on the machine:

```bash 
export TF_VAR_client_id=<client-id>
export TF_VAR_client_secret=<client-secret>
terraform init
terraform plan
terraform apply
```

Using Terraform on a container:

```bash
export TF_VAR_client_id=<client-id>
export TF_VAR_client_secret=<client-secret>

# Initialize Terraform
docker run --rm -it \
-e TF_VAR_client_id=$TF_VAR_client_id \
-e TF_VAR_client_secret=$TF_VAR_client_secret \
-w /tf -v $PWD:/tf \
hashicorp/terraform:1.7.1 \
init

# Create Terraform plan, if you want.
docker run --rm -it \
-e TF_VAR_client_id=$TF_VAR_client_id \
-e TF_VAR_client_secret=$TF_VAR_client_secret \
-w /tf -v $PWD:/tf \
hashicorp/terraform:1.7.1 \
plan

# Create the Aura instance.
docker run --rm -it \
-e TF_VAR_client_id=$TF_VAR_client_id \
-e TF_VAR_client_secret=$TF_VAR_client_secret \
-w /tf -v $PWD:/tf \
hashicorp/terraform:1.7.1 \
apply

```

### Delete the instance

Using local terraform:
```
terraform destroy -input=false
```

Using Docker:
```
docker run --rm -it \
-e TF_VAR_client_id=$TF_VAR_client_id \
-e TF_VAR_client_secret=$TF_VAR_client_secret \
-w /tf -v $PWD:/tf \
hashicorp/terraform:1.7.1 \
destroy -input=false
```

Before destroying the instance resource, Terraform will be asking 
the same variables again (cloud provider, instance memory, etc.). 
This is [a known issue](https://github.com/hashicorp/terraform/issues/23552).