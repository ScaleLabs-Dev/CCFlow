# Template Usage Guide

**Purpose**: Practical guide for using CCFlow workflow templates effectively
**Audience**: Command developers and framework contributors
**Last Updated**: 2025-11-03

---

## Overview

**Workflow templates** are markdown files in `.claude/templates/workflow/` that structure command outputs for consistency and quality. They define placeholder sections that commands fill with agent outputs and synthesis logic.

**Core Principle**: Templates separate structure (what sections) from content (what goes in sections), enabling reusable, consistent outputs across command invocations.

---

## Template Locations and Naming

### Location
```
.claude/templates/workflow/
├── checkpoint-template.md
├── creative-spec-template.md
└── feature-task-template.md
```

### Naming Convention
**Pattern**: `[command-name]-template.md`

**Examples**:
- `checkpoint-template.md` → Used by `/cf:checkpoint`
- `creative-spec-template.md` → Used by `/cf:creative`
- `feature-task-template.md` → Used by `/cf:feature`

**Rationale**: Command name in template name makes association obvious

---

## Template Structure

### Basic Template Format

```markdown
# [Output Title]

**Metadata Field 1**: [Placeholder value]
**Metadata Field 2**: [Placeholder value]

---

## Section 1: [Section Name]

[Section description or instructions]

**Subsection A**: [Placeholder for Agent A's input]

**Subsection B**: [Placeholder for Agent B's input]

---

## Section 2: [Section Name]

[Instructions for synthesis or integration]

**Combined Analysis**: [Placeholder for command's synthesis logic]

---

## Section 3: [Next Steps]

**Recommended Action**: [Placeholder for routing recommendation]
```

### Key Elements

1. **Metadata Header**: Title, timestamps, key identifiers
2. **Placeholder Sections**: Clearly marked areas for agent inputs
3. **Synthesis Sections**: Areas for command integration logic
4. **Structure Markers**: `---` separators between major sections
5. **Instructions**: Guidance on what goes where (in comments or brackets)

---

## Available Templates

### 1. checkpoint-template.md

**Used By**: `/cf:checkpoint`, `/cf:plan` (for plan outputs)

**Purpose**: Structure memory bank checkpoint summaries

**Key Sections**:
- **Checkpoint Summary**: High-level overview
- **Changes by Memory Bank File**: Systematic file-by-file changes
  - projectbrief.md
  - productContext.md
  - systemPatterns.md
  - activeContext.md
  - progress.md
  - tasks.md
- **Cross-File Synthesis**: Integration and consistency validation
- **Recommendations**: Next actions and focus areas

**Agent Inputs**:
- Documentarian: Memory bank analysis and suggestions
- Architect: Technical pattern implications (if applicable)
- Product: Feature/requirement implications (if applicable)

**Command Synthesis**:
- Cross-file consistency validation
- Impact assessment across memory bank
- Routing recommendations

**Example Use**:
```markdown
## Step 4: Synthesize via checkpoint-template.md

Read template: .claude/templates/workflow/checkpoint-template.md

Fill sections:
- Checkpoint Summary: [Session overview from context]
- projectbrief.md section: [Changes from Documentarian]
- activeContext.md section: [Current focus updates]
- Synthesis: [Command integrates changes across files]
```

---

### 2. creative-spec-template.md

**Used By**: `/cf:creative`

**Purpose**: Structure creative exploration and design specifications

**Key Sections**:
- **Problem Definition**: User's problem statement (from Facilitator Phase 1)
- **Solution Approaches**: Multiple approaches analyzed
  - Approach 1: [Architect's technical perspective + Product's user perspective]
  - Approach 2: [Architect + Product]
  - Approach 3: [Architect + Product]
- **Selected Approach**: User's choice with rationale
- **Implementation Specification**: Detailed design for selected approach
  - Components
  - Implementation Phases
  - Testing Strategy
  - Tensions Resolved
  - Trade-offs Accepted
- **Patterns Documented**: Reusable patterns extracted (if applicable)

**Agent Inputs**:
- Facilitator: User's problem definition (via questions)
- Architect: 3 technical approaches with analysis
- Product: User implications for each approach
- Facilitator: User's selected approach (via validation questions)

**Command Synthesis**:
- Integration of technical + user perspectives for each approach
- Selected approach expansion into implementation spec
- Pattern extraction logic (reusable 3+ times?)

**Example Use**:
```markdown
## Step 4: Synthesize via creative-spec-template.md

Read template: .claude/templates/workflow/creative-spec-template.md

Fill sections:
- Problem Definition: [User answers from Facilitator Phase 1]
- Approach 1:
  - Technical: [Architect's analysis]
  - User Impact: [Product's analysis]
- Selected Approach: [User's choice from Facilitator Phase 3]
- Implementation Specification: [Command synthesizes detailed design]
- Patterns: [Command extracts if reusable 3+]
```

