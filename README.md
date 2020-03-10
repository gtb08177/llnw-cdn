# llnw-cdn
Technical task for demonstrating a small content delivery network

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
ansible-playbook -i inventory.cfg -u ubuntu setup.yml -b

# Things that are noteworthy
Manually created the hosted zone in AWS as it means that I won't have to update my name servers on every terraform redeploy.
Fallback index.html on nginx lives at `sudo vim /usr/share/nginx/html/index.html`
`terraform show | egrep "^#"` list terraform by name
Remember cache key will involve the host name i.e. localhost is not the same as edge-1.llnw.mcnulty.network so need to cater for both in purge

# Nice future thoughts / stretch targets
SSL cert


# Notes for demo
 curl -svo /dev/null http://localhost -X PURGE / curl -X PURGE http://edge-1.llnw.mcnulty.network/
 curl -svo /dev/null http://localhost/myfile -H "If-Modified-Since: Tue, 10 Mar 2020 21:09:22 GMT"
# Running this within PSSH allows me to purge the local cache version on the box but also the client facing or header
curl -svo /dev/null --resolve edge.llnw.mcnulty.network:80:127.0.0.1 http://edge.llnw.mcnulty.network/myfile -X PURGE


### Useful Resources Found ###
https://varnish-cache.org/docs/trunk/users-guide/vcl-hashing.html
https://linux.die.net/man/1/pssh


### Asked for TODOs remiaing
# 1 - Ansible sync to put objects on the box
# 2 - Multiple objects with difference caching headers on a per item basis.
# 3 - s-maxage from origin to edge

### Nice Stretch Ideas
# 1 - purge with a secret header
# 2 - pssh to run purge in parallel.
# 3 - use pssh to pull all the varnishlog to demo how many requests