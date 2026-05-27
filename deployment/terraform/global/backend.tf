terraform {
  backend "local" {
    path = "terraform.tfstate"
  }

  # Migration path to GitLab HTTP backend:
  # backend "http" {
  #   address        = "https://<gitlab-host>/api/v4/projects/<project-id>/terraform/state/global"
  #   lock_address   = "https://<gitlab-host>/api/v4/projects/<project-id>/terraform/state/global/lock"
  #   unlock_address = "https://<gitlab-host>/api/v4/projects/<project-id>/terraform/state/global/lock"
  #   lock_method    = "POST"
  #   unlock_method  = "DELETE"
  #   retry_wait_min = 5
  # }
}
