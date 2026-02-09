# iSupayX – Transaction Processing API

API-only Phoenix application for processing merchant transactions with layered validation, idempotency, and compliance checks.

## Tech Stack
- Elixir
- Phoenix
- Ecto
- SQLite

## Setup
```bash
mix deps.get
mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds.exs
mix phx.server

```

## API
```
POST /api/v1/transactions
```
## Headers:
```
Content-Type: application/json

X-Api-Key

Idempotency-Key (optional)
```
## Notes

- See decision_log.md for architecture decisions and assumptions.
