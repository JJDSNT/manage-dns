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

# === 🛰️ Coleta de dados ===
echo -e "${YELLOW}📦 Coletando todos os recursos do projeto: $PROJECT_ID...${NC}"
gcloud asset search-all-resources --project="$PROJECT_ID" --format=json > "$ALL_ASSETS_FILE"

# === 🧠 Filtro de órfãos ===
echo -e "${YELLOW}🔍 Filtrando recursos órfãos (sem label 'provisioned_by' ou valor inesperado)...${NC}"

jq --argjson expected_labels "$(printf '%s\n' "${EXPECTED_LABELS[@]}" | jq -R . | jq -s .)" '
  map(select(
    (.labels.provisioned_by == null) or
    (.labels.provisioned_by != null and (.labels.provisioned_by as $val | $expected_labels | index($val) | not))
  ))
' "$ALL_ASSETS_FILE" > "$ORPHANS_FILE"

# === 📊 Resumo ===
COUNT=$(jq length "$ORPHANS_FILE")
echo -e "${GREEN}✅ Resultado salvo em: $ORPHANS_FILE${NC}"
echo -e "${YELLOW}⚠️  Recursos órfãos encontrados: $COUNT${NC}"

echo -e "${YELLOW}📊 Tipos de recursos órfãos:${NC}"
jq '.[].assetType' "$ORPHANS_FILE" | sort | uniq -c

# === 📄 Geração de CSV ===
jq -r '.[] | [.assetType, .name] | @csv' "$ORPHANS_FILE" > "$CSV_FILE"
echo -e "${GREEN}📄 CSV gerado em: $CSV_FILE${NC}"

# === ✅ Modo resumo para CI ou pipelines ===
if [[ "$SUMMARY_MODE" == true ]]; then
  exit 0
fi

