# llnw-cdn
Technical task for demonstrating a small content delivery network

# Tech stacks
- Terraform
- Ansible
- AWS Lightsail
- Ubuntu
- Nginx
- Varnish

# Step 1 - init terraform
If not already done so, from the parent directory, run: `terraform init`

# Step 2 - provision infrastructure
run: `terraform apply` to get use terraform to deploy edges and origins

# Step 3 - run ansible to now configure that infrastructure
ansible-playbook -i inventory.cfg -u ubuntu setup.yml

# Things that are noteworthy
Manually created the hosted zone in AWS as it means that I won't have to update my name servers on every terraform redeploy.
Fallback index.html on nginx lives at `sudo vim /usr/share/nginx/html/index.html`
`terraform show | egrep "^#"` list terraform by name
Remember cache key will involve the host name i.e. localhost is not the same as edge-1.llnw.mcnulty.network so need to cater for both in purge

# debug header
curl -svo /dev/null http://edge.llnw.mcnulty.network/ -H "x-secret-debug-header: yes"


#### Running this within PSSH allows me to purge the local cache version on the box but also the client facing or header
curl -svo /dev/null --resolve edge.llnw.mcnulty.network:80:127.0.0.1 http://edge.llnw.mcnulty.network/myfile -X PURGE -H "x-secret-purge-header: yes"


### Useful Resources Found ###
https://varnish-cache.org/docs/trunk/users-guide/vcl-hashing.html
https://linux.die.net/man/1/pssh


### Nice Stretch Ideas
# 1 - pssh to run purge in parallel.
# 2 - use pssh to pull all the varnishlog to demo how many requests
# 3 - SSL cert with nginx front varnish as to allow SSL termination