# 0. Prerequisites
Install kubectl and aws cli.

# Task 1. Create EKS cluster.

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

```
eksctl create cluster --name eks-demo-cluster-pl-cli --region eu-north-1 --node-type t3.medium --nodes 2 --managed
```
![Screenshot 1](images/image1.png)

The cluster was created and `kubectl get nodes` returned 2 nodes with status "Ready"
![Screenshot 2](images/image2.png)

# Task 2. Configure kubectl to access the cluster.

Configures kubectl so that I'm able to connect to an Amazon EKS cluster:
```
 aws eks update-kubeconfig --region eu-north-1 --name eks-demo-cluster-pl-cli
```
![Screenshot 3](images/image3.png)

# Task 3. Deploy static website
Create and apply [configmap.yaml](configmap.yaml), [deployment.yaml](deployment.yaml), [service.yaml](service.yaml).

![Screenshot 4](images/image4.png)

If I open the EXTERNAL IP in browser:
![Screenshot 5](images/image5.png)

# Task 4. Create PersistentVolumeClaim.
Create and apply [pvc-pod.yaml](pvc-pod.yaml)
![Screenshot 6](images/image6.png)

From Amazon Console installed Amazon EBS CSI Driver for the cluster:
![Screenshot 7](images/image7.png)
![Screenshot 8](images/image8.png)

Create and apply [storageclass.yaml](storageclass.yaml), re-apply updated pvc.yaml, re-start the pod:
![Screenshot 9](images/image9.png)


# Task 5. Run Job.
Create and apply [job.yaml](job.yaml).
![Screenshot 10](images/image10.png)

# Task 6. Deploy test app.
Create and apply [test-app-deployment.yaml](test-app-deployment.yaml) and [test-app-service.yaml](test-app-service.yaml):
![Screenshot 11](images/image11.png)

Test:
![Screenshot 12](images/image12.png)

# Task 7. Create namespace.
```
kubectl create namespace dev
```

Create and apply [busybox-dev.yaml](busybox-dev.yaml):
![Screenshot 13](images/image13.png)

# Task 8. Cleanup resources.

```
kubectl delete namespace dev
kubectl delete deployment nginx-website test-app
kubectl delete service nginx-service test-app-service
kubectl delete pvc ebs-pvc
kubectl delete pod pvc-pod
kubectl delete job echo-job
```
![Screenshot 14](images/image14.png)

```
eksctl delete cluster --name eks-demo-cluster-pl-cli --region eu-north-1
```
![Screenshot 15](images/image15.png)
