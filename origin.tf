# Creates my lightsail origin in Sydney
resource "aws_lightsail_instance" "origin" {
    name = "origin"
    provider = aws.sydney
    availability_zone = "ap-southeast-2a"
    blueprint_id = "ubuntu_18_04"
    bundle_id = "nano_1_2"
    key_pair_name = aws_lightsail_key_pair.ryan_sydney.name # Push the secondary SSH key 
}

# No name conflict as the resource types are different
# Create the A record in R53 for origin
resource "aws_route53_record" "origin" { 
    zone_id = data.aws_route53_zone.mcnulty_network.zone_id
    name = "origin.llnw.${data.aws_route53_zone.mcnulty_network.name}"
    type = "A"
    ttl = "60"
    records = [aws_lightsail_instance.origin.public_ip_address] 
}