---

### 3. feature-task-template.md

**Used By**: `/cf:feature`

**Purpose**: Structure task creation with dual-agent coordination

**Key Sections**:
- **Task Header**: ID, complexity, status, priority, effort
- **Description**: User's original request
- **User Value**: Why this matters (from Product agent)
- **Acceptance Criteria**: Testable criteria (from Product agent)
- **Complexity Assessment**: Scope, risk, effort (from Assessor agent)
- **Edge Cases**: Scenarios to handle (from Product agent)
- **Non-Functional Requirements**: Performance, security, etc. (from Product agent)
- **Prerequisites**: Dependencies and blockers
- **Testing Strategy**: Test types required
- **Implementation Approach**: Routing recommendation (from Assessor)
- **Notes**: Creation metadata and pattern references

**Agent Inputs**:
- Assessor: Complexity level, scope estimate, risk assessment, routing recommendation
- Product: User value statement, acceptance criteria (3-5), edge cases, non-functional requirements

**Command Synthesis**:
- Task ID generation (next sequential ID)
- Integration of complexity and requirements perspectives
- Routing logic (Level 1 → /cf:code, Level 2+ → /cf:plan)
- Status determination (Pending or Active for Level 1)

**Example Use**:
```markdown
## Step 4: Synthesize via feature-task-template.md

Read template: .claude/templates/workflow/feature-task-template.md

Fill sections:
- Task Header:
  - Task ID: [Generate next ID from tasks.md]
  - Complexity: [From Assessor: Level 1-4]
  - Status: [Pending or Active if Level 1]
- Description: [User's request verbatim]
- User Value: [From Product agent]
- Acceptance Criteria: [From Product agent - 3-5 criteria]
- Complexity Assessment: [From Assessor agent]
- Routing Recommendation: [From Assessor - /cf:code or /cf:plan]
```

---

## Template Usage Workflow

### Step 1: Identify Template Need

**Question**: Does this command need a template?

**Use Template When**:
- Command produces structured output (multiple sections)
- Output format should be consistent across invocations
- Multiple agent inputs need integration
- Output will be referenced later (documentation, memory bank)

**Don't Use Template When**:
- Simple, ad-hoc output (e.g., status query)
- Output format varies significantly each time
- Single agent with straightforward output
- Temporary/debugging output

---

### Step 2: Create or Select Template

**If Template Exists**: Use existing template (check `.claude/templates/workflow/`)

**If New Template Needed**:

1. **Define Output Structure**:
   - What sections are needed?
   - What metadata is required?
   - What agent inputs go where?
   - What synthesis does command perform?

2. **Create Template File**:
   ```
   .claude/templates/workflow/[command-name]-template.md
   ```

3. **Add Version and Metadata**:
   ```markdown
   # [Template Title]

   **Template Version**: 1.0
   **Created**: [YYYY-MM-DD]
   **Used By**: [Command name]
   **Purpose**: [One-line purpose]
   ```

4. **Define Placeholder Sections**:
   - Use `[Placeholder description]` for values to fill
   - Use **Bold** for subsection headers
   - Use `---` to separate major sections
   - Add instructions in square brackets

5. **Document Agent Inputs**:
   ```markdown
   **From Agent A**: [What Agent A provides]
   **From Agent B**: [What Agent B provides]
   ```

6. **Define Synthesis Areas**:
   ```markdown
   ## Synthesis Section

   [Command integrates Agent A + Agent B perspectives here]
   ```

---

### Step 3: Reference Template in Command

**In Command File** (Step 4: Synthesize section):

```markdown
## Step 4: Synthesize Using Template

**Read template**:
```
.claude/templates/workflow/[template-name].md
```

**Apply synthesis logic**:

[Show how to fill each section with agent outputs and command synthesis]
```

**Code Pattern**:
```markdown
Read template from .claude/templates/workflow/[template-name].md

Fill placeholders:
- [Section 1]: [Agent A's output + processing]
- [Section 2]: [Agent B's output + processing]
- [Synthesis]: [Command's integration logic]
```

---

### Step 4: Fill Template

**Process**:

1. **Load Template**: Read template file into memory
2. **Extract Structure**: Identify all placeholder sections
3. **Fill Agent Sections**: Replace placeholders with agent outputs
4. **Apply Synthesis**: Command logic integrates agent outputs
5. **Validate Completeness**: Ensure no placeholders remain unfilled
6. **Format Output**: Apply markdown formatting for clarity

