# Product Team Configuration System - Implementation Plan (FINAL v3)

## Architecture Overview

### Core Principles
1. **Core agents are workers** - Execute tasks, routing handled by commands
2. **Routing in separate file** - `routing.md` defines agent paths and delegation rules  
3. **Core agents can be replaced** - Stack-specific or use generic fallback
4. **Team types are folders** - Organized by domain/stack
5. **Generic agents as fallback** - Always available, handle everything without specialists
6. **Facilitator for custom teams** - Guided creation when no template exists

### Fallback Pattern

```
.claude/agents/
├── workflow/              # Universal (always present)
├── generic/               # Generic fallback (always present - NO specialists/)
│   ├── codeImplementer.md
│   ├── testEngineer.md
│   └── uiDeveloper.md
└── web/                   # Stack-specific (conditional)
    └── react-express/
        ├── core/
        └── specialists/   # Only stack-specific have specialists
```

**Key**: Generic agents have NO specialists folder - they handle everything directly using general patterns.

## Routing.md Schema

```yaml
---
domain: web
stack: react-express
version: 1.0
custom: false
---

# Team Routing Configuration

## Core Agents

### Backend Development
**Agent Path**: `.claude/agents/web/react-express/core/expressBackend.md`
**Fallback Path**: `.claude/agents/generic/codeImplementer.md`
**Scope**: REST APIs, Express middleware, database operations
**Keywords**: api, endpoint, route, server, backend, database

### Frontend Development
**Agent Path**: `.claude/agents/web/react-express/core/reactFrontend.md`
**Fallback Path**: `.claude/agents/generic/uiDeveloper.md`
**Scope**: React components, hooks, state management
**Keywords**: component, ui, page, form, frontend, react

### Testing
**Agent Path**: `.claude/agents/web/react-express/core/jestTest.md`
**Fallback Path**: `.claude/agents/generic/testEngineer.md`
**Scope**: Jest tests, integration tests
**Keywords**: test, spec, testing, jest

## Specialist Routing Rules

### Backend Specialists
- **sequelizeDb** → `.claude/agents/web/react-express/specialists/sequelizeDb.md`
  - **Triggers**: database, query, migration, schema, sequelize
  - **Fallback**: Handle directly (no specialist delegation)
  
- **jwtAuth** → `.claude/agents/web/react-express/specialists/jwtAuth.md`
  - **Triggers**: auth, authentication, jwt, token, login
  - **Fallback**: Handle directly (no specialist delegation)

### Frontend Specialists
- **reactPerformance** → `.claude/agents/web/react-express/specialists/reactPerformance.md`
  - **Triggers**: performance, optimization, rendering, memoization
  - **Fallback**: Handle directly (no specialist delegation)

## Fallback Behavior

When using generic agents:
- NO specialist delegation (generic agents handle everything)
- Use general best practices from CLAUDE.md and systemPatterns.md
- Log: "Using generic agent - consider configuring stack-specific team"
```

## File Structure (Complete)

### User Project (After /cf:init)
```
.claude/agents/
├── workflow/              # Always (6 agents)
│   ├── Assessor.md
│   ├── Architect.md
│   ├── Product.md
│   ├── Facilitator.md
│   ├── Documentarian.md
│   └── Reviewer.md
│
├── generic/               # Always (3 agents) - NO specialists/
│   ├── codeImplementer.md
│   ├── testEngineer.md
│   └── uiDeveloper.md
│
└── web/                   # Conditional (if team type configured)
    └── react-express/
        ├── core/          # 3 stack-specific agents
        │   ├── expressBackend.md
        │   ├── reactFrontend.md
        │   └── jestTest.md
        └── specialists/   # 3 stack-specific specialists
            ├── sequelizeDb.md
            ├── jwtAuth.md
            └── reactPerformance.md
```

## Generic Agent Behavior

**Purpose**: Universal fallback that handle ALL tasks without delegation

