# Claude Code Slash Commands Reference

> **Source**: Official Claude Code documentation
> **Purpose**: Local reference for creating and managing slash commands in CCFlow
> **Last Updated**: 2025-10-13

## Overview

Slash commands are a powerful feature in Claude Code that provide quick access to custom workflows, automate repetitive tasks, and control Claude's behavior during interactive sessions. They enable users to create reusable command sequences that can accept arguments, execute tools, and integrate with external systems.

## Command Types

### 1. Built-in Commands
Claude Code provides several pre-defined commands:
- `/clear` - Clear the conversation history
- `/help` - Display available commands and help
- `/model` - Switch between AI models
- `/review` - Request code review
- `/permissions` - Configure command permissions

### 2. Custom Commands
User-defined commands stored in specific directories:
- **Project-level**: `.claude/commands/` (project-specific)
- **Personal-level**: `~/.claude/commands/` (available across all projects)

## Command Structure

### File Format
Slash commands are Markdown files with optional YAML frontmatter:

```yaml
---
description: Brief description shown in command list
allowed-tools: tool1, tool2, tool3  # Optional - restrict tool access
argument-hint: <required> [optional]  # Shows expected arguments
model: sonnet  # Optional - specify model (sonnet, opus, haiku, inherit)
disable-model-invocation: false  # Optional - prevent automatic execution
---

# Command body in Markdown

Detailed instructions for Claude to execute.
Can include argument placeholders: $ARGUMENTS, $1, $2, etc.
```

### YAML Frontmatter Fields

#### Core Fields

**description** (string, optional)
- Brief one-line description shown in command lists
- Should be concise and descriptive
- Example: `"Create a git commit with smart message generation"`

**allowed-tools** (string or array, optional)
- Comma-separated list or array of allowed tools
- Can include wildcards for specific operations
- Examples:
  - `"Read, Edit, Write"`
  - `"Bash(git:*), Grep"`
  - `["TodoWrite", "Task", "WebSearch"]`

**argument-hint** (string, optional)
- Shows expected argument format
- Use `<required>` for required args, `[optional]` for optional
- Examples:
  - `"<filename>"`
  - `"<task-name> [--flags]"`
  - `"[commit message]"`

**model** (string, optional)
- Specify which model to use for this command
- Options: `"sonnet"`, `"opus"`, `"haiku"`, `"inherit"`
- Default: inherits from current session

**disable-model-invocation** (boolean, optional)
- When `true`, prevents automatic command execution
- Useful for testing or manual review workflows
- Default: `false`

## Argument Handling

### Argument Placeholders

Commands can capture and use arguments through placeholders:

**$ARGUMENTS**
- Captures all arguments passed to the command
- Example: `/commit fix bug` → `$ARGUMENTS` = "fix bug"

**Positional Parameters**
- `$1`, `$2`, `$3`, etc. for specific positions
- Example: `/deploy $1 to $2` with `/deploy app production`
  - `$1` = "app"
  - `$2` = "production"

### Special Prefixes

**@ File References**
```
/analyze @src/main.js @package.json
```
Allows referencing files directly in commands

**! Bash Commands**
```
/run !npm test
```
Execute bash commands directly (if permitted)

## Directory Organization

### Namespacing with Subdirectories

Commands can be organized in subdirectories for namespacing:

```
.claude/commands/
├── git/
│   ├── commit.md
│   ├── push.md
│   └── pr.md
├── test/
│   ├── unit.md
│   └── e2e.md
└── deploy.md
```

Usage:
- `/git:commit` or `/git/commit`
- `/test:unit` or `/test/unit`
- `/deploy`

### CCFlow Convention

CCFlow uses the `/cf:` namespace for all commands:

```
.claude/commands/cf/
├── init.md
├── feature.md
├── plan.md
├── code.md
└── checkpoint.md
```

This prevents conflicts with user commands and other tools.

## Best Practices

### 1. Clear Command Names
- Use descriptive, lowercase names
- Prefer hyphens over underscores
- Keep names concise but meaningful
- Examples: `review-pr`, `run-tests`, `deploy-staging`

### 2. Comprehensive Frontmatter
Always include:
- `description` for discoverability
- `argument-hint` for usage clarity
- `allowed-tools` for security

### 3. Structured Command Body
Organize commands with clear sections:
```markdown
# Purpose
Brief explanation of what this command does

# Process
1. Step-by-step execution
2. Clear decision points
3. Error handling

# Examples
Show typical usage scenarios
```

### 4. Argument Validation
Start commands with argument checking:
```markdown
Check if required arguments provided:
- If missing: Show usage and exit
- If invalid: Provide helpful error message
```

### 5. Tool Restrictions
Only grant necessary tools:
```yaml
# Good - specific tools
allowed-tools: Read, Edit, TodoWrite

# Avoid - overly permissive
allowed-tools: "*"
```

## Example Commands

