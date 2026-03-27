# Mini Task Management System

A full-stack monolith project with:

- Backend: Spring Boot (JWT auth, RBAC, task APIs)
- Frontend: Next.js (login/register/task board)
- Database: MySQL or PostgreSQL

## Features

- User registration and login with JWT authentication
- Password hashing with BCrypt
- Role-based access control with `ADMIN` and `USER`
- Task CRUD operations
- Mark task as completed
- Task filtering by `status` and `priority`
- Pagination and sorting by `dueDate` or `priority`
- Global exception handling and validation
- Swagger API docs

## Project Structure

- `src/main/java/...` -> Spring Boot backend
- `frontend/` -> Next.js frontend
- `docs/database-schema.md` -> database schema description
- `docs/api-documentation.md` -> API reference

## Environment Variables

### Backend (`.env` or system env)

Required keys:

- `SERVER_PORT`
- `DB_URL`
- `DB_USERNAME`
- `DB_PASSWORD`
- `JPA_DDL_AUTO`
- `JPA_SHOW_SQL`
- `JWT_SECRET`
- `JWT_EXPIRATION_MS`
- `FRONTEND_URL`

Optional keys:

- `ADMIN_EMAIL`
- `ADMIN_PASSWORD`
- `ADMIN_NAME`

See `.env.example`.

### Frontend (`frontend/.env.local`)

Required keys:

- `NEXT_PUBLIC_API_BASE_URL`

See `frontend/.env.example`.

## Database Configuration

The backend reads DB config from environment variables.

Default behavior:

- If you do not set `DB_URL`, the app starts with an in-memory H2 database for quick local testing.
- For assignment/demo submission, set MySQL or PostgreSQL variables explicitly.

### MySQL example

- `DB_URL=jdbc:mysql://localhost:3306/task_db`
- `DB_USERNAME=root`
- `DB_PASSWORD=password`

### PostgreSQL example

- `DB_URL=jdbc:postgresql://localhost:5432/task_db`
- `DB_USERNAME=postgres`
- `DB_PASSWORD=password`

## Run Instructions

## 1) Backend

From project root:

```bash
./mvnw spring-boot:run
```

On Windows PowerShell:

```powershell
.\mvnw.cmd spring-boot:run
```

Or use the helper script (PowerShell) that auto-selects a JDK and starts backend:

```powershell
.\start-backend.ps1
```

Backend runs on `http://localhost:8080` by default.

## 2) Frontend

```bash
cd frontend
npm install
npm run dev
```

Frontend runs on `http://localhost:3000`.

## 3) Access

- Frontend UI: `http://localhost:3000`
- Swagger UI: `http://localhost:8080/swagger-ui.html`
- OpenAPI JSON: `http://localhost:8080/api-docs`

## API Summary

Auth endpoints:

- `POST /api/auth/register`
- `POST /api/auth/login`

Task endpoints (JWT required):

- `GET /api/tasks`
- `GET /api/tasks/{id}`
- `POST /api/tasks`
- `PUT /api/tasks/{id}`
- `PATCH /api/tasks/{id}/complete`
- `DELETE /api/tasks/{id}`

## Notes

- `USER` can only access their own tasks.
- `ADMIN` can access all tasks.
- Build folders and node modules are ignored in `.gitignore`.

## Troubleshooting

### Error: No compiler is provided in this environment

Cause:
- Maven is using a JRE or legacy Java path instead of a JDK.

Fix:
- Use `start-backend.ps1`, or set `JAVA_HOME` to a JDK 17+ and ensure `<JDK>\\bin` is first in `PATH`.

### Error: Unable to determine Dialect without JDBC metadata

Cause:
- Backend cannot connect to your database.

Fix checklist:
1. Ensure your DB server is running.
2. Ensure the database exists (`task_db` by default).
3. Set environment variables correctly:
	- `DB_URL`
	- `DB_USERNAME`
	- `DB_PASSWORD`
4. Retry backend startup.
