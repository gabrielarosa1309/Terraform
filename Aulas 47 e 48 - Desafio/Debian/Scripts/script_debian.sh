#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y apache2
sudo systemctl enable apache2
sudo apt-get install -y git
git clone https://github.com/FofuxoSibov/sitebike
sudo mv sitebike/* /var/www/html/
sudo systemctl restart apache2