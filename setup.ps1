function tf-init{
    terraform init
}

function tf-plan {
    terraform plan
    <#
    No changes. Infrastructure is up-to-date.

    This means that Terraform did not detect any differences between your
    configuration and real physical resources that exist. As a result, no
    actions need to be performed.
    #>
}

function tf-deploy {
    terraform apply
    
    $DeploymentProperties = terraform output -json | ConvertFrom-Json
    $DeploymentProperties.website_hostname.value
}

function tf-clean {
    terraform destroy
}

