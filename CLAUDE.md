# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**CCFlow** is a comprehensive workflow system for Claude Code providing structured development with TDD enforcement, persistent memory bank context, and intelligent agent-based task coordination.

**Tech Stack**: Markdown-based specification system with Claude Code custom commands and sub-agents
**Status**: ✅ Production Ready (v1.0)

## Critical Architecture Concepts

### 1. Two-Layer Agent System

**Workflow Layer** (`.claude/agents/workflow/`):
- **Assessor**: Analyzes task complexity (1-4 levels), routes to appropriate workflow
- **Architect**: Technical design, system architecture, pattern identification
- **Product**: Requirements analysis, user needs, feature prioritization
- **Facilitator**: Interactive refinement through question-driven dialogue (Action Recommendation Pattern)
- **Documentarian**: Memory bank maintenance, cross-file consistency
- **Reviewer**: Code quality assessment, technical debt tracking

**Implementation Layer** (`.claude/agents/{testing,development,ui}/`):
- **Hub agents**: Stack-agnostic coordinators (testEngineer, codeImplementer, uiDeveloper)
- **Specialists**: Created on-demand for specific tech stacks/domains (in `specialists/` subdirs)
- Hub agents delegate to specialists, never implement directly

**Key Distinction**: Workflow agents orchestrate and plan; implementation agents execute code changes.

### 2. Memory Bank as Single Source of Truth

Located in `memory-bank/` directory (created per-project, NOT in this repo):

**6 Core Files**:
- `projectbrief.md`: Immutable scope definition (rarely changes)
- `productContext.md`: Feature specs, user needs, UX requirements
- `systemPatterns.md`: Architectural decisions, design patterns, ADRs
- `activeContext.md`: Current focus, recent changes (most frequently updated)
- `progress.md`: Completed work, milestones, technical debt
- `tasks.md`: Task tracking with status, complexity, sub-tasks, blockers

**Update Strategy**:
- Commands auto-update relevant files during execution
- `/cf:checkpoint` creates formal savepoints across ALL files
- Documentarian ensures cross-file consistency

### 3. Complexity-Based Routing

**4-Level System**:
- **Level 1** (Quick): 1-2 files, <2h → Direct to `/cf:code`
- **Level 2** (Simple): 3-5 files, 2-6h → Requires `/cf:plan`
- **Level 3** (Intermediate): 5-15 files, 1-3 days → Requires `/cf:plan` (auto-interactive)
- **Level 4** (Complex): 15+ files, 3+ days → Requires `/cf:plan` (auto-interactive) → `/cf:creative` for sub-tasks

**Auto-Facilitation**: Level 3-4 tasks automatically enable `--interactive` mode (can override with `--skip-facilitation`)

### 4. TDD Enforcement (GREEN Gate)

**Absolute Rule**: Tests MUST pass before task completion

**RED → GREEN → REFACTOR workflow**:
1. testEngineer writes failing tests FIRST
2. Hub agent implements to make tests pass (delegates to specialists)
3. GREEN gate: If tests fail after 3 attempts → STOP, report blocker
4. Only after 100% GREEN → update memory bank, mark complete

**No exceptions**: Implementation cannot be marked complete with failing tests.

### 5. Command Namespace: `/cf:*`

All commands use `/cf:` prefix to avoid conflicts. Commands are self-documenting (see `.claude/commands/`).

**Core workflow**: `/cf:feature` → `/cf:plan` → `/cf:creative` (if complex) → `/cf:code` → `/cf:checkpoint`

### 6. Facilitator Action Recommendation Pattern

**Critical Pattern** (used throughout interactive modes):
```
1. Present Current State
2. Identify Gaps/Concerns
3. Ask Clarifying Questions
4. Refine Based on Feedback
5. Recommend Next Action (always ends with recommendation)
```

Never leave user without clear next step. See `docs/specifications/facilitator-patterns.md` for templates.

### 7. Creative Session for Deep Exploration

For high-complexity sub-tasks without established patterns:

**4-Phase Process** (`/cf:creative`):
- Phase 1: Problem Deep-Dive (with "think" directive)
- Phase 2: Solution Exploration (with "think hard/harder/ultrathink")
- Phase 3: Design Refinement (with "think hard")
- Phase 4: Validation & Documentation (with "think")

Uses Sequential MCP for structured reasoning, always interactive, 20-35 minutes investment.

## Working with This Repository

### Understanding File Organization

**Implementation Files**:
- `.claude/commands/`: 12 command implementations (cf-*.md)
- `.claude/agents/`: 9 agent definitions with YAML frontmatter
- `.claude/templates/`: 6 templates for new project initialization

**Documentation** (`docs/`):
- `user-guide/`: Getting started, commands, agents, workflows
- `system/`: Architecture, validation, extending CCFlow
- `specifications/`: Complete technical specifications

**Root Files**:
- `README.md`: User-facing quick start and reference
- `CLAUDE.md`: This file - guidance for Claude Code instances

### Modifying Commands

