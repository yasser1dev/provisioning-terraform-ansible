#!bin/bash
mv main.yml ~/self-provisioning/roles/ssl-certificate-generation/vars/
mv web-site1 ../static_website_files/

ansible-playbook ~/self-provisioning/roles/playbook.yaml -i ./inventory.yaml -vvvv
