variable "tfc_org" {
  type        = string
  description = "TFC organisation name"
}

variable "tfc_project" {
  type        = string
  description = "TFC project name the root module will be created in"
  default     = "Default Project"
}

variable "tfc_token" {
  type        = string
  description = "TFC API token"
}

variable "github_owner" {
  type        = string
  description = "GitHub account"
}

variable "github_token" {
  type        = string
  description = "GitHub API token"
}

variable "github_app_installation_id" {
  type        = string
  description = "GitHub App installation ID allowing TFC to access GitHub repos"
}
variable "root_repo" {
  type        = string
  description = "Name of GitHub repo containing terraform root workspace that provisions AWS resources for website"
}
variable "root_repo_description" {
  type        = string
  description = "Repo description used in GitHub & TFC"
}
variable "module_repo" {
  type        = string
  description = "Name of GitHub repo containing terraform child module that provisions AWS resources for website"
}
variable "module_repo_description" {
  type        = string
  description = "Repo description used in GitHub & TFC"
}
variable "website_repo" {
  type        = string
  description = "Name of GitHub repo containing static website files and action to build & deploy to S3"
}
variable "website_repo_description" {
  type        = string
  description = "Repo description used in GitHub"
}
