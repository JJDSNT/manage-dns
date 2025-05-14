#!/bin/bash

# Nome do projeto
PROJECT_ID="observatudo-infra"
EXPECTED_LABELS=("infra-base" "dns-zones-observatudo" "observatudo-www-app")

# Arquivo temporário para armazenar todos os recursos
ALL_ASSETS_FILE="all-assets.json"
ORPHANS_FILE="possible-orphans.json"

echo "📦 Coletando todos os recursos do projeto: $PROJECT_ID..."
gcloud asset search-all-resources --project="$PROJECT_ID" --format=json > "$ALL_ASSETS_FILE"

echo "🔍 Filtrando recursos órfãos (sem label 'provisioned_by' ou valor inesperado)..."

jq --argjson expected_labels "$(printf '%s\n' "${EXPECTED_LABELS[@]}" | jq -R . | jq -s .)" '
  map(select(
    (.labels.provisioned_by == null) or
    (.labels.provisioned_by != null and (.labels.provisioned_by as $val | $expected_labels | index($val) | not))
  ))
' "$ALL_ASSETS_FILE" > "$ORPHANS_FILE"

echo "✅ Resultado salvo em: $ORPHANS_FILE"
echo "⚠️  Recursos órfãos encontrados: $(jq length "$ORPHANS_FILE")"