**Generic codeImplementer.md** (example):
```markdown
# Generic Code Implementer

## Role
Universal backend/business logic implementation agent.
Works across all stacks. Handles everything directly - NO specialist delegation.

## When Used
- No stack-specific agent configured (no routing.md)
- Stack-specific agent missing (fallback from routing.md)
- Task doesn't match stack patterns

## Approach
1. Read CLAUDE.md for tech stack and conventions
2. Read systemPatterns.md for project patterns
3. Implement using general best practices:
   - Database work: General ORM patterns, not Sequelize-specific
   - Auth: General JWT patterns, not framework-specific
   - Performance: General optimization, not React-specific
4. Follow existing code style from codebase
5. Log: "Using generic implementation - stack-specific agent would optimize this"

## No Specialist Delegation
Generic agents do NOT delegate to specialists.
All complexity handled directly with general patterns.

For specialized optimization:
- Configure stack-specific team: /cf:configure-team
- Stack agents can then delegate to specialists

## Recommendation
For better results:
- Run: /cf:configure-team
- Get stack-specific agents with specialist delegation
- Better framework integration and optimization
```

**Generic testEngineer.md**: Handles all test types (unit, integration, e2e) directly
**Generic uiDeveloper.md**: Handles all UI work (components, state, styling) directly

## Files to Create

### 1. Generic Agent Templates (3 files - NEW)
1. `.claude/templates/generic/codeImplementer.template.md`
   - Universal backend, handles database/auth/performance directly
   - NO specialist delegation
2. `.claude/templates/generic/testEngineer.template.md`
   - Universal testing, handles all test types directly
   - NO specialist delegation  
3. `.claude/templates/generic/uiDeveloper.template.md`
   - Universal UI, handles components/state/styling directly
   - NO specialist delegation

### 2. Team Type Templates (21 files - MVP)
**Web/React-Express** (7 files):
4. `.claude/templates/team-types/web/react-express/core/expressBackend.template.md`
5. `.claude/templates/team-types/web/react-express/core/reactFrontend.template.md`
6. `.claude/templates/team-types/web/react-express/core/jestTest.template.md`
7. `.claude/templates/team-types/web/react-express/specialists/sequelizeDb.template.md`
8. `.claude/templates/team-types/web/react-express/specialists/jwtAuth.template.md`
9. `.claude/templates/team-types/web/react-express/specialists/reactPerformance.template.md`
10. `.claude/templates/team-types/web/react-express/routing.template.md`

**Mobile/React-Native** (7 files):
11-17. Similar structure

**AI/LangChain-Python** (7 files):
18-24. Similar structure

### 3. Blank Templates (3 files)
25. `.claude/templates/blank-agents/core-agent.template.md`
26. `.claude/templates/blank-agents/specialist.template.md`
27. `.claude/templates/blank-agents/routing.template.md`

### 4. New Command (1 file)
28. `.claude/commands/cf/configure-team.md`

## Files to Modify

### Commands (2 files)
29. `.claude/commands/cf/code.md` - Routing with fallback logic
30. `.claude/commands/cf/init.md` - Always copy workflow + generic

### Documentation (3 files)
31. `docs/user-guide/commands.md`
32. `CLAUDE.md`
33. `README.md`

**Total: 33 files (27 new + 6 modified)**

## Success Criteria

- ✅ 3 generic fallback agents (NO specialists folder)
- ✅ 21 stack-specific templates (3 stacks × 7 files, WITH specialists)
- ✅ 3 blank templates for custom creation
- ✅ /cf:init always copies workflow + generic
- ✅ /cf:configure-team with multiple modes
- ✅ /cf:code routing with fallback to generic
- ✅ Facilitator integration for custom teams
- ✅ Generic agents handle everything directly (no delegation)
- ✅ Stack agents can delegate to specialists
- ✅ Backward compatible
- ✅ Documentation complete