### Simple Command: Git Commit
```yaml
---
description: Create a git commit with generated message
allowed-tools: Bash(git:*), Read
argument-hint: [message]
---

1. Run `git status` to see changes
2. Run `git diff` to understand modifications
3. Generate or use provided commit message: $ARGUMENTS
4. Create commit with message
5. Show commit confirmation
```

### Complex Command: Code Review
```yaml
---
description: Comprehensive code review with multiple checks
allowed-tools: Read, Grep, Task
argument-hint: <file-or-directory>
model: opus
---

# Code Review for $1

## Automated Checks
1. Security vulnerabilities scan
2. Code quality assessment
3. Performance analysis
4. Test coverage check

## Manual Review Points
- Architecture alignment
- Best practices adherence
- Documentation completeness

Generate comprehensive review report.
```

### Interactive Command: Feature Planning
```yaml
---
description: Interactive feature planning session
allowed-tools: Read, Write, TodoWrite
argument-hint: <feature-name>
disable-model-invocation: false
---

# Plan Feature: $1

1. Gather requirements through questions
2. Analyze existing codebase
3. Create task breakdown
4. Generate implementation plan
5. Update memory bank with plan
6. Recommend next steps
```

## Permissions and Security

### Permission Configuration

Use `/permissions` to configure:
- Enable/disable specific commands
- Control tool access
- Set execution limits

### Security Considerations

1. **Tool Restrictions**: Always specify `allowed-tools`
2. **Input Validation**: Validate arguments before use
3. **Bash Commands**: Be cautious with `Bash(*)` permissions
4. **File Access**: Limit Read/Write to necessary paths
5. **Model Selection**: Consider cost implications of model choice

## Integration with CCFlow

### CCFlow Command Standards

All CCFlow commands follow these patterns:

1. **Namespace**: Use `/cf:` prefix
2. **Structure**: Required sections (Usage, Purpose, Process, Examples, Error Handling)
3. **Memory Bank**: Update relevant files after execution
4. **Action Recommendations**: Always suggest next steps
5. **Token Efficiency**: Stay within budgets (simple: 800-1500, moderate: 1500-3000, complex: 3000-5000)

### Command Refinement

Use `/cf:refine-command` to optimize commands:
- Check structure completeness
- Validate token budgets
- Ensure error handling
- Add missing examples
- Improve decision clarity

## Advanced Features

### MCP Server Integration

Commands can invoke MCP servers:
```yaml
allowed-tools: mcp__sequential-thinking__sequentialthinking
```

### Thinking Modes

Trigger extended reasoning:
```markdown
Think through this problem step by step...
```

### Command Composition

Commands can invoke other commands:
```markdown
First run `/cf:init` if not initialized
Then proceed with main task...
```

### Dynamic Tool Selection

Commands can conditionally use tools:
```markdown
If file exists:
  Use Edit tool
Else:
  Use Write tool
```

## Common Pitfalls to Avoid

### 1. Missing Argument Validation
❌ **Wrong**: Assume arguments are present
✅ **Right**: Check and provide usage if missing

### 2. Overly Broad Tool Permissions
❌ **Wrong**: `allowed-tools: "*"`
✅ **Right**: `allowed-tools: "Read, Edit, TodoWrite"`

### 3. No Error Handling
❌ **Wrong**: Linear execution without checks
✅ **Right**: Include error detection and recovery

### 4. Unclear Argument Hints
❌ **Wrong**: `argument-hint: "args"`
✅ **Right**: `argument-hint: "<filename> [--verbose]"`

### 5. Missing Action Recommendations
❌ **Wrong**: End without next steps
✅ **Right**: Always suggest what to do next

## Validation Checklist

Before deploying a slash command, verify:

- [ ] Valid YAML frontmatter syntax
- [ ] Clear, descriptive command name
- [ ] `description` field present and helpful
- [ ] `argument-hint` accurately describes usage
- [ ] `allowed-tools` restricted to necessary tools
- [ ] Command body has clear structure
- [ ] Argument validation implemented
- [ ] Error handling included
- [ ] Examples provided (2-3 scenarios)
- [ ] Action recommendations present
- [ ] Token budget appropriate for complexity
- [ ] File in correct location (.claude/commands/ or subdirectory)
- [ ] Tested with representative inputs

## Related CCFlow Documentation

- [Command Refinement](./../commands/cf/refine-command.md) - Optimize existing commands
- [CCFlow Commands Guide](./../user-guide/commands.md) - Overview of CCFlow command system
- [CLAUDE.md](./../../CLAUDE.md) - Main guidance for modifying commands
- [Sub-Agents Reference](./claude-code-sub-agents.md) - Related agent creation documentation

## Notes

- Commands execute in the current project context
- Each command invocation is independent
- Commands can be disabled without deletion
- Performance varies by model selection
- Token usage counts against overall limits
- Commands can timeout on long operations
- Use `disable-model-invocation` for testing