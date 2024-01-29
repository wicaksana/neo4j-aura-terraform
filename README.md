# neo4j-aura-terraform

WIP. Note that creating the instance via data block is not the correct approach because it is not maintained as a Terraform resource. Will fix it later.

## How

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
