-- supabase init sql
create extension if not exists vector;

create table documents (
  id bigserial primary key,
  user_id uuid references auth.users not null,
  content text,
  embedding vector(3072), -- text-embedding-3-large
  metadata jsonb -- {source: 'handbook.pdf', page: 3}
);

-- Index để search nhanh
create index on documents using ivfflat (embedding vector_cosine_ops);

-- RLS: user chỉ thấy docs của mình
alter table documents enable row level security;
create policy "Users can see own docs" on documents for select using (auth.uid() = user_id);

-- Function search
create function match_documents(
  query_embedding vector(3072),
  match_count int default 4,
  filter_user_id uuid default auth.uid()
)
returns table (id bigint, content text, metadata jsonb, similarity float)
language sql stable
as $$
  select id, content, metadata, 1 - (documents.embedding <=> query_embedding) as similarity
  from documents
  where user_id = filter_user_id
  order by documents.embedding <=> query_embedding
  limit match_count;
$$;
