---
description: "Create specialized implementation agent for delegated tasks"
allowed-tools: ['Read', 'Write', 'Edit', 'Task']
argument-hint: "[domain] --type [testing|development|ui] --name [agent-name]"
---

# Command: /cf:create-specialist

## Usage

```
/cf:create-specialist [domain] --type [testing|development|ui] --name [agent-name]
```

## Parameters

- `[domain]`: **Required** - Domain or specialty area (e.g., "database", "authentication", "charts")
- `[--type]`: **Required** - Agent category: `testing`, `development`, or `ui`
- `[--name]`: **Required** - Agent filename (e.g., "databaseSpecialist", "chartSpecialist")

---

## Purpose

Create custom specialist agents for specific technical domains:
1. Extend hub agent capabilities with focused specialists
2. Delegate complex domain-specific implementation
3. Maintain consistent patterns while adding expertise
4. Support team's unique technology stack and patterns
5. Enable scalable agent architecture

---

## Prerequisites

**Memory bank must be initialized**. Run `/cf:init [project-name]` first if needed.

**.claude/agents directory structure exists**. Should exist from initialization.

**Hub agent exists** for specialist's category. testEngineer, codeImplementer, or uiDeveloper should already exist.

---

## When to Create Specialists

**Good reasons to create specialist**:
- Hub agent repeatedly delegates to same domain (pattern detected)
- Specific technology requires deep expertise (e.g., GraphQL, WebSockets)
- Complex domain with many patterns (e.g., database optimization, security)
- Team has specialist expertise to encode
- Recurring implementation patterns in specific area

**Bad reasons (avoid)**:
- One-off task (hub agent can handle directly)
- Simple domains without complexity
- Premature specialization (create after pattern proven)
- Duplicating existing specialist capabilities

---

## Process

### Step 1: Verify Memory Bank and Agent Structure

Check if `memory-bank/` and `.claude/agents/` directories exist:

**If NOT EXISTS**:
```
⚠️ Memory Bank Not Initialized

Run: /cf:init [project-name]
```

**Stop execution.**

---

### Step 2: Validate Specialist Parameters

**Validate type**:
- Must be one of: `testing`, `development`, `ui`
- Determines which subdirectory specialist is created in

**Validate name**:
- Should be camelCase or kebab-case
- Should not conflict with existing specialist names
- Should end with "Specialist" for clarity (e.g., databaseSpecialist)

**Validate domain**:
- Should be specific enough to be useful (not too broad)
- Should represent cohesive area of expertise

---

### Step 3: Determine Specialist Directory

**Based on type, select directory**:

- `--type testing` → `.claude/agents/testing/specialists/`
- `--type development` → `.claude/agents/development/specialists/`
- `--type ui` → `.claude/agents/ui/specialists/`

**Check if specialist already exists**:
```
If file exists at: [directory]/[name].md
Warn user and ask if they want to overwrite
```

---

### Step 4: Create Specialist Agent File

**Generate specialist agent** using template structure:

