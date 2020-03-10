#!/bin/bash
# Get ansible if not already
pip3 install ansible --quiet

# Run ansible
cd ansible
ansible-playbook -i inventory.cfg -u ubuntu setup.yml
#ansible-playbook -i inventory.cfg -u ubuntu setup.yml -l edges # target a group
#ansible-playbook -i inventory.cfg -u ubuntu setup.yml -v # Verbose
cd ..