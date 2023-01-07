Flask Infrastructure

This project contains the infrastructure code for a Flask web application. It is set up using Terraform and Ansible and is designed to be deployed on AWS.
Prerequisites

Before you can use this project, you will need the following:

    Terraform
    An AWS account

Setting Up

    Clone the repository:

git clone https://github.com/xrouted/flask.git
cd flask/infrastructure

    Copy the terraform.tfvars.example file to terraform.tfvars and fill in your AWS access keys and desired region:

cp terraform.tfvars.example terraform.tfvars

    Initialize Terraform:

terraform init

    Review the infrastructure plan:

terraform plan

    Apply the infrastructure:

terraform apply

    Run the Ansible playbook to set up the server:

ansible-playbook -i inventory.ini playbook.yml

Deploying the Application

To deploy the Flask application, you will need to build and package it and then copy the package to the server. Here is an example of how you can do this using git and scp:

    Check out the code for the application:

git clone https://github.com/xrouted/flask.git
cd flask/app

    Build the application package:

python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python setup.py sdist

    Copy the package to the server:

scp dist/flask-app-0.1.tar.gz ubuntu@<server_ip>:/tmp

    SSH into the server and install the package:

ssh ubuntu@<server_ip>
cd /tmp
tar -xzvf flask-app-0.1.tar.gz
cd flask-app-0.1
sudo python3 setup.py install

    Restart the application server to pick up the new code:

sudo systemctl restart flask-app

Cleaning Up

To destroy the infrastructure and delete all resources created by Terraform, run:

terraform destroy
