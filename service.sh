#!/bin/bash

//This file is going to be the starting of the project with local Archtiecture ( A VM with Jenkins / Docker / Kubernetes )
// Register and pull images from docker hub for Kubernetes cluster 
// and make it available on the destinated namespace environments

// This file begin with installation of the neccessary softwares
// Then run jenkins and start the pipeline
// The pipeline steps take care of tool / software verification / docker build and push to docker hub
// Then build service container for Kubernetes and expose the container for microservices with different ips / ports

sudo apt-get update
wget https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
sudo tar xf /tmp/apache-maven-*.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.6.3 /opt/maven
sudo nano /etc/profile.d/maven.sh
export JAVA_HOME=$(dirname $(dirname $(readlink $(readlink $(which javac)))))
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
export PATH=${M2_HOME}/bin:${PATH}
sudo chmod u+x,g+x,o+x /etc/profile.d/maven.sh

./setup_platform.sh
