#!/bin/bash
# Get ansible if not already
pip3 install ansible --quiet

# Run ansible
cd ansible
# ansible-playbook -i inventory.cfg -u ubuntu setup.yml -b -v # Verbose
ansible-playbook -i inventory.cfg -u ubuntu setup.yml -b
cd ..