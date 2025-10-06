# Command: /cf:init

Initialize CCFlow workflow system with guided project brief creation.

---

## Usage

```
/cf:init [project-name]
/cf:init [project-name] --quick
```

## Parameters

- `[project-name]`: **Required** - Name of the project to initialize

## Flags

- `--quick`: Skip guided brief creation, create stub files with TODOs

**Default**: Interactive guided brief creation (10-20 minutes)

---

## Purpose

Bootstrap CCFlow system through:
1. Creating memory bank directory structure
2. Creating .claude agent directory structure
3. **Guided project brief creation** (default) - Collaborative discovery with Facilitator + Product + Architect agents

**Philosophy**: Initialization is a **collaborative discovery process**, not form-filling. Agents guide you through creating a comprehensive project brief that serves as the foundation for all future work.

---

## Process

### Phase 1: Structure Creation (Automated)

**Step 1: Check if Already Initialized**

If `memory-bank/` exists:
```
⚠️ CCFlow Already Initialized

Memory bank exists at: memory-bank/

To view: /cf:sync
To reinitialize: Manually delete memory-bank/ first (⚠️ destroys data)
```

**Stop execution.**

---

**Step 2: Create Structure**

```bash
# Create directories
mkdir -p memory-bank
mkdir -p .claude/agents/{workflow,development/specialists,testing/specialists,ui/specialists}
mkdir -p .claude/commands

# Copy template files from .claude/templates/ (remove .template extension)
for template in .claude/templates/*.template.md; do
  cp "$template" "memory-bank/$(basename "$template" .template.md).md"
done

# Hub agents already exist in .claude/agents/ (from CCFlow installation)
```

**Output**:
```
🚀 Initializing CCFlow for: [project-name]

Creating structure...
✓ memory-bank/ (6 files)
✓ .claude/agents/ (3 hub agents)

Structure created successfully!
```

---

### Phase 2: Guided Brief Creation (Default Interactive)

**Duration**: 10-20 minutes

**Agents**: 🔄 Facilitator (lead), 🎨 Product (expert), 🏗️ Architect (technical)

**Introduction**:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 PROJECT BRIEF CREATION

Guided conversation to create comprehensive project brief.
Typically takes 10-20 minutes.

Agents:
🔄 Facilitator - Guides conversation, identifies gaps
🎨 Product - Domain expertise, requirements structure
🏗️ Architect - Technical feasibility, constraints

Ready to begin?
```

---

**Brief Creation Process** (7 sections):

Each section follows **iteration pattern**:
1. Agent asks questions
2. User responds
3. Facilitator captures and identifies gaps
4. Agent provides structure/validation
5. User refines
6. Iterate until user approves
7. Mark section complete (✓)

**Sections**:

#### 1. Executive Summary
- **🎨 Product asks**: "In 1-2 sentences, what are you building and why?"
- **🔄 Facilitator**: Captures, refines through iteration
- **Goal**: Clear, compelling summary (what + why)

#### 2. Problem Statement
- **🎨 Product asks**: "What problem? Who has it? Current solutions?"
- **🎨 Product structures**: Who / Current Pain / Impact / Existing Solutions → Limitations
- **🔄 Facilitator**: Ensures clarity and specificity

#### 3. Objectives
- **🎨 Product asks**: "What does success look like? Measurable goals?"
- **🎨 Product validates**: Specific, measurable, prioritized
- **🔄 Facilitator**: Refines until actionable

#### 4. Scope Definition
- **🎨 Product asks**: "Must have? Should have? Out of scope?"
- **🏗️ Architect checks**: Technical feasibility, complexity estimates
- **🔄 Facilitator**: Structures into table (Must/Should/Out) with complexity
- **🎨 Product validates**: "Anything critical forgotten?"

#### 5. Constraints
- **��️ Architect asks**: "Technical? Resource? Business constraints?"
- **🔄 Facilitator**: Organizes by type with impact notes
- **🏗️ Architect validates**: Constraints are workable together

#### 6. Success Criteria
- **🎨 Product asks**: "How will we know project succeeded?"
- **🔄 Facilitator**: Creates measurable checklist
- **🎨 Product validates**: Aligns with objectives

#### 7. Complete Review
- **🔄 Facilitator**: Presents complete brief draft
- **All agents**: Quality gate validation (see below)
- **User**: Final approval

---

**Quality Gates** (before writing files):

**🔄 Facilitator**:
- [ ] All sections complete
- [ ] Information structured
- [ ] User approved

**🎨 Product**:
- [ ] Problem clear
- [ ] Objectives measurable
- [ ] Scope well-defined
- [ ] Success criteria align

**🏗️ Architect**:
- [ ] Constraints documented
- [ ] Technically feasible
- [ ] No show-stoppers

**Only when all pass**: Write projectbrief.md

---

**Finalization**:
```
✓ Project Brief Complete!

