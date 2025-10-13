# Claude Code Sub-Agents Reference

> **Source**: Official Claude Code documentation
> **Purpose**: Local reference for creating and managing sub-agents in CCFlow
> **Last Updated**: 2025-10-13

## Overview

Sub-agents are specialized AI assistants within Claude Code that enable focused task delegation and expertise separation. They operate independently with their own context windows and can be configured with specific tools and models.

## Key Characteristics

- **Unique Context Preservation**: Each sub-agent maintains its own separate context window
- **Specialized Domain Expertise**: Focused on specific tasks or areas of expertise
- **Reusable Components**: Can be used across multiple projects
- **Configurable Permissions**: Fine-grained control over tool access
- **Stateless Operation**: Each invocation is independent

## Sub-Agent Structure

### File Format
Sub-agents are defined as Markdown files with YAML frontmatter:

```yaml
---
name: your-sub-agent-name
description: When this subagent should be invoked and what it does
tools: tool1, tool2, tool3  # Optional - specific tools this agent can use
model: sonnet  # Optional - model selection (sonnet, opus, haiku, or inherit)
---

# System Prompt

Define the sub-agent's role, responsibilities, and behavioral guidelines here.
This becomes the system prompt for the sub-agent when invoked.
```

### YAML Frontmatter Fields

#### Required Fields

**name** (string, required)
- Unique identifier for the sub-agent
- Must be lowercase, alphanumeric with hyphens allowed
- Examples: `code-reviewer`, `test-engineer`, `database-expert`

**description** (string, required)
- Clear description of when and why to use this sub-agent
- Used by Claude to determine when to invoke the sub-agent
- Should be specific about the agent's expertise and use cases

#### Optional Fields

**tools** (string or array, optional)
- Comma-separated list or array of tool names
- Restricts the sub-agent to only these tools
- If omitted, inherits parent context's tools
- Examples: `"Read, Edit, Write"` or `["Bash", "Grep", "TodoWrite"]`

**model** (string, optional)
- Specifies which model to use for this sub-agent
- Options: `"sonnet"`, `"opus"`, `"haiku"`, `"inherit"`
- Default: inherits from parent context
- Use `"opus"` for complex reasoning tasks
- Use `"haiku"` for simple, fast operations

## Creation Methods

### 1. Interactive Creation (`/agents` command)

The easiest way to create a sub-agent:

```bash
/agents
```

This provides:
- Guided step-by-step setup
- Interactive tool selection
- Option to generate agent with Claude's help
- Automatic validation of structure

### 2. Direct File Management

Create Markdown files directly in:

**Project-level agents** (project-specific):
```
.claude/agents/your-agent.md
```

**User-level agents** (available across all projects):
```
~/.claude/agents/your-agent.md
```

### 3. CLI Configuration

For temporary or dynamic sub-agents:

```bash
--agents '[{"name": "temp-agent", "description": "...", "system_prompt": "..."}]'
```

## Best Practices

### 1. Single Responsibility Principle
- Each sub-agent should have ONE clear purpose
- Avoid creating "do-everything" agents
- Example: Separate `code-reviewer` from `code-formatter`

### 2. Clear System Prompts
Write detailed prompts that specify:
- The agent's role and expertise
- Specific responsibilities
- Output format expectations
- Interaction style
- Constraints and limitations

### 3. Appropriate Tool Selection
- Only grant tools the agent actually needs
- Less is more - restrict for safety and clarity
- Consider security implications of tool access

### 4. Naming Conventions
- Use descriptive, lowercase names
- Include domain in name: `react-specialist`, `database-optimizer`
- Avoid generic names like `helper` or `assistant`

### 5. Version Control
- Track project-level agents in git (`.claude/agents/`)
- Document changes to agent behavior
- Test agents after modifications

## Example Sub-Agents

### Code Reviewer
```yaml
---
name: code-reviewer
description: Reviews code for quality, security, and best practices. Proactively reviews after significant code changes.
tools: Read, Grep, Bash
model: sonnet
---

You are a meticulous code reviewer focused on:
1. Security vulnerabilities and potential exploits
2. Code readability and maintainability
3. Performance optimizations
4. Adherence to project patterns and standards
5. Test coverage and quality

Always provide actionable feedback with specific line references.
Prioritize critical issues over stylistic preferences.
```

