-- ============================================================
-- CONTROL PRO — Migração para Supabase (dados compartilhados)
-- Cole este script inteiro no SQL Editor do Supabase e clique em RUN.
-- ============================================================

-- Tabela única que guarda cada "bloco de dados" do sistema (projetos,
-- lista de produção, semana aberta, histórico e calculadora de fibra)
-- como um JSON, um por linha, identificado por uma chave (key).
create table if not exists public.app_state (
  key text primary key,
  value jsonb not null,
  updated_at timestamptz not null default now()
);

-- Habilita Row Level Security (obrigatório no Supabase)
alter table public.app_state enable row level security;

-- Como o sistema usa uma senha única compartilhada (não Supabase Auth),
-- liberamos leitura e escrita para a chave "anon" (a mesma chave pública
-- usada no app). Isso é intencional: quem tem o link + senha do app
-- consegue ler/gravar. Não coloque dados sigilosos/sensíveis aqui.
create policy "Permitir leitura para todos (anon)"
  on public.app_state for select
  to anon
  using (true);

create policy "Permitir inserção para todos (anon)"
  on public.app_state for insert
  to anon
  with check (true);

create policy "Permitir atualização para todos (anon)"
  on public.app_state for update
  to anon
  using (true)
  with check (true);

-- Habilita o Realtime nessa tabela (faz as edições aparecerem
-- automaticamente pros outros funcionários, sem precisar dar F5)
alter publication supabase_realtime add table public.app_state;

-- Índice auxiliar (opcional, ajuda se um dia a tabela crescer muito)
create index if not exists app_state_updated_at_idx on public.app_state (updated_at);
