#!/bin/bash

set -x

#####JENKINS#######
yum update -y
wget -O /etc/yum.repos.d/jenkins.repo \
   https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum upgrade -y
amazon-linux-extras install java-openjdk11 -y
yum install jenkins git -y
systemctl enable jenkins
systemctl start jenkins

#######DOCKER############
yum install -y docker
systemctl start docker
systemctl enable docker
usermod -aG docker jenkins

####KUBECTLandHELM######
curl -LO https://dl.k8s.io/release/v1.23.6/bin/linux/amd64/kubectl
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
curl -L https://git.io/get_helm.sh | bash -s -- --version v3.8.2

######### KUBERNETES KIND #############
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

echo "
apiVersion: kind.x-k8s.io/v1alpha4
kind: Cluster
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    listenAddress: "0.0.0.0" # Optional, defaults to "0.0.0.0"
    protocol: udp # Optional, defaults to tcp
- role: worker" >>  cluster.yaml


kind create cluster --config cluster.yaml 
mkdir -p /var/lib/jenkins/.kube/
kind get kubeconfig > config
cp config /var/lib/jenkins/.kube/config 
chown -R jenkins: /var/lib/jenkins/ 
chmod 600 /var/lib/jenkins/.kube/config