**Example**:
```markdown
# Checkpoint Summary
**Created**: 2025-11-03 15:30
**Session Duration**: 2 hours
**Changes Summary**: Refactored /cf:feature to orchestration pattern

---

## Changes by Memory Bank File

### tasks.md
**Status**: Updated
**Changes Made**:
- Added TASK-003-8: /cf:feature refactored
- Added TASK-003-9: /cf:feature validated
**Rationale**: Track orchestration pattern implementation progress
**Impact**: 75% complete on TASK-003

[etc.]
```

---

### Step 5: Validate Template Usage

**Checklist**:
- [ ] All placeholder sections filled (no `[Placeholder]` remaining)
- [ ] Agent inputs correctly mapped to sections
- [ ] Command synthesis applied to integration sections
- [ ] Output follows template structure exactly
- [ ] Metadata complete (timestamps, IDs, versions)
- [ ] Markdown formatting correct

---

## Template Best Practices

### 1. Keep Templates Simple

**Good**:
```markdown
## Section Name

**Agent Input**: [Placeholder]

**Synthesis**: [Integration logic]
```

**Bad** (overly complex):
```markdown
## Section Name (with extensive instructions about what to put here, how to format it, what edge cases to consider, and multiple sub-sections with nested conditionals...)
```

**Rationale**: Templates define structure, not content logic. Instructions belong in command files.

---

### 2. Use Clear Placeholder Names

**Good**:
```markdown
**Task ID**: TASK-[NNN] (zero-padded 3 digits)
**Complexity**: Level [1-4] ([Category Name])
```

**Bad**:
```markdown
**Task ID**: [ID]
**Complexity**: [Level]
```

**Rationale**: Descriptive placeholders make it obvious what to fill in.

---

### 3. Separate Agent Sections

**Good**:
```markdown
## Technical Analysis (from Architect)
[Architect's perspective]

## User Requirements (from Product)
[Product's perspective]

## Synthesis
[Command integrates both]
```

**Bad** (mixed):
```markdown
## Analysis
[Architect and Product mixed together without clear attribution]
```

**Rationale**: Clear attribution makes agent responsibilities obvious.

---

### 4. Version Templates

**Good**:
```markdown
**Template Version**: 1.1
**Last Updated**: 2025-11-03
**Changes from v1.0**: Added edge cases section
```

**Bad** (no versioning):
```markdown
# Template
[No version tracking]
```

**Rationale**: Version tracking enables evolution and rollback if needed.

---

### 5. Document Template Purpose

**Good**:
```markdown
**Purpose**: Structure task creation with dual-agent coordination (Assessor + Product)
**Used By**: /cf:feature command
**Agent Inputs**: Assessor (complexity), Product (requirements)
```

**Bad** (no documentation):
```markdown
# Task Template
[No explanation of purpose or usage]
```

**Rationale**: Documentation helps future template users understand intent.

---

### 6. Use Consistent Formatting

**Markdown Standards**:
- `# H1` for template title
- `## H2` for major sections
- `### H3` for subsections
- `**Bold**` for field names
- `[Placeholders]` in square brackets
- `---` separators between major sections
- Numbered lists for sequences
- Bulleted lists for non-sequential items

**Rationale**: Consistency across templates makes them easier to use and maintain.

---

## Template Maintenance

### When to Update Templates

**Update When**:
- Output structure changes (new section needed)
- Agent responsibilities change (different inputs)
- Synthesis logic changes (different integration)
- User feedback indicates confusion (clarity improvements)

**Version Bump**:
- **Patch (v1.0 → v1.1)**: Minor clarifications, formatting fixes
- **Minor (v1.0 → v2.0)**: New sections added, structure changes
- **Major (v1.0 → v2.0)**: Complete restructure, breaking changes

---

### Update Process

1. **Identify Need**: What needs to change and why?
2. **Update Template File**: Make changes to `.claude/templates/workflow/[template].md`
3. **Update Version Number**: Increment appropriately
4. **Add Changelog**: Document what changed
5. **Update Command References**: Update commands that use this template
6. **Test**: Validate template with real command invocation
7. **Document**: Update this guide if usage changes

---

### Backward Compatibility

**Principle**: Templates should be backward compatible when possible

