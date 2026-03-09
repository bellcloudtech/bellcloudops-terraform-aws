provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "bellcloudops-main-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "bellcloudops-public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "bellcloudops-private-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "bellcloudops-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "bellcloudops-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "web_sg" {
  name        = "bellcloudops-web-sg"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bellcloudops-web-sg"
  }
}

resource "aws_instance" "web_server" {
  ami                         = "ami-0c2b8ca1dad447f8a"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  user_data_replace_on_change = true

  user_data = <<-EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

cat > /var/www/html/index.html <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>BellCloudOps | Cloud Infrastructure Services</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f4f7fb;
      color: #1f2937;
    }

    header {
      background: #0f172a;
      color: white;
      padding: 60px 20px;
      text-align: center;
    }

    header h1 {
      margin: 0;
      font-size: 42px;
    }

    header p {
      margin-top: 15px;
      font-size: 18px;
      color: #d1d5db;
    }

    .btn {
      display: inline-block;
      margin-top: 25px;
      padding: 12px 24px;
      background: #2563eb;
      color: white;
      text-decoration: none;
      border-radius: 6px;
      font-weight: bold;
    }

    .section {
      max-width: 1100px;
      margin: auto;
      padding: 50px 20px;
    }

    .section h2 {
      color: #111827;
      margin-bottom: 15px;
    }

    .services {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
      gap: 20px;
      margin-top: 25px;
    }

    .card {
      background: white;
      padding: 25px;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    }

    .card h3 {
      margin-top: 0;
      color: #2563eb;
    }

    .about, .contact {
      background: white;
      border-radius: 10px;
      padding: 30px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    }

    footer {
      background: #0f172a;
      color: #cbd5e1;
      text-align: center;
      padding: 20px;
      margin-top: 30px;
    }
  </style>
</head>
<body>

  <header>
    <h1>BellCloudOps</h1>
    <p>Cloud Infrastructure, Automation, and Secure AWS Solutions for Modern Businesses</p>
    <a class="btn" href="#services">Explore Services</a>
  </header>

  <section class="section">
    <div class="about">
      <h2>About BellCloudOps</h2>
      <p>
        BellCloudOps is a demo cloud services company focused on helping organizations
        modernize their infrastructure with secure, scalable, and reliable AWS-based solutions.
        This website was deployed on an Amazon EC2 instance using Apache and Terraform as part
        of a hands-on cloud engineering project.
      </p>
    </div>
  </section>

  <section class="section" id="services">
    <h2>Our Services</h2>
    <div class="services">
      <div class="card">
        <h3>AWS Infrastructure Deployment</h3>
        <p>Provisioning EC2, VPCs, subnets, security groups, and networking resources for small business cloud environments.</p>
      </div>

      <div class="card">
        <h3>Infrastructure as Code</h3>
        <p>Automating cloud deployments with Terraform for repeatable, version-controlled infrastructure management.</p>
      </div>

      <div class="card">
        <h3>Cloud Security Foundations</h3>
        <p>Implementing IAM, least-privilege access, security groups, and monitoring controls to improve cloud security posture.</p>
      </div>

      <div class="card">
        <h3>Monitoring and Operations</h3>
        <p>Supporting operational visibility with CloudWatch monitoring, alerting concepts, and cloud troubleshooting workflows.</p>
      </div>
    </div>
  </section>

  <section class="section">
    <div class="contact">
      <h2>Architecture Overview</h2>
      <p>
        This demo environment includes a custom VPC, a public subnet for the web server,
        a private subnet for future internal workloads, an internet gateway, route table,
        security group, and an Apache web server running on Amazon EC2.
      </p>
      <p>
        Technologies used: AWS EC2, VPC, Public and Private Subnets, Internet Gateway,
        Route Table, Security Groups, Apache HTTP Server, and Terraform.
      </p>
    </div>
  </section>

  <footer>
    BellCloudOps Demo Environment | Built on AWS with Terraform
  </footer>

</body>
</html>
HTML
EOF

  tags = {
    Name = "BellCloudOps-WebServer"
  }
}