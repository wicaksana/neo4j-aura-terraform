# neo4j-aura-terraform

WIP.

## How

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

docker run --rm -it \
-e TF_VAR_client_id=$TF_VAR_client_id \
-e TF_VAR_client_secret=$TF_VAR_client_secret \
-w /tf -v $PWD:/tf \
hashicorp/terraform:1.7.1 \
init

docker run --rm -it \
-e TF_VAR_client_id=$TF_VAR_client_id \
-e TF_VAR_client_secret=$TF_VAR_client_secret \
-w /tf -v $PWD:/tf \
hashicorp/terraform:1.7.1 \
plan

docker run --rm -it \
-e TF_VAR_client_id=$TF_VAR_client_id \
-e TF_VAR_client_secret=$TF_VAR_client_secret \
-w /tf -v $PWD:/tf \
hashicorp/terraform:1.7.1 \
apply
```