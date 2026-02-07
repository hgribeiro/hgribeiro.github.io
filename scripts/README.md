# Scripts de Build

Scripts para testar o build localmente, simulando a GitHub Action.

## 🚀 build-local.sh

Script simples para fazer build de produção localmente.

```bash
./scripts/build-local.sh
```

**O que faz:**
- Verifica versão do Hugo Extended
- Limpa builds anteriores (`public/`, `resources/`)
- Executa build de produção com as mesmas flags da Action
- Mostra instruções para testar o site

**Uso após o build:**
```bash
cd public
python3 -m http.server 8000
# Abra http://localhost:8000 no navegador
```

## 🧪 test-build.sh

Script completo que simula toda a pipeline da GitHub Action.

```bash
./scripts/test-build.sh
```

**O que faz:**
1. Verifica Hugo Extended instalado
2. Verifica Dart Sass (opcional)
3. Sincroniza módulos Hugo (`hugo mod get`)
4. Limpa builds anteriores
5. Executa build de produção
6. Valida resultado (conta arquivos, tamanho)

**Quando usar:**
- Antes de fazer push para validar que o build vai funcionar na Action
- Para depurar problemas de build
- Para testar mudanças em módulos Hugo

## 📋 Requisitos

- **Hugo Extended** (preferencialmente v0.123.0 para match com a Action)
- **Git** (para sincronizar módulos Hugo)
- Dart Sass (opcional, mas recomendado)

### Instalar Hugo Extended 0.123.0

```bash
wget https://github.com/gohugoio/hugo/releases/download/v0.123.0/hugo_extended_0.123.0_linux-amd64.deb
sudo dpkg -i hugo_extended_0.123.0_linux-amd64.deb
```

### Instalar Dart Sass

```bash
# Via snap (recomendado - usado na Action)
sudo snap install dart-sass

# Via npm
npm install -g sass
```

## 🔍 Troubleshooting

**"Hugo Extended não encontrado"**
- Instale o Hugo Extended usando as instruções acima
- Verifique com: `hugo version | grep extended`

**"Build falhou"**
- Execute com debug: `hugo --gc --minify --logLevel debug`
- Verifique se os módulos estão sincronizados: `hugo mod get`

**Warning sobre versão do Hugo**
- Os scripts funcionam com versões diferentes, mas pode haver pequenas diferenças
- Para garantir 100% de compatibilidade com a Action, use Hugo 0.123.0
