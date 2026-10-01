-- Jotter Planner: run this once in Supabase > SQL Editor > New query.
-- One row per signed-in user, holding the whole planner. Only that user can read or write it.

create table if not exists public.planner (
  user_id    uuid primary key references auth.users (id) on delete cascade,
  data       jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.planner enable row level security;

drop policy if exists "Own planner only" on public.planner;
create policy "Own planner only" on public.planner
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
