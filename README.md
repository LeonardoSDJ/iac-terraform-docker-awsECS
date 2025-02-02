# Infraestrutura como Código com Docker e Terraform na AWS

## 📝 Resumo do Projeto

Este projeto foi inicialmente desenvolvido durante o curso: "Infraestrutura como código: Terraform, Docker e Elastic Container Service" da plataforma Alura, focando em Infraestrutura como Código (IaC) com Docker e Terraform, utilizando a AWS como provedor de infraestrutura. Posteriormente, o projeto foi expandido com melhorias para aprofundamento dos estudos.

## 🔨 Funcionalidades do Projeto

- Criação automatizada de ambientes para aplicações Docker
- Separação de código em múltiplos ambientes conforme necessidades específicas
- Desenvolvimento acelerado através da criação de módulos no Terraform

## ✔️ Tecnologias e Técnicas Base

- **ECS (Elastic Container Service) com Fargate**: Criação automatizada de máquinas para execução de containers Docker
- **Módulos Terraform**: Utilização de módulos desenvolvidos pelos provedores e comunidade
- **Elastic Container Registry (ECR)**: Repositório AWS para armazenamento de imagens de containers
- **Multi-ambiente**: Implementação de dois ambientes distintos com reutilização de código via Terraform

## 🔧 Melhorias Pós-curso

### Monitoramento e Observabilidade
- Integração com CloudWatch Logs para visibilidade aprimorada das aplicações
- Implementação de métricas personalizadas no CloudWatch
- Configuração de sistema de alarmes para recursos críticos (CPU, memória, etc.)
- Implementação de rastreamento distribuído com AWS X-Ray

### Segurança
- Proteção contra ataques web através do AWS WAF no Application Load Balancer
- Implementação de proteção DDoS com AWS Shield
- Refinamento das políticas IAM seguindo o princípio do menor privilégio
- Gerenciamento seguro de secrets através do AWS Secrets Manager

### Networking
- Implementação de endpoints VPC para serviços AWS
- Aprimoramento na segmentação de rede
- Integração com AWS Network Firewall
- Implementação de Transit Gateway para comunicação inter-VPC

## 🛠️ Configuração e Execução

1. Instale o Visual Studio Code (VSC)
2. Instale a extensão HashiCorp Terraform (Ctrl+Shift+X)
3. Clone ou extraia o projeto em sua máquina local
4. Abra um terminal no diretório do projeto
5. Navegue até `env/Prod`
6. Execute `terraform init` para inicializar
7. Execute `terraform apply` para criar a infraestrutura

> Nota: Certifique-se de ter as credenciais AWS configuradas adequadamente antes de executar os comandos Terraform.

## 👨‍💻 Desenvolvimento

O projeto base foi desenvolvido durante o curso da Alura, e as melhorias adicionais em monitoramento, segurança e networking foram implementadas posteriormente como parte de um estudo adiccional que realizei.
