terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.2.0"
    }

    tfe = {
      source = "hashicorp/tfe"
    }
  }

  required_version = "~> 1.7.0"
}

provider "github" {
  token = var.github_token
  owner = var.github_owner
}

provider "tfe" {
  token = var.tfc_token
}