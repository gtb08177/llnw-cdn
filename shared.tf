# Push key to default region - eu-west-1
resource "aws_lightsail_key_pair" "ryan" { 
    name = "ryanskey"
    public_key = file("~/.ssh/id_rsa.pub")
}

# Push key to secondary region
resource "aws_lightsail_key_pair" "ryan_sydney" { 
    name = "ryanskey"
    provider = aws.sydney
    public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_route53_zone" "mcnulty_network" {
    name = "mcnulty.network." # '.' at end since zone name
}