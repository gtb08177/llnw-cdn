# Define my SSH key here for lightsail instances and call it ryan
resource "aws_lightsail_key_pair" "ryan" { 
    name = "ryanskey"
    public_key = file("~/.ssh/id_rsa.pub")
}

# Define my SSH key here for lightsail instances and call it ryan_sydney
# not required but means easily configurable to use a different key.
resource "aws_lightsail_key_pair" "ryan_sydney" { 
    name = "ryanskey"
    public_key = file("~/.ssh/id_rsa.pub")
    provider = aws.sydney
}

# Defined my name servers by hand rather than in terraform so i don't have
# to repopulate on every apply / destroy.
data "aws_route53_zone" "mcnulty_network" {
    name = "mcnulty.network." # '.' at end since zone name
}