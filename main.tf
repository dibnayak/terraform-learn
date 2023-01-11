provider "aws" {
    region = "ap-south-1"
}

variable "cidr_blocks" { /*can define several attributes*/
    description = "cidr blocks for vpc and subnets" 
    //default = 10.0.10.0/24 //it only works when terraform dont find the value declared 
    /*type = string //it enforces that the parameter has to be a string*/
    type = list(object({
        cidr_block = string
        name = string
    }))
}


resource "aws_vpc" "development-vpc" {
    cidr_block = var.cidr_blocks[0].cidr_block //first elemnt of tfvars file
    tags = {
        Name: var.cidr_blocks[0].name
        
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id //2nd element of tfvars list
    cidr_block = var.cidr_blocks[1].cidr_block /*reference to varibale*/
    availability_zone = "ap-south-1a" /*same as main region*/
     tags = {
        Name: var.cidr_blocks[1].name
    }
}

