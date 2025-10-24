# Agent Organization Architecture

**Version**: 2.0
**Last Updated**: 2025-10-23
**Status**: Active

---

## Overview

CCFlow agents are organized into two distinct categories: **framework-level** agents that provide consistent behavior across all projects, and **project-level** agents that are customized for each project's specific needs.

This document defines the organization, classification criteria, and customization guidelines for all CCFlow agents.

---

## Agent Classification

### Framework-Level Agents

**Never copied to projects | Never customized | Always referenced from framework**

Framework-level agents provide CCFlow's core functionality and maintain consistent behavior across all projects.

**Location**: `.claude/agents/system/` and `.claude/agents/workflow/`

**Characteristics**:
- No project-specific customization needed
- Consistent behavior is a feature (ensures predictable workflows)
- Updated by framework maintainers only
- Referenced from framework location
- Never appear in project directories

---

### Project-Level Agents

**Copied during init | Customizable | Deleted during reset**

Project-level agents are customized for each project's tech stack, coding style, and specific requirements.

**Location**: `.claude/agents/` (project root)

**Characteristics**:
- Require project-specific customization
- Vary by tech stack and team preferences
- Modified by project developers
- Can diverge from framework defaults
- Deleted when project is reset

---

## Framework-Level Agents

### System Agents (`.claude/agents/system/`)

**Meta-agents for framework optimization**

| Agent | Purpose | Tools |
|-------|---------|-------|
| **commandBuilder.md** | Command optimization and refinement | Read, Write, Edit, Glob, Grep |
| **agentBuilder.md** | Agent creation and refinement | Read, Write, Edit, Glob, Grep |
| **project-discovery.md** | Project analysis during init | Read, Glob, Grep, Bash |

**Customizable?**: ❌ NO

**Used By**: `/cf:refine-command`, `/cf:refine-agent`, `/cf:create-specialist`, `/cf:init`

---

### Workflow Agents (`.claude/agents/workflow/`)

**Decision layer for workflow orchestration**

| Agent | Purpose | Tools |
|-------|---------|-------|
| **assessor.md** | Complexity analysis and routing (L1-L4) | Read, Glob, Grep |
| **architect.md** | Technical design decisions | Read, Glob, Grep |
| **product.md** | User requirements and UX analysis | Read, Glob, Grep |
| **facilitator.md** | Interactive refinement through questions | Read, Edit |
| **documentarian.md** | Memory bank consistency validation | Read, Edit |
| **reviewer.md** | Quality validation gate | Read, Glob, Grep, Bash |

**Customizable?**: ❌ NO

**Used By**: All workflow commands (`/cf:feature`, `/cf:plan`, `/cf:facilitate`, `/cf:code`, `/cf:review`, `/cf:checkpoint`)

**Rationale for Framework-Level**:
1. No customization points in implementation
2. Provide consistent CCFlow workflow behavior
3. Should be updated framework-wide, not per-project
4. Behave like system agents functionally
5. Copying creates maintenance burden with no benefit

---

## Project-Level Agents

### Generic Implementation Agents

**Universal fallback agents that work with any tech stack**

**Location**: `.claude/agents/` (copied during `/cf:init`)

| Agent | Purpose | Customization Required |
|-------|---------|----------------------|
| **codeImplementer.md** | Backend/business logic implementation | Tech stack, frameworks, code style |
| **testEngineer.md** | TDD test writing (RED phase) | Test frameworks, coverage targets, patterns |
| **uiDeveloper.md** | UI/Frontend implementation (GREEN phase) | UI frameworks, design systems, accessibility |

**Customizable?**: ✅ YES - Extensive customization required

**Customization Points**:
```markdown
## Technology Stack (CUSTOMIZE)
- Language: [Python | JavaScript | TypeScript | Ruby | Go | Java]
- Framework: [Express | Django | Rails | Spring Boot | None]
- Database: [PostgreSQL | MySQL | MongoDB | None]

## Code Style & Conventions (CUSTOMIZE)
- Style Guide: [Link or description]
- Linting: [ESLint | Pylint | RuboCop | None]
- Formatting: [Prettier | Black | None]

## Testing Approach (CUSTOMIZE)
- Test Framework: [Jest | Pytest | RSpec | JUnit]
- Coverage Target: [e.g., 80%]
- Test Patterns: [Your patterns]
```

