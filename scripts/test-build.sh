#!/bin/bash
# Script completo para testar toda a pipeline localmente (incluindo Dart Sass)

set -e

echo "🧪 Testando pipeline completa da GitHub Action..."
echo ""

# 1. Verificar Hugo Extended
echo "1️⃣  Verificando Hugo Extended..."
if ! hugo version | grep -q "extended"; then
    echo "❌ Hugo Extended não encontrado!"
    echo ""
    echo "📥 Para instalar Hugo Extended 0.123.0:"
    echo "   wget https://github.com/gohugoio/hugo/releases/download/v0.123.0/hugo_extended_0.123.0_linux-amd64.deb"
    echo "   sudo dpkg -i hugo_extended_0.123.0_linux-amd64.deb"
    exit 1
fi
echo "   ✅ Hugo Extended instalado"

# 2. Verificar Dart Sass (opcional, mas usado na Action)
echo ""
echo "2️⃣  Verificando Dart Sass..."
if command -v dart-sass &> /dev/null || command -v sass &> /dev/null; then
    echo "   ✅ Dart Sass instalado"
else
    echo "   ⚠️  Dart Sass não encontrado (opcional, mas usado na Action)"
    echo ""
    echo "📥 Para instalar Dart Sass:"
    echo "   sudo snap install dart-sass"
    echo "   # ou com npm: npm install -g sass"
fi

# 3. Sincronizar módulos Hugo
echo ""
echo "3️⃣  Sincronizando módulos Hugo..."
hugo mod get
echo "   ✅ Módulos sincronizados"

# 4. Limpar builds anteriores
echo ""
echo "4️⃣  Limpando builds anteriores..."
rm -rf public resources
echo "   ✅ Diretórios limpos"

# 5. Build de produção
echo ""
echo "5️⃣  Executando build de produção..."
HUGO_ENVIRONMENT=production HUGO_ENV=production hugo \
    --gc \
    --minify \
    --baseURL "https://hugo-mods.github.io/"

# 6. Verificar resultado
echo ""
echo "6️⃣  Verificando resultado..."
if [ -d "public" ] && [ -f "public/index.html" ]; then
    FILE_COUNT=$(find public -type f | wc -l)
    SIZE=$(du -sh public | cut -f1)
    echo "   ✅ Build OK: $FILE_COUNT arquivos, $SIZE total"
else
    echo "   ❌ Build falhou!"
    exit 1
fi

echo ""
echo "🎉 Pipeline testada com sucesso!"
echo ""
echo "📊 Próximos passos:"
echo "   • Testar site: cd public && python3 -m http.server 8000"
echo "   • Ver em: http://localhost:8000"
echo "   • Verificar erros: hugo --gc --minify --logLevel debug"
