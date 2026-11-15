-- Meter Log: run this once in Supabase (SQL Editor -> New query -> Run).
create table if not exists public.readings (
  id   uuid primary key,
  t    bigint not null,            -- time of the reading, milliseconds since 1970
  vt   double precision not null,  -- higher tariff register, kWh
  nt   double precision,           -- lower tariff register, kWh (optional)
  note text not null default ''
);

alter table public.readings enable row level security;

-- Anyone who has your project URL and publishable key can read and write this one table.
-- Those two values are typed into the app on your devices; they are not in the GitHub files.
drop policy if exists "meter log access" on public.readings;
create policy "meter log access" on public.readings
  for all to anon using (true) with check (true);

grant select, insert, update, delete on public.readings to anon;