**Command Structure** (all commands follow this):
```markdown
# Command: /cf:name

[Brief description]

## Usage
[Syntax examples]

## Parameters / Flags
[Arguments and options]

## Purpose
[What it does and why]

## Prerequisites
[What must exist first]

## Process
[Step-by-step execution with decision points]

## Examples
[Real-world usage scenarios]

## Error Handling
[Common errors and responses]

## Memory Bank Updates
[Which files get updated and how]

## Notes
[Important caveats]

## Related Commands
[Integration points]
```

**Required Sections**: Usage, Purpose, Process, Examples, Error Handling

### Modifying Agents

**Agent Structure** (YAML frontmatter + markdown):
```yaml
---
name: AgentName
role: Brief role description
priority: high|medium|low
triggers: [command1, command2]
dependencies: [file1.md, file2.md]
outputs: [file1.md, file2.md]
---

# Agent: AgentName

[Full role description]

## Responsibilities
[Specific duties]

## Process
[How agent operates]

## Output Format
[What agent produces]

## Integration
[How agent works with others]
```

**Critical**: Validate frontmatter YAML syntax - Phase 8 validation checks this.

### Creating New Specialists

Use `/cf:create-specialist` command, which:
1. Prompts for domain, type (testing/development/ui), name
2. Creates file in appropriate `specialists/` subdirectory
3. Generates agent template with proper frontmatter
4. Updates hub agent to recognize specialist

**Specialist Pattern**: Hub agents detect repeated delegation patterns (3+ times) and recommend specialist creation.

## Development Workflow for This Repository

### Making Changes

1. **Read specifications first**: Understand intent in `docs/specifications/` files
2. **Check validation**: Changes must maintain validation standards (see `docs/system/validation.md`)
3. **Update documentation**: Keep README.md and user guides synchronized
4. **Cross-reference integrity**: Update all related files (commands ↔ agents ↔ specs)

### Validation Checklist

Before considering changes complete:
- [ ] All command files have required sections
- [ ] All agent files have valid YAML frontmatter
- [ ] Cross-references between files are accurate
- [ ] Memory bank templates are consistent (6 files)
- [ ] README.md reflects any command/agent changes
- [ ] Error handling is documented for new scenarios
- [ ] Integration points are specified

### Key Design Constraints

**Non-Negotiables**:
- TDD with GREEN gate enforcement (no skipping tests)
- Memory bank as single source of truth (no duplicate state)
- Action Recommendation Pattern in all interactive modes
- Two-layer agent architecture (workflow vs implementation)
- Complexity-based routing (can't skip planning for Level 2-4)
- `/cf:` command namespace (avoid conflicts)

**Extensibility Points**:
- Creating specialists for new tech stacks (encouraged)
- Adding memory bank files for specific needs (optional)
- Custom facilitation templates for domains (see `docs/specifications/facilitator-patterns.md`)

## Common Patterns

### Pattern: Complexity Assessment

Every new feature request goes through Assessor:
```
Keywords → Scope estimation → Risk analysis → Effort calculation → Level assignment (1-4) → Route recommendation
```

### Pattern: Interactive Refinement

Facilitator-led commands cycle through:
```
Draft → Present → Identify Gaps → Ask Questions → User Responds → Refine → Repeat until satisfied → Recommend Next Action
```

No iteration limits - user controls the loop.

### Pattern: Hub Agent Delegation

Implementation hubs follow:
```
Load systemPatterns.md → Check for specialist → Delegate OR implement directly → Verify tests pass → Update memory bank
```

After 3+ delegations to same domain → recommend specialist creation.

### Pattern: Memory Bank Synchronization

Commands that modify state:
```
Pre-read relevant files → Execute operation → Update activeContext.md (always) → Update domain files (as needed) → Checkpoint opportunity
```

Documentarian ensures no conflicts between files.

## MCP Server Integration

CCFlow uses Sequential MCP for `/cf:creative` command:
- Extended thinking mode with progressive budgets (think → think hard → think harder → ultrathink)
- Hypothesis-driven solution comparison
- Structured multi-step reasoning for architectural decisions

## Important Implementation Notes

1. **Command Execution Context**: Commands assume they're run from project root with `memory-bank/` directory present
2. **Agent Invocation**: Agents are invoked by name in command process steps (e.g., "Engage Assessor agent")
3. **File Path Assumptions**: All memory bank references use `memory-bank/` prefix, external refs use `.claude/`
4. **Error Recovery**: Commands should detect missing prerequisites and provide exact commands to fix (e.g., "Run: /cf:init [project-name]")
5. **Specialist Discovery**: Hub agents check `specialists/` subdirectory existence before attempting delegation
6. **Facilitator Enforcement**: Level 3-4 tasks bypass `--interactive` flag and activate Facilitator automatically

## Testing This System

This is a specification-based system (no executable code). Validation is through:
1. **Structural validation**: Check all required files exist and have proper format
2. **Cross-reference validation**: Verify all mentioned commands/agents exist
3. **Template validation**: Ensure memory bank templates match spec
4. **Consistency validation**: Check command outputs match agent inputs

See `docs/system/validation.md` for validation methodology.

---

**Version**: 1.0
**Last Updated**: 2025-10-05
**Full Documentation**:
- User guide: `docs/user-guide/getting-started.md`
- System architecture: `docs/system/architecture.md`
- Complete specifications: `docs/specifications/`
