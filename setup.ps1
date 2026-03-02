#!/bin/bash
# Script de Setup Rápido para Windows (PowerShell)

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "SETUP RÁPIDO - Sistema Jurídico" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Cyan

# Verificar se Node.js está instalado
Write-Host "`n📦 Verificando Node.js..." -ForegroundColor Yellow
if (!(Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Node.js não está instalado!" -ForegroundColor Red
    Write-Host "Baixe em: https://nodejs.org/" -ForegroundColor Yellow
    exit
}
Write-Host "✅ Node.js $(node -v) instalado" -ForegroundColor Green

# Ir para pasta backend
Write-Host "`n📁 Entrando na pasta backend..." -ForegroundColor Yellow
cd backend

# Instalar dependências
Write-Host "`n📥 Instalando dependências..." -ForegroundColor Yellow
npm install

# Criar .env
Write-Host "`n⚙️  Criando arquivo .env..." -ForegroundColor Yellow
$envContent = @"
MONGODB_URI=mongodb+srv://usuario:senha@seu_cluster.mongodb.net/sistemajuridico?retryWrites=true&w=majority
PORT=5000
NODE_ENV=development
JWT_SECRET=sua_chave_secreta_super_segura_2024
CORS_ORIGIN=http://localhost
"@

if (!(Test-Path ".env")) {
    Set-Content -Path ".env" -Value $envContent
    Write-Host "✅ Arquivo .env criado" -ForegroundColor Green
    Write-Host "📝 Edite .env e adicione sua URL do MongoDB!" -ForegroundColor Yellow
} else {
    Write-Host "⚠️  .env já existe (não sobrescrevendo)" -ForegroundColor Yellow
}

Write-Host "`n=====================================" -ForegroundColor Cyan
Write-Host "✅ SETUP CONCLUÍDO!" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "`n📝 Próximos passos:" -ForegroundColor Cyan
Write-Host "1. Edite backend/.env com suas credenciais MongoDB" -ForegroundColor White
Write-Host "2. Execute: npm run dev" -ForegroundColor White
Write-Host "3. Acesse: http://localhost:5000/api/health" -ForegroundColor White
Write-Host "4. Abra login.html no seu navegador" -ForegroundColor White
Write-Host "`n"
