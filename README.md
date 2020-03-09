# llnw-cdn
Technical task for demonstrating a small CDN setup

# Tech stacks
- Terraform
- Ansible
- AWS Lightsail
- Ubuntu

# Step 1 - init terraform
If not already done so, from the parent directory, run: `terraform init`

# Step 2 - provision infrastructure
run: `terraform apply` to get use terraform to deploy edges and origins

# Step 3 - run ansible to now configure that infrastructure


# Things that are noteworthy
I manually created the hosted zone in AWS as it means that I won't have to update my name servers on every terraform redeploy.