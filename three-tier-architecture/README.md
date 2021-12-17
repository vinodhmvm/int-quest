# three-tier-architecture

The code in this repo is an 3-tier(App,Web and DB Tier) environment setup. I have used Terraform as a IaC(Infrastructure as Code) tool to build the environment. For resusability purpose I have created this code as an module and called when ever required.

## Requirements

- AWS Account Credentials.
- Terraform installed environment. To download the necessary Terraform binary refer [here](https://www.terraform.io/downloads).
- VS Code(In case you need to edit your code). To know about it refere [here](https://www.terraform.io/downloads)

## Providers

```shell
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
```
## Inputs

- VPC Input:

```text
aws_cidr_block                 CIDR Block for creating the VPC(Default: 10.0.0.0/16)
aws_public_subnet_1            CIDR Block for creating the Public Subnet 1 will be used for Availability Zone A(Default: 10.0.1.0/24)
aws_public_subnet_2            CIDR Block for creating the Public Subnet 2 will be used for Availability Zone B(Default: 10.0.2.0/24)
aws_private_subnet_3           CIDR Block for creating the Private Subnet 1 will be used for Availability Zone A(Default: 10.0.3.0/24)
aws_private_subnet_4           CIDR Block for creating the Private Subnet 2 will be used for Availability Zone B(Default: 10.0.4.0/24)
aws_availability_zone_A        AWS Availability Zone Name(default: us-east-1a)
aws_availability_zone_B        AWS Availability Zone Name(default: us-east-1b)
aws_any_ip                     IP CIDR which is to allow any access to the instances(default: 0.0.0.0/0)
```
- ASG Input:

```text
min_asg_value                       Autoscaling group Minimum instance need to provisioned.(Deafult: 2)
max_asg_value                       Autoscaling group Maximum instance need to provisioned while the ASG Scales up.(Default: 4)
```
- AWS Common Input:

```text
region                              Region of the AWS Account where you need to deploy the resources.
aws_profile                         AWS Profile need to be selected in order to Terraform authenticate to the AWS Accounts.(Example: default)
```
- AWS EC2 Input:

```text
aws_instance_type                   AWS EC2 Instance type selection. (Default: t3.micro)
ami_id                              AWS AMI Id. The image id of the Operating system need to be deployed inside the AWS.(Default Amazon Linux AMI2: ami-0ed9277fb7eb570c9)
```
- AWS RDS DB Input:

```text
mysql_db_allocated_storage          Custom DB Size for AWS RDS Database Storage(Default: 30). Here 30 refers 30 GB.
mysql_db_storage_type               Choose the AWS RDS DB Storage Type. (Default: 'gp2')
mysql_db_engine                     Choose the AWS RDS DB Engine. (Defualt: mysql)
mysql_db_engine_version             Choose the AWS RDS DB Engine version. (Defualt: 8.0.20)
mysql_db_instance_class             Choose the Size of the AWS RDS Instance.(Defualt: db.t3.micro)
mysql_db_name                       Custom MySQL DB Name: (Example: demords)
mysql_db_username                   Custom MySQL DB Username.(Example: demordsadmin)
mysql_db_password                   Strong MySQL DB Password.(Example: Uas38y3yQWha1gVxB)
mysql_db_multi_az                   Used for the purpose of creating RDS two availability zones(Master/Slave concept) for resilence purpose.(Defualt: True)
mysql_db_port                       MySQL DB port configuration.(Defualt: 3306)
```

### Configure environment variables

```shell
aws configure
AWS Access Key ID : AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key : wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name : us-east-1
```

## Usage

The below steps explain about the steps involved in creating the infra in Code.

- Clone the Git in any of your convenient tool. I did in VS Code. Provide the necessary username and password of the github when it asks. You will get the message clone completed successfully
```shell
git clone https://github.com/vinodhmvm/intchallenge.git
```
- Do Terraform init will initialize a configuration directory downloads and installs the providers defined in the configuration, which in this case is the aws provider.
```shell
terraform init
Initializing modules...
Downloading git::ssh://git@github.com/vinodhmvm/intchallenge.git for app-stack...
- app-stack in .terraform\modules\app-stack\three-tier-architecture\tf-modules\ec2-stack
Downloading git::ssh://git@github.com/vinodhmvm/intchallenge.git for db-stack...
- db-stack in .terraform\modules\db-stack\three-tier-architecture\tf-modules\rds-stack
Downloading git::ssh://git@github.com/vinodhmvm/intchallenge.git for web-stack...
- web-stack in .terraform\modules\web-stack\three-tier-architecture\tf-modules\ec2-stack

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 3.0"...
- Installing hashicorp/aws v3.70.0...
- Installed hashicorp/aws v3.70.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
- I recommend using consistent formatting in all of your configuration files. The terraform fmt command automatically updates configurations in the current directory for readability and consistency. Validate your configuration using terraform validate. The example configuration provided above is valid, so Terraform will return a success message.
```shell
terraform fmt
terraform validate
Success! The configuration is valid.
```
- Apply the configuration now with the terraform apply command. Terraform will print output similar to what is shown below. I have truncated some of the output to save space.
```shell
terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.bastion will be created
  + resource "aws_instance" "bastion" {
      + ami                          = "ami-830c94e3"
      + arn                          = (known after apply)
##...

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.
```  
## Outputs

- Creates VPC with four subnets,route tables.(Two Private and Two Public)
- Creates an Web EC2 instance with the userdata mentioned in it. ALB and ASG are created.
- Creates an APP EC2 instance with the userdata mentioned in it. ALB and ASG are created.
- Creates an RDS instance.

## Authors

Author Name: Vinodh Kumar
Code Version: 1.0
Author Email id: example@example.com
