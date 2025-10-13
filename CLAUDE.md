# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**CCFlow** is a comprehensive workflow system for Claude Code providing structured development with TDD enforcement, persistent memory bank context, and intelligent agent-based task coordination.

**Tech Stack**: Markdown-based specification system with Claude Code custom commands and sub-agents
**Status**: ✅ Production Ready (v1.0)

## Fundamental Execution Model

**Critical Constraint**: CCFlow is a specification-based system running on Claude Code. Understanding this constraint is essential for all modifications.

### How Claude Code Agents Work

**What agents ARE**:
- Markdown files with YAML frontmatter (defines metadata)
- Prose instructions that Claude reads and follows
- Step-by-step procedures for Claude to execute
- Reference documentation for context

**What agents ARE NOT**:
- Executable code or scripts
- Programs with automatic validation logic
- Systems that parse/enforce data structures
- Automated enforcement mechanisms

### How Commands Work

**Commands provide**:
- Procedural steps for Claude to follow in sequence
- Decision points with explicit conditions
- Agent invocation instructions
- Validation procedures (manual, not automatic)

**Commands do NOT**:
- Execute code or run validation logic
- Automatically enforce rules
- Parse YAML or execute algorithms
- Provide programmatic guarantees

### Practical Implications for CCFlow Design

**1. Memory Bank Integrity System**
- YAML headers in memory bank files = **reference documentation** (not parsed data)
- Documentarian agent = **procedural consultant** (not automated gatekeeper)
- Health scoring = **manual calculation** following documented formula
- Validation = **Claude following checklist** (not code execution)

**2. Agent Boundaries**
- Domain boundaries = **behavioral guidance** in prose
- Write permissions = **instructions to follow** (not enforced programmatically)
- Classification = **keyword matching by Claude** (not automated parsing)

**3. TDD Enforcement**
- GREEN gate = **command-level requirement** that Claude verifies
- Test validation = **Claude runs tests and checks results**
- No automatic blocking = **Claude responsible for following rules**

### Writing Effective Agents and Commands

**DO**:
- Write step-by-step procedural instructions
- Include decision trees and keyword lists inline
- Specify manual validation procedures
- Provide examples and edge cases
- Use imperative language ("Check if...", "Verify that...", "List all...")

**DON'T**:
- Describe "validation logic" or "algorithms"
- Assume automatic enforcement
- Reference parsed data structures
- Write as if agents execute code
- Use terms like "the system will automatically..."

**Examples**:

❌ **Wrong** (assumes code execution):
```
The agent validates content against classification rules using semantic analysis.
```

✅ **Right** (procedural instruction):
```
Read the content. Match keywords against the lists below (product_keywords, technical_keywords). Count matches in each category. Choose the category with most matches.
```

❌ **Wrong** (assumes automatic):
```
The system enforces domain boundaries and rejects invalid writes.
```

✅ **Right** (manual procedure):
```
Before writing to systemPatterns.md:
1. Read the content to be written
2. Search for product keywords: [user needs, feature, UX, user story]
3. If found, reject write and recommend productContext.md instead
4. If not found, proceed with write
```

### YAML Frontmatter Guidelines

**Valid Claude Code frontmatter fields** (official):
- `name`: Agent identifier (required)
- `description`: Purpose and usage (required)
- `tools`: Tool permissions (optional)
- `model`: Model selection (optional)

**Custom fields** (for CCFlow):
- Can add custom fields for documentation purposes
- These are **not parsed or enforced** by Claude Code
- Serve as inline reference for Claude to read
- Examples: `priority`, `triggers`, `dependencies`, `outputs`

**Memory Bank YAML headers**:
- Entirely custom documentation
- Claude reads them for context
- Not programmatically enforced
- Provide guidance for classification decisions

### This Affects All CCFlow Components

**Commands**: Must include explicit validation steps (not assume automation)
**Agents**: Must have procedural instructions (not "logic" descriptions)
**Memory Bank**: YAML headers are reference docs (not enforced schema)
**Integrity System**: Manual procedures following checklists (not automated)
**Testing**: Claude runs and interprets tests (not automated CI/CD)

## Critical Architecture Concepts

### 1. Two-Layer Agent System

**Workflow Layer** (`.claude/agents/workflow/`):
- **Assessor**: Analyzes task complexity (1-4 levels), routes to appropriate workflow
- **Architect**: Technical design, system architecture, pattern identification
- **Product**: Requirements analysis, user needs, feature prioritization
- **Facilitator**: Interactive refinement through question-driven dialogue (Action Recommendation Pattern)
- **Documentarian**: Memory bank maintenance, cross-file consistency
- **Reviewer**: Code quality assessment, technical debt tracking

**Product Teams Architecture** (`.claude/agents/`):

CCFlow uses a two-tier implementation model:

**1. Generic Agents** (`.claude/agents/generic/` in user projects):
- **Purpose**: Universal fallbacks that work with any tech stack
- **Agents**: codeImplementer, testEngineer, uiDeveloper
- **Behavior**: Handle ALL tasks directly, NO specialist delegation
- **Patterns**: Framework-agnostic best practices from CLAUDE.md and systemPatterns.md
- **When used**: Default after `/cf:init`, or when no stack-specific team configured

**2. Stack-Specific Teams** (`.claude/agents/[domain]/[stack]/` in user projects):
- **Purpose**: Optimized for specific tech stacks (React-Express, React Native, LangChain, etc.)
- **Structure**:
  - `core/` - Framework-aware implementation agents (e.g., expressBackend, reactFrontend, jestTester)
  - `specialists/` - Domain experts (e.g., sequelizeDb, jwtAuth, reactPerformance)
  - `routing.md` - Keyword-based delegation rules