```markdown
---
name: [AgentName]
description: Specialized [type] agent for [domain]
tools: [List of Claude Code tools this specialist needs]
model: claude-sonnet-4-5
parent: [testEngineer|codeImplementer|uiDeveloper]
---

# [AgentName] - [Domain] Specialist

**Domain**: [Domain description]
**Parent Agent**: [Hub agent that delegates to this specialist]
**Specialization**: [What makes this agent specialized]

---

## Responsibilities

### Primary

- [Responsibility 1 specific to domain]
- [Responsibility 2 specific to domain]
- [Responsibility 3 specific to domain]

### Delegated From Parent

**[Parent Agent Name]** delegates to this specialist when:
- [Delegation trigger 1]
- [Delegation trigger 2]
- [Delegation trigger 3]

---

## Domain Expertise

### [Domain] Patterns

**[Pattern 1 Name]**:
- **When**: [Context for using this pattern]
- **Approach**: [Implementation approach]
- **Example**:
```[language]
[Code example demonstrating pattern]
```

**[Pattern 2 Name]**:
- **When**: [Context]
- **Approach**: [Implementation]
- **Example**:
```[language]
[Code example]
```

### Common [Domain] Tasks

1. **[Task Type 1]**
   - Input: [What this specialist receives]
   - Output: [What this specialist produces]
   - Process: [How this specialist approaches it]

2. **[Task Type 2]**
   - Input: [What receives]
   - Output: [What produces]
   - Process: [Approach]

### [Domain] Anti-Patterns (Avoid)

- ❌ **[Anti-pattern 1]**: [Why to avoid] → Use [alternative] instead
- ❌ **[Anti-pattern 2]**: [Why to avoid] → Use [alternative] instead

---

## Tools and Technologies

### Required Tools

- **[Tool 1]**: [Why needed for this domain]
- **[Tool 2]**: [Why needed]
- **[Tool 3]**: [Why needed]

### Technology Stack (Customize for Project)

**Current Stack** (TODO: Update with project-specific technologies):
- [Technology 1]: [Version] - [Purpose in domain]
- [Technology 2]: [Version] - [Purpose in domain]

**Dependencies**:
- [Dependency 1]: [Why needed]
- [Dependency 2]: [Why needed]

---

## Integration with Project

### Pattern Sources

This specialist follows patterns from:
- `systemPatterns.md` - Project-wide conventions
- `[Domain]-specific patterns` - [Document or section in systemPatterns.md]

**TODO**: Review systemPatterns.md and identify domain-specific patterns to follow.

### Quality Standards

This specialist enforces:
- **[Quality Aspect 1]**: [Standard for this domain]
- **[Quality Aspect 2]**: [Standard]
- **[Quality Aspect 3]**: [Standard]

**TODO**: Define domain-specific quality standards based on project requirements.

---

## Workflow

### Delegation Pattern

1. **Parent agent identifies [domain] work** (e.g., [example scenario])
2. **Delegates to this specialist** with context:
   - Task requirements
   - Acceptance criteria
   - Relevant patterns from systemPatterns.md
3. **Specialist implements** following domain expertise
4. **Returns to parent** with:
   - Implementation artifacts
   - Any patterns discovered
   - Integration notes

### Output Format

**Standard output** from this specialist:

```markdown
## [Domain] Implementation Complete

**Task**: [What was implemented]
**Approach**: [Pattern used]

**Files Modified**:
- [file1]: [Changes made]
- [file2]: [Changes made]

**Patterns Applied**:
- [Pattern name]: [How applied]

**Integration Notes**:
[Any notes for parent agent or future work]

**Quality Checks**:
✓ [Domain-specific check 1]
✓ [Domain-specific check 2]
```

---

## Examples

### Example 1: [Common Domain Task]

**Scenario**: [Description of typical task this specialist handles]

**Input** (from parent agent):
```
[Example input/context provided by parent]
```

**Process**:
1. [Step 1 of how specialist approaches this]
2. [Step 2]
3. [Step 3]

**Output**:
```[language]
[Example code or artifact produced]
```

**Patterns Used**: [Pattern names]

### Example 2: [Another Common Task]

**Scenario**: [Description]

**Input**: [Example input]

**Process**:
1. [Step 1]
2. [Step 2]

**Output**: [Example output]

---

## Evolution and Maintenance

### Pattern Discovery

As this specialist works on tasks, it may discover new patterns:
- **Document in systemPatterns.md** under [Domain] section
- **Update this agent file** to reference new patterns
- **Share with team** for review and adoption

### Quality Improvement

Periodically review this specialist's output:
- Are domain patterns being followed consistently?
- Are quality standards being met?
- Should new patterns be added?
- Are there common mistakes to prevent?

**Review cadence**: Every [N] tasks or [timeframe]

---

## Customization Checklist

Before using this specialist, customize:

- [ ] Update "Technology Stack" section with project-specific technologies
- [ ] Review systemPatterns.md and add domain-specific patterns
- [ ] Define quality standards for this domain
- [ ] Add project-specific examples
- [ ] Update delegation triggers based on project needs
- [ ] Verify tools list matches project setup
- [ ] Add anti-patterns observed in project
- [ ] Document team's domain expertise

---

**Specialist Version**: 1.0
**Created**: [YYYY-MM-DD]
**Last Updated**: [YYYY-MM-DD]
**Parent Agent**: [Hub agent name]
```

---

### Step 5: Populate Specialist Template with Domain Details

**Based on domain and type, add domain-specific content**:

