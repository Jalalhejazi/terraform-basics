# Ref

- https://docs.microsoft.com/en-gb/learn/modules/provision-infrastructure-azure-pipelines/4-run-terraform-cloud-shell

CloudShell Bash flow:

```bash
#first time
scoop install terraform
terraform init

# on every change
terraform plan
terraform apply 

# on exit
terraform destroy 
```