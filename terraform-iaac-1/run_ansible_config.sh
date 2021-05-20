#!bin/bash
mv template_based_conf/main.yml ~/self-provisioning/roles/ssl-certificate-generation/vars/
mv template_based_conf/web-site1 ~/static_website_files/
mv template_based_conf/inventory.yaml .
ansible-playbook ~/self-provisioning/roles/playbook.yaml -i ./inventory.yaml -vvvv
