provider "aws" {
    region = "eu-west-1"
}

provider "aws" {
    alias = "sydney"
    region = "ap-southeast-2"
}