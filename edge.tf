# Create one or more instances of AWS Lightsail.
# Good benefit is has a static IP by default.
resource "aws_lightsail_instance" "edge" {
    name = "edge-${count.index+1}"
    availability_zone = "eu-west-1a"
    blueprint_id = "ubuntu_18_04"
    bundle_id = "nano_1_0"
    key_pair_name = aws_lightsail_key_pair.ryan.name # Pulls from resource living in shared.tf
    count = "2"
}

# Create the A records in R53 for ALL the edges defined above
resource "aws_route53_record" "edge_servers" { 
    zone_id = data.aws_route53_zone.mcnulty_network.zone_id
    name = "edge-${count.index+1}.llnw.${data.aws_route53_zone.mcnulty_network.name}" # Generates dynamic hostname
    type = "A"
    ttl = "60"
    records = [aws_lightsail_instance.edge.*.public_ip_address[count.index]] # .* due to multiple edges thanks to count above.
    count = "2" # TODO pull out to variable to drive with the block above
}

# Create the A records in R53 for the 'cdn' host with all edge
# IP includes within the records.
resource "aws_route53_record" "cdn" { 
    zone_id = data.aws_route53_zone.mcnulty_network.zone_id
    name = "edge.llnw.${data.aws_route53_zone.mcnulty_network.name}"
    type = "A"
    ttl = "60"
    records = aws_lightsail_instance.edge.*.public_ip_address # .* due to multiple edges thanks to count above.
}