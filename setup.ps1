function tf-init{
    terraform init
}

function tf-deploy {
    terraform plan
    terraform apply
}

function tf-clean {
    terraform destroy
}

