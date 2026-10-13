# RAG docs chat

[Project: https://www.meta.ai/prompt/2d7db31b-fee2-461c-863a-024413e9200f](https://www.meta.ai/prompt/2d7db31b-fee2-461c-863a-024413e9200f)

## Project structure

rag-docs-chat/
├── app/
│ ├── (auth)/login/page.tsx # Supabase Auth UI
│ ├── (app)/chat/page.tsx # UI chat chính
│ ├── api/
│ │ ├── chat/route.ts # Edge: RAG + stream
│ │ └── ingest/route.ts # Upload PDF → embedding
│ └── layout.tsx
│
├── components/chat/
│ ├── message.tsx # Render markdown + citation
│ ├── citation.tsx # [1] thành link click được
│ └── upload-dialog.tsx # Upload PDF
│
├── lib/
│ ├── supabase/
│ │ ├── client.ts # createBrowserClient
│ │ ├── server.ts # createServerClient
│ │ └── middleware.ts # Auth check
│ └── ai/
│ ├── embedding.ts # Gọi OpenAI embedding
│ └── rag.ts # Hàm search vector
│
├── supabase/
│ ├── migrations/
│ │ └── 001_init.sql # Tạo table + pgvector + RLS
│ └── functions/ingest/ # Edge Function xử lý PDF nặng
│
├── middleware.ts # Edge auth
└──.env.local
