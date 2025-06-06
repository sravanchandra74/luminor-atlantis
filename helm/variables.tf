variable "github_user" { description = "GitHub user" }

variable "github_token" { 
    description = "GitHub token"
    sensitive = true 
}

variable "webhook_secret" { 
    description = "Webhook secret"
    sensitive = true 
}

variable "org_whitelist" { 
    description = "Allowed orgs"
    type = list(string) 
}

variable "repo_whitelist" { 
    description = "Allowed repos"
    type = list(string) 
}

variable "aws_region" {
  default = "eu-north-1"
}