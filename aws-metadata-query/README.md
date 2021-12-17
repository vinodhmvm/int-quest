# aws-metadata-query

The code in this repo will query the meta data of an instance within AWS and provide a json formatted output. The choice of language which I have choosen is Python.

## Configure environment variables

```shell
aws configure
AWS Access Key ID : AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key : wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name : us-east-1
```

## Requirements

- Python Version 3 Installed in your machine.
- Downloaded instancemetadata using the below awscli command.
```shell
aws ec2 describe-instances --instance-ids <anyrunningec2instanceid> ./instancemetadata.json
```

## Usage

The below snips were captured while executing the above code

![1](https://user-images.githubusercontent.com/39188223/146565616-e655e13c-69f6-4d85-b6cb-99c0c12a2060.png)

![2](https://user-images.githubusercontent.com/39188223/146565747-bd50e910-1e58-4d65-8c2d-c3fb3f168498.PNG)


## Authors

Author Name: Vinodh Kumar
Code Version: 1.0
Author Email id: example@example.com
