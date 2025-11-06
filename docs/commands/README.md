# CCFlow Command Reference

Complete reference for all CCFlow commands organized by domain.

---

## Command Categories

### 1. Project Initialization

**Setup and configure your project**

| Command | Purpose | Usage |
|---------|---------|-------|
| `/cf:init` | Initialize CCFlow with memory bank | `/cf:init [--quick] [--force-fresh]` |
| `/cf:configure-team` | Install stack-specific agent teams | `/cf:configure-team --type [team]` |
| `/cf:create-specialist` | Create domain-specific agents | `/cf:create-specialist [domain] --type [type] --name [name]` |
| `/cf:reset` | Undo initialization (dev/QA tool) | `/cf:reset [--backup] [--force] [--dry-run]` |

**Specifications**: `.claude/commands/cf/init.md`, `configure-team.md`, `create-specialist.md`, `reset.md`

---

### 2. Workflow Execution

**Core development loop**

| Command | Purpose | Usage |
|---------|---------|-------|
| `/cf:feature` | Entry point → automatic complexity routing | `/cf:feature [description]` |
| `/cf:plan` | Planning with Architect + Product agents | `/cf:plan [task-id] [--interactive]` |
| `/cf:creative` | Deep exploration for L4 complexity | `/cf:creative [task-id\|topic]` |
| `/cf:code` | TDD implementation (RED → GREEN → REFACTOR) | `/cf:code [task-id]` |
| `/cf:review` | Quality validation gate | `/cf:review [task-id\|all] [--focus area]` |

**Specifications**: `.claude/commands/cf/feature.md`, `plan.md`, `creative.md`, `code.md`, `review.md`

**See Also**: `docs/workflows/standard-development-flow.md`

---

### 3. State Management

**Persist and load project context**

| Command | Purpose | Usage |
|---------|---------|-------|
| `/cf:checkpoint` | Create memory bank snapshot | `/cf:checkpoint [--message "text"] [--interactive]` |
| `/cf:context` | Load active project context | `/cf:context [--full]` |
| `/cf:sync` | Inspect memory bank status | `/cf:sync [--verbose]` |
| `/cf:status` | Quick task overview | `/cf:status [--filter status\|priority\|complexity]` |
| `/cf:git` | Smart commit with memory integration | `/cf:git [--message "text"] [--no-update]` |

**Specifications**: `.claude/commands/cf/checkpoint.md`, `context.md`, `sync.md`, `status.md`, `git.md`

**See Also**: `docs/workflows/session-management.md`

---

### 4. Interactive Support

**Human-in-the-loop refinement**

| Command | Purpose | Usage |
|---------|---------|-------|
| `/cf:ask` | Direct agent consultation | `/cf:ask [agent] "question"` |
| `/cf:facilitate` | Interactive exploration | `/cf:facilitate [topic\|task-id] [--mode explore\|refine\|validate]` |

**Specifications**: `.claude/commands/cf/ask.md`, `facilitate.md`

**See Also**: `docs/workflows/facilitator-pattern.md`

**Flag**: `--interactive` can be added to any command for Facilitator engagement

---

### 5. Meta-Development

**System optimization and consistency**

| Command | Purpose | Usage |
|---------|---------|-------|
| `/cf:refine-agent` | Optimize agents (target: 500-1500 tokens) | `/cf:refine-agent [agent-name] [--target tokens]` |
| `/cf:refine-command` | Optimize commands (via commandBuilder) | `/cf:refine-command [command-name] [--interactive]` |

**Specifications**: `.claude/commands/cf/refine-agent.md`, `refine-command.md`

**Best Practice**: Always use meta-tools for ALL system modifications to ensure consistency

---

## Command Flags

### Common Flags

| Flag | Purpose | Compatible Commands |
|------|---------|---------------------|
| `--interactive` | Enable facilitator-guided refinement | Most commands |
| `--force` | Skip confirmation prompts | init, reset, git |
| `--dry-run` | Preview without executing | reset |
| `--backup` | Create backup before destructive ops | reset |
| `--verbose` | Show detailed output | sync |
| `--filter` | Filter results | status, review |

---

## Quick Start Sequences

### New Project
```bash
/cf:init                      # Initialize
/cf:configure-team --type react-express  # Optional: Add stack team
/cf:feature "implement user login"       # Start first feature
```

### Resuming Work
```bash
/cf:context                  # Load state
/cf:status                   # Check tasks
/cf:code TASK-042            # Continue work
```

### Session End
```bash
/cf:checkpoint               # Save state
/cf:review                   # Quality check
/cf:git                      # Commit work
```

---

## Command Workflow Patterns