**For testing specialists**:
- Test framework specifics (Jest, Pytest, etc.)
- Domain-specific test patterns
- Mocking/stubbing strategies for domain
- Coverage requirements for domain

**For development specialists**:
- API patterns, data access patterns, business logic patterns
- Error handling specific to domain
- Performance considerations for domain
- Security concerns for domain

**For UI specialists**:
- Component patterns for domain
- Accessibility requirements for domain (e.g., charts need keyboard nav)
- Responsive design considerations
- State management patterns for domain

---

### Step 6: Update Parent Hub Agent

**Update parent hub agent** to reference new specialist:

**Add to specialist delegation section**:

```markdown
### Specialist Delegation

**When to Delegate**:

[...existing specialists...]

- **[Domain] work** → [SpecialistName] (.claude/agents/[type]/specialists/[name].md)
  - Examples: [Example task 1], [Example task 2]
  - Triggers: [When to delegate]
```

---

### Step 7: Update systemPatterns.md (If Needed)

**If domain patterns exist but aren't documented**:

Add domain-specific pattern section to systemPatterns.md:

```markdown
### [Domain] Patterns

**[Pattern Name]**:

**Context**: [When this pattern applies]

**Problem**: [What problem it solves]

**Solution**:
[Implementation approach]

**Example**:
```[language]
[Code example]
```

**Rationale**: [Why this pattern over alternatives]

**Used By**: [SpecialistName] specialist
```

---

### Step 8: Output Creation Summary

```markdown
✅ SPECIALIST CREATED: [SpecialistName]
─────────────────────────────────────

**Specialist**: [AgentName]
**Domain**: [Domain]
**Type**: [testing|development|ui]
**File**: .claude/agents/[type]/specialists/[name].md

## Capabilities

**Responsibilities**:
- [Responsibility 1]
- [Responsibility 2]
- [Responsibility 3]

**Parent Agent**: [Hub agent name]
**Delegation Triggers**:
- [Trigger 1]
- [Trigger 2]

## Integration

✓ Specialist agent file created
✓ Parent hub agent updated with delegation reference
[✓ systemPatterns.md updated with domain patterns]

## Next Steps

**Before using this specialist**:

1. **Customize specialist file**:
   - [ ] Update technology stack section
   - [ ] Add project-specific examples
   - [ ] Define quality standards
   - [ ] Review and customize all TODO sections

2. **Verify integration**:
   - [ ] Parent agent knows when to delegate
   - [ ] systemPatterns.md has domain patterns documented
   - [ ] Tools list matches project needs

3. **Test delegation**:
   - Create a task requiring [domain] expertise
   - Verify parent hub agent delegates to specialist
   - Review specialist's output quality

**Ready to use** after customization checklist is complete.

**Specialist file**: .claude/agents/[type]/specialists/[name].md
```

---

## Examples

### Example 1: Create Database Specialist

```
User: /cf:create-specialist database --type development --name databaseSpecialist

Claude:
[Validates parameters, creates specialist file in .claude/agents/development/specialists/...]

✅ SPECIALIST CREATED: DatabaseSpecialist
─────────────────────────────────────

**Specialist**: DatabaseSpecialist
**Domain**: Database operations and optimization
**Type**: development
**File**: .claude/agents/development/specialists/databaseSpecialist.md

## Capabilities

**Responsibilities**:
- Complex database queries and optimization
- Schema design and migrations
- Database transaction management
- Query performance analysis and tuning
- Data integrity and constraint management

**Parent Agent**: codeImplementer
**Delegation Triggers**:
- Complex JOIN queries (3+ tables)
- Database schema changes or migrations
- Transaction management (ACID requirements)
- Query performance issues or optimization
- Advanced database features (triggers, stored procedures, full-text search)

## Integration

✓ Specialist agent file created
✓ Parent hub agent updated with delegation reference

## Next Steps

**Before using this specialist**:

1. **Customize specialist file**:
   - [ ] Update technology stack (PostgreSQL? MySQL? MongoDB?)
   - [ ] Add project-specific query patterns
   - [ ] Define performance standards (query time thresholds)
   - [ ] Add common migrations examples

2. **Verify integration**:
   - [ ] codeImplementer knows to delegate database work
   - [ ] systemPatterns.md has database patterns section
   - [ ] ORM/query builder tools listed correctly

3. **Test delegation**:
   - Create a task requiring complex database work
   - Verify codeImplementer delegates to DatabaseSpecialist
   - Review SQL quality and performance

**Ready to use** after customization checklist is complete.

**Specialist file**: .claude/agents/development/specialists/databaseSpecialist.md
```

