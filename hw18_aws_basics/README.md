# Task 1: Create and configure VPC
 1. Create VPC and choose CIDR block.
 We need to avoid collisions with other existing VPCs in the account.
 Currently there are two more VPCs with the following CIDRs:
- 10.0.0.0/16
- 172.31.0.0/16 (default VPC AWS)

![Screenshot 1](images/image1.png)

So let's select 10.1.0.0/16.

Press "Create VPC":
- VPC only
- name is "pl-vpc"
- IPv4 CIDR 10.1.0.0/16
- no IPv6 CIDR block
- default tenancy (meaning "shared"/not dedicated hardware)
- VPC encryption control - none, just because it's free :)
![Screenshot 2](images/image2.png)

2. Create subnets.
Go to Subnets -> Create subnet, select previously created VPC:
![Screenshot 3](images/image3.png)

Public:
![Screenshot 4](images/image4.png)

Private:
![Screenshot 5](images/image5.png)

![Screenshot 6](images/image6.png)

3. Create and configure Internet Gateway.

Go to "Internet Gateway" tab, press "Create internet gateway", name "internet-gateway-pl".
![Screenshot 7](images/image7.png)

Actions -> Attach to VPC
![Screenshot 8](images/image8.png)

Go to "Route tables", Create route table
![Screenshot 9](images/image9.png)

Routes -> Edit routes -> Add route
![Screenshot 10](images/image10.png)
![Screenshot 11](images/image11.png)

Go to Subnet associations, Edit, select the public subnet.
![Screenshot 12](images/image12.png)
![Screenshot 13](images/image13.png)

Go to Subnets, select public-subnet-pl, Actions -> Edit subnet settings -> Enable auto-assign public IPv4 address.
This way every new EC2 will automatically get a public IP address.
![Screenshot 14](images/image14.png)
![Screenshot 15](images/image15.png)

# Task 2. Configure Security Groups and Access Control Lists (ACL).

Go to EC2 -> Secutity groups -> Create security group.
Add two inbound rules - for SSH and HTTP.
Leave outbound rules as is.
![Screenshot 16](images/image16.png)
![Screenshot 17](images/image17.png)

# Task 3. Run new EC2 instance.

Go to EC2 -> Instances -> Launch instance.
![Screenshot 18](images/image18.png)

- instance type is t3.micro (t2 was was not available).
- VPC is pl-vpc
- Subnet is public-subnet-pl
- Enable auto-assign public IP
- Select existing security group - GroupPL
- Key pair (login) -> Create new key pair
	- name: key-pl
	- type: RSA
	- format: .pem
![Screenshot 19](images/image19.png)

key-pl.pem was automatically downloaded.

![Screenshot 20](images/image20.png)
![Screenshot 21](images/image21.png)

Connect to the instance using the ssh key:
![Screenshot 22](images/image22.png)

# Task 4. Elastic IP.

Go to EC2 -> Elastic IPs -> Allocate elastic IP address.
![Screenshot 23](images/image23.png)

Associate this elastic IP address, select previously created instance.
![Screenshot 24](images/image24.png)
![Screenshot 25](images/image25.png)

Connected to the same instance:
![Screenshot 26](images/image26.png)
