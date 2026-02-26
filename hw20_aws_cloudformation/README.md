# Configure infrastructure via CloudFormation

1. Create template for a stack:
[template.yaml](template.yaml)

2. Log into AWS console, change region to eu-east-1.

3. Open CLoudFormation service -> Create stack -> With new resources.

Set stack name - "pl-stack-hw-20", and wait for creation to be complete.
![Screenshot 1](images/image1.png)
![Screenshot 2](images/image2.png)

4. Verify the results.

VPC -> My VPCs:
![Screenshot 3](images/image3.png)

EC2 -> Instances:
![Screenshot 4](images/image4.png)

S3 -> Buckets:
![Screenshot 5](images/image5.png)

CloudFormation -> Stacks -> pl-stack-hw-20 -> Outputs:
![Screenshot 6](images/image6.png)

# Extra task - detect drift.

1. Change tag of an EC2:
![Screenshot 7](images/image7.png)
![Screenshot 8](images/image8.png)

2. CloudFormation -> Stacks -> pl-stack-hw-20 -> Stack actions -> detect drift.
![Screenshot 9](images/image9.png)

3. Drift status -> DRIFTED
![Screenshot 10](images/image10.png)
