output "public_ec2_ip" {
  description = "Public IP of the public EC2 instance"
  value       = module.public_ec2.public_ip
}

output "private_ec2_id" {
  description = "Instance ID of the private EC2"
  value       = module.private_ec2.instance_id
}
