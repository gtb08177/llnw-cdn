resource "aws_lightsail_instance" "edge" {
    name = "edge-${count.index+1}"
    availability_zone = "eu-west-1a"
    blueprint_id = "ubuntu_18_04"
    bundle_id = "nano_1_0"
    key_pair_name = aws_lightsail_key_pair.ryan.name
    count = "2"
}

# No name conflict as the resource types are different
resource "aws_route53_record" "edge_servers" { 
    zone_id = data.aws_route53_zone.mcnulty_network.zone_id
    name = "edge-${count.index+1}.llnw.${data.aws_route53_zone.mcnulty_network.name}"
    type = "A"
    ttl = "60"
    records = [aws_lightsail_instance.edge.*.public_ip_address[count.index]] # .* due to multiple edges thanks to count above.
    count = "2" # TODO pull out to variable later
}

# No name conflict as the resource types are different
resource "aws_route53_record" "cdn" { 
    zone_id = data.aws_route53_zone.mcnulty_network.zone_id
    name = "edge.llnw.${data.aws_route53_zone.mcnulty_network.name}"
    type = "A"
    ttl = "60"
    records = aws_lightsail_instance.edge.*.public_ip_address # .* due to multiple edges thanks to count above.
}