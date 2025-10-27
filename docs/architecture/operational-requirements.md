# Operational Requirements

**Purpose**: Critical operational requirements for CCFlow command execution
**Audience**: Command developers and framework contributors

---

## Command Execution Context

### Working Directory
**Requirement**: Commands must run from project root

**Validation**:
```bash
# Commands should verify memory-bank/ exists
[ -d "memory-bank/" ] || echo "Error: Run from project root"
```

**Why**: Memory bank paths are relative to project root

---

### Memory Bank Presence
**Requirement**: `memory-bank/` directory must exist for workflow commands

**Error Handling**:
```
⚠️ Memory Bank Not Found

Memory bank not found at: memory-bank/

To initialize: /cf:init
```

**Exceptions**:
- `/cf:init` (creates memory bank)
- `/cf:status` (shows helpful message if missing)
- Meta commands (refine-agent, refine-command)

---

## Error Recovery

### Missing Prerequisites
Commands detect missing requirements and suggest fixes:

**Pattern**:
```
❌ Error: [Requirement] missing

To fix: [Specific command]

Example: [Usage example]
```

**Examples**:
```
❌ Error: Memory bank not initialized
To fix: /cf:init
Example: /cf:init MyProject
```

```
❌ Error: No active task
To fix: /cf:feature [description]
Example: /cf:feature "Add user authentication"
```

---

### Graceful Degradation
When optional features unavailable:
- Continue with reduced functionality
- Inform user what's unavailable
- Suggest how to enable

---

## Agent Discovery

### Implementation Agent Lookup
**Search Order**:
1. Check `.claude/agents/specialists/` for domain-specific agents
2. Check `.claude/agents/[team-type]/` for stack-specific agents
3. Fall back to `.claude/agents/` generic agents

**Pattern**:
```bash
# Specialist exists?
if [ -f ".claude/agents/specialists/authGuard.md" ]; then
  use authGuard
# Team-specific exists?
elif [ -f ".claude/agents/react-express/reactFrontend.md" ]; then
  use reactFrontend
# Fall back to generic
else
  use uiDeveloper
fi
```

---

### Workflow Agent Lookup
**Location**: Always `.claude/agents/workflow/` (framework-level)

**No fallback needed**: Workflow agents are always present in framework

---

## Auto-Facilitation

### Trigger Conditions
Level 3-4 tasks automatically enable interactive mode

**Logic**:
```
if complexity >= 3 AND not --non-interactive:
  enable --interactive flag
  invoke facilitator for refinement
```

**User Override**:
```bash
# Force non-interactive
/cf:plan TASK-042 --non-interactive
```

---

## File Naming Conventions

### Agents
- **Format**: `camelCase.md` or `lowercase-with-hyphens.md`
- **Examples**: `codeImplementer.md`, `auth-guard.md`
- **Location**: `.claude/agents/` or subdirectories

### Commands
- **Format**: `lowercase-with-hyphens.md`
- **Examples**: `create-specialist.md`, `configure-team.md`
- **Location**: `.claude/commands/cf/`

### Memory Bank Files
- **Format**: `camelCase.md`
- **Examples**: `projectbrief.md`, `activeContext.md`
- **Location**: `memory-bank/`

---

## Tool Permissions

### Workflow Agents (Read-Only)
**Allowed**:
- Read, Glob, Grep
- Analysis and decision-making
- No file modifications

**Rationale**: Workflow agents analyze and decide, never execute

---

### Implementation Agents (Full Access)
**Allowed**:
- Read, Write, Edit, Bash
- File creation and modification
- Test execution

**Rationale**: Implementation agents execute changes

---

### System Agents (Selective)
**Varies by agent**:
- commandBuilder: Read, Write, Edit (for command files)
- agentBuilder: Read, Write, Edit (for agent files)
- project-discovery: Read, Glob, Grep, Bash (for analysis)

---

## Context Passing

### Command → Agent
Via Task tool invocation with context parameter:

```
Invoke [agent] subagent with context:
- Current task: TASK-042
- Complexity: Level 3
- Files affected: [list]
- Requirements: [from memory bank]
```

---

### Agent → Agent (Indirect)
Agents cannot invoke other agents directly.

**Pattern**:
```
Command invokes Agent A
  ↓
Agent A returns results to Command
  ↓
Command invokes Agent B with Agent A's output
```

---

### Memory Bank as Shared State
Agents communicate via memory bank updates:
```
Agent A updates activeContext.md
  ↓
Command checkpoints
  ↓
Agent B reads activeContext.md
```

---

## Status Transitions

### Task Workflow States
```
NOT_STARTED → ASSESSED → PLANNED → TESTING → IMPLEMENTING → REVIEWING → COMPLETE
```

### Command Responsibilities
- `/cf:feature` → ASSESSED
- `/cf:plan` → PLANNED
- `/cf:code` → TESTING → IMPLEMENTING
- `/cf:review` → REVIEWING → COMPLETE

---

## Performance Requirements

### Command Response Time
- **Simple commands** (status, sync): < 1 second
- **Context loading** (context): < 5 seconds
- **Planning** (plan): < 30 seconds
- **Implementation** (code): Variable (depends on complexity)

### Memory Bank Operations
- **Read**: Instant
- **Write**: < 100ms
- **Consistency check**: < 1 second

---

## Related Documentation

- **Agent Organization**: `docs/architecture/agent-organization.md`
- **Command Specifications**: `.claude/commands/cf/*.md`
- **Agent Communication Patterns**: See CLAUDE.md

---

**Version**: 1.0
**Last Updated**: 2025-10-23
**Status**: Active
