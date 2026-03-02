#!/bin/bash
# Script de Setup Rápido para Linux/Mac

echo "====================================="
echo "SETUP RÁPIDO - Sistema Jurídico"
echo "====================================="

# Verificar se Node.js está instalado
echo ""
echo "📦 Verificando Node.js..."
if ! command -v node &> /dev/null; then
    echo "❌ Node.js não está instalado!"
    echo "Baixe em: https://nodejs.org/"
    exit 1
fi
echo "✅ Node.js $(node -v) instalado"

# Ir para pasta backend
echo ""
echo "📁 Entrando na pasta backend..."
cd backend || exit

# Instalar dependências
echo ""
echo "📥 Instalando dependências..."
npm install

# Criar .env
echo ""
echo "⚙️  Criando arquivo .env..."

if [ ! -f ".env" ]; then
    cat > .env << EOF
MONGODB_URI=mongodb+srv://usuario:senha@seu_cluster.mongodb.net/sistemajuridico?retryWrites=true&w=majority
PORT=5000
NODE_ENV=development
JWT_SECRET=sua_chave_secreta_super_segura_2024
CORS_ORIGIN=http://localhost
EOF
    echo "✅ Arquivo .env criado"
    echo "📝 Edite .env e adicione sua URL do MongoDB!"
else
    echo "⚠️  .env já existe (não sobrescrevendo)"
fi

echo ""
echo "====================================="
echo "✅ SETUP CONCLUÍDO!"
echo "====================================="
echo ""
echo "📝 Próximos passos:"
echo "1. Edite backend/.env com suas credenciais MongoDB"
echo "2. Execute: npm run dev"
echo "3. Acesse: http://localhost:5000/api/health"
echo "4. Abra login.html no seu navegador"
echo ""