**When to Use**: Generic agents serve as fallbacks when stack-specific teams aren't configured.

---

### Team-Specific Implementation Agents

**Stack-optimized agents for common technology combinations**

**Location**: `.claude/agents/[team-type]/` (copied when `/cf:configure-team` is run)

**Examples** (React-Express team):
- `reactFrontend.md` - React-specific UI development
- `expressBackend.md` - Express-specific backend
- `jestTest.md` - Jest-specific testing

**Customizable?**: ✅ YES - Stack configurations

**When to Use**: After running `/cf:configure-team [team-type]` for stack-specific optimization.

**Relationship to Generic Agents**: Team-specific agents augment or replace generic agents with stack-optimized behavior.

---

### Specialist Agents

**Domain-specific agents for recurring patterns**

**Location**: `.claude/agents/specialists/` (created via `/cf:create-specialist`)

**Examples**:
- `authGuard.md` - Authentication specialist
- `dbMigration.md` - Database migration specialist
- `paymentGateway.md` - Payment processing specialist

**Customizable?**: ✅ YES - Entirely custom per domain

**When to Use**: When patterns repeat 3+ times in your project.

**Creation**: `/cf:create-specialist [domain] --type [development|testing] --name [agentName]`

---

## Directory Structure

### Framework (CCFlow itself)

```
.claude/
├── agents/
│   ├── system/                  # Meta-agents (never copied)
│   │   ├── commandBuilder.md
│   │   ├── agentBuilder.md
│   │   └── project-discovery.md
│   └── workflow/                # Workflow agents (never copied)
│       ├── assessor.md
│       ├── architect.md
│       ├── product.md
│       ├── facilitator.md
│       ├── documentarian.md
│       └── reviewer.md
├── commands/                    # Command specs
│   └── cf/
│       ├── init.md
│       ├── reset.md
│       ├── feature.md
│       └── ...
└── templates/                   # Project agent templates
    ├── generic/                 # Generic implementation agents
    │   ├── codeImplementer.template.md
    │   ├── testEngineer.template.md
    │   └── uiDeveloper.template.md
    └── team-types/              # Team-specific templates
        └── [stack]/
            └── core/
                └── [agents].template.md
```

### Project (After /cf:init)

```
.claude/agents/
├── codeImplementer.md           # Generic (needs customization)
├── testEngineer.md              # Generic (needs customization)
├── uiDeveloper.md               # Generic (needs customization)
├── [team-type]/                 # Optional (if team configured)
│   └── [stack-specific agents]
└── specialists/                 # Optional (if specialists created)
    └── [custom specialists]
```

**Note**: Workflow agents do NOT appear in project directories (they remain in framework).

---

## Initialization Workflow

### /cf:init Process

1. **Create memory bank structure**: `memory-bank/` with 6 files
2. **Copy generic agents**: 3 implementation agents from `.claude/templates/generic/`
3. **Create specialists directory**: Empty `.claude/agents/specialists/`
4. **Reference workflow agents**: Automatically available from framework

**What is NOT copied**:
- ❌ Workflow agents (remain in framework)
- ❌ System agents (remain in framework)
- ❌ Team-specific agents (added separately via `/cf:configure-team`)

### /cf:configure-team Process

1. **Detect project stack**: Via project-discovery or user input
2. **Copy team agents**: From `.claude/templates/team-types/[stack]/core/`
3. **Create routing**: Optional routing configuration
4. **Preserve generic agents**: Keep as fallbacks

### /cf:create-specialist Process

