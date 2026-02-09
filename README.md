# iSupayX – Transaction Processing API 💳⚡

**iSupayX** is an API-only Phoenix application for processing merchant transactions with **layered validation**, **idempotency guarantees**, and **compliance checks**.

The system is intentionally minimal, explicit, and auditable — designed to resemble a real payment gateway core while remaining easy to reason about and extend.

---

## ✨ Features

- 🔐 API key–based authentication
- 🔁 Idempotent transaction processing
- 🧩 Layered validation pipeline
- 🧾 Persistent transaction records
- 🧠 Clear separation of concerns
- 🗄 SQLite-backed storage via Ecto
- 📦 API-only Phoenix app (no HTML, no LiveView)

---

## 🧱 Tech Stack

| Layer        | Technology |
|-------------|------------|
| Language     | Elixir |
| Web         | Phoenix (API-only) |
| Persistence | Ecto |
| Database    | SQLite |
| JSON        | Jason |

---

## 🚀 Getting Started

### Prerequisites

- Elixir ≥ 1.14
- Erlang/OTP ≥ 25

### Setup

```bash
mix deps.get
mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds.exs
mix phx.server
