# Stack Detection Patterns

This reference document defines patterns for detecting technology stacks across multiple languages and frameworks. Used by the projectDiscovery agent during `/cf:init` Phase 0.

## JavaScript/TypeScript

**Package Manager Files**:
- `package.json` - Node.js/npm packages
- `yarn.lock` - Yarn package manager
- `pnpm-lock.yaml` - pnpm package manager
- `package-lock.json` - npm lock file

**Frontend Frameworks** (check dependencies in package.json):
- React: `"react"` in dependencies
- Vue: `"vue"` in dependencies
- Angular: `"@angular/core"` in dependencies
- Svelte: `"svelte"` in dependencies
- Solid: `"solid-js"` in dependencies
- Qwik: `"@builder.io/qwik"` in dependencies

**Backend Frameworks** (check dependencies in package.json):
- Express: `"express"` in dependencies
- Fastify: `"fastify"` in dependencies
- NestJS: `"@nestjs/core"` in dependencies
- Koa: `"koa"` in dependencies
- Hapi: `"@hapi/hapi"` in dependencies
- Next.js: `"next"` in dependencies (fullstack)
- Nuxt: `"nuxt"` in dependencies (fullstack)
- Remix: `"@remix-run/node"` in dependencies (fullstack)

**Databases/ORMs** (check dependencies):
- PostgreSQL: `"pg"` or `"postgres"` in dependencies
- MySQL: `"mysql"` or `"mysql2"` in dependencies
- MongoDB: `"mongodb"` or `"mongoose"` in dependencies
- SQLite: `"sqlite3"` or `"better-sqlite3"` in dependencies
- Prisma: `"@prisma/client"` in dependencies
- TypeORM: `"typeorm"` in dependencies
- Sequelize: `"sequelize"` in dependencies
- Knex: `"knex"` in dependencies

**Testing Frameworks** (check devDependencies):
- Jest: `"jest"` in devDependencies
- Vitest: `"vitest"` in devDependencies
- Mocha: `"mocha"` in devDependencies
- Playwright: `"@playwright/test"` in devDependencies
- Cypress: `"cypress"` in devDependencies

## Ruby

**Package Manager Files**:
- `Gemfile` - Ruby gem dependencies
- `Gemfile.lock` - Locked gem versions

**Frameworks** (check Gemfile):
- Rails: `gem "rails"`
- Sinatra: `gem "sinatra"`
- Hanami: `gem "hanami"`
- Roda: `gem "roda"`
- Grape: `gem "grape"` (API framework)

**Databases** (check Gemfile):
- PostgreSQL: `gem "pg"`
- MySQL: `gem "mysql2"`
- SQLite: `gem "sqlite3"`
- MongoDB: `gem "mongoid"`

**Testing** (check Gemfile):
- RSpec: `gem "rspec"`
- Minitest: `gem "minitest"`
- Capybara: `gem "capybara"`

## Python

**Package Manager Files**:
- `requirements.txt` - pip dependencies
- `Pipfile` - Pipenv dependencies
- `pyproject.toml` - Modern Python project config
- `setup.py` - Traditional setup file
- `poetry.lock` - Poetry lock file

**Frameworks** (check in package files):
- Django: `django>=` or `Django==`
- Flask: `flask>=` or `Flask==`
- FastAPI: `fastapi>=` or `FastAPI==`
- Pyramid: `pyramid>=` or `Pyramid==`
- Tornado: `tornado>=` or `Tornado==`
- Starlette: `starlette>=` or `Starlette==`

**Databases** (check in package files):
- PostgreSQL: `psycopg2` or `asyncpg`
- MySQL: `mysql-connector-python` or `PyMySQL`
- SQLite: Built-in (check for `sqlite3` imports)
- MongoDB: `pymongo` or `motor`
- SQLAlchemy: `sqlalchemy` (ORM)
- Django ORM: Included with Django

**Testing** (check in package files):
- pytest: `pytest`
- unittest: Built-in
- nose2: `nose2`
- behave: `behave` (BDD)

## Go

**Package Manager Files**:
- `go.mod` - Go module definition
- `go.sum` - Go module checksums

**Frameworks** (check go.mod):
- Gin: `github.com/gin-gonic/gin`
- Echo: `github.com/labstack/echo`
- Fiber: `github.com/gofiber/fiber`
- Chi: `github.com/go-chi/chi`
- Gorilla Mux: `github.com/gorilla/mux`
- Beego: `github.com/beego/beego`