1. **Invoke agentBuilder**: System agent creates specialist spec
2. **Write to specialists/**: Place in `.claude/agents/specialists/[name].md`
3. **Document pattern**: Record in systemPatterns.md

---

## Reset Workflow

### /cf:reset Process

**Deleted**:
- ✅ `memory-bank/` - All memory bank files
- ✅ `.claude/agents/codeImplementer.md`
- ✅ `.claude/agents/testEngineer.md`
- ✅ `.claude/agents/uiDeveloper.md`
- ✅ `.claude/agents/specialists/` - All custom specialists
- ✅ `.claude/agents/[team-type]/` - Team-specific agents

**Preserved (Framework)**:
- ❌ `.claude/agents/system/` - System agents
- ❌ `.claude/agents/workflow/` - Workflow agents
- ❌ `.claude/commands/` - All commands
- ❌ `.claude/templates/` - All templates

**Transition Support**:
- Old architecture projects with workflow agents in project location: Smart cleanup removes them

---

## Customization Guidelines

### Which Agents Can I Customize?

**Framework Agents** (DO NOT MODIFY):
- System agents (`.claude/agents/system/`)
- Workflow agents (`.claude/agents/workflow/`)

**Project Agents** (CUSTOMIZE THESE):
- Generic implementation agents (`.claude/agents/*.md`)
- Team-specific agents (`.claude/agents/[team-type]/`)
- Specialists (`.claude/agents/specialists/`)

### How to Customize

**Generic Implementation Agents**:
1. After `/cf:init`, open each generic agent
2. Find TODO sections marked with `<!-- TODO: ... -->`
3. Fill in your tech stack, coding style, testing approach
4. Save and commit to project repository

**Team-Specific Agents**:
1. Run `/cf:configure-team [team-type]`
2. Agents are pre-configured for stack
3. Optional: Fine-tune for project-specific patterns

**Specialists**:
1. Run `/cf:create-specialist [domain] --type [type] --name [name]`
2. agentBuilder creates initial spec
3. Refine with project-specific domain knowledge
4. Use `/cf:refine-agent [name]` for optimization

---

## Migration from Old Architecture

### Old Architecture (Pre-2.0)

```
.claude/agents/
├── workflow/                    # ❌ Copied to project (incorrect)
│   ├── assessor.md
│   ├── architect.md
│   └── ...
├── codeImplementer.md
├── testEngineer.md
└── uiDeveloper.md
```

### New Architecture (2.0+)

```
Framework:
.claude/agents/
├── system/                      # Framework
├── workflow/                    # Framework (moved from project)

Project:
.claude/agents/
├── codeImplementer.md           # Project
├── testEngineer.md              # Project
└── uiDeveloper.md               # Project
```

### Migration Steps

**Option 1: Reset + Reinit** (Recommended)
```bash
/cf:reset --backup    # Save project config
/cf:init              # Reinitialize with new architecture
# Restore customizations from backup
```

**Option 2: Manual Cleanup**
```bash
# Remove workflow agents from project
rm -rf .claude/agents/workflow/

# Framework workflow agents will be used automatically
```

**Option 3: Let /cf:reset Handle It**
```bash
# /cf:reset automatically detects and cleans old architecture
/cf:reset
```

---

## Agent Invocation

### How Commands Find Agents

Commands invoke agents using the Task tool, which searches:
1. `.claude/agents/system/` - System agents
2. `.claude/agents/workflow/` - Workflow agents (framework)
3. `.claude/agents/` - Project-level agents
4. `.claude/agents/specialists/` - Custom specialists
5. `.claude/agents/[team-type]/` - Team-specific agents

**No explicit paths needed**: Task tool automatically searches appropriate locations.

---

## Best Practices

### For Project Developers

1. **Always customize generic agents**: Fill in TODOs after `/cf:init`
2. **Use team configs when available**: `/cf:configure-team` for stack optimization
3. **Create specialists for patterns**: When pattern repeats 3+ times
4. **Never modify framework agents**: System and workflow agents are read-only
5. **Commit customized agents**: Project agents belong in version control

### For Framework Contributors

1. **Workflow agents are framework-level**: Never create customization points
2. **Generic agents need clear TODOs**: Mark all customization points
3. **Document team types**: Clear stack compatibility
4. **Test both architectures**: Old and new during transition
5. **Update docs with changes**: Keep this document current

---

## Related Documentation

- **Planning Analysis**: `docs/planning/agent-organization-analysis.md` - Detailed architectural analysis and rationale
- **Initialization**: `docs/specifications/initialization.md` - Full /cf:init specification
- **Command Specs**: `.claude/commands/cf/*.md` - Individual command documentation
- **Agent Specs**: `docs/agents/` - Individual agent documentation

---

## Decision Rationale

For the complete architectural analysis, decision matrix, and rationale for framework vs. project classification, see:

📄 **`docs/planning/agent-organization-analysis.md`**

**Key decisions**:
1. Workflow agents classified as framework-level (no customization points)
2. Generic agents classified as project-level (extensive customization needed)
3. Team-specific agents augment generic agents with stack optimization
4. Specialists provide domain-specific reusable patterns

---

**Last Reviewed**: 2025-10-23
**Architecture Version**: 2.0
**Status**: Active - Migration period for old architecture projects
