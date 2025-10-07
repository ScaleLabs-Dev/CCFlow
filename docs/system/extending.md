# Extending CCFlow

How to customize and extend the CCFlow system for your needs.

## Understanding the Template System

**CCFlow uses a template-based architecture** to remain universally applicable across different tech stacks.

### Two Agent Locations

1. **`.claude/templates/agents/`** - Generic templates (what ships with CCFlow)
   - Contains TODO placeholders like `{{LANGUAGE}}`, `{{FRAMEWORK}}`
   - Workflow agents (already generic, no customization needed)
   - Implementation agents (with project-specific TODOs)

2. **`.claude/agents/`** - Configured agents (created per-project during `/cf:init`)
   - Fully configured for your specific tech stack
   - NO TODO sections (replaced with actual configuration)
   - Ready to use immediately

### Configuration Process (Phase 1.5 of /cf:init)

```
1. Read CLAUDE.md → Extract Tech Stack, Conventions, Patterns
2. Auto-detect → package.json, code structure, config files
3. Merge → Priority: CLAUDE.md > Auto-detected > Defaults
4. Prompt → Only for critical gaps not found
5. Populate → Replace {{PLACEHOLDERS}} in templates
6. Write → Configured agents to .claude/agents/
```

See [`.claude/templates/agents/CONFIGURATION_SCHEMA.md`](../../.claude/templates/agents/CONFIGURATION_SCHEMA.md) for complete details.

### When to Modify Templates

**Modify `.claude/templates/agents/` when:**
- Adding new TODO sections to implementation agents
- Changing workflow agent logic (applies to all projects)
- Creating new agent types

**Modify `.claude/agents/` when:**
- Customizing agents for YOUR specific project
- Adding project-specific patterns or conventions
- Creating specialists for your domain

---

## Creating Specialists

**When to create:** After 3+ delegations from a hub agent to the same domain

**Command:**
```bash
/cf:create-specialist database --type development --name databaseSpecialist
```

**Manual process:**

1. Create file in appropriate `specialists/` directory:
```bash
touch .claude/agents/development/specialists/databaseSpecialist.md
```

2. Add YAML frontmatter:
```yaml
---
name: databaseSpecialist
role: Database operations and ORM management
priority: medium
triggers: [database, orm, migration, query]
dependencies: [systemPatterns.md, CLAUDE.md]
outputs: [activeContext.md, systemPatterns.md]
---
```

3. Document responsibilities:
```markdown
# Agent: databaseSpecialist

Specialist for database operations, ORM usage, migrations, and query optimization.

## Responsibilities
- Design database schemas
- Create and manage migrations
- Optimize database queries
- Implement ORM patterns
- Handle database testing strategies

## Tech Stack (Customize)
- ORM: Prisma / TypeORM / SQLAlchemy
- Database: PostgreSQL / MySQL / MongoDB
- Migration tools: [Your tools]

## Process
1. Load systemPatterns.md for database patterns
2. Load CLAUDE.md for tech stack configuration
3. Design/implement database solution
4. Document patterns in systemPatterns.md
5. Update activeContext.md with changes
```

4. Update hub agent to recognize specialist:
```markdown
# Edit .claude/agents/development/codeImplementer.md

## Delegation Rules

**Database Operations** (triggers: database, orm, migration):
- Check: `.claude/agents/development/specialists/databaseSpecialist.md` exists?
- YES → Delegate to databaseSpecialist
- NO → Implement directly
```

---

## Adding New Commands

**Structure to follow:**

```markdown
# Command: /cf:your-command

[Brief description]

---

## Usage

\`\`\`
/cf:your-command [required] [optional]
/cf:your-command [required] --flag
\`\`\`

## Parameters

- `[required]`: **Required** - Description
- `[optional]`: **Optional** - Description

## Flags

- `--flag`: Description

---

## Purpose

What this command does and why it exists.

---

## Prerequisites

- Memory bank initialized (if applicable)
- Other requirements

---

## Process

### Step 1: [First Step]

Detailed description with code examples

---

### Step 2: [Second Step]

Detailed description

---

## Examples

### Example 1: [Common Use Case]

\`\`\`bash
/cf:your-command example
# Expected output
\`\`\`

---

## Error Handling

### Error 1: [Common Error]

\`\`\`
Error message
Explanation and fix
\`\`\`

---

## Memory Bank Updates

- File 1: What gets updated and how
- File 2: What gets updated and how

---

## Notes

- Important caveats
- Related patterns
- Best practices

---

## Related Commands

- `/cf:related` - How it relates

---

**Command Version**: 1.0
**Last Updated**: YYYY-MM-DD
```

**Save to:** `.claude/commands/cf:your-command.md`

---

## Modifying Existing Agents

**Locate agent file:**
- Workflow: `.claude/agents/workflow/[agent].md`
- Implementation: `.claude/agents/{testing,development,ui}/[agent].md`

**Modify sections:**
- **Responsibilities:** What the agent does
- **Process:** How the agent operates
- **Output Format:** What the agent produces
- **Integration:** How it works with others

**Maintain YAML frontmatter:**
```yaml
---
name: agent-name  # Must match filename
role: Brief description
priority: high|medium|low
triggers: [command1, command2]
dependencies: [file1.md, file2.md]
outputs: [file1.md, file2.md]
---
```

