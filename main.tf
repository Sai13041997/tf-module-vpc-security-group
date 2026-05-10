resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each          = { for rule in var.inbound_rules : "${var.name}-ingress-${rule.cidr_ipv4}-${lookup(rule, "from_port", "all")}" => rule }
  security_group_id = aws_security_group.this.id
  description       = lookup(each.value, "description", null)
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = lookup(each.value, "from_port", null)
  to_port           = lookup(each.value, "to_port", null)
  ip_protocol       = each.value.ip_protocol
}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each          = { for rule in var.outbound_rules : "${var.name}-egress-${rule.cidr_ipv4}-${lookup(rule, "from_port", "all")}" => rule }
  security_group_id = aws_security_group.this.id
  description       = lookup(each.value, "description", null)
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = lookup(each.value, "from_port", null)
  to_port           = lookup(each.value, "to_port", null)
  ip_protocol       = each.value.ip_protocol
}


resource "aws_vpc_security_group_ingress_rule" "self_rule" {
  count                        = var.self_referencing ? 1 : 0
  security_group_id            = aws_security_group.this.id
  description                  = "security group that allows traffic from resources assigned to the same securiy group"
  referenced_security_group_id = aws_security_group.this.id
  ip_protocol                  = "-1"
}
