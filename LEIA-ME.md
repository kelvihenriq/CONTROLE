# CONTROL PRO — Guia de Deploy (GitHub + Vercel + Supabase)

## 1. Criar a tabela no Supabase
1. Entre no seu projeto em https://supabase.com/dashboard
2. Vá em **SQL Editor** (menu lateral) → **New query**
3. Cole todo o conteúdo do arquivo `schema.sql` (junto com este guia) e clique em **RUN**
4. Confirme que a tabela `app_state` apareceu em **Table Editor**

## 2. Trocar a senha da equipe
No arquivo `CONTROLE (3) (8).html`, procure por:
```js
const TEAM_PASSWORD = 'MUDE_ESTA_SENHA';
```
Troque `'MUDE_ESTA_SENHA'` pela senha combinada com os 9 funcionários. Salve o arquivo.

> ⚠️ Importante: essa senha só protege a **tela de entrada do app**. Ela fica visível
> pra quem abrir o código-fonte da página (é normal em apps client-side simples).
> Não é criptografia militar — é uma trava de acesso básica pra time interno.
> Se no futuro vocês quiserem login individual de verdade (usuário/senha por
> pessoa, com permissões), dá pra evoluir para Supabase Auth.

## 3. Subir pro GitHub
```bash
git init
git add .
git commit -m "Control Pro - versão com Supabase"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/SEU_REPO.git
git push -u origin main
```
(Se preferir, pode simplesmente arrastar o arquivo `.html` direto pela interface web do GitHub, criando um repositório novo.)

## 4. Deploy no Vercel
1. Entre em https://vercel.com/new
2. Selecione o repositório que você acabou de criar no GitHub
3. Como é um HTML puro (sem build/framework), o Vercel já detecta automaticamente
   — não precisa configurar Build Command nem Output Directory
4. Clique em **Deploy**
5. Em alguns segundos você recebe um link tipo `https://seu-projeto.vercel.app`

Esse é o link que os 9 funcionários vão usar. Depois vocês podem trocar por
um domínio próprio (ex: `controlpro.suaempresa.com.br`) em **Settings → Domains**.

## 5. Testar a sincronização
1. Abra o link em duas abas/dispositivos diferentes
2. Digite a senha da equipe nas duas
3. Edite alguma coisa (ex: adicione um item no Dashboard) em uma aba
4. Em até ~1 segundo, a outra aba deve atualizar sozinha, sem precisar de F5

## O que já está sincronizado entre todos (tempo real):
- ✅ Dashboard de Controle (itens, status, OTs)
- ✅ Semana aberta / ciclo ativo
- ✅ Histórico de meses arquivados
- ✅ Lista de Produção & Códigos AS-BUILT
- ✅ Calculadora de Fibra (todos os "Cálculos" salvos)

## O que ainda fica só no navegador de cada pessoa (não sincronizado):
- ⚠️ Aba **Automação (Mapa)** — o PDF/imagem do mapa carregado, as caixas
  desenhadas e a chave de API de IA. Deixei assim de propósito: imagens de
  mapa são pesadas (podem chegar a vários MB), e sincronizar isso pela
  tabela `app_state` encheria rápido o limite de 500 MB do banco gratuito
  do Supabase. Se vocês quiserem essa aba também compartilhada entre a
  equipe, o caminho certo é usar o **Supabase Storage** (bucket de arquivos,
  não o banco) — posso implementar isso como próximo passo, se fizer sentido
  pra vocês.

## Backup (o plano gratuito não faz backup automático)
Recomendo, de tempos em tempos, exportar os dados pela função de Exportar
XLSX que já existe no sistema (aba Produção), ou pedir pra eu montar um botão
de "Backup Completo" que baixa um `.json` com tudo. Assim, mesmo sem backup
nativo da Supabase, vocês não dependem só da nuvem.