### Example 2: Create Chart Specialist for UI

```
User: /cf:create-specialist data-visualization --type ui --name chartSpecialist

Claude:
[Validates parameters, creates specialist file...]

✅ SPECIALIST CREATED: ChartSpecialist
─────────────────────────────────────

**Specialist**: ChartSpecialist
**Domain**: Data visualization and interactive charts
**Type**: ui
**File**: .claude/agents/ui/specialists/chartSpecialist.md

## Capabilities

**Responsibilities**:
- Interactive chart and graph components
- Data visualization patterns (line, bar, pie, scatter, etc.)
- Chart accessibility (keyboard navigation, screen readers)
- Responsive chart sizing and scaling
- Chart performance optimization (large datasets)

**Parent Agent**: uiDeveloper
**Delegation Triggers**:
- Any chart or graph component request
- Data visualization requirements
- Interactive data displays
- Dashboard components with charts

## Integration

✓ Specialist agent file created
✓ Parent hub agent updated with delegation reference
✓ systemPatterns.md updated with data visualization patterns section

## Next Steps

**Before using this specialist**:

1. **Customize specialist file**:
   - [ ] Update technology stack (Chart.js? D3.js? Recharts?)
   - [ ] Add project-specific chart patterns
   - [ ] Define accessibility standards for charts
   - [ ] Add responsive breakpoint patterns

2. **Verify integration**:
   - [ ] uiDeveloper knows to delegate chart work
   - [ ] Chart library dependencies documented
   - [ ] Accessibility requirements defined

3. **Test delegation**:
   - Create a task requiring chart component
   - Verify uiDeveloper delegates to ChartSpecialist
   - Review chart accessibility and responsiveness

**Ready to use** after customization checklist is complete.

**Specialist file**: .claude/agents/ui/specialists/chartSpecialist.md
```

### Example 3: Create API Integration Test Specialist

```
User: /cf:create-specialist api-integration --type testing --name apiIntegrationSpecialist

Claude:
[Validates parameters, creates specialist file...]

✅ SPECIALIST CREATED: ApiIntegrationSpecialist
─────────────────────────────────────

**Specialist**: ApiIntegrationSpecialist
**Domain**: API integration testing and contract validation
**Type**: testing
**File**: .claude/agents/testing/specialists/apiIntegrationSpecialist.md

## Capabilities

**Responsibilities**:
- External API integration tests
- API contract validation (schema, response structure)
- Mock/stub strategies for third-party APIs
- API error handling and retry logic testing
- Rate limiting and throttling test scenarios

**Parent Agent**: testEngineer
**Delegation Triggers**:
- Testing external API integrations
- Validating API contracts and schemas
- Testing API error scenarios and edge cases
- Integration tests involving third-party services

## Integration

✓ Specialist agent file created
✓ Parent hub agent updated with delegation reference

## Next Steps

**Before using this specialist**:

1. **Customize specialist file**:
   - [ ] Update technology stack (nock? MSW? WireMock?)
   - [ ] Add project-specific API patterns
   - [ ] Define contract testing approach (Pact? JSON Schema?)
   - [ ] Document external APIs used in project

2. **Verify integration**:
   - [ ] testEngineer knows to delegate API integration testing
   - [ ] Mocking libraries installed and documented
   - [ ] Contract testing tools configured

3. **Test delegation**:
   - Create a task requiring API integration tests
   - Verify testEngineer delegates to ApiIntegrationSpecialist
   - Review test coverage and mock quality

**Ready to use** after customization checklist is complete.

**Specialist file**: .claude/agents/testing/specialists/apiIntegrationSpecialist.md
```

---

## Error Handling

### Memory Bank Not Initialized

```
⚠️ Memory Bank Not Initialized

Memory bank not found at: memory-bank/

To initialize, run: /cf:init [project-name]

Example: /cf:init MyProject
```