**Databases** (check go.mod):
- PostgreSQL: `github.com/lib/pq` or `github.com/jackc/pgx`
- MySQL: `github.com/go-sql-driver/mysql`
- MongoDB: `go.mongodb.org/mongo-driver`
- GORM: `gorm.io/gorm` (ORM)
- sqlx: `github.com/jmoiron/sqlx`

## Java

**Package Manager Files**:
- `pom.xml` - Maven project
- `build.gradle` or `build.gradle.kts` - Gradle project

**Frameworks** (check in build files):
- Spring Boot: `spring-boot-starter` dependencies
- Quarkus: `quarkus-bom` in dependencyManagement
- Micronaut: `micronaut-bom` in dependencies
- Vert.x: `vertx-core` in dependencies
- Jakarta EE: `jakarta.platform` dependencies

**Databases** (check in build files):
- PostgreSQL: `postgresql` driver
- MySQL: `mysql-connector-java`
- MongoDB: `mongodb-driver`
- H2: `h2database`
- Hibernate: `hibernate-core` (ORM)

## PHP

**Package Manager Files**:
- `composer.json` - Composer dependencies
- `composer.lock` - Locked versions

**Frameworks** (check composer.json):
- Laravel: `"laravel/framework"`
- Symfony: `"symfony/framework-bundle"`
- Slim: `"slim/slim"`
- Lumen: `"laravel/lumen-framework"`
- CodeIgniter: `"codeigniter4/framework"`
- Yii: `"yiisoft/yii2"`

**Databases** (check composer.json):
- Eloquent: Included with Laravel
- Doctrine: `"doctrine/orm"`
- PDO: Built-in PHP

## Rust

**Package Manager Files**:
- `Cargo.toml` - Rust package manifest
- `Cargo.lock` - Locked dependencies

**Frameworks** (check Cargo.toml):
- Actix Web: `actix-web`
- Rocket: `rocket`
- Axum: `axum`
- Warp: `warp`
- Tide: `tide`

**Databases** (check Cargo.toml):
- PostgreSQL: `tokio-postgres` or `postgres`
- SQLite: `rusqlite`
- MongoDB: `mongodb`
- Diesel: `diesel` (ORM)
- SeaORM: `sea-orm` (async ORM)

## .NET/C#

**Package Manager Files**:
- `*.csproj` - C# project file
- `packages.config` - NuGet packages
- `project.json` - Legacy project format

**Frameworks** (check in project files):
- ASP.NET Core: `Microsoft.AspNetCore`
- ASP.NET MVC: `Microsoft.AspNet.Mvc`
- Blazor: `Microsoft.AspNetCore.Components`
- Web API: `Microsoft.AspNetCore.WebApi`

**Databases** (check in project files):
- Entity Framework Core: `Microsoft.EntityFrameworkCore`
- Dapper: `Dapper`
- MongoDB: `MongoDB.Driver`

## Common Patterns

**Version Control**:
- `.git/` directory - Git repository
- `.gitignore` - Git ignore patterns

**CI/CD**:
- `.github/workflows/` - GitHub Actions
- `.gitlab-ci.yml` - GitLab CI
- `Jenkinsfile` - Jenkins pipeline
- `.circleci/` - CircleCI
- `azure-pipelines.yml` - Azure DevOps

**Containerization**:
- `Dockerfile` - Docker container definition
- `docker-compose.yml` - Multi-container Docker
- `kubernetes/` or `k8s/` - Kubernetes manifests

**Cloud Platforms**:
- `vercel.json` - Vercel deployment
- `netlify.toml` - Netlify configuration
- `app.yaml` - Google App Engine
- `serverless.yml` - Serverless Framework
- `.aws/` - AWS configuration

## Detection Priority

When detecting stack, check in this order:
1. Package manager files (most reliable)
2. Configuration files
3. Source code structure
4. File extensions and naming patterns

## Usage

This file is read by the projectDiscovery agent using grep to identify patterns. The agent searches for specific package manager files first, then examines their contents for framework indicators.

Example grep patterns:
- Find JavaScript project: `grep -l "package.json"`
- Check for React: `grep '"react"' package.json`
- Find Ruby project: `grep -l "Gemfile"`
- Check for Rails: `grep 'gem "rails"' Gemfile`