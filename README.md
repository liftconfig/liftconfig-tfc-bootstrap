# AWS S3 static website - Bootstrap TFC & GitHub repositories

## Purpose

Bootstraps the Terraform Cloud (TFC) workspace/modules and GitHub respositories required for hosting a statically-generated website on AWS.

1. Provisions the TFC root workspace and GitHub repository used for provisioning the AWS services required to run the static website e.g. [liftconfig-tfc-root](https://github.com/liftconfig/liftconfig-tfc-root)
2. Provisions the TFC registry module and GitHub repository used for the terraform-aws-s3-website module. This module is used by the root workspace to deploy the majority of the AWS services e.g. [terraform-aws-s3-website](https://github.com/liftconfig/terraform-aws-s3-website)
3. Provisions the GitHub repository containing raw website files in markdown format. GitHub actions is run from this respository to build and deploy the website to production & test S3 buckets e.g. [liftconfig-website](https://github.com/liftconfig/liftconfig-website)

<br/>![website provisioning system](images/c4-container-website_prov_system.drawio.svg)

## Prerequisites

- TFC account with a configured Organization
- TFC project. The recommendation is to create a new project initially for this bootstrap workspace. The root workspace will then also be created under this project
- GitHub account with Terraform Cloud authorised as an [installed GitHub App](https://developer.hashicorp.com/terraform/cloud-docs/vcs/github-app)

## Input variables

| Input name                   | Type    | Description                                                                           |
|:-----------------------------|:--------|:--------------------------------------------------------------------------------------|
| `tfc_org`                    | string  | TFC organisation name                                                                 |
| `tfc_project`                | string  | TFC project name the root module will be created in                                   |
| `tfc_token`                  | string  | TFC API token. Created in TFC under "Account Settings > Tokens > Create an API Token" |
| `github_owner`               | string  | GitHub account                                                                        |
| `github_token`               | string  | GitHub API token. Created in GitHub under "Settings > Developer Settings > Personal access tokens > Fine-grained tokens". Needs access to administer repositories |
| `github_app_installation_id` | string  | GitHub App installation ID allowing TFC to access GitHub repos. Found in TFC under "Account Settings > Tokens > Create an API Token > Github App OAuth Token" after TFC has been authorised as an installed GitHub App (done by connecting to GitHub as a VSC provider during workspace creation) |
| `root_repo`                  | string  | Name of GitHub repo containing Terraform root workspace                               |
| `root_repo_description`      | string  | Repo description used in GitHub & TFC                                                 |
| `module_repo`                | string  | Name of GitHub repo containing Terraform child module                                 |
| `module_repo_description`    | string  | Repo description used in GitHub & TFC                                                 |
| `website_repo`               | string  | Name of GitHub repo containing static website files                                   |
| `website_repo_description`   | string  | Repo description used in GitHub                                                       |