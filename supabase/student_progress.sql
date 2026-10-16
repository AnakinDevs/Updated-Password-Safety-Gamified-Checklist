-- =====================================================================
-- PassQuest: online progress for Supabase Auth (email + password)
-- Paste into Supabase Dashboard > SQL Editor > New query > Run.
-- Safe to run more than once. Does NOT touch the existing tables
-- (users, consent, user_progress, checklist_responses, user_badges,
--  leaderboard, certificates, password_checker_results, ...).
-- Supabase will show "Potential issue detected: This query includes
-- destructive operations". That is expected: the only DROPs below remove
-- this script's own trigger and policies so they can be re-created.
-- Click "Run query".
-- =====================================================================

-- 1. One row per student: profile fields + the whole progress object
create table if not exists public.student_progress (
  user_id          uuid primary key
                   default auth.uid()
                   references auth.users (id) on delete cascade,
  username         text not null check (char_length(btrim(username)) >= 3),
  name             text not null default '',
  strand           text not null default '',
  section          text not null default '',
  progress         jsonb not null default '{}'::jsonb
                   check (jsonb_typeof(progress) = 'object'),
  research_user_id bigint,  -- optional: the matching public.users.id (old passquest_user_id)
  created_at       timestamptz not null default now(),
  updated_at       timestamptz not null default now()
);

comment on table public.student_progress is
  'PassQuest: one row per Supabase Auth user. progress = the same JSON the app kept in localStorage passquest_progress_<username>.';

-- Usernames stay unique, ignoring case ("Juan" = "juan"), like the app does today.
create unique index if not exists student_progress_username_lower_key
  on public.student_progress (lower(username));

-- 2. updated_at refreshes on every update (created_at cannot be changed)
create or replace function public.student_progress_touch()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at := now();
  new.created_at := old.created_at;
  return new;
end;
$$;

drop trigger if exists student_progress_touch on public.student_progress;
create trigger student_progress_touch
  before update on public.student_progress
  for each row execute function public.student_progress_touch();

-- 3. Row Level Security: a signed-in student sees and changes only their own row
alter table public.student_progress enable row level security;

drop policy if exists "student_progress: select own" on public.student_progress;
create policy "student_progress: select own"
  on public.student_progress
  for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "student_progress: insert own" on public.student_progress;
create policy "student_progress: insert own"
  on public.student_progress
  for insert
  to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "student_progress: update own" on public.student_progress;
create policy "student_progress: update own"
  on public.student_progress
  for update
  to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

-- No delete policy on purpose: deleting the user in Authentication > Users
-- removes their row automatically (on delete cascade).

-- 4. Table permissions: anon gets nothing; signed-in users get only what the policies allow
revoke all on table public.student_progress from anon, authenticated;
grant select, insert, update on table public.student_progress to authenticated;
