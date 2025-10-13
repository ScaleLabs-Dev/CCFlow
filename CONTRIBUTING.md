# Contributing to CCFlow

This guide covers development workflows for contributing to the CCFlow repository.

## Working with This Repository

### Understanding File Organization

**Implementation Files**:
- `.claude/commands/cf/`: Command implementations
- `.claude/agents/`: Agent definitions with YAML frontmatter
- `.claude/templates/`: Templates for new project initialization

**Documentation** (`docs/`):
- `user-guide/`: Getting started, commands, agents, workflows
- `system/`: Architecture, validation, extending CCFlow
- `specifications/`: Complete technical specifications

**Root Files**:
- `README.md`: User-facing quick start and reference
- `CLAUDE.md`: Architecture guidance for Claude Code instances
- `CONTRIBUTING.md`: This file - development workflows

## Development Workflow

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

## Modifying Commands

When creating or modifying slash commands, consult the **[Claude Code Slash Commands Reference](docs/references/claude-code-slash-commands.md)** for:
- Official YAML frontmatter options (`description`, `allowed-tools`, `argument-hint`, `model`)
- Argument handling with placeholders (`$ARGUMENTS`, `$1`, `$2`)
- Best practices for command structure and security
- Directory organization and namespacing conventions

### Command Structure

All CCFlow commands follow this structure:

```markdown
---
description: Brief one-line description
allowed-tools: tool1, tool2, tool3
argument-hint: <required> [optional]
---

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
**Required Frontmatter**: `description`, `allowed-tools`, `argument-hint`

## Modifying Agents

### Agent Structure

YAML frontmatter + markdown:

```yaml
---
name: AgentName
description: Purpose and usage
tools: ['Read', 'Write', 'Edit']  # Minimal required tools only
model: inherit  # or sonnet, opus, haiku
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

**Critical**: Validate frontmatter YAML syntax - invalid YAML will break the agent.

### Creating Sub-Agents

When creating or modifying sub-agents, consult the **[Claude Code Sub-Agents Reference](docs/references/claude-code-sub-agents.md)** for:
- Official YAML frontmatter requirements (`name`, `description`, `tools`, `model`)
- Best practices for sub-agent design and single responsibility
- Proper file structure and naming conventions
- Tool permission configuration
- Integration with CCFlow's agent architecture

Key requirements:
- **name**: lowercase, alphanumeric with hyphens
- **description**: clear invocation context
- **tools**: (optional) restricted tool access
- **model**: (optional) sonnet, opus, haiku, or inherit

## Testing This System

This is a specification-based system (no executable code). Validation is through:

1. **Structural validation**: Check all required files exist and have proper format
2. **Cross-reference validation**: Verify all mentioned commands/agents exist
3. **Template validation**: Ensure memory bank templates match spec
4. **Consistency validation**: Check command outputs match agent inputs

See `docs/system/validation.md` for validation methodology.

## Key Design Constraints

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

## Configuring Implementation Teams

### For User Projects

CCFlow provides two commands:

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

### For CCFlow Itself

- CCFlow's agents in `.claude/agents/` are already configured
- Specialists would only be needed if CCFlow's work becomes more specialized
- Currently, empty `specialists/` subdirs indicate no need for specialization

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

### Pattern: Implementation Agent Delegation

**Generic agents** (user projects without configured team):
```
Load systemPatterns.md + CLAUDE.md → Implement directly (NO delegation) → Verify tests pass → Update memory bank
```

**Stack-specific core agents** (user projects with configured team):
```
Load systemPatterns.md → Check routing.md → Check for specialist → Delegate OR implement directly → Verify tests pass → Update memory bank
```

**CCFlow's own agents** (this repository):
```
Load systemPatterns.md + CLAUDE.md → Implement directly → Verify tests pass → Update memory bank
```

### Pattern: Memory Bank Synchronization

Commands that modify state:
```
Pre-read relevant files → Execute operation → Update activeContext.md (always) → Update domain files (as needed) → Checkpoint opportunity
```

## MCP Server Integration

CCFlow uses Sequential MCP for `/cf:creative` command:
- Extended thinking mode with progressive budgets
- Hypothesis-driven solution comparison
- Structured multi-step reasoning for architectural decisions

## Submitting Changes

1. Create a feature branch
2. Make your changes following the guidelines above
3. Validate all changes using the checklist
4. Update documentation as needed
5. Submit a pull request with clear description

---

**Last Updated**: 2025-01-13