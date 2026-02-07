#!/bin/bash
# Script para simular o build da GitHub Action localmente

set -e

echo "🏗️  Simulando build da GitHub Action..."
echo ""

# Verificar versão do Hugo
echo "📦 Verificando Hugo..."
HUGO_VERSION=$(hugo version | grep -oP 'v\K[0-9]+\.[0-9]+\.[0-9]+' | head -1)
REQUIRED_VERSION="0.123.0"

if [ "$HUGO_VERSION" != "$REQUIRED_VERSION" ]; then
    echo "⚠️  WARNING: Hugo version $HUGO_VERSION difere da Action ($REQUIRED_VERSION)"
    echo "   Considere instalar a versão correta para garantir compatibilidade"
else
    echo "✅ Hugo $HUGO_VERSION (OK)"
fi

# Verificar se é Hugo Extended
if ! hugo version | grep -q "extended"; then
    echo "❌ ERROR: Hugo Extended é necessário!"
    exit 1
fi

# Limpar build anterior
echo ""
echo "🧹 Limpando build anterior..."
rm -rf public resources

# Build com as mesmas flags da Action
echo ""
echo "🚀 Executando build..."
HUGO_ENVIRONMENT=production HUGO_ENV=production hugo \
    --gc \
    --minify \
    --baseURL "https://hugo-mods.github.io/"

echo ""
echo "✅ Build concluído com sucesso!"
echo "📁 Arquivos gerados em: ./public/"
echo ""
echo "💡 Para testar localmente:"
echo "   cd public && python3 -m http.server 8000"
