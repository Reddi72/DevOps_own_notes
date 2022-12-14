provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

resource "aws_instance" "ec2_server" {
  name = "terraform_instance"
  ami = "ami-05fa00d4c63e32376"
  instance_type = "t2.micro"
  key_name = "aws"
}
  tags = {
    name = "terraform_instnce"
  }

#create iam user for access key id secret access key.
#aws configure
# give the access key id and secret access key in command line intreptr
# terraform init  --> terraform intialized  -- .terraform created in this all terraform plugins
# terraform validate ----> check the syntax
# terraform paln ---> check the plan what can create ---> and terrafom.tfstate folder created
#terraform apply  ---> creating the server in aws
# terrafrom destroy ---> delete the server


