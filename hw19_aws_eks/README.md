# 0. Prerequisites
Install kubectl and aws cli.

# Task 1. Create EKS cluster.
1. Create IAM role for cluster.
Go to IAM -> Roles -> Create role.
- Entity type: AWS service
- Use case: EKS -> EKS - cluster.
- Policy:
	- AmazonEKSClusterPolicy
	- AmazonEKSBlockStoragePolicy
	- AmazonEKSComputePolicy
	- AmazonEKSLoadBalancingPolicy
	- AmazonEKSNetworkingPolicy
- Role name: EKSClusterRole-PL
- add "sts:TagSession" to trust policy
![Screenshot 1](images/image1.png)

2. Create IAM role for node.
- Entity type: AWS service
- Use case: EC2 -> EC2
- Policy:
	- AmazonEKSWorkerNodePolicy - This policy allows Amazon EKS worker nodes to connect to Amazon EKS Clusters.
	- AmazonEC2ContainerRegistryReadOnly - Provides read-only access to Amazon EC2 Container Registry repositories
	- AmazonEKS_CNI_Policy - This policy provides the Amazon VPC CNI Plugin (amazon-vpc-cni-k8s) the permissions it requires to modify the IP address configuration on your EKS worker nodes. This permission set allows the CNI to list, describe, and modify Elastic Network Interfaces on your behalf.
- Role name: EKSNodeRole-PL

![Screenshot 2](images/image2.png)

3. Add another public subnet to the VPC, because AWS cluster requires at least 2 subnets in different AZs.
CIDR is 10.1.3.0/24.
The first public subnet is in eu-north-1b, for this one I select eu-north-1c.
![Screenshot 3](images/image3.png)

4. Create cluster.
Open AWS console, go to EKS -> Create cluster.
- name: eks-cluster-pl
- k8s version: latest (1.35)
- cluster IAM role: default value (AmazonEKSAutoClusterRole)
- VPC: pl-vpc (from the previous homework)
- select two public subnets
![Screenshot 4](images/image4.png)

Creation of nodes is not immediately available, waiting for the cluster creation to be complete.

Go to Compute -> Node groups -> Add node group.
	- name: public-nodes-pl
	- IAM role: EKSNodeRole-PL
	- Instance types: t3 medium
	- node group scaling configuration"
		- desired: 2
		- min: 2
		- max: 2
	- subnets: the two public subnets (pubic-subnet-pl,pubic-subnet-pl-2)
-> Create and wait until the creation is complete.

![Screenshot 5](images/image5.png)

The creation had failed
![Screenshot 6](images/image6.png)

The second public subnet didn't have 0.0.0.0 in the route tables.
Now I had to delete the node group and create it again, following the same steps.

On the second try I found out that the second subnet also didn't automatically assign public addresses.

I also had to add EKS cluster subnet tag for each public subnet
![Screenshot 7](images/image7.png)

// TODO

# Task 2. Configure kubectl to access the cluster.

Log into aws on my local console
```
aws login
```
and approve login via browser.

The default region was us-east-1, so I had to change it
```
 aws configure set region eu-north-1
```

And then I was able to log in.

Configures kubectl so that I'm able to connect to an Amazon EKS cluster:
```
 aws eks update-kubeconfig --region eu-north-1 --name eks-cluster-pl
```




# Task 3. Deploy static website


# Task 4. Create PersistentVolumeClaim.


# Task 5. Run Job.


# Task 6. Deploy test app.


# Task 7. Create namespace.


# Task 8. Cleanup resources.


