```

\# BellCloudOps Terraform AWS Infrastructure Lab



\## Project Overview

This project demonstrates how to deploy AWS infrastructure using Terraform Infrastructure as Code (IaC).



The Terraform configuration provisions a full networking environment including a custom VPC, public subnet, private subnet, routing, security groups, and an EC2 web server. The EC2 instance hosts a simple demonstration website for the fictional cloud services company BellCloudOps.



This project simulates how cloud engineers deploy infrastructure programmatically instead of manually configuring resources through the AWS console.



---



\## Architecture



The Terraform configuration automatically creates the following AWS resources:



\- VPC

\- Public Subnet

\- Private Subnet

\- Internet Gateway

\- Route Table

\- Route Table Association

\- Security Group

\- EC2 Web Server



The EC2 instance runs a web server that hosts a basic webpage representing a fictional cloud services company.



---



\## Architecture Diagram



User Browser  

&nbsp;     |  

&nbsp;  Internet  

&nbsp;     |  

Internet Gateway  

&nbsp;     |  

&nbsp;  Public Subnet  

&nbsp;     |  

&nbsp;  EC2 Web Server  

&nbsp;     |  

&nbsp;  Demo Website  



---



\## Technologies Used



\- Terraform

\- AWS EC2

\- AWS VPC

\- AWS Networking

\- Apache Web Server

\- Linux



---



\## AWS Services Used



\- Amazon EC2

\- Amazon VPC

\- Internet Gateway

\- Subnets

\- Route Tables

\- Security Groups



---



\## Terraform Commands Used



Initialize Terraform



terraform init



Format Terraform configuration files



terraform fmt



Preview infrastructure changes



terraform plan



Deploy infrastructure



terraform apply



Destroy infrastructure when finished



terraform destroy



---



\## What This Project Demonstrates



This project demonstrates several important cloud engineering skills:



\- Infrastructure as Code using Terraform

\- Creating AWS networking environments

\- Deploying compute resources in AWS

\- Configuring secure network access

\- Hosting a web server on cloud infrastructure

\- Automating infrastructure deployment



These are foundational skills used by cloud engineers working in AWS environments.



---



\## Real World Use Cases



Infrastructure like this is commonly used in production environments.



Hosting Public Websites  

Companies host websites on cloud servers inside public subnets.



Application Hosting  

Applications and APIs can run on EC2 instances inside VPC networks.



Cloud Infrastructure Automation  

Organizations use Infrastructure as Code tools like Terraform to deploy and manage infrastructure consistently across environments.



---



\## Security Notes



For demonstration purposes, HTTP access was allowed from anywhere:



0.0.0.0/0



In a production environment this would typically be restricted using:



\- Specific trusted IP ranges

\- Web Application Firewalls

\- Load balancers

\- Private subnets with NAT gateways



---



\## Screenshots



\### Terraform Apply Success

!\[Terraform Apply](screenshots/Terraform Apply Success.png)



\### VPC Created

!\[VPC](screenshots/VPC.png)



\### Subnets

!\[Subnets](screenshots/Subnets.png)



\### Route Table

!\[Route Table](screenshots/Route Table.png)



\### Security Group

!\[Security Group](screenshots/Security Group.png)



\### EC2 Instance Running

!\[EC2 Instance](screenshots/EC2 Instance.png)



\### Live Website

!\[Live Website](screenshots/Live Website.png)



---



\## Future Improvements



Possible improvements to this architecture include:



\- Deploying the EC2 instance behind an Application Load Balancer

\- Adding HTTPS with SSL certificates

\- Implementing Auto Scaling groups

\- Using Terraform modules for reusable infrastructure

\- Deploying multiple environments (dev, staging, production)



---



\## Author



Anthony Bell  

Cloud \& Network Engineering Student  

AWS Cloud Engineering Track

```



