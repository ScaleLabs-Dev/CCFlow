# Agent and Command Development Guidelines

This document provides critical guidelines for developing agents and commands in the CCFlow system. These are essential constraints that must be understood when creating or modifying system components.

## Fundamental Constraint: Specification-Based System

**Critical Understanding**: CCFlow is a specification-based system running on Claude Code. Agents and commands are markdown instructions that Claude reads and follows, NOT executable code.

## Writing Effective Agents

### DO - Correct Approaches

✅ **Write step-by-step procedural instructions**
```markdown
1. Read the task description from tasks.md
2. Check for keywords: "database", "orm", "migration"
3. If found, delegate to databaseSpecialist
4. If not found, implement directly
```

✅ **Include decision trees and keyword lists inline**
```markdown
Decision: Is this a database task?
- Check keywords: [database, orm, query, migration, schema]
- If 2+ matches → delegate to specialist
- If <2 matches → handle directly
```

✅ **Specify manual validation procedures**
```markdown
Validation Steps:
1. Run the test command: `npm test`
2. Check the output for "PASS" or "FAIL"
3. Count the number of passing tests
4. If all tests pass, mark task complete
```

✅ **Use imperative language**
- "Check if the file exists"
- "Verify that tests pass"
- "List all matching files"
- "Count keyword matches"

✅ **Provide examples and edge cases**
```markdown
Example: Task contains "optimize database queries"
- Keywords found: "database", "queries" (2 matches)
- Decision: Delegate to databaseSpecialist
```

### DON'T - Common Mistakes

❌ **Describe "validation logic" or "algorithms"**
```markdown
Wrong: "The agent validates content against classification rules using semantic analysis."
Right: "Read the content. Match keywords against the lists below. Choose the category with most matches."
```

❌ **Assume automatic enforcement**
```markdown
Wrong: "The system enforces domain boundaries and rejects invalid writes."
Right: "Before writing to systemPatterns.md, check for product keywords. If found, recommend productContext.md instead."
```

❌ **Reference parsed data structures**
```markdown
Wrong: "Parse the YAML header and extract the priority field."
Right: "Read the file. Look for 'priority:' line. Note the value after the colon."
```

❌ **Write as if agents execute code**
```markdown
Wrong: "The agent calls the validation function and processes the result."
Right: "Run `npm test`. Read the output. Check if all tests passed."
```

❌ **Use terms like "the system will automatically..."**
```markdown
Wrong: "The system automatically detects and fixes errors."
Right: "Check for errors in the output. If found, follow these steps to fix..."
```

## Writing Effective Commands

### Command Structure Requirements

Commands must include explicit procedural steps, not abstract descriptions:

✅ **Right Approach**:
```markdown
## Process

### Step 1: Check Prerequisites
1. Check if memory-bank/ directory exists
2. If not exists, output: "Run: /cf:init first"
3. Stop execution

### Step 2: Load Context
1. Read tasks.md for task details
2. Read activeContext.md for current state
3. Extract task ID and description
```

❌ **Wrong Approach**:
```markdown
## Process
The command analyzes task complexity using sophisticated algorithms and routes appropriately based on internal logic.
```

## YAML Frontmatter Guidelines

### For Agents (Claude Code Official Fields)

**Required fields**:
- `name`: lowercase with hyphens (e.g., `database-specialist`)
- `description`: Clear invocation context

**Optional fields**:
- `tools`: Comma-separated list of allowed tools
- `model`: `sonnet`, `opus`, `haiku`, or `inherit`

**Custom documentation fields** (not enforced):
- `priority`, `triggers`, `dependencies`, `outputs`
- These serve as inline documentation for Claude to read

### For Commands (Claude Code Official Fields)

**Required fields**:
- `description`: Brief one-line description
- `allowed-tools`: Tools the command can use
- `argument-hint`: Shows usage pattern (e.g., `<required> [optional]`)

**Optional fields**:
- `model`: Model preference for command execution

## Meta-Development Tools

CCFlow provides specialized agents for system development:

### AgentBuilder (`/cf:refine-agent`)
- Generates new agents from specifications
- Refines existing agents for token efficiency
- Maintains 500-1500 token budgets
- Enforces single responsibility principle

### CommandBuilder (`/cf:refine-command`)
- Optimizes command clarity and completeness
- Ensures all essential sections present
- Maintains appropriate token budgets
- Adds missing examples and error handling

## Best Practices for System Development

1. **Use meta-agents for consistency**: Always use `/cf:refine-agent` and `/cf:refine-command` when modifying system components

2. **Validate against specifications**: Check against official Claude Code documentation:
   - [Claude Code Sub-Agents Reference](../references/claude-code-sub-agents.md)
   - [Claude Code Slash Commands Reference](../references/claude-code-slash-commands.md)

3. **Test procedural clarity**: Can a human follow these steps? Then Claude can too.

4. **Avoid over-engineering**: Trust Claude's base capabilities. Don't over-specify what Claude already knows.

5. **Maintain token efficiency**:
   - Agents: 500-1500 tokens
   - Commands: 800-5000 tokens (based on complexity)

## Common Patterns

### Pattern: Keyword-Based Delegation
```markdown
1. Read task description
2. Check for keywords: [list specific keywords]
3. Count matches
4. If threshold met, delegate to specialist
5. Otherwise, implement directly
```

### Pattern: Test Validation
```markdown
1. Run test command
2. Read output
3. Look for "PASS" or "FAIL" indicators
4. Count passing vs failing
5. If all pass, proceed
6. If any fail, stop and report
```

### Pattern: Memory Bank Updates
```markdown
1. Read current file content
2. Find appropriate section
3. Add new entry with timestamp
4. Write updated content back
5. Verify write succeeded
```

## Testing Your Agents/Commands

Before deploying:

1. **Procedural Clarity Test**: Can you manually follow the steps?
2. **Decision Coverage Test**: Are all decision branches specified?
3. **Keyword Completeness Test**: Are trigger keywords comprehensive?
4. **Error Handling Test**: Is there a clear action for each error?
5. **Token Budget Test**: Is the component within size limits?

## References

- [Claude Code Sub-Agents Specification](../references/claude-code-sub-agents.md)
- [Claude Code Slash Commands Specification](../references/claude-code-slash-commands.md)
- [CCFlow Architecture](./architecture.md)
- [Extending CCFlow](./extending.md)

---

**Important**: This document is critical for maintaining CCFlow's specification-based architecture. All agents and commands must follow these guidelines to function correctly within Claude Code's execution model.