**Guidelines**:
- **Adding sections**: OK (optional sections don't break existing usage)
- **Removing sections**: AVOID (breaks existing commands)
- **Renaming sections**: AVOID (breaks existing commands)
- **Reordering sections**: OK (if documented)

**If Breaking Change Needed**:
1. Create new template version (e.g., `feature-task-template-v2.md`)
2. Migrate commands gradually
3. Deprecate old template with timeline
4. Document migration path

---

## Template Anti-patterns

### ❌ Embedding Logic in Templates

**Problem**: Templates contain conditional logic or decision-making

**Why Bad**: Logic belongs in commands, not templates. Templates define structure only.

**Solution**: Move logic to command's synthesis step

---

### ❌ Templates Without Placeholders

**Problem**: Template is just static text with no fill-in sections

**Why Bad**: Not actually a template if nothing needs to be filled

**Solution**: Either add placeholders or remove template (use direct output)

---

### ❌ One-Off Templates

**Problem**: Template used by only one command once

**Why Bad**: Creates maintenance burden without reusability benefit

**Solution**: Inline structure in command unless reuse expected

---

### ❌ Overly Generic Templates

**Problem**: Template tries to serve multiple unrelated purposes

**Why Bad**: Becomes complex and unclear, loses specificity benefit

**Solution**: Create separate templates for different command types

---

### ❌ Undocumented Placeholders

**Problem**: Placeholder meaning is unclear

**Why Bad**: Command developers don't know what to fill in

**Solution**: Add descriptions in square brackets or comments

---

## Examples

### Example 1: Using checkpoint-template.md

**Command**: `/cf:checkpoint`

**Step 4 in Command**:
```markdown
## Step 4: Synthesize via checkpoint-template.md

Read template: .claude/templates/workflow/checkpoint-template.md

Fill sections:
- Checkpoint Summary:
  - Created: [Current timestamp]
  - Duration: [Session duration from start]
  - Changes Summary: [High-level overview from Documentarian]

- Memory Bank Files (for each file):
  - Status: [Documentarian assessment: No changes / Updated]
  - Changes Made: [List from Documentarian]
  - Rationale: [Why from Documentarian]
  - Impact: [Command synthesis: cross-file implications]

- Cross-File Synthesis:
  - Consistency: [Command validation: no contradictions]
  - Patterns: [Command identification: emerging patterns]
  - Focus: [Command assessment: where attention needed]

- Recommendations:
  - Next Actions: [Command routing: what to do next]
  - Priority Areas: [Command prioritization based on all changes]
```

**Result**: Structured checkpoint with clear file-by-file changes and synthesis

---

### Example 2: Using creative-spec-template.md

**Command**: `/cf:creative "design caching system"`

**Step 4 in Command**:
```markdown
## Step 4: Synthesize via creative-spec-template.md

Read template: .claude/templates/workflow/creative-spec-template.md

Fill sections:
- Problem Definition:
  - Problem: [User's statement from Facilitator Phase 1]
  - Context: [User's constraints and requirements]
  - Success Criteria: [User's definition of done]

- Solution Approaches (for each approach):
  - Approach N:
    - Technical: [Architect's technical analysis]
    - User Impact: [Product's user perspective]
    - Trade-offs: [Command synthesis of both]

- Selected Approach:
  - Chosen: [User's selection from Facilitator Phase 3]
  - Rationale: [User's reasoning]

- Implementation Specification:
  - Components: [Command extracts from selected approach]
  - Phases: [Command organizes implementation sequence]
  - Testing: [Command defines testing strategy]
  - Patterns: [Command extracts reusable patterns if applicable]
```

**Result**: Complete design specification ready for implementation

---

## Related Documentation

- **Command Orchestration Pattern**: `docs/architecture/command-orchestration.md`
- **Facilitator Pattern**: `docs/workflows/facilitator-pattern.md`
- **System Patterns**: `memory-bank/systemPatterns.md:409-582`
- **Agent Organization**: `docs/architecture/agent-organization.md`

---

## Quick Reference

### Template Checklist

**Creating Templates**:
- [ ] File location: `.claude/templates/workflow/[command]-template.md`
- [ ] Version and metadata header
- [ ] Clear placeholder sections with `[Descriptions]`
- [ ] Separation of agent inputs vs synthesis sections
- [ ] Markdown formatting consistent
- [ ] Purpose and usage documented

**Using Templates**:
- [ ] Template referenced in command Step 4
- [ ] All placeholders filled (no `[Placeholder]` remaining)
- [ ] Agent outputs mapped correctly
- [ ] Command synthesis applied
- [ ] Output validated for completeness

**Maintaining Templates**:
- [ ] Version incremented appropriately
- [ ] Changelog updated
- [ ] Commands using template updated
- [ ] Backward compatibility considered
- [ ] Documentation updated

---

**Guide Version**: 1.0
**Created**: 2025-11-03 (TASK-003-11)
**Maintainers**: CCFlow framework contributors