**Validate:**
- YAML syntax is correct
- All referenced files exist
- Integration points still work

---

## Adding Memory Bank Files

**For project-specific needs, add to `memory-bank/`:**

**Example: API documentation**

1. Create template:
```bash
# In .claude/templates/
touch apiDocumentation.template.md
```

2. Define structure:
```markdown
# API Documentation

## Endpoints

### [Endpoint Name]
- **Method**: GET/POST/PUT/DELETE
- **Path**: /api/path
- **Parameters**: ...
- **Response**: ...

## Authentication
[Auth details]

## Rate Limiting
[Limits]

**Last Updated**: [Auto-updated]
```

3. Update `/cf:init` to copy template:
```bash
# Add to template copy loop in cf-init.md
cp .claude/templates/apiDocumentation.template.md memory-bank/apiDocumentation.md
```

4. Specify which agents update it:
```markdown
# In relevant agent files (e.g., codeImplementer.md)

## Outputs
- systemPatterns.md
- activeContext.md
- apiDocumentation.md  # New
```

---

## Customizing Facilitation Templates

**Location:** `docs/specifications/facilitator-patterns.md`

**Add domain-specific question templates:**

```markdown
### [Your Domain] Questions Template

**Context Questions**:
- Question 1 about domain context
- Question 2 about domain goals

**Technical Questions**:
- Question 1 about technical approach
- Question 2 about constraints

**Validation Questions**:
- Question 1 to validate assumptions
- Question 2 to check edge cases
```

**Use in `/cf:facilitate`:**
```markdown
# In .claude/commands/cf:facilitate.md

## Domain-Specific Templates

If topic matches [domain]:
  Load questions from facilitator-patterns.md
  Apply domain-specific template
```

---

## Customizing Hub Agents for Tech Stack

**Edit hub agent files to match your stack:**

**Example: codeImplementer for Go backend**

```markdown
# Edit: .claude/agents/development/codeImplementer.md

## Tech Stack Configuration

**Language**: Go
**Framework**: Gin / Echo
**Testing**: testify
**ORM**: GORM
**Patterns**: From systemPatterns.md

## Coding Conventions

**Style**: gofmt, golint
**Error Handling**: Explicit error returns
**Project Structure**:
- cmd/ - Main applications
- pkg/ - Public libraries
- internal/ - Private packages

## Implementation Process

1. Load systemPatterns.md for Go patterns
2. Load CLAUDE.md for project-specific config
3. Check for Go specialists in specialists/
4. Implement following Go conventions
5. Ensure tests use testify
6. Update activeContext.md with changes
```

**Similar for testEngineer and uiDeveloper:**
- Specify testing frameworks
- Define UI component patterns
- Set code style standards

---

## Extending Complexity Assessment

**Modify Assessor for domain-specific complexity:**

```markdown
# Edit: .claude/agents/workflow/assessor.md

## Custom Complexity Indicators

**Keywords to watch:**
- [Domain-specific term] → Indicates Level 3+ complexity
- [Technology keyword] → May require specialist

**Scope Estimation:**
- [Domain pattern] → Typically affects 5-10 files
- [Integration type] → High cross-module impact

## Domain-Specific Routing

If task involves [domain]:
  Increase complexity assessment by 1 level
  Recommend specialist creation
```

---

## Creating Custom Workflows

**Define new workflow patterns in documentation:**

```markdown
# In docs/user-guide/workflows.md

## [Your Workflow Name]

**Scenario:** [When to use this pattern]

**Pattern:**
\`\`\`bash
/cf:feature "[description]"
/cf:plan [...]
/cf:custom-step [...]  # Your custom command
/cf:code [...]
/cf:checkpoint "[message]"
\`\`\`

**Duration:** [Estimate]

**Key points:**
- [Important note 1]
- [Important note 2]
```

---

## Best Practices for Extensions

**Do:**
- ✅ Follow existing file structures and patterns
- ✅ Maintain YAML frontmatter in agent files
- ✅ Document all custom additions
- ✅ Update cross-references when adding files
- ✅ Test with `/cf:init test-project`
- ✅ Keep memory bank templates consistent

**Don't:**
- ❌ Break existing integration points
- ❌ Skip YAML validation
- ❌ Create undocumented commands/agents
- ❌ Duplicate state across memory bank files
- ❌ Modify core TDD enforcement logic
- ❌ Skip required command sections

---

## Validation After Extensions

**Run validation checks:**

1. **Structural:** All required sections present
2. **YAML:** Frontmatter validates
3. **Cross-references:** All references resolve
4. **Integration:** Commands → agents → memory bank flow works
5. **Test:** `/cf:init test-project` succeeds

**Validation commands:**
```bash
# Check YAML
head -n 10 .claude/agents/*/*.md

# Check templates exist
ls .claude/templates/*.template.md

# Test initialization
/cf:init test-project
cd test-project
ls memory-bank/  # Should have all files
```

---

## Contributing Extensions Back

**If you create generally useful extensions:**

1. Document in this file
2. Add examples to user guide
3. Update specifications if architecture changes
4. Test thoroughly
5. Share with CCFlow community

---

For architectural understanding, see [architecture.md](architecture.md).
For quality standards, see [validation.md](validation.md).
