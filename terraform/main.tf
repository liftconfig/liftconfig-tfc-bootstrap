# --- GitHub repo & TFC workspace for website root module ---

data "tfe_project" "project" {
  organization = var.tfc_org
  name         = var.tfc_project
}

resource "github_repository" "root" {
  name                   = var.root_repo
  description            = var.root_repo_description
  auto_init              = true
  license_template       = "GPL-3.0"
  delete_branch_on_merge = true
  has_issues             = false
  has_projects           = false
  has_wiki               = false
  visibility             = "public"
  vulnerability_alerts   = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_protection" "root" {
  repository_id = github_repository.root.id
  pattern       = "main"

  required_pull_request_reviews {
    required_approving_review_count = 1
  }
}

resource "github_actions_repository_permissions" "root" {
  repository = github_repository.root.id
  enabled    = false
}

resource "tfe_workspace" "root" {
  name              = var.root_repo
  organization      = var.tfc_org
  project_id        = data.tfe_project.project.id
  description       = var.root_repo_description
  working_directory = "/terraform"

  vcs_repo {
    identifier                 = "${var.github_owner}/${github_repository.root.name}"
    github_app_installation_id = var.github_app_installation_id
  }

  lifecycle {
    prevent_destroy = true
  }
}


# --- GitHub repo & TFC registry module for website child module ---

resource "github_repository" "module" {
  name                   = var.module_repo
  description            = var.module_repo_description
  auto_init              = true
  license_template       = "GPL-3.0"
  delete_branch_on_merge = true
  has_issues             = false
  has_projects           = false
  has_wiki               = false
  visibility             = "public"
  vulnerability_alerts   = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_protection" "module" {
  repository_id = github_repository.module.id
  pattern       = "main"

  required_pull_request_reviews {
    required_approving_review_count = 1
  }
}

resource "github_actions_repository_permissions" "module" {
  repository = github_repository.module.id
  enabled    = false
}

resource "tfe_registry_module" "module" {
  organization = var.tfc_org

  vcs_repo {
    display_identifier         = "${var.github_owner}/${github_repository.module.name}"
    identifier                 = "${var.github_owner}/${github_repository.module.name}"
    github_app_installation_id = var.github_app_installation_id
    tags                       = true
  }

  lifecycle {
    prevent_destroy = true
  }
}


# --- GitHub repo for static website files that are built and uploaded to S3 using GitHub Actions ---

resource "github_repository" "website" {
  name                   = var.website_repo
  description            = var.website_repo_description
  auto_init              = true
  license_template       = "GPL-3.0"
  delete_branch_on_merge = true
  has_issues             = false
  has_projects           = false
  has_wiki               = false
  visibility             = "public"
  vulnerability_alerts   = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_protection" "website" {
  repository_id = github_repository.website.id
  pattern       = "main"

  required_pull_request_reviews {
    required_approving_review_count = 1
  }
}

resource "github_actions_repository_permissions" "website" {
  repository      = github_repository.website.id
  enabled         = true
  allowed_actions = "selected"
  allowed_actions_config {
    github_owned_allowed = true
    verified_allowed     = true
  }

  #Note: There is no argument/API call available for configuring "require approval for all outside collaborators" 
  #under the GH actions pull request settings. This must be set manually via the GUI after creation
}
