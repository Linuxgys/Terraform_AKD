
# Terraform AWS Web Application Deployment

This project provisions a simple web application on AWS using Terraform. It includes:
- A public EC2 instance with NGINX and a custom web page
- An Application Load Balancer (ALB) with HTTP to HTTPS redirection
- Target group registration
- Secure HTTPS listener using an ACM certificate

## 📁 Project Structure

```
.
├── ec2.tf                 # EC2 instance setup with NGINX and user_data
├── vpc.tf                 # VPC, subnets, and internet gateway
├── security.tf            # Security groups for EC2 and ALB
├── alb.tf / loadbalancer.tf  # Application Load Balancer configuration
├── target-group.tf        # Target group and attachment
├── variables.tf           # Input variables
├── outputs.tf             # Useful outputs like ALB DNS name
└── terraform.tfvars       # Variable values
```

## 🚀 Getting Started

### 1. Clone this repository

```bash
git clone https://github.com/your-repo/aws-terraform-webapp.git
cd aws-terraform-webapp
```

### 2. Set up AWS credentials

```bash
export AWS_ACCESS_KEY_ID=your_key
export AWS_SECRET_ACCESS_KEY=your_secret
export AWS_REGION=ap-south-1
```

Or configure via AWS CLI:

```bash
aws configure
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Format & Validate Code

```bash
terraform fmt -recursive
terraform validate
```

### 5. Plan & Apply

```bash
terraform plan
terraform apply -auto-approve
```

## 🌐 Accessing the Application

Visit `http://<ALB-DNS>` — redirected to HTTPS and see a custom NGINX page with **🚩 जय श्री राम 🚩**.

## 🔐 SSL Certificate (ACM)

Update ARN in `alb.tf`:

```hcl
certificate_arn = "arn:aws:acm:ap-south-1:1234567890:certificate/abcde..."
```

## 🧹 Destroy Resources

```bash
terraform destroy -auto-approve
```

## 📌 Notes

- Default EC2 AMI is Ubuntu 22.04
- Health check endpoint: `/health` returns `OK`
- HTTPS uses `ELBSecurityPolicy-TLS13-1-2-Res-2021-06`

## 📝 License

MIT © 2025 YourName


## CI/CD with GitHub Actions

This project uses GitHub Actions to automate Terraform operations. The CI/CD pipeline performs the following steps on every push to the `main` branch or pull request:

### Workflow: `Terraform CI/CD`

```yaml
name: Terraform CI/CD

on:
  push:
    branches:
      - main
  pull_request:

jobs:
  terraform:
    name: Terraform Plan and Apply
    runs-on: ubuntu-latest

    defaults:
      run:
        shell: bash

    steps:
    - name: Checkout code
      uses: actions/checkout@v4

    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v3
      with:
        terraform_version: 1.8.3

    - name: Configure AWS Credentials
      uses: aws-actions/configure-aws-credentials@v4
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: ap-south-1

    - name: Terraform Init
      run: terraform init

    - name: Terraform Format Check
      run: terraform fmt -check -recursive

    - name: Terraform Validate
      run: terraform validate

    - name: Terraform Plan
      run: terraform plan

    - name: Terraform Apply
      if: github.ref == 'refs/heads/main'
      run: terraform apply -auto-approve
```

This ensures best practices such as linting, validation, and infrastructure as code workflows are consistently applied.
