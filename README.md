<br> **PROJECT DETAILS** <br>
- I have created a CI/CD Pipeline for an app which basically let you make a tweet from your twitter account.
- Jenkins triggers build whenever there is any change made in Master branch on github repo.
- New docker image is build with Dockerfile and pushed to docker hub by jenkins.
- Jenkins install kubectl on worker nodes of k8s cluster.
- And then jenkins deploy it on k8s cluster's worker node with deployment.yaml file.
- We can use Ingress-Controller but this app only has single service exposed to internet that is why I have used LoadBalancer as a service type and exposed it directly on load balancer.

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

<br> **OUTCOME OF PROJECT** <br>
* Provided automation where CI/CD pipeline is to deliver software changes quickly and efficiently, reducing the time it takes to bring new features live.
* By automating repetitive tasks, it helped to reduce the costs associated with software development and deployment.
* In the event of issues or bugs, it can help teams quickly identify and resolve these issues, reducing downtime and improving the overall user experience.

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

<br> **SETUP OVERVIEW** <br>
* First we need to create a VPC on AWS
* Install Kubernetes Cluster inside VPC
<img width="1024" alt="Screenshot 2023-04-17 at 10 12 35 AM" src="https://user-images.githubusercontent.com/95365748/232380118-2e8388a2-bf20-4135-8c48-e1bf03559cf2.png">


* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

<br> **INSTALLATION PART** <br>
<br> 1)Launch an ec2 instance for running Jenkins and add port 8080 in security group of the instance to access Jenkins. <br>
<br> 2)Connect to instance and install Jenkins, Kubectl, AWS-CLI, Git and Docker. <br>
<br> 3)Install these plugins
- Docker
- Docker Pipeline
- Kubernetes
- Kuberneets Credentials
- Kubernetes CLI

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

<br> **CONFIGURATION PART** <br>
<br> 1)Add jenkins as user to docker group so that jenkins can run docker command for building image and pushing it to docker hub. <br>
<br> 2)Add jenkins user to sudoers file so that password is not asked while performing some tasks by jenkins user. <br>
<br> 3)To switch to jenkins user make some changes inside /etc/passwd file and copy env-variables files into present home directory of user. <br>
<br> 4)Switch to jenkins user. <br>
<br> 5)Configure AWS. <br>
<br> 6)Intergrate Kubernetes with Jenkins using kube-config file. <br>
<br> 7)Add docker hub credentials. <br>
<br> <img width="1436" alt="Screenshot 2023-04-17 at 11 35 31 AM" src="https://user-images.githubusercontent.com/95365748/232397693-8c64d246-03f6-4b7f-8ac6-7c56595fa15a.png"> <br>

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

<br> **PIPELINE SETUP** <br>
<br> 1)Create a new job and select Multibranch Pipeline. <br>
<br> <img width="1438" alt="Screenshot 2023-04-17 at 11 40 12 AM" src="https://user-images.githubusercontent.com/95365748/232398828-07c999eb-f818-44fa-89d3-852080530534.png"> <br>
<br> 2)Add github url and save. <br>
<br> <img width="1437" alt="Screenshot 2023-04-17 at 11 45 01 AM" src="https://user-images.githubusercontent.com/95365748/232400122-1e6a33d0-6723-42e1-af37-f277281cb040.png"> <br>
<br> 3)If everything goes right and build is successful then we can see the output of different stages of Jenkinsfile. <br>
<br> <img width="1439" alt="Screenshot 2023-04-17 at 11 49 39 AM" src="https://user-images.githubusercontent.com/95365748/232401270-4a916469-e7ab-4818-a057-f41882f0dc07.png"> <br>

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

<br> **EXPLANATION OF JENKINSFILE** <br>
<br> * Stage 1: Jenkins will build new docker image with the latest changes made in github repo. <br>
<br> * Stage 2: Jenkins will install kubectl on worker nodes to apply yaml files. <br>
<br> * Stage 3: Jenkins will deploy the deployment.yaml file into k8s cluster's worker node. <br>

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

<br> **APP** <br>
<br> <img width="1440" alt="Screenshot 2023-04-17 at 12 30 14 PM" src="https://user-images.githubusercontent.com/95365748/232408916-52826690-d763-4beb-9b5b-1ba1c7b3e236.png"> <br>
