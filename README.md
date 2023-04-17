<br> **SETUP OVERVIEW** <br>
<img width="1024" alt="Screenshot 2023-04-17 at 10 12 35 AM" src="https://user-images.githubusercontent.com/95365748/232380118-2e8388a2-bf20-4135-8c48-e1bf03559cf2.png">
* First we need to create a VPC on AWS
* Install Kubernetes Cluster inside VPC
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

**INSTALLATION PART** <br>
<br> 1)Launch an ec2 instance for running Jenkins and add port 8080 in security group of the instance to access Jenkins. <br>
<br> 2)Connect to instance and install Jenkins, Kubectl, AWS-CLI, Git and Docker. <br>
<br> 3)Add jenkins as user to docker group so that jenkins can run docker command for building image and pushing it to docker hub. <br>
<br> 3)Install these plugins
- Docker
- Docker Pipeline
- Kubernetes
- Kuberneets Credentials
- Kubernetes CLI