Writing files...
✓ projectbrief.md - Comprehensive brief
✓ productContext.md - Initialized
✓ systemPatterns.md - Initialized
✓ activeContext.md - "Project initialization"
✓ progress.md - 0% complete, Planning phase
✓ tasks.md - Ready for first task

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 NEXT STEPS:

1. **Customize agents** (.claude/agents/*.md - fill TODOs)
2. **Review**: /cf:sync
3. **Start building**: /cf:feature [description]

Ready to customize or jump to development?
```

---

### Phase 3: Quick Mode (--quick flag)

Skip Phase 2, create stubs:

```
🚀 Initializing CCFlow for: [project-name] (Quick Mode)

✓ Structure created
✓ Stub files with TODOs created

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚠️ QUICK MODE: Manual completion required

Complete: memory-bank/projectbrief.md

OR run /cf:init WITHOUT --quick for guided creation
```

---

## Agent Collaboration Patterns

### 🔄 Facilitator (Primary)
**Responsibilities**:
- Guides conversation flow
- Identifies gaps after each response
- Synthesizes input into structured content
- Manages iteration (no limits, user controls)
- Uses Action Recommendation Pattern:
  1. Present state
  2. Identify gaps
  3. Ask questions
  4. Refine
  5. Recommend next

### 🎨 Product (Expert)
**Responsibilities**:
- Asks insightful domain questions
- Provides structure for requirements
- Validates measurability and alignment
- Ensures critical items not forgotten
- Shares best practices

### 🏗️ Architect (Technical)
**Responsibilities**:
- Flags complex features early
- Identifies dependencies
- Validates feasibility
- Documents technical constraints
- Raises trade-offs

**Collaboration**: Agents work in sequence per section, with Facilitator synthesizing.

---

## Examples

### Example: Interactive Session (Abbreviated)

```
User: /cf:init task-manager

[Structure creation...]

📋 PROJECT BRIEF CREATION
Ready to begin?

User: Yes

🎨 Product: In 1-2 sentences, what are you building and why?

User: A task manager for developers that integrates with IDEs

🔄 Facilitator: Let me capture that...

Draft: "A task manager for developers that integrates with IDEs"

Questions:
- What makes this different from existing task managers?
- What problem does IDE integration solve?
- Solo or team focused?

User: For solo developers who context-switch. Tasks show in IDE to reduce app-switching.

🔄 Facilitator: Updated:
"A task manager for solo developers who context-switch between projects,
surfacing tasks directly in their IDE to reduce app-switching and maintain focus."

Better?

User: Perfect!

✓ Executive Summary captured

[Continues through all sections with same pattern...]

🔄 Facilitator: Here's the complete brief:

[Shows full brief]

Review questions:
1. Accurate vision?
2. Anything missing?
3. Would guide others?
4. Right scope?

User: Add keyboard shortcuts requirement

🔄 Facilitator: Added to constraints. Ready to finalize?

User: Yes

✓ Writing projectbrief.md...
✓ Complete!

🎯 NEXT STEPS: [as shown above]
```

---

## Edge Cases

### Minimal Information
**🔄 Facilitator**: "Description is brief. Let me ask specific questions..." [targeted extraction]

### Wants to Skip Section
**🔄 Facilitator**: "Skipping [X] means missing [Y], causes [Z]. Just 2-3 minutes? Or use --quick mode instead?"

### Changes Mind
**🔄 Facilitator**: "No problem! Let's go back to [section]..." [re-iterate]

### Technical Issues
**🏗️ Architect**: "[Feature] requires [dependencies] - adds complexity. Options: 1) Keep 2) Simplify 3) Defer. Your call?"

---

## Error Handling

### Already Initialized
```
⚠️ CCFlow Already Initialized
Memory bank exists. To view: /cf:sync
To reinitialize: Delete memory-bank/ first
```

### Missing Project Name
```
❌ Error: Project name required
Usage: /cf:init [project-name]
```

### Templates Missing
```
❌ Error: CCFlow templates not found
Expected: memory-bank/templates/
Ensure running from CCFlow directory
```

---

## Success Criteria

**Artifacts**: 6 memory bank files + 3 agent templates
**Brief Quality**: Clear summary, specific problem, measurable objectives, defined scope, documented constraints, measurable criteria
**User Confidence**: Understands what to build, clear scope, knows success metrics

---

## Integration

**After /cf:init**: `/cf:sync` (review) → `/cf:feature [desc]` (start building)

**Brief Usage**: All commands reference projectbrief.md for scope, objectives, constraints, success criteria

---

## Notes

- **Default is interactive** (10-20 min investment worth it)
- **No iteration limits** (Facilitator refines until satisfied)
- **Multi-agent collaboration** (leverages specialized expertise)
- **Quality gates** (validated before writing)
- **--quick available** (for manual completion preference)
- **Idempotent** (warns if already initialized)
- **Hub agents need customization** (fill TODOs before use)

---

**Command Version**: 2.0 (Enhanced with guided brief creation)
**Last Updated**: 2025-10-05
