⚠️ This configuration was **not tested or applied**, because an AWS account was not available at the time of preparation. 

The Terraform configuration defines the following architecture:

- One VPC
- One public subnet
- One private subnet
- One EC2 instance in the public subnet
- One EC2 instance in the private subnet

The project uses Terraform modules to separate concerns:
- VPC module
- Subnet module
- EC2 module

All values are parameterized using variables.

Once an AWS account is available, the following steps should be performed:

1. Initialize Terraform
```
terraform init
```

2. Validate the configuration:
```
terraform validate
```

3. Create a variables file:
```
cp terraform.tfvars.example terraform.tfvars
```

4. Review the execution plan:
```
terraform plan
```

5. Apply the configuration:
```
terraform apply
```

