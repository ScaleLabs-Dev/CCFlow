---
domain: web
stack: react-express
version: 1.0
custom: false
---

# Team Routing Configuration: React-Express

This file defines which implementation agents handle which tasks and when to delegate to specialists.

## Core Agents

### Backend Development
**Agent Path**: `.claude/agents/expressBackend.md`
**Fallback Path**: `.claude/agents/codeImplementer.md`
**Scope**: REST APIs, Express middleware, server logic, database operations
**Keywords**: api, endpoint, route, server, backend, express, middleware, database

**Delegation Rules**:
- Database work (query, schema, migration, model) → sequelizeDb specialist
- Authentication (jwt, token, login, auth) → jwtAuth specialist
- General routing/middleware → Handle directly

### Frontend Development
**Agent Path**: `.claude/agents/reactFrontend.md`
**Fallback Path**: `.claude/agents/uiDeveloper.md`
**Scope**: React components, hooks, state management, UI
**Keywords**: component, ui, page, form, frontend, react, hooks, state

**Delegation Rules**:
- Performance optimization (memoization, rendering, slow) → reactPerformance specialist
- Standard components/hooks → Handle directly

### Testing
**Agent Path**: `.claude/agents/jestTest.md`
**Fallback Path**: `.claude/agents/testEngineer.md`
**Scope**: Jest tests, React Testing Library, Supertest API tests
**Keywords**: test, spec, testing, jest, coverage

**Delegation Rules**:
- No delegation (testing agents handle all test types directly)

## Specialist Routing Rules

### Backend Specialists (invoked BY expressBackend)

**sequelizeDb** → `.claude/agents/specialists/sequelizeDb.md`
- **Triggers**: database, query, migration, schema, model, sequelize
- **Fallback**: expressBackend handles with general ORM patterns
- **Returns To**: expressBackend for route integration

**jwtAuth** → `.claude/agents/specialists/jwtAuth.md`
- **Triggers**: auth, authentication, jwt, token, login, logout, authorize
- **Fallback**: expressBackend handles with general JWT patterns
- **Returns To**: expressBackend for route integration

### Frontend Specialists (invoked BY reactFrontend)

**reactPerformance** → `.claude/agents/specialists/reactPerformance.md`
- **Triggers**: optimization, memoization, performance, rendering, slow, profiling
- **Fallback**: reactFrontend handles with basic React patterns
- **Returns To**: reactFrontend for component integration

## Fallback Behavior

### When Specialist Missing
If a specialist is not available:
1. Core agent handles task directly with general patterns
2. Logs: "Using general patterns - specialist [name] recommended"
3. Documents pattern in activeContext.md for potential specialist creation

### When Core Agent Missing
If a core agent is not available:
1. Falls back to generic agent (codeImplementer, uiDeveloper, testEngineer)
2. Logs: "Using generic agent - configure stack-specific team with /cf:configure-team"
3. Generic agent handles with framework-agnostic best practices

### When All Agents Missing
If both core and generic agents missing:
1. ERROR: System misconfiguration
2. User must run: /cf:init to restore agents
3. /cf:code command should detect and report this

## Task Routing Logic (for /cf:code)

### Step 1: Keyword Analysis
Extract keywords from task description:
- Backend keywords → expressBackend (or codeImplementer fallback)
- Frontend keywords → reactFrontend (or uiDeveloper fallback)
- Testing keywords → jestTest (or testEngineer fallback)

### Step 2: Agent Selection
1. Check if stack-specific agent exists (expressBackend.md)
2. If yes → Use stack-specific agent
3. If no → Use generic fallback (codeImplementer.md)
4. If neither → ERROR and guide user to run /cf:init

### Step 3: Specialist Delegation (within agent)
Agent determines if task requires specialist:
- expressBackend checks for database/auth keywords → delegates to specialist
- reactFrontend checks for performance keywords → delegates to specialist
- jestTest never delegates (handles all test types)

## Usage in /cf:code Command

```markdown
## Process (in /cf:code command)

1. Read `routing.md` to understand team configuration
2. Analyze task keywords
3. Select appropriate agent:
   - Backend task → expressBackend (or codeImplementer fallback)
   - Frontend task → reactFrontend (or uiDeveloper fallback)
   - Testing task → jestTest (or testEngineer fallback)
4. Invoke selected agent
5. Agent handles delegation to specialists if needed
6. Agent returns implementation
7. Update memory bank with results
```

## Team Type Information

**Domain**: Web Development
**Stack**: React.js frontend + Express.js backend
**Database**: Sequelize ORM (PostgreSQL/MySQL/SQLite)
**Authentication**: JWT (JSON Web Tokens)
**Testing**: Jest + React Testing Library + Supertest

**When to Use This Team**:
- Full-stack JavaScript/TypeScript web applications
- React for frontend UI
- Express for REST APIs
- Sequelize for database operations
- JWT for authentication

**When NOT to Use**:
- Different frontend framework (Vue, Angular) → Different team type
- Different backend (Django, Rails, .NET) → Different team type
- GraphQL instead of REST → May need custom team
- NoSQL database (MongoDB) → May need custom team

## Configuration Notes

**Created By**: /cf:configure-team command
**Custom**: false (pre-built template)
**Version**: 1.0
**Last Updated**: 2025-10-08

**Modification**:
- To add specialists: Create new agent in `specialists/` directory
- To change delegation rules: Update "Delegation Rules" sections above
- To switch teams: Run /cf:configure-team again with different template
- To create custom team: Run /cf:configure-team with Facilitator guidance
