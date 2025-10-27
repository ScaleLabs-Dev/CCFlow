# Team Type Recommendations

This reference maps detected technology stacks to available CCFlow team configurations. Used by `/cf:init` to suggest appropriate teams and by `/cf:configure-team` for team selection.

## Available Team Types

### Web Development Teams

#### web/react-express
**Stack**: React frontend + Express.js backend
**Location**: `.claude/templates/team-types/web/react-express/`
**Includes**:
- Core agents: reactFrontend, expressBackend, jestTest
- Specialists: jwtAuth, sequelizeDb, reactPerformance
- Best for: Full-stack JavaScript/TypeScript web applications

#### web/vue-fastify (Future)
**Stack**: Vue.js frontend + Fastify backend
**Status**: Planned - template not yet available
**Best for**: High-performance Vue applications

#### web/angular-nest (Future)
**Stack**: Angular frontend + NestJS backend
**Status**: Planned - template not yet available
**Best for**: Enterprise TypeScript applications

### Mobile Development Teams (Future)

#### mobile/react-native
**Stack**: React Native + Express/Node.js backend
**Status**: Planned - template not yet available
**Best for**: Cross-platform mobile apps

#### mobile/flutter
**Stack**: Flutter + Dart backend
**Status**: Planned - template not yet available
**Best for**: Native performance mobile apps

### Backend API Teams (Future)

#### api/express-postgres
**Stack**: Express.js + PostgreSQL
**Status**: Planned - template not yet available
**Best for**: RESTful APIs with relational data

#### api/fastapi-postgres
**Stack**: FastAPI (Python) + PostgreSQL
**Status**: Planned - template not yet available
**Best for**: High-performance Python APIs

### Data Science Teams (Future)

#### data/python-jupyter
**Stack**: Python + Jupyter + Pandas/NumPy
**Status**: Planned - template not yet available
**Best for**: Data analysis and machine learning

## Stack Detection → Team Mapping

### JavaScript/TypeScript Stacks

| Detected Stack | Recommended Team | Fallback |
|---------------|------------------|----------|
| React + Express | web/react-express | generic |
| React + Fastify | generic (future: web/react-fastify) | generic |
| React + NestJS | generic (future: web/react-nest) | generic |
| Vue + Express | generic (future: web/vue-express) | generic |
| Vue + Fastify | generic (future: web/vue-fastify) | generic |
| Angular + Express | generic (future: web/angular-express) | generic |
| Angular + NestJS | generic (future: web/angular-nest) | generic |
| Next.js | generic (future: web/nextjs) | generic |
| Nuxt | generic (future: web/nuxt) | generic |
| Express (API only) | generic (future: api/express) | generic |

### Python Stacks

| Detected Stack | Recommended Team | Fallback |
|---------------|------------------|----------|
| Django | generic (future: web/django) | generic |
| Flask | generic (future: web/flask) | generic |
| FastAPI | generic (future: api/fastapi) | generic |
| Jupyter/Data Science | generic (future: data/python-jupyter) | generic |

### Ruby Stacks

| Detected Stack | Recommended Team | Fallback |
|---------------|------------------|----------|
| Rails | generic (future: web/rails) | generic |
| Sinatra | generic (future: api/sinatra) | generic |

### Go Stacks

| Detected Stack | Recommended Team | Fallback |
|---------------|------------------|----------|
| Gin | generic (future: api/gin) | generic |
| Echo | generic (future: api/echo) | generic |
| Fiber | generic (future: api/fiber) | generic |

### Java Stacks

| Detected Stack | Recommended Team | Fallback |
|---------------|------------------|----------|
| Spring Boot | generic (future: web/spring-boot) | generic |
| Quarkus | generic (future: api/quarkus) | generic |

### PHP Stacks

| Detected Stack | Recommended Team | Fallback |
|---------------|------------------|----------|
| Laravel | generic (future: web/laravel) | generic |
| Symfony | generic (future: web/symfony) | generic |

### .NET/C# Stacks

| Detected Stack | Recommended Team | Fallback |
|---------------|------------------|----------|
| ASP.NET Core | generic (future: web/aspnet-core) | generic |
| Blazor | generic (future: web/blazor) | generic |

## Generic Team (Default)

The generic team is the universal fallback that works with ANY technology stack:
- **codeImplementer**: Adapts to any backend/business logic
- **testEngineer**: Works with any testing framework
- **uiDeveloper**: Handles any UI framework

Generic agents read `CLAUDE.md` and `systemPatterns.md` at runtime to adapt to your specific stack.

## Team Selection Logic

1. **Exact Match**: If detected stack exactly matches an available team → recommend that team
2. **Partial Match**: If core framework matches but not all components → suggest generic with note about future team
3. **No Match**: If stack not recognized → use generic team (works universally)
4. **User Override**: User can always choose different team via `/cf:configure-team --type [team]`

## Recommendation Messages

### When Exact Match Found:
```
Detected: React + Express
Recommended team: web/react-express
Run: /cf:configure-team --type web/react-express
```

### When Future Team Detected:
```
Detected: Django + PostgreSQL
This stack will have specialized support in future (web/django team).
Currently using generic agents which will adapt to your stack.
```

### When No Match:
```
Detected: Custom stack
Generic agents will adapt to your project's patterns.
No additional configuration needed.
```

## Adding New Teams

To add a new team type:

1. Create team directory: `.claude/templates/team-types/[domain]/[stack]/`
2. Add core agents and specialists
3. Create routing.template.md for delegation rules
4. Update this file with mapping
5. Test with sample project

## Usage

This file is used by:
- `/cf:init` - To suggest team after project brief creation
- `/cf:configure-team` - To validate team selection
- `projectDiscovery` agent - To map detected stack to team recommendation