terraform {
  backend "local" {
    path = "terraform.tfstate"
  }

  # Migration path to GitLab HTTP backend — run `terraform state push` per component after switching.
  # backend "http" {
  #   address        = "https://<gitlab-host>/api/v4/projects/<project-id>/terraform/state/dev-vms"
  #   lock_address   = "https://<gitlab-host>/api/v4/projects/<project-id>/terraform/state/dev-vms/lock"
  #   unlock_address = "https://<gitlab-host>/api/v4/projects/<project-id>/terraform/state/dev-vms/lock"
  #   lock_method    = "POST"
  #   unlock_method  = "DELETE"
  #   retry_wait_min = 5
  # }
}
