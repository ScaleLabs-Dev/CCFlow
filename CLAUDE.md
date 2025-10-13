# CLAUDE.md

CCFlow orchestrates development through commands that coordinate specialized sub-agents. Each agent has a single responsibility and minimal tool permissions, following Claude Code best practices for efficient, modular workflows.

## System Architecture

CCFlow uses a three-tier architecture:
1. **Commands** orchestrate workflows (user interface)
2. **Workflow agents** analyze and plan (decision layer)
3. **Implementation agents** execute tasks (execution layer)

This separation enables parallel processing, clean context windows, and framework-specific customization while maintaining consistent TDD enforcement.

## CCFlow Workflow & Agent Orchestration

```
ENTRY → ROUTING → PLANNING → IMPLEMENTATION → VALIDATION → PERSISTENCE
  ↓         ↓          ↓            ↓              ↓            ↓
/cf:feature → Assessor → /cf:plan → /cf:code → /cf:review → /cf:checkpoint
              (L1-L4)    ↓            ↓          Reviewer    Documentarian
                      Architect    testEngineer
                      Product      +
                      Facilitator  Implementation
                                   Agents

Complexity Routing:
- Level 1: /cf:feature → /cf:code → /cf:checkpoint
- Level 2-3: /cf:feature → /cf:plan → /cf:code → /cf:checkpoint
- Level 4: /cf:feature → /cf:plan → /cf:creative → /cf:code → /cf:checkpoint
```

## Quick Decision Guide

**New Task?**
→ `/cf:feature` → Complexity assessment → Routing

**Complexity Routing:**
- L1 (Quick: <30min, 1-2 files) → Direct to `/cf:code`
- L2 (Simple: 2-6h, 3-5 files) → Requires `/cf:plan`
- L3 (Intermediate: 1-3 days, 5-15 files) → `/cf:plan` with auto-facilitation
- L4 (Complex: 3+ days, 15+ files) → `/cf:plan` → `/cf:creative` sub-tasks

**Need Specialist?**
- Pattern repeated 3+ times → `/cf:create-specialist`
- New tech stack → `/cf:configure-team`
- Domain expertise → Create specialist agent

## Sub-Agent Best Practices

### Single Responsibility Principle
Each agent has ONE clear goal:
- **Assessor**: Analyze complexity, route to workflow
- **Architect**: Technical design and architecture decisions
- **Product**: User requirements and feature validation
- **Facilitator**: Interactive refinement through questions
- **testEngineer**: Write failing tests (RED phase)
- **codeImplementer**: Make tests pass (GREEN phase)
- **uiDeveloper**: Frontend implementation
- **Reviewer**: Validate quality and completeness
- **Documentarian**: Memory bank consistency

### Agent Communication Patterns
Commands orchestrate agents through explicit handoffs:
- **Status Transitions**: ASSESSED → PLANNED → TESTING → IMPLEMENTING → REVIEWING
- **Tool Isolation**: Each agent has minimal required tools (see Agent Permission Matrix)
- **Context Passing**: Via memory bank files, not direct agent-to-agent communication
- **No Direct Invocation**: Agents don't call other agents; commands orchestrate

### Parallel vs Sequential Execution
- **Sequential** (high-risk): Planning → Design → Test Writing → Implementation
- **Parallel** (safe): Multiple file edits, independent test runs, documentation updates
- **Delegation Triggers**: Keywords in task description trigger specialist invocation
- **Context Isolation**: Each agent operates in clean context window

### Performance Optimization
- **Separate Context Windows**: Each agent operates independently
- **Lazy Loading**: Load only required memory bank files per agent
- **Early Termination**: GREEN gate stops execution if tests fail 3 times
- **Batch Operations**: Group similar operations for efficiency

## Agent Permission Matrix

| Agent | Tools | Rationale |
|-------|-------|-----------|
| Assessor | Read, Grep, Glob | Read-only complexity analysis |
| Architect | Read, Write (patterns) | Design documentation |
| Product | Read, Write (context) | Requirements documentation |
| Facilitator | Read | Question-driven exploration |
| testEngineer | Read, Write, Edit, Bash | Test creation & execution |
| codeImplementer | Read, Write, Edit, Bash, Glob, Grep | Implementation |
| uiDeveloper | Read, Write, Edit, Bash, Glob, Grep | Frontend implementation |
| Reviewer | Read, Grep, Glob, Bash | Quality assessment |
| Documentarian | Read, Edit | Memory bank updates |

## Agent Architecture

### Command Layer (Orchestration)
Commands coordinate agent execution based on complexity:
- `/cf:feature` → Invokes Assessor for routing
- `/cf:plan` → Coordinates Architect + Product + Facilitator
- `/cf:code` → Orchestrates testEngineer → Implementation agents
- `/cf:checkpoint` → Triggers Documentarian for memory sync
- `/cf:review` → Engages Reviewer for quality validation

### Workflow Layer (Analysis & Planning)
Located in `.claude/agents/workflow/`:
- **Assessor**: Complexity analysis (L1-L4 routing)
- **Architect + Product**: Technical/user requirement planning
- **Facilitator**: Human-in-the-loop refinement
- **Reviewer**: Quality validation
- **Documentarian**: Memory bank consistency

### Implementation Layer (Execution)
Configurable per project via `/cf:configure-team`:

**Option 1: Generic Agents** (Default)
- Direct implementation without delegation
- Framework-agnostic patterns
- Located in `.claude/agents/generic/` (user projects)

**Option 2: Stack-Specific Teams**
- Core agents delegate to specialists
- Framework-aware patterns
- Keyword-based routing via `routing.md`
- Located in `.claude/agents/[domain]/[stack]/` (user projects)