### Standard Development Flow
```
/cf:feature → Assessor routes:
├─ L1 → /cf:code (direct implementation)
├─ L2-3 → /cf:plan → /cf:code
└─ L4 → /cf:plan → /cf:creative → subtasks
       ↓
/cf:code (TDD: RED → GREEN → REFACTOR)
       ↓
/cf:review (quality validation)
       ↓
/cf:checkpoint (save state)
```

### Interactive Refinement
```
/cf:feature [vague description]
       ↓
Assessor L3+ → Auto-enable --interactive
       ↓
/cf:plan --interactive (facilitator guides refinement)
       ↓
Clear plan → /cf:code
```

### Specialist Creation
```
Notice pattern repeating 3+ times
       ↓
/cf:create-specialist [domain] --type development --name [name]
       ↓
Specialist created in .claude/agents/specialists/
       ↓
Use: /cf:code [task] --specialist [name]
```

---

## Complexity Routing (Automatic)

The Assessor agent automatically routes based on task complexity:

| Level | Criteria | Route |
|-------|----------|-------|
| **L1** | 1-2 files, clear scope, known pattern | → `/cf:code` |
| **L2** | 3-5 files, established patterns | → `/cf:plan` → `/cf:code` |
| **L3** | 5-15 files, some ambiguity, cross-cutting | → `/cf:plan --interactive` → `/cf:code` |
| **L4** | 15+ files, high uncertainty, architectural | → `/cf:plan` → `/cf:creative` → sub-tasks |

**Note**: Complexity is determined by scope and clarity, NOT temporal estimates.

---

## Memory Bank Integration

Commands interact with memory bank files:

| File | Read By | Written By | Purpose |
|------|---------|------------|---------|
| `projectbrief.md` | All | init | Immutable project scope |
| `productContext.md` | plan, feature | plan, checkpoint | Features and requirements |
| `systemPatterns.md` | code, review | code, checkpoint | Pattern catalog index |
| `patterns/*.md` | code, review | code, checkpoint | Pattern documentation |
| `activeContext.md` | context, code | checkpoint | Current work focus |
| `progress.md` | status, context | checkpoint, review | Completed milestones |
| `tasks.md` | status, feature | feature, plan | Task tracking |

---

## Error Recovery

Commands detect issues and suggest fixes:

### Common Errors

| Error | Fix Command | Example |
|-------|-------------|---------|
| Memory bank not found | `/cf:init` | `/cf:init MyProject` |
| No active task | `/cf:feature [desc]` | `/cf:feature "Add authentication"` |
| Agent not found | `/cf:create-specialist` | `/cf:create-specialist auth --type development --name authGuard` |
| Git conflicts | Manual resolution then `/cf:git` | Resolve conflicts, then `/cf:git` |

---

## Command Development

### Creating New Commands

**Location**: `.claude/commands/cf/[command-name].md`

**Structure**:
```markdown
---
description: "Brief command purpose"
allowed-tools: ['Tool1', 'Tool2']
argument-hint: "[arg1] [arg2]"
---

# Command: /cf:[name]

## Usage
[Usage examples]

## Process
[Step-by-step execution]

## Examples
[Real examples]

## Error Handling
[Error scenarios]
```

**Best Practice**: Use `/cf:refine-command [name]` for optimization

---

## Archived Commands

| Command | Status | Reason |
|---------|--------|--------|
| `/cf:archive` | Planned | Deferred to post-Phase 3 |

**See**: `.claude/commands/cf/archive.md` for planned features

---

## Related Documentation

- **Workflows**: `docs/workflows/` - Detailed workflow guides
  - `facilitator-pattern.md` - 5-step interaction pattern
  - `session-management.md` - Context, checkpoint, git patterns
  - `specialist-creation.md` - When and how to create specialists

- **Architecture**: `docs/architecture/` - System design
  - `agent-organization.md` - Framework vs project agents
  - `operational-requirements.md` - Command execution requirements

- **CLAUDE.md**: Core principles and architecture overview

---

## Quick Reference Card

### Most Used Commands
```bash
/cf:init                     # Start new project
/cf:context                  # Resume work
/cf:feature [desc]           # Add feature
/cf:code [task-id]           # Implement
/cf:checkpoint               # Save state
/cf:git                      # Commit
```

### Getting Help
```bash
/cf:status                   # What's on my plate?
/cf:sync                     # Memory bank health?
/cf:ask facilitator "help"   # Need guidance?
```

### Development Tools
```bash
/cf:create-specialist        # Recurring pattern?
/cf:refine-agent             # Optimize agent?
/cf:reset --dry-run          # Test init changes?
```

---

**Version**: 2.0
**Last Updated**: 2025-10-23
**Commands**: 19 active, 1 planned
