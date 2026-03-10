create extension if not exists pgcrypto;

create table if not exists tenants (
  id uuid primary key default gen_random_uuid(),
  company_name text not null,
  license_code text unique not null,
  user_code text unique not null,
  password_hash text,
  is_active boolean default true,
  created_at timestamp default now()
);

create table if not exists customers (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references tenants(id) on delete cascade,
  full_name text not null,
  phone text,
  address text,
  balance numeric(12,2) default 0,
  created_at timestamp default now()
);

create table if not exists customer_transactions (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references tenants(id) on delete cascade,
  customer_id uuid not null references customers(id) on delete cascade,
  transaction_type text not null,
  amount numeric(12,2) not null default 0,
  description text,
  created_at timestamp default now()
);

create table if not exists cash_transactions (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references tenants(id) on delete cascade,
  transaction_type text not null,
  amount numeric(12,2) not null default 0,
  description text,
  created_at timestamp default now()
);

create table if not exists business_settings (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references tenants(id) on delete cascade,
  company_name text,
  owner_name text,
  phone text,
  address text,
  logo_url text,
  created_at timestamp default now()
);