### Missing Required Parameter

```
❌ Error: Missing required parameter

Usage: /cf:create-specialist [domain] --type [testing|development|ui] --name [agent-name]

Examples:
- /cf:create-specialist database --type development --name databaseSpecialist
- /cf:create-specialist charts --type ui --name chartSpecialist
- /cf:create-specialist api-integration --type testing --name apiIntegrationSpecialist

Required:
- [domain]: What area this specialist covers
- --type: testing, development, or ui
- --name: Filename for specialist (e.g., databaseSpecialist)
```

### Invalid Type

```
❌ Error: Invalid specialist type

Provided: [user input]

Valid types:
- testing: For test specialists (delegates from testEngineer)
- development: For code specialists (delegates from codeImplementer)
- ui: For UI specialists (delegates from uiDeveloper)

Usage: /cf:create-specialist [domain] --type [testing|development|ui] --name [agent-name]
```

### Specialist Already Exists

```
⚠️ Specialist Already Exists

File exists: .claude/agents/[type]/specialists/[name].md

**Specialist**: [AgentName]
**Domain**: [Existing domain]

**Options**:
1. Use existing specialist (no action needed)
2. Choose different name: /cf:create-specialist [domain] --type [type] --name [different-name]
3. Overwrite existing (⚠️ Warning: Will lose existing customizations)

To overwrite: /cf:create-specialist [domain] --type [type] --name [name] --force

**Not recommended**: Overwriting loses customization work. Consider renaming instead.
```

### Parent Hub Agent Missing

```
❌ Error: Parent hub agent not found

Type: [testing|development|ui]
Expected file: .claude/agents/[type]/[hubAgent].md

The parent hub agent must exist before creating specialists.

**Resolution**:
Ensure hub agents are initialized:
- testEngineer.md (for testing specialists)
- codeImplementer.md (for development specialists)
- uiDeveloper.md (for ui specialists)

These should exist from /cf:init. If missing, re-run initialization.
```

---

## Integration with Other Commands

**Typical usage patterns**:

```
# During project setup - create core specialists
/cf:init MyProject → Initialize
/cf:create-specialist database --type development --name databaseSpecialist
/cf:create-specialist api-integration --type testing --name apiIntegrationSpecialist
[Customize specialists before first use]

# As patterns emerge - add specialists
[Notice hub agent repeatedly delegates to same domain]
/cf:create-specialist [domain] --type [type] --name [name]
[Encode team expertise in specialist]

# After creating specialist
/cf:create-specialist [domain] --type [type] --name [name]
[Edit specialist file to customize]
[Update systemPatterns.md with domain patterns]
/cf:code TASK-[ID] → Hub agent can now delegate to specialist
```

**When specialists are used**:
- Hub agents (**testEngineer**, **codeImplementer**, **uiDeveloper**) detect domain-specific work
- Hub agents delegate to appropriate specialist
- Specialist implements using domain expertise
- Specialist returns to hub agent for integration

---

## Notes

- **Scalable architecture**: Specialists extend hub agents without modifying core framework
- **Encapsulate expertise**: Team's domain knowledge encoded in specialist agents
- **Delegation pattern**: Hub agents remain coordinators, specialists are domain experts
- **Customization required**: Generated specialist is template, must be customized for project
- **Pattern evolution**: Specialists discover and document new patterns over time
- **One specialist per domain**: Avoid creating multiple specialists for overlapping domains

**Best practices**:
- Create specialists after pattern proven (3+ similar tasks delegated)
- Keep domain focused (not too broad, not too narrow)
- Document patterns in systemPatterns.md for specialist to reference
- Customize specialist before first use (technology stack, quality standards)
- Review specialist output periodically for quality and pattern adherence
- Update specialists as project patterns evolve

**Maintenance**:
- Review specialist files every [N] tasks or [timeframe]
- Update as new patterns emerge
- Remove specialists that are rarely used (consolidate into hub agent)
- Keep specialist aligned with systemPatterns.md

---

## Related Commands

- `/cf:init` - Initialize project (creates hub agents)
- `/cf:code` - Implementation command (hub agents delegate to specialists)
- `/cf:sync` - Review project status (includes agent structure)

---

**Command Version**: 1.0
**Last Updated**: 2025-10-05
