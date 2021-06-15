terraform {
    backend "remote" {
        hostname = "app.terraform.io"
        organization = "KomalRathore"
        workspaces {
            prefix = "gh-actions-demo"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

module "aws_static_site" {
    source  = "dvargas92495/static-site/aws"
    version = "1.2.0"
    secret = "secret-key"   
}

provider "github" {
    owner = "komalrathore786"
}

resource "github_actions_secret" "deploy_aws_access_key" {
  repository       = "ReactApp"
  secret_name      = "DEPLOY_AWS_ACCESS_KEY_ID"
  plaintext_value  = module.aws_static_site.deploy-id     
}

resource "github_actions_secret" "deploy_aws_access_secret" {
  repository       = "ReactApp"
  secret_name      = "DEPLOY_AWS_SECRET_ACCESS_KEY"       
  plaintext_value  = module.aws_static_site.deploy-secret 
}