## Custom Implementation Teams

CCFlow supports two team models:

### Generic Team (Default)
- Installed via `/cf:init`
- Framework-agnostic implementation
- No delegation, direct implementation
- Good for: prototypes, simple projects, learning

### Stack-Specific Teams
- Configured via `/cf:configure-team`
- Framework-aware patterns
- Core agents delegate to specialists
- Good for: production apps, complex stacks

Example team structure:
```
.claude/agents/
├── web/react-express/
│   ├── core/
│   │   ├── expressBackend.md
│   │   ├── reactFrontend.md
│   │   └── jestTester.md
│   ├── specialists/
│   │   ├── sequelizeDb.md
│   │   ├── jwtAuth.md
│   │   └── reactHooks.md
│   └── routing.md
```

### Creating Specialists
When patterns emerge (3+ similar tasks):
```bash
/cf:create-specialist database --type development --name postgresDb
```
- Specialists handle domain-specific implementation
- Parent core agent delegates based on keywords
- Maintains single responsibility principle

## Memory Bank Structure

CCFlow's persistent context system:

```
memory-bank/
├── projectbrief.md       # Immutable scope definition
├── productContext.md     # Features, user needs, UX
├── systemPatterns.md     # Architecture, patterns, ADRs
├── activeContext.md      # Current focus, recent changes
├── progress.md           # Completed work, milestones
└── tasks.md              # Task tracking with status
```

**Update Strategy**:
- Commands auto-update relevant files during execution
- `/cf:checkpoint` creates formal savepoints
- Documentarian ensures cross-file consistency

## TDD Enforcement (GREEN Gate)

**Absolute Rule**: Tests MUST pass before task completion

**RED → GREEN → REFACTOR workflow**:
1. testEngineer writes failing tests FIRST (RED)
2. Implementation agent makes tests pass (GREEN)
3. GREEN gate: If tests fail after 3 attempts → STOP, report blocker
4. Only after 100% GREEN → update memory bank, mark complete

**No exceptions**: Tasks cannot be marked complete with failing tests.

## Command Namespace

All commands use `/cf:` prefix to avoid conflicts:

**Core Workflow Commands**:
- `/cf:feature` - Entry point for new work
- `/cf:plan` - Planning with agents
- `/cf:code` - TDD implementation
- `/cf:creative` - Deep exploration for complex tasks
- `/cf:review` - Quality assessment
- `/cf:checkpoint` - Memory bank savepoint

**Team Management**:
- `/cf:init` - Initialize project
- `/cf:configure-team` - Set up stack-specific team
- `/cf:create-specialist` - Add domain specialist

**Utility Commands**:
- `/cf:sync` - Read memory bank status
- `/cf:status` - Quick task overview
- `/cf:context` - Load project context
- `/cf:git` - Smart commit with memory integration

## Critical Design Principles

### Specification-Based System
CCFlow operates through markdown specifications, not executable code:
- **Agents ARE**: Step-by-step instructions Claude reads and follows
- **Agents ARE NOT**: Programs with automatic enforcement
- **Commands ARE**: Procedural orchestration steps
- **Commands ARE NOT**: Code that executes validation logic

### Writing Effective Agents

For detailed DO's and DON'Ts with examples, see **[Agent and Command Development Guidelines](docs/system/agent-command-development.md)**.

Key principles:
- Write clear procedural instructions (not algorithms)
- Include explicit decision trees and keyword lists
- Specify manual validation steps (not automatic enforcement)
- Use imperative language ("Check if...", "Verify that...")

### YAML Frontmatter
Valid Claude Code fields:
- `name`: Agent identifier (required)
- `description`: Purpose and usage (required)
- `tools`: Tool permissions (optional)
- `model`: Model selection (optional)

Custom documentation fields (not enforced):
- `priority`, `triggers`, `dependencies`, `outputs`

## Facilitator Action Recommendation Pattern

Used throughout interactive modes:
1. Present Current State
2. Identify Gaps/Concerns
3. Ask Clarifying Questions
4. Refine Based on Feedback
5. **Always Recommend Next Action** (never leave user without next step)

## Meta-Development Tools

CCFlow includes specialized agents for system development:

### AgentBuilder System
- **Command**: `/cf:refine-agent [name]` - Optimize existing agents
- **Agent**: `AgentBuilder` - Universal agent generator/refiner
- **Purpose**: Maintain token efficiency (500-1500 tokens) and consistency
- **Usage**: Always use for creating/modifying agents in CCFlow

### CommandBuilder System
- **Command**: `/cf:refine-command [name]` - Optimize existing commands
- **Agent**: `CommandBuilder` - Command optimizer (via Task tool)
- **Purpose**: Ensure clarity, completeness, proper structure
- **Usage**: Always use for creating/modifying commands in CCFlow

**Best Practice**: Use these meta-tools for ALL system modifications to ensure consistency and compliance with Claude Code specifications.

## Important Implementation Notes

1. **Command Execution Context**: Commands run from project root with `memory-bank/` present
2. **Agent Invocation**: Commands invoke agents by name in process steps
3. **File Paths**: Memory bank refs use `memory-bank/` prefix
4. **Error Recovery**: Commands detect missing prerequisites and provide fix commands
5. **Specialist Discovery**: Implementation agents check `specialists/` subdirectory
6. **Auto-Facilitation**: Level 3-4 tasks automatically enable interactive mode

---

**Version**: 2.0 (Focused on Sub-Agent Architecture)
**Last Updated**: 2025-01-13
**Documentation**: See `docs/` for detailed guides and specifications