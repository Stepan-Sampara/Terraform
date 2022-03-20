#!/bin/bash
terraform output | grep -E -o '\b[A-Za-z]{1,10}|(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' > /home/step/Ansible/hosts.txt 
sed -i -e '/[A-Za-z]/ s/$/]/' -e '/[A-Za-z]/ s/^/[/' /home/step/Ansible/hosts.txt
