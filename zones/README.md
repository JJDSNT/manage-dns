# Gerenciamento de Zonas DNS

Este diretório contém as configurações do Terraform responsáveis por gerenciar as **zonas DNS públicas** de múltiplos domínios, utilizando o serviço **Google Cloud DNS**.

Cada subdiretório representa uma zona DNS separada e possui seu próprio state remoto, isolado por meio do `prefix` no bucket GCS.

---

## 📁 Estrutura

```bash
zones/
├── observatudo.com.br/
│   ├── backend.tf           # State remoto isolado por zona
│   ├── zone.tf              # Criação da zona DNS
│   ├── root-and-www.tf      # Registros A e CNAME principais
│   └── jdias.tf             # Subdomínio jdias.observatudo.com.br
├── foo.com.br/
│   └── ... (em breve)

```
---

## 🧩 Backend remoto por zona

Cada zona utiliza seu próprio bloco `backend "gcs"` com um `prefix` exclusivo para manter o state isolado:

```hcl
terraform {
  backend "gcs" {
    bucket  = "terraform-state-observatudo"
    prefix  = "zones/observatudo.com.br"
  }
}
```

Essa separação garante organização, facilita o controle de alterações e evita conflitos entre domínios distintos.

---

## 📦 Como aplicar ou remover zonas

### ✅ Para aplicar (criar ou atualizar) uma zona específica:

Navegue até o diretório da zona e execute os comandos padrão do Terraform:

```bash
cd zones/observatudo.com.br
terraform init
terraform plan
terraform apply
```

### ❌ Para deletar uma zona DNS:

Se você quiser remover completamente a zona e seus registros DNS do Google Cloud:

```bash
cd zones/observatudo.com.br
terraform destroy
```

> ⚠️ **Atenção**: isso apagará a zona DNS no Cloud DNS, tornando o domínio não resolvível até que uma nova zona seja criada ou outro provedor assuma a autoridade.


---

## 🛡️ Segurança

- Nenhum segredo é armazenado neste diretório.
- O estado remoto (`terraform.tfstate`) é salvo de forma segura no bucket GCS criado em `infra-base/`.
- A aplicação é realizada por uma **Service Account com permissões mínimas**, autenticada via CI/CD.

---

## 📌 Observação

Este repositório demonstra como aplicar práticas modernas de **GitOps** ao gerenciamento de DNS público, com:

- ✅ Separação clara por domínio
- ✅ Controle de versões da infraestrutura
- ✅ Segurança no manuseio do estado remoto
- ✅ Boa organização para projetos pessoais ou corporativos

---
