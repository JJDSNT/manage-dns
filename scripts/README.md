# Auditoria de Recursos GCP com Terraform

Este diretório contém utilitários para auditoria da infraestrutura GCP e validação de consistência com o que está sob gerenciamento do Terraform.

---

## 📜 Script principal

### `verificar_orfaos.sh`

Realiza as seguintes auditorias automatizadas:

1. **Recursos órfãos** (via Cloud Asset Inventory)
2. **Service Accounts (SAs)** sem `labels.provisioned_by`
3. **IAM bindings** com Service Accounts

Gera arquivos de saída JSON e CSV para análise detalhada ou integração com CI.

---

## 🚀 Como usar

### Execução padrão:

```bash
./verificar_orfaos.sh
```
## 📦 Uso avançado

### 🔀 Com projeto diferente:

```bash
PROJECT_ID=meu-outro-projeto ./verificar_orfaos.sh
```
### ⚡ Modo rápido para CI/CD:
```bash
./verificar_orfaos.sh --summary
```

### 📁 Estrutura dos arquivos gerados (`output/`)

| Arquivo                                | Conteúdo                                               |
|----------------------------------------|--------------------------------------------------------|
| all-assets.json                        | Todos os recursos do projeto via `gcloud asset`        |
| possible-orphans.json                  | Recursos sem `labels.provisioned_by` esperadas         |
| possible-orphans.csv                   | Versão CSV resumida dos órfãos                         |
| iam-service-accounts.json              | Todas as Service Accounts do projeto                   |
| iam-service-account-orphans.json       | SAs sem `provisioned_by` definido                      |
| iam-bindings.json                      | IAM policy completa do projeto                         |
| iam-bindings-service-accounts.json     | Apenas bindings com `serviceAccount:` como membro      |


### 🧠 Como interpretar os resultados

- Recursos ou SAs sem `labels.provisioned_by` são considerados **potencialmente órfãos**
- Bindings IAM com service accounts são listados para conferência com o código Terraform
- Use os arquivos `.csv` para relatórios ou automações


### 📌 Requisitos
gcloud autenticado com permissão de leitura no projeto

jq instalado (sudo apt install jq ou brew install jq)

### ✅ Sugestão de .gitignore
<pre><code> output/ </code></pre>

### ✨ Próximos passos (opcional)
Validar se os bindings IAM estão todos sob controle do Terraform

Usar terraform state list para cruzar com os recursos GCP

Automatizar alertas em CI se órfãos forem detectados