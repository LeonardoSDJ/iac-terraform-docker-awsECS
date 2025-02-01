resource "aws_networkfirewall_firewall_policy" "politica" {
  name = "${var.ambiante}-politica"

  firewall_policy {
    stateless_default_actions          = ["aws:forward_to_sfe"]
    stateless_fragment_default_actions = ["aws:forward_to_sfe"]

    stateful_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.bloquear_dominios.arn
    }
  }
}

resource "aws_networkfirewall_rule_group" "bloquear_dominios" {
  capacity = 100
  name     = "${var.ambiante}-bloquear-dominios"
  type     = "STATEFUL"
  rule_group {
    rules_source {
      rules_source_list {
        generated_rules_type = "DENYLIST"
        target_types        = ["HTTP_HOST", "TLS_SNI"]
        # targets            = [".malicious.com"] # Exemplo de uso
      }
    }
  }
}

resource "aws_networkfirewall_firewall" "main" {
  name                = "${var.ambiante}-firewall"
  firewall_policy_arn = aws_networkfirewall_firewall_policy.politica.arn
  vpc_id              = module.vpc.vpc_id

  dynamic "subnet_mapping" {
    for_each = module.vpc.public_subnets
    content {
      subnet_id = subnet_mapping.value
    }
  }
} 