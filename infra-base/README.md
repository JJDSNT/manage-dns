# Infraestrutura Base - manage-dns

Este diretório contém os recursos de infraestrutura essenciais para permitir que o repositório [`manage-dns`](../) funcione corretamente com Terraform, GitOps e CI/CD.

---

## 🔧 O que é provisionado aqui

- 🪣 **Bucket no Google Cloud Storage (GCS)** para armazenar o state remoto do Terraform
- 👤 **Service Account** dedicada para execução automatizada do Terraform via CI/CD
- 🔐 **Permissões IAM mínimas** para permitir que essa conta gerencie apenas recursos de DNS no GCP

---

## 📁 Estrutura

```bash
infra-base/
├── bucket.tf              # Criação do bucket GCS
├── service-account.tf     # Criação da SA que será usada no CI
├── iam.tf                 # Permissões mínimas (DNS Admin restrito à zona)
├── variables.tf           # (opcional) para personalização futura
└── README.md              # Este arquivo
```

---

## 🚨 Aviso

**Nenhuma chave de autenticação é criada ou armazenada neste repositório.**  
A autenticação no CI/CD deve ser feita com segurança via [GitHub Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets).

---

## 📦 Uso

```bash
cd infra-base
terraform init
terraform plan
terraform apply
```
> Execute esse provisionamento apenas uma vez no início do projeto. Após isso, o repositório principal (`terraform/`) já poderá operar com state remoto no bucket criado aqui.

---

## 📌 Próximo passo

Após aplicar esta infraestrutura base, inicie o uso do Terraform no diretório [`terraform/`](../terraform) com o seguinte comando:

```bash
cd ../terraform
terraform init
```
Isso irá inicializar o backend remoto usando o bucket criado nesta etapa.

---

## 🧩 Dependências

- Projeto GCP previamente criado
- Permissão para:
  - Criar buckets no Google Cloud Storage (GCS)
  - Criar Service Accounts
  - Atribuir permissões IAM (por exemplo: DNS Admin)

---

