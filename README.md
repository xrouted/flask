Project Description

This DevOps project automates the deployment and management of a cloud-based infrastructure for a Flask application using Terraform, AWS EC2, AWS ECR, Bash, Python, Jenkins, Docker, kind Kubernetes cluster, Helm, Git, and Flask.
Getting Started
Prerequisites

    Terraform   [https://www.terraform.io]
    AWS Account [https://aws.amazon.com/]
    AWS EC2     [https://aws.amazon.com/ec2/]
    AWS ECR     [https://aws.amazon.com/ecr/]
    Bash        [https://www.gnu.org/software/bash/]
    Python      [https://www.python.org/]
    Jenkins     [https://www.jenkins.io/]
    Docker      [https://www.docker.com/]
    kind Kubernetes cluster [https://kind.sigs.k8s.io/]
    Helm        [https://helm.sh/]
    Git         [https://git-scm.com/]
    Flask       [https://flask.palletsprojects.com/]

Deployment

    Clone this repository
    Modify the terraform.tfvars file with your desired infrastructure configuration
    Run terraform init to initialize the Terraform module
    Run terraform apply to apply the infrastructure changes
    Use Helm to deploy the Flask application to the kind Kubernetes cluster

Management

    Use Bash scripts for common infrastructure management tasks
    Use Python scripts for custom infrastructure management tasks and integrations
    Use Jenkins for continuous integration and delivery (CI/CD) pipelines
    Use Docker for containerizing the Flask application
    Use AWS ECR for storing the Docker images for the Flask application
    Use the kind Kubernetes cluster for deploying and managing the containerized Flask application
    Use Helm for managing the deployment of the Flask application on the Kubernetes cluster
    Use Git for version control and collaborating with team members

Authors

    xRouted : Bozhidar Bashev https://www.linkedin.com/in/bozhidar-bashev-56a41067/ 

License

This project is licensed under the nLimit License.
