# Bobobox Web Server VM (OpenTofu)

This configuration provisions the Bobobox network and a single web server instance on Google Cloud Platform. The project is split into reusable modules plus shared provider and variable definitions.

## Configuration Layout
- `provider.tf` configures the required Google provider and remote GCS backend.
- `variables.tf` exposes the static inputs (`project_id`, `region`, `zone`) consumed by the modules.
- `vpc-bobobox` module creates the dedicated VPC, subnetwork, and exposes HTTP (80) and SSH (22) via firewall.
- `server-bobobox` module launches a Compute Engine VM inside that VPC and uses the templates under `server-bobobox/templates` to render the Ansible inventory, playbook, and startup script that configure Nginx and serve the "Hello, OpenTofu!" page.

## Prerequisites
- OpenTofu >= 1.6 installed and available as `tofu`
- Access to the GCP project `genai-bootcamp-438805` with permissions to manage Compute Engine, networking, and Cloud Storage
- Application Default Credentials configured (e.g., `gcloud auth application-default login`) or a service account JSON key set via `GOOGLE_APPLICATION_CREDENTIALS`
- Existing GCS bucket `box-terraform-state` accessible for state storage

## Usage
1. Navigate to the configuration directory:
   ```bash
   cd opentofu-vm-provisioning
   ```
2. Initialise the backend and providers:
   ```bash
   tofu init
   ```
3. Review the plan. Override the defaults for `project_id`, `region`, or `zone` with `-var` flags if needed:
   ```bash
   tofu plan
   ```
4. Review & Apply the changes. Type “yes” if all configuration looks good
   ```bash
   tofu apply
   ```
5. Note the `vm_public_ip` output once the apply finishes to reach the web server or connect over SSH.


## Destroying the Environment
When the resources are no longer required, delete them with:
```bash
tofu destroy
```

Remember to clean up any additional resources created outside this configuration.
