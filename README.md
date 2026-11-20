<div align="center">
<img src="assets/brand-logo.svg" alt="Arya Fatthurahman" width="120" />
</div>

# SQL Server Lab

<sub>Run SQL Server 2022 Developer Edition in Docker and practice T-SQL with sqlcmd.</sub>

<p>
  <img src="https://img.shields.io/badge/Database-SQL%20Server-CC2927?style=flat-square" alt="Database: SQL Server" />
  <img src="https://img.shields.io/badge/Category-Relational%20%28SQL%29-6366F1?style=flat-square" alt="Category: Relational (SQL)" />
  <img src="https://img.shields.io/badge/Runs%20in-Docker-2496ED?style=flat-square&logo=docker&logoColor=white" alt="Runs in Docker" />
  <img src="https://img.shields.io/badge/License-MIT-22C55E?style=flat-square" alt="License: MIT" />
  <a href="https://github.com/devarent/sql-server-lab/actions/workflows/compose-check.yml"><img src="https://github.com/devarent/sql-server-lab/actions/workflows/compose-check.yml/badge.svg" alt="compose-check" /></a>
</p>

## What this lab is

SQL Server is common in enterprise .NET estates and data platforms. This lab runs the Developer edition locally, gives you a `LabDB` database, and walks through T-SQL features that differ from PostgreSQL and MySQL: batches, `TOP`, `OFFSET/FETCH`, and `MERGE`.

## Quickstart

```bash
docker compose up -d
docker compose cp examples/01_schema.sql sqlserver:/tmp/01_schema.sql
docker compose exec sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P 'Str0ng!Passw0rd' -C -i /tmp/01_schema.sql
docker compose exec sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P 'Str0ng!Passw0rd' -C -Q 'SELECT name FROM sys.databases'
```

## Connection details

| Field | Value |
| --- | --- |
| Host | `localhost` |
| Port | `1433` |
| Database | `LabDB` |
| User | `sa` |
| Password | `Str0ng!Passw0rd` |
| JDBC URL | `jdbc:sqlserver://localhost:1433;databaseName=LabDB;encrypt=true;trustServerCertificate=true` |
| sqlcmd | `sqlcmd -S localhost -U sa -P 'Str0ng!Passw0rd' -C` |

## Examples

| File | What it shows |
| --- | --- |
| [`docker-compose.yml`](docker-compose.yml) | Engine, ports, and persistent volume. |
| [`.github/workflows/compose-check.yml`](.github/workflows/compose-check.yml) | Validates the Compose file on every push. |
| [`examples/01_schema.sql`](examples/01_schema.sql) | Creates LabDB and a small sales schema. `GO` separates sqlcmd batches. |
| [`examples/02_queries.sql`](examples/02_queries.sql) | Seed data, `TOP`, a window function, and `MERGE`. |

## Exercises

1. Add a `products` table and an `order_items` table, then compute totals with `GROUPING SETS`.
2. Compare the execution plan of the revenue query with and without the index.
3. Create a stored procedure that returns the top N customers by revenue.
4. Try `SELECT * FROM dbo.orders FOR JSON PATH` and inspect the JSON output.

## Notes and limits

- Developer Edition is free for non-production development and testing.
- The SA password must meet SQL Server complexity rules. Change it before exposing port 1433.
- Recent 2022 images ship sqlcmd at `/opt/mssql-tools18/bin/sqlcmd`; older images use `/opt/mssql-tools/bin/sqlcmd`.
- This image is published for linux/amd64. Apple Silicon users need emulation.

## Run it from anywhere

This lab publishes its ports on `127.0.0.1` only. To use it from another country, do **not** open the database port to the internet. Pick one:

- **VPS + private tunnel:** run the lab on a small Ubuntu VPS, keep the port closed, and connect through WireGuard or `ssh -L`.
- **Managed service:** use a managed free tier for this engine and point the same examples at its connection string.
- **HTTP UI only:** if the engine has a web UI, put it behind Caddy with TLS and basic auth.

The shared checklist, provider map, and commands are in **[REMOTE-ACCESS.md](https://github.com/devarent/database-labs/blob/main/REMOTE-ACCESS.md)**.

## Cleanup

```bash
docker compose down -v
```

`-v` also removes the named volume, so the next start is a clean slate.

## References

- [SQL Server documentation](https://learn.microsoft.com/en-us/sql/sql-server/)
- [SQL Server Linux container](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-container)
- [sqlcmd utility](https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility)

---

<sub>Part of the <a href="https://github.com/devarent/database-labs">database-labs</a> collection: 26 database engines, one index.</sub>

## License

MIT (c) 2026 Arya Fatthurahman. See [LICENSE](LICENSE).