- **Behavior**: Core agents delegate to specialists based on keywords
- **Configuration**: Via `/cf:configure-team` command (auto-detection or custom creation)

**3. CCFlow's Own Agents** (`.claude/agents/` in THIS repo):
- **Purpose**: Customized for CCFlow's self-development (markdown specs, commands, agents)
- **Location**: `development/`, `testing/`, `ui/`, `workflow/`, `system/`
- **Note**: These are CCFlow's working agents, not templates for user projects
- **Specialists**: Empty `specialists/` subdirs (CCFlow doesn't need stack-specific specialists)

**Key Distinctions**:
- Workflow agents → orchestrate and plan
- Generic agents → implement directly without delegation
- Stack-specific agents → delegate to specialists
- CCFlow's agents → customized for specification system work

**Template System**:
- Generic templates: `.claude/templates/generic/` (3 agents)
- Stack templates: `.claude/templates/team-types/` (pre-built stacks like React-Express)
- Blank templates: `.claude/templates/blank-agents/` (for custom team creation)
- `/cf:init` installs workflow + generic agents
- `/cf:configure-team` installs stack-specific teams
- See templates for configuration placeholders

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
2. Implementation agent implements to make tests pass (delegates to specialists)
3. GREEN gate: If tests fail after 3 attempts → STOP, report blocker
4. Only after 100% GREEN → update memory bank, mark complete

**No exceptions**: Implementation cannot be marked complete with failing tests.

### 5. Command Namespace: `/cf:*`

All commands use `/cf:` prefix to avoid conflicts. Commands are self-documenting (see `.claude/commands/cf/`).

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
- `.claude/commands/cf/`: 12 command implementations (cf-*.md)
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

### Creating Sub-Agents

When creating or modifying sub-agents in CCFlow, consult the **[Claude Code Sub-Agents Reference](docs/references/claude-code-sub-agents.md)** for:
- Official YAML frontmatter requirements (`name`, `description`, `tools`, `model`)
- Best practices for sub-agent design and single responsibility
- Proper file structure and naming conventions
- Tool permission configuration
- Integration with CCFlow's agent architecture

Sub-agents follow the official Claude Code specification with these key requirements:
- **name**: lowercase, alphanumeric with hyphens
- **description**: clear invocation context
- **tools**: (optional) restricted tool access
- **model**: (optional) sonnet, opus, haiku, or inherit

### Configuring Implementation Teams

**For user projects**, CCFlow provides two commands:

**1. `/cf:configure-team`** - Set up stack-specific teams:
- Auto-detects tech stack from package.json, systemPatterns.md, directory structure
- Installs pre-built templates (React-Express, React Native, LangChain)
- OR guides custom team creation via Facilitator
- Creates: core agents + specialists + routing.md
- Updates systemPatterns.md with team configuration

**2. `/cf:create-specialist`** - Add specialists to existing teams:
- Prerequisites: Must run `/cf:configure-team` first
- Only works with stack-specific teams (NOT generic agents)
- Creates specialist in `specialists/` subdirectory
- Updates parent core agent to recognize new specialist
- User-driven: Create specialists when you recognize repeated domain patterns

**For CCFlow itself**:
- CCFlow's agents in `.claude/agents/` are already configured
- Specialists would only be needed if CCFlow's work becomes more specialized
- Currently, empty `specialists/` subdirs indicate no need for specialization

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

### Pattern: Project Initialization (Fresh vs Existing)

`/cf:init` auto-detects project type and imports existing documentation:
```
Phase 0: Scan for docs (README.md, CLAUDE.md, package.json, code structure)
         ↓
    If found → Present findings → User confirms import
         ↓
    Import mode: Pre-populate templates → Validate with user → Fill gaps
         ↓
    If not found → Fresh mode: Empty templates → Standard guided creation
```

**Import Sources**:
- README.md → Executive Summary, Features, Problem Statement
- CLAUDE.md → Tech Stack, Constraints, Patterns
- package.json → Dependencies, Framework detection
- Code structure → Architecture style, Component patterns

**Flags**:
- Default: Auto-detect (import if docs exist, fresh if not)
- `--force-fresh`: Skip discovery, use empty templates
- `--quick`: Skip guided creation (works with both modes)

**Token Efficiency**: Discovery logic inline in command (not in agents) to avoid loading on frequent operations.

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

### Pattern: Implementation Agent Delegation

**Generic agents** (user projects without configured team):
```
Load systemPatterns.md + CLAUDE.md → Implement directly (NO delegation) → Verify tests pass → Update memory bank
```
- Handle everything using framework-agnostic patterns
- Suggest `/cf:configure-team` for better framework integration

**Stack-specific core agents** (user projects with configured team):
```
Load systemPatterns.md → Check routing.md → Check for specialist → Delegate OR implement directly → Verify tests pass → Update memory bank
```
- User can create specialists with `/cf:create-specialist` when repeated domain patterns emerge

**CCFlow's own agents** (this repository):
```
Load systemPatterns.md + CLAUDE.md → Implement directly → Verify tests pass → Update memory bank
```
- Customized for CCFlow's markdown/specification work
- Empty specialists/ subdirs (no specialization needed currently)

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
5. **Specialist Discovery**: Implementation agents check `specialists/` subdirectory existence before attempting delegation
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
