#!/bin/bash
sudo yum update -y
sleep 90
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