### Test Engineer
```yaml
---
name: test-engineer
description: Writes comprehensive tests following TDD principles. Creates tests before implementation.
tools: Read, Write, Edit, Bash, TodoWrite
model: sonnet
---

You are a Test-Driven Development specialist who:
1. Writes failing tests FIRST before any implementation
2. Creates comprehensive test suites with edge cases
3. Ensures 100% coverage of critical paths
4. Follows the project's testing patterns and frameworks
5. Documents test purposes and expected behaviors

Never implement features - only write tests that define expected behavior.
```

### Database Specialist
```yaml
---
name: database-specialist
description: Optimizes database queries, designs schemas, and handles data migrations
tools: Read, Write, Edit, Bash, Grep
model: opus
---

You are a database optimization expert specializing in:
1. Query performance optimization
2. Schema design and normalization
3. Index strategy and optimization
4. Migration script creation
5. Data integrity and constraints

Always consider scalability and provide performance metrics where possible.
```

## Integration with CCFlow

### Workflow Agents vs Sub-Agents

**Workflow Agents** (CCFlow's orchestration layer):
- Located in `.claude/agents/workflow/`
- Coordinate complex multi-step operations
- Examples: Assessor, Facilitator, Documentarian

**Implementation Sub-Agents** (Task execution layer):
- Located in `.claude/agents/` subdirectories
- Execute specific technical tasks
- Examples: codeImplementer, testEngineer, uiDeveloper

### Creating Specialists

Use `/cf:create-specialist` to add domain-specific sub-agents:
```bash
/cf:create-specialist database --type testing --name sequelize-tester
```

This automatically:
- Creates the agent file with proper structure
- Updates parent core agent's routing
- Adds to specialists directory

### Agent Builder Integration

The AgentBuilder meta-agent (`/cf:refine-agent`) ensures:
- Proper YAML frontmatter structure
- Token efficiency (400-1500 tokens)
- Clear decision logic and triggers
- Integration with existing agents

## Common Pitfalls to Avoid

### 1. Overly Broad Agents
❌ **Wrong**: Agent that handles "all backend tasks"
✅ **Right**: Separate agents for API, database, authentication

### 2. Missing Clear Triggers
❌ **Wrong**: Vague description like "helps with code"
✅ **Right**: "Reviews React component performance and optimization"

### 3. Excessive Tool Permissions
❌ **Wrong**: Granting all tools to every agent
✅ **Right**: Only tools needed for the specific task

### 4. Inconsistent Naming
❌ **Wrong**: MixedCase or spaces in names
✅ **Right**: lowercase-with-hyphens

### 5. No Version Control
❌ **Wrong**: Creating agents only in ~/.claude/agents/
✅ **Right**: Project agents in .claude/agents/ tracked in git

## Validation Checklist

Before deploying a sub-agent, verify:

- [ ] Valid YAML frontmatter syntax
- [ ] Required fields: `name` and `description`
- [ ] Name is lowercase with only alphanumeric and hyphens
- [ ] Clear, specific description of when to use
- [ ] System prompt defines role clearly
- [ ] Only necessary tools are granted
- [ ] Model selection appropriate for task complexity
- [ ] File in correct location (.claude/agents/ or ~/.claude/agents/)
- [ ] Tested with representative tasks
- [ ] Documented in project if project-specific

## Related CCFlow Documentation

- [AgentBuilder Specification](./../specifications/agent_builder.md) - Meta-agent for creating and refining agents
- [CCFlow Agents Guide](./../user-guide/agents.md) - Overview of CCFlow's agent system
- [Product Teams Architecture](./../specifications/product_teams.md) - Stack-specific team configuration
- [CLAUDE.md](./../../CLAUDE.md) - Main guidance for modifying agents

## Notes

- Sub-agents are stateless - each invocation is independent
- Context window is separate from parent Claude instance
- Sub-agents can invoke other sub-agents (delegation chain)
- Performance varies by model selection
- Token usage counts against your overall limit