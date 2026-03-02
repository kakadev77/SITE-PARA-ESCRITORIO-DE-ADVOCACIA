# ?? Guia Completo - Sistema Jur�dico com Banco de Dados

## ?? O que foi criado?

Voc� agora tem um **sistema completo com autentica��o e armazenamento em nuvem**:

? **Frontend** - Interface HTML/CSS/JavaScript (j� existente)  
? **Backend** - Servidor Node.js + Express  
? **Banco de Dados** - MongoDB na nuvem (MongoDB Atlas)  
? **Autentica��o** - JWT + Hash de senha com bcrypt  
? **Sincroniza��o** - Dados salvos na nuvem, acess�veis de qualquer dispositivo

---

## ??? PASSO A PASSO DE INSTALA��O

### PASSO 1: Configurar MongoDB Atlas (Banco de Dados)

1. Acesse [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Crie uma conta gratuita
3. Crie um novo projeto
4. Crie um cluster (escolha "M0 Free" - gr�tis)
5. Espere 3-5 minutos para criar
6. Acesse "Database Access" e crie um usu�rio:
   - **Username**: `usuario`
   - **Password**: `senha123` (use uma senha segura!)
7. V� para "Network Access" e adicione "0.0.0.0/0" (permite acesso de qualquer IP)
8. Clique em "Connect" e escolha "Connect your Application"
9. Copie a URL: `mongodb+srv://usuario:senha123@cluster.mongodb.net/`

### PASSO 2: Configurar o Backend

```bash
# 1. Ir para a pasta backend
cd backend

# 2. Instalar depend�ncias
npm install

# 3. Criar arquivo .env
# Copie o conte�do de .env.example e preencha:
```

**Criar arquivo: `backend/.env`**
```env
# Copie a URL do MongoDB Atlas e substitua user:password
MONGODB_URI=mongodb+srv://usuario:senha123@cluster.mongodb.net/sistemajuridico?retryWrites=true&w=majority

PORT=5000
NODE_ENV=development
JWT_SECRET=sua_chave_super_segura_2024_sistema_juridico
CORS_ORIGIN=http://localhost
```

### PASSO 3: Rodar o Backend

```bash
# Em desenvolvimento (com auto-reload):
npm run dev

# Ou em produ��o:
npm start
```

**Voc� deve ver:**
```
? MongoDB Conectado: cluster.mongodb.net
?? Servidor rodando em http://localhost:5000
```

### PASSO 4: Testar a Conex�o

Abra seu navegador e acesse:
```
http://localhost:5000/api/health
```

Deve aparecer:
```json
{ "status": "Servidor online ?" }
```

### PASSO 5: Atualizar URL da API no Frontend

**Abra: `js/api.js`**

Na primeira linha, verifique se est� correto:
```javascript
const API_URL = 'http://localhost:5000/api';
```

Se o servidor estiver em outro computador, mude para:
```javascript
const API_URL = 'http://192.168.1.100:5000/api';  // IP do servidor
```

### PASSO 6: Abrir o Sistema

1. Abra `index.html` ou `login.html` no navegador
2. Crie uma conta
3. Fa�a login
4. Os dados ser�o salvos no MongoDB!

---

## ? Como Verificar se Est� Funcionando?

### Teste 1: Criar Conta
1. Clique em "Crie uma aqui" no login
2. Preencha os dados
3. Clique em "Criar Conta"
4. Voc� deve ser redirecionado para o dashboard

### Teste 2: Verificar no MongoDB
1. Acesse [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Clique em "Collections" no seu cluster
3. Voc� deve ver uma database `sistemajuridico`
4. Dentro dela, cole��es: `usuarios`, `clientes`, `casos`, `financeiro`

### Teste 3: Trocar de Navegador/Dispositivo
1. Fa�a login em outro navegador/computador
2. Seus dados devem estar l�!

---

## ?? Colocar em Produ��o (Para Clientes)

### Op��o 1: Servidor Local (Empresa)
```bash
# Na empresa, instale Node.js
# Rode o backend em um computador sempre ligado
npm run dev

# Clientes acessam via IP interno
http://IP_EMPRESA:5000
```

### Op��o 2: Cloud (Recomendado)
Use servi�os gr�tis como:

#### Heroku (Backend)
1. Crie conta em [Heroku](https://heroku.com)
2. Instale Heroku CLI
3. Na pasta `backend`:
```bash
heroku login
heroku create nome-app-seu
git push heroku main
heroku config:set MONGODB_URI="mongodb+srv://..."
```

#### Firebase Hosting (Frontend)
1. Instale Firebase CLI: `npm install -g firebase-tools`
2. Na pasta raiz:
```bash
firebase login
firebase init hosting
firebase deploy
```

---

## ?? Seguran�a

?? **IMPORTANTE:**

1. **Nunca compartilhe o `.env`** - Cont�m senhas
2. **Use HTTPS em produ��o** - N�o apenas HTTP
3. **Altere JWT_SECRET** - Use uma senha forte
4. **Senhas s�o criptografadas** - Mesmo admin n�o v�
5. **Tokens expiram em 30 dias** - Seguran�a extra

---

## ?? Problemas Comuns

### "MongoDB not connected"
- Verifique credenciais em `.env`
- Adicione seu IP em MongoDB Atlas > Network Access

### "CORS error"
- Atualize `CORS_ORIGIN` em `.env`
- Exemplo: `CORS_ORIGIN=http://localhost:3000`

### "Cannot find module"
- Execute: `npm install`
- Certifique-se de estar em `backend/` folder

### "Port 5000 already in use"
- Mude em `.env`: `PORT=5001`
- Ou mate o processo: `lsof -ti:5000 | xargs kill -9`

---

## ?? API Alguns Exemplos

### Registrar Novo Usu�rio
```bash
curl -X POST http://localhost:5000/api/auth/registro \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "Jo�o Advogado",
    "email": "joao@email.com",
    "senha": "senha123"
  }'
```

### Fazer Login
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "joao@email.com",
    "senha": "senha123"
  }'
```

Retorna:
```json
{
  "token": "eyJhbGc...",
  "usuario": {
    "_id": "...",
    "nome": "Jo�o",
    "email": "joao@email.com"
  }
}
```

### Criar Cliente (com token)
```bash
curl -X POST http://localhost:5000/api/clientes \
  -H "Authorization: Bearer SEU_TOKEN_AQUI" \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "Cliente XYZ",
    "telefone": "(11) 99999-9999",
    "tipoCliente": "Pessoa F�sica"
  }'
```

---

## ?? Pr�ximos Passos

1. **Teste localmente** - Crie contas, clientes, casos
2. **Configure produ��o** - Use Heroku ou servidor pr�prio
3. **Compartilhe com clientes** - URL + instru��es
4. **Fa�a backup** - MongoDB Atlas autom�tico
5. **Customize** - Adicione mais campos conforme necess�rio

---

## ?? Suporte

Se tiver d�vidas:
- Verifique os logs do servidor: `npm run dev`
- Consulte documenta��o: [Node.js](https://nodejs.org) | [MongoDB](https://docs.mongodb.com)
- Teste a API: [Postman](https://postman.com)

---

**?? Pronto! Seu sistema est� completo e pronto para usar!**
