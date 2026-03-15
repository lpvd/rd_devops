# Solution stack

- The app: fork of [spring-petclinic](https://github.com/spring-projects/spring-petclinic)
- Source code: GitHub, as I'm more familiar with the platform and use it on daily basis.
- Cloud: AWS, as they offer a full ecosystem, which can be used for this exercise. I'm also more familiar with this cloud provider.
- Infrastructure automatization: Terraform
- Remote data storage for Terraform: Amazon S3
- Configuration management tool: Ansible
- CI/CD automation tool: Github Actions, as the code is stored on GitHub, so there's no need for another VM for Jenkins. And I'm also more familiar with it comparing to Jenkins.
- Artifacts: Docker images
- Storage of artifacts:  Amazon ECR (Elastic Container Registry). Native integration with EC2/ECS, free (up to some point). Nexus would require an extra VM. 
- Persistent database for applications: Amazon RDS for MySQl.
- Monitoring: AWS CloudWatch. Embedded into AWS, free basic monitoring for EC2, easy to configure dashboard.
- Scripts: Python and/or Bash
- Diagram: draw io

There will be no k8s, it's not needed at this scale.  k8s is justified when there are 10+ microservices or auto-scaling is needed under load.
Spring-petclinic is one monolithic application on one VM. Adding k8s would just add complexity without benefit.
Kubernetes would be the next step after this project if the task required high availability or a microservice architecture.
For the final project of the DevOps course, this is overengineering, which will do more harm (more places where something can break in the presentation) than help.

# Prepare the repo

Fork a repository of the app `spring-petclinic`:
![Screenshot 1](images/image1.png)

Create a skeleton - add `terraform`, `ansible` and `scripts` folders.
The folder for GitHub Actions already exists, so we clean it up.
Also remove k8s folder, as it won't be needed for this project. Remove gitpod.yaml.
Add a pythons script for semver bump_version.py.
Add a Dockerfile and test it locally:
```
docker build -t petclinic-test .
```
![Screenshot 2](images/image2.png)

```
docker run -p 8080:8080 petclinic-test
```

-> http://localhost:8080
![Screenshot 3](images/image3.png)

# IAM user with rights

As a user under my email has AdministratorAccess Permission policy, it is enough for Terraform.
As I'm the only person working on the project, I can just directly create an access key and use it for Terraform.

Ideally in a real product it should be a separate user, so that permissions can be managed for this user specifically, without touching the "main" account.

![Screenshot 4](images/image4.png)

AM Roles Anywhere is a way to issue temporary credentials instead of permanent keys. It works through PKI certificates: your computer has a certificate, AWS checks it and issues a token that lives for 1 hour, then automatically expires.
AWS recommends this for security reasons - permanent Access Keys are more dangerous because:

- they do not expire
- if they leak in git or logs - the attacker has access forever (till the key is revoked).
- it is more difficult to track who used them and when

IAM Roles Anywhere requires:
- setting up a Certificate Authority (PKI infrastructure)
- generating certificates
- a separate configuration in the AWS Console
- changing the authentication method in Terraform and GitHub Actions

These are additional hours of configuration for the sake of security, which is important in production with real data, but is not important for an educational project.

So I just proceed with the access key and configure it locally via a file.
```
aws configure
# AWS Access Key ID: (enter) - already set up
# AWS Secret Access Key: (enter) - already set up
# Default region name: eu-west-1
# Default output format: json
```

Reasons for selecting this region: the most stable European region, the most documentation and examples for it, all the services needed for the project are there.
The main rule is all resources in one region. S3 bucket for state, EC2, RDS, ECR — all eu-west-1. Otherwise, there will be network problems and additional costs for cross-region traffic.

# Create S3 bucket for Terraform state and DynamoDB table for lock

The only two resources that must be created manually, because Terraform state must be stored somewhere even before the Terraform started running.

Why Dynamo DB?
Terraform requires distributed lock, so that two processess would not be modifying `state` at the same moment.
It requires `conditional write` operation, which DynamoDB supports out of the box (`PutItem` with `ConditionalExpression`).
We don't necessarily need NoSQL here, but relational SQL would also be an overkill for a single table, and a single field `LockID`.
Also DynamoDB is serverless, so there's no instance, for which we should pay 24/7. It's just a table, so we pay only when really use it.

We could probably use HashiCorp Terraform Cloud instead of S3 + Dynamo DB, but the task had listed specifically S3 as an option.
Probably to better understand how the locking works, as HashiCorp Terraform Cloud hides this complexity.

## AWS S3 Bucket
AWS Console → S3 → Create bucket
Name "petclinic-tfstate-plopit", enable bucket versioning. The rest is default:
- bucket type - general purpose
- namespace: global
- encryption - SSE-S3
- block all public Access
- ACLs disabled

![Screenshot 5](images/image5.png)
![Screenshot 6](images/image6.png)

## DynamoDB

AWS Console → DynamoDB → Create table
- Table name: terraform-lock
- Partition key: LockID - String
- Table settings -> Customize settings
- Table class -> DynamoDB Standard (Frequently accessed data)
- Read/write capacity settings -> On-demand (has no minimal payment, checper than Provisioned)

The rest is default.

![Screenshot 7](images/image7.png)
![Screenshot 8](images/image8.png)

# Terraform

Technically, Terraform reads all .tf files in a folder at once — the order of the files doesn’t matter, only the dependencies between resources. So you can split it into network.tf, ec2.tf, rds.tf — and that’s even cleaner. But for a course project, one main.tf is simpler and clearer in the presentation.

1. terraform/backend.tf - for remote state
2. terraform/variables.tf.
my IP and DB password don't have defaults. They should be passed to terraform.
3. For those variables I'm going to use file `terraform.tfvars`, which is added to `.gitignore`.
For GitHub actions those will be stored in secrets.

4. Check previous steps
```
terraform init
```
![Screenshot 9](images/image9.png)

5. Network in terraform/main.tf
VPC/subnet, EC2, RDS, ECR (Elastic Container Registry) and ALB (Application Load balancer).

Check which VPCs are there:
![Screenshot 10](images/image10.png)

```
terraform plan
```
![Screenshot 11](images/image11.png)

```
terraform apply
```
![Screenshot 12](images/image12.png)
![Screenshot 13](images/image13.png)

6.  Add SSH kay pair, IAM role for EC2 and add EC2 instances in terraform/main.tf

Generate ssh key:
```
ssh-keygen -t rsa -b 4096 -f ~/.ssh/petclinic-key
```
Public key will be used by Terraform, private will be used later:
- Connect via SSH to EC2:
```
   ssh -i ~/.ssh/petclinic-key ec2-user@<EC2_IP>
```

- GitHub Secret SSH_PRIVATE_KEY.

Run 
```
terraform plan
terraform apply
```
![Screenshot 14](images/image14.png)

Check Terraform outputs. First create a file terraform/outputs.tf and define ec2_public_ip.
![Screenshot 15](images/image15.png)

Connect by SSH to the instance and check IAM identity when logged in:
```
$ ssh -v -i ~/.ssh/petclinic-key ec2-user@18.201.234.117
```
![Screenshot 16](images/image16.png)

So EC2 is good to go.

7. Add RDS and ECR to terraform/main.tf, add rds_host to outputs.
![Screenshot 17](images/image17.png)

Now checking the AWS Console:
![Screenshot 18](images/image18.png)

8. Add Application Load Balancer to terraform/main.tf.
ALB accepts traffic on standard port 80, EC2 remains protected behind it. Health check automatically determines whether the application is alive. In a real project, you can put several EC2 instances behind ALB.

Also define outputs for ecr_registry and alb_dns, and apply:
![Screenshot 19](images/image19.png)

# Ansible

Create ansible/inventory.ini and andible/playbook.yml.
Add the IP address from the Terraform output to ansible/inventory.ini.

At first check connection to EC2:
```
ansible app_servers -i inventory.ini -m ping
```
![Screenshot 20](images/image20.png)

Run the playbook
```
ansible-playbook -i inventory.ini playbook.yml
```
![Screenshot 21](images/image21.png)
![Screenshot 22](images/image22.png)

Check the result on EC2. Connect via SSH:
![Screenshot 23](images/image23.png)

# CI/CD

1. Add all GitHub secrets:
- AWS_ACCESS_KEY_ID - from ~/.aws/credentials
- AWS_SECRET_ACCESS_KEY - from ~/.aws/credentials
- AWS_REGION - eu-west-1
- ECR_REGISTRY - terraform output ecr_registry
- EC2_HOST - terraform output ec2_public_ip
- SSH_PRIVATE_KEY - from ~/.ssh/petclinic-key
- RDS_HOST - terraform output rds_host
- DB_USER - petclinic_user from variables.tf
- DB_PASSWORD - db_password from terraform.tfvars

Repo's fork  → Settings → Secrets and variables → Actions → New repository secret.
![Screenshot 24](images/image24.png)

2. Define pr-pipeline.yml and main-pipeline.yml, add branch protection rules for main.
![Screenshot 25](images/image25.png)

3. Create a test PR to check the pipeline.
The branch protection works:
![Screenshot 26](images/image26.png)

After addressing the build issue I got the successful pr-pipeline:
![Screenshot 27](images/image27.png)
![Screenshot 28](images/image28.png)

Results of the main-pipeline run after merge:
![Screenshot 29](images/image31.png)

![Screenshot 30](images/image29.png)
![Screenshot 31](images/image30.png)

Uploaded docker images on ECR:
![Screenshot 32](images/image32.png)

# Cloud Watch

Check CloudWatch on the EC2 instance:
![Screenshot 33](images/image33.png)

Create a dashboard with metrics on EC2:
AWS Console → CloudWatch → Dashboards → Create dashboard
 - Name: petclinic-monitoring → Create dashboard
![Screenshot 34](images/image34.png)
![Screenshot 35](images/image35.png)

# RDS

Check that the app is connected to RDS
![Screenshot 36](images/image36.png)
![Screenshot 37](images/image37.png)
![Screenshot 38](images/image38.png)

# Diagram

![Screenshot 39](images/image39.png)

xml file of the diagram is stored in the repo as well.
See [petclinic-diagram.drawio](petclinic-diagram.drawio).
