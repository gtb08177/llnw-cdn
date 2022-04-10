# llnw-cdn
Technical interview task put forward by Limelight Network to build, implement and demonstrate a small content delivery network.

# Technology
- Terraform
- Ansible
- AWS Lightsail
- Ubuntu
- Nginx
- Varnish

# Step 1 - init terraform
In the top level directory of this project, on command line run: `terraform init`

# Step 2 - provision infrastructure
run `terraform apply` to get use terraform to deploy edges and origins

# Step 3 - configure the application
Use ansible to configure the newly provisioned infrastructure.
`ansible-playbook -i inventory.cfg -u ubuntu setup.yml`

# Noteworthy points
I manually created the hosted zone in AWS as it means that I won't have to update my name servers on every terraform redeploy.
Fallback index.html on nginx lives at `sudo vim /usr/share/nginx/html/index.html`
`terraform show | egrep "^#"` list terraform by name
Cache keys will involve the hostname i.e. localhost is not the same as edge-1.llnw.mcnulty.network so need to cater for both when purging

# debug header
curl -svo /dev/null http://edge.llnw.mcnulty.network/ -H "x-secret-debug-header: yes"


#### Running this within PSSH allows me to purge the local cache version on the box but also the client facing or header
curl -svo /dev/null --resolve edge.llnw.mcnulty.network:80:127.0.0.1 http://edge.llnw.mcnulty.network/myfile -X PURGE -H "x-secret-purge-header: yes"


### Useful Resources Found ###
https://varnish-cache.org/docs/trunk/users-guide/vcl-hashing.html
https://linux.die.net/man/1/pssh


### Stretch Ideas
# 1 - Create ansible playbooks for the local client machine orchestrating these changes to make adoption easier.
# 2 - Provide a means of carrying out purge across all edges (pssh or orchestrated edge to edge communication).
# 3 - Use pssh to pull all the varnishlog to demo how many requests
# 3 - Provide a certificate using LetsEncrypt for each node, either locally and pushing it or allowing the nodes to manage their own for TLS termination.
