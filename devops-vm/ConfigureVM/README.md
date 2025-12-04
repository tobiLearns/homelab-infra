# ConfigureVM

This folder contains the Ansible playbook and role assets used to configure the DevOps workstation VM.

Secrets strategy
- This project uses a single local, uncommitted variable file for developer secrets (same pattern used for Terraform `secrets.auto.tfvars`).
- Create a local file `vars/secrets.yml` (NOT committed) with the following contents:

```yaml
# vars/secrets.yml
git_user_name: "Your Name"
git_user_email: "you@example.com"
```

- A sample is provided at `vars/secrets.example.yml` — copy it and edit before running the playbook.
- `vars/git_secrets.yml` is ignored by git via `.gitignore`.

Running the playbook
- Make sure `vars/git_secrets.yml` exists before running the playbook, otherwise the play will stop with a helpful error.

```bash
cd devops-vm/ConfigureVM
# create local secrets file from example
cp vars/secrets.example.yml vars/secrets.yml
# edit vars/secrets.yml to add your real values
ansible-playbook -i "your-host," -u tobi playbook_devopsVM.yaml
```

CI note
- When moving to CI, replace local vars with secure CI variables or a secret manager.
