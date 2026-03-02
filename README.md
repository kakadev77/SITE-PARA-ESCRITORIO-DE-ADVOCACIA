# Sistema Juridico - Escritorio de Advocacia

Sistema web com frontend em HTML/CSS/JS e backend Node.js + MongoDB.

## Estrutura

- `backend/` API Express + MongoDB
- `css/` estilos
- `js/` scripts de interface e integracao com API
- `*.html` paginas do sistema

## Rodar localmente

1. Configure `backend/.env` (use `backend/.env.example` como base).
2. Instale dependencias:

```bash
cd backend
npm install
```

3. Inicie o backend:

```bash
npm start
```

4. Abra no navegador:

- `http://localhost:5000/login.html`

## API principal

- `/api/auth`
- `/api/clientes`
- `/api/financeiro`
- `/api/cobrancas`
- `/api/documentos`
- `/api/usuarios`
- `/api/configuracoes`
- `/api/auditoria`
- `/api/backup`

## Deploy

Veja [DEPLOY_GITHUB_RENDER.md](./DEPLOY_GITHUB_RENDER.md).
