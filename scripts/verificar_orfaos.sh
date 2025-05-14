#!/bin/bash

# === 💡 Cores para terminal ===
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
NC="\033[0m" # No Color

# === 📌 Parâmetros ===
if [[ "$1" == "--summary" ]]; then
  SUMMARY_MODE=true
  shift
else
  SUMMARY_MODE=false
fi

PROJECT_ID="${PROJECT_ID:-${1:-observatudo-infra}}"
EXPECTED_LABELS=(${EXPECTED_LABELS[@]:-infra-base dns-zones-observatudo observatudo-www-app})

# === 📂 Diretório de saída ===
OUTPUT_DIR="output"
mkdir -p "$OUTPUT_DIR"

# === 📄 Arquivos de saída ===
ALL_ASSETS_FILE="$OUTPUT_DIR/all-assets.json"
ORPHANS_FILE="$OUTPUT_DIR/possible-orphans.json"
CSV_FILE="$OUTPUT_DIR/possible-orphans.csv"

# === 🛰️ Coleta de dados gerais (Asset Inventory) ===
echo -e "${YELLOW}📦 Coletando todos os recursos do projeto: $PROJECT_ID...${NC}"
gcloud asset search-all-resources --project="$PROJECT_ID" --format=json > "$ALL_ASSETS_FILE"

# === 🧠 Filtro de órfãos (sem labels ou labels inválidos) ===
echo -e "${YELLOW}🔍 Filtrando recursos órfãos (sem label 'provisioned_by' ou valor inesperado)...${NC}"
jq --argjson expected_labels "$(printf '%s\n' "${EXPECTED_LABELS[@]}" | jq -R . | jq -s .)" '
  map(select(
    (.labels.provisioned_by == null) or
    (.labels.provisioned_by != null and (.labels.provisioned_by as $val | $expected_labels | index($val) | not))
  ))
' "$ALL_ASSETS_FILE" > "$ORPHANS_FILE"

COUNT=$(jq length "$ORPHANS_FILE")
echo -e "${GREEN}✅ Resultado salvo em: $ORPHANS_FILE${NC}"
echo -e "${YELLOW}⚠️  Recursos órfãos encontrados: $COUNT${NC}"

echo -e "${YELLOW}📊 Tipos de recursos órfãos:${NC}"
jq '.[].assetType' "$ORPHANS_FILE" | sort | uniq -c

jq -r '.[] | [.assetType, .name] | @csv' "$ORPHANS_FILE" > "$CSV_FILE"
echo -e "${GREEN}📄 CSV gerado em: $CSV_FILE${NC}"

# === ✅ Modo resumo termina aqui ===
if [[ "$SUMMARY_MODE" == true ]]; then
  exit 0
fi

# === 🔐 Auditoria de Service Accounts ===
SA_FILE="$OUTPUT_DIR/iam-service-accounts.json"
SA_ORPHANS_FILE="$OUTPUT_DIR/iam-service-account-orphans.json"

echo -e "${YELLOW}🔍 Coletando todas as Service Accounts...${NC}"
gcloud iam service-accounts list --project="$PROJECT_ID" --format=json > "$SA_FILE"

jq '
  map(select(
    (.labels == null) or (.labels.provisioned_by == null)
  ))
' "$SA_FILE" > "$SA_ORPHANS_FILE"

SA_ORPHANS_COUNT=$(jq length "$SA_ORPHANS_FILE")
echo -e "${YELLOW}⚠️  Service Accounts sem 'provisioned_by': $SA_ORPHANS_COUNT${NC}"
echo -e "${GREEN}📄 Detalhes salvos em: $SA_ORPHANS_FILE${NC}"

# === 🔐 Auditoria de IAM bindings com Service Accounts ===
IAM_BINDINGS_FILE="$OUTPUT_DIR/iam-bindings.json"
IAM_SA_BINDINGS_FILE="$OUTPUT_DIR/iam-bindings-service-accounts.json"

echo -e "${YELLOW}🔍 Coletando todos os IAM bindings do projeto...${NC}"
gcloud projects get-iam-policy "$PROJECT_ID" --format=json > "$IAM_BINDINGS_FILE"

jq '
  .bindings
  | map(select(.members[]? | startswith("serviceAccount:")))
' "$IAM_BINDINGS_FILE" > "$IAM_SA_BINDINGS_FILE"

IAM_SA_BINDINGS_COUNT=$(jq length "$IAM_SA_BINDINGS_FILE")
echo -e "${YELLOW}⚠️  Total de papéis atribuídos a service accounts: $IAM_SA_BINDINGS_COUNT${NC}"
echo -e "${GREEN}📄 Bindings com SAs salvos em: $IAM_SA_BINDINGS_FILE${NC}"
