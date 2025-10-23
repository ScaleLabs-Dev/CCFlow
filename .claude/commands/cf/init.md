---
description: "Initialize CCFlow workflow system with guided project brief creation"
allowed-tools: ['Read', 'Write', 'Glob', 'Bash(ls:*)', 'Task']
argument-hint: "[--quick] [--force-fresh]"
---

# Command: /cf:init

## Usage

```
/cf:init
/cf:init --quick
/cf:init --force-fresh
```

## Flags

- `--quick`: Skip guided brief creation, create stub files with TODOs
- `--force-fresh`: Skip project discovery, use empty templates (ignore existing docs)

**Default**: Auto-detect (import if docs exist, fresh if not) + Interactive guided brief creation

---

## Purpose

Bootstrap CCFlow system through:
1. Creating memory bank directory structure
2. Creating .claude agent directory structure
3. **Guided project brief creation** (default) - Collaborative discovery with facilitator + product + architect agents

**Philosophy**: Initialization is a **collaborative discovery process**, not form-filling. Agents guide you through creating a comprehensive project brief that serves as the foundation for all future work.

---

## Process

### Phase 0: Project Discovery (Automated)

**Purpose**: Detect existing project documentation and tech stack to streamline initialization.

**Step 1: Project Discovery**

**Invoke the project-discovery subagent** to analyze the existing project:
- Check for package manager files (package.json, Gemfile, requirements.txt, etc.)
- Extract tech stack from dependencies
- Parse README.md and CLAUDE.md
- Analyze code structure
- Generate structured discovery report

The agent uses `.claude/references/stack-patterns.md` for multi-language detection:
- JavaScript/TypeScript (package.json)
- Python (requirements.txt, Pipfile)
- Ruby (Gemfile)
- Go (go.mod)
- Java (pom.xml, build.gradle)
- PHP (composer.json)
- And more...

---

**Step 2: Process Discovery Report**

Parse the returned discovery report to extract:
- Project name and description
- Technology stack (language, frameworks, database)
- Existing documentation
- Code structure and patterns
- Team type recommendation

Store this information in command context for use in later phases.

---

**Step 3: Determine Initialization Mode**

**If NO files found** (brand new project):
```
🚀 Initializing CCFlow...

No existing documentation found.
Proceeding with fresh project initialization...

[Continue to Phase 1 with empty templates]
```

**If --force-fresh flag used**:
```
🚀 Initializing CCFlow...

Skipping discovery (--force-fresh flag).
Proceeding with fresh project initialization...

[Continue to Phase 1 with empty templates]
```

**If files found** (existing project):
```
📋 EXISTING PROJECT DETECTED

[Display summary from project-discovery report]

Discovered Information:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Project: [Name from discovery]
Language: [e.g., JavaScript/TypeScript, Python, Ruby]

Tech Stack (auto-detected):
- Frontend: [if applicable]
- Backend: [frameworks found]
- Database: [if detected]
- Testing: [test frameworks]

Project Structure:
- [Key directories and their purpose]

Documentation Found:
✓ README.md - [what was extracted]
✓ CLAUDE.md - [if found]
✓ Package files - [which ones]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

This information will be used to streamline the setup process.
The facilitator will incorporate these findings automatically.

[Continue to Phase 1 with pre-populated context]
```

**If user types "use findings" during facilitator interaction**:
```
✓ Pre-populating from discovered documentation...

Pre-populating memory bank with:
✓ Executive Summary (from README.md)
✓ Tech Stack (from CLAUDE.md + package.json)
✓ Project Structure (from code analysis)

Gaps to fill during guided creation:
- Problem Statement (not found in docs)
- Success Criteria (needs definition)
- Detailed Constraints (partial info only)

Proceeding to guided refinement with pre-populated context...
[Continue to Phase 2 with PRE-POPULATED templates]
```

---

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
mkdir -p .claude/agents/{workflow,specialists}
mkdir -p .claude/commands

# Copy memory bank template files from .claude/templates/ (remove .template extension)
for template in .claude/templates/*.template.md; do
  cp "$template" "memory-bank/$(basename "$template" .template.md).md"
done

# Copy workflow agents (removing .template extension during copy)
for template in .claude/templates/agents/workflow/*.template.md; do
  target=".claude/agents/workflow/$(basename "$template" .template.md).md"
  # Only copy if target doesn't exist (preserves existing customizations)
  if [ ! -f "$target" ]; then
    cp "$template" "$target"
  fi
done

# Copy generic implementation agents (universal fallbacks)
# Only copy if targets don't exist (preserves existing customizations)
[ ! -f ".claude/agents/codeImplementer.md" ] && cp .claude/templates/generic/codeImplementer.template.md .claude/agents/codeImplementer.md
[ ! -f ".claude/agents/testEngineer.md" ] && cp .claude/templates/generic/testEngineer.template.md .claude/agents/testEngineer.md
[ ! -f ".claude/agents/uiDeveloper.md" ] && cp .claude/templates/generic/uiDeveloper.template.md .claude/agents/uiDeveloper.md

# Note: Stack-specific agents added later with /cf:configure-team
```

**Output**:
```
🚀 Initializing CCFlow...

Creating structure...
✓ memory-bank/ (6 files)
✓ .claude/agents/workflow/ (6 agents)
✓ .claude/agents/ (3 generic implementation agents)
✓ .claude/agents/specialists/ (empty, for future specialists)

Structure created successfully!
```

---

### Phase 1.5: Agent Installation Complete

**Purpose**: Generic agents are now installed and ready to use.

**What Was Installed**:
- **Workflow agents**: assessor, architect, product, facilitator, documentarian, reviewer (no configuration needed)
- **Generic implementation agents**: codeImplementer, testEngineer, uiDeveloper (framework-agnostic, work with any stack)

**No Configuration Needed**: Generic agents use universal patterns that work across all tech stacks. They adapt to your project by reading CLAUDE.md and systemPatterns.md during execution.

**Next Step (Optional)**: For stack-specific optimization, run `/cf:configure-team` after initialization completes.

**Agents Installation Summary**:
```
✅ AGENTS INSTALLED

Workflow Agents (6):
✓ assessor, architect, product, facilitator, documentarian, reviewer

Generic Implementation Agents (3):
✓ codeImplementer (universal backend/logic)
✓ testEngineer (universal testing)
✓ uiDeveloper (universal UI/frontend)

ℹ️ Generic agents work with ALL tech stacks
ℹ️ Configure stack-specific team: /cf:configure-team
```

---

**Error Handling**

**If template files missing**:
```
⚠️ Agent Templates Not Found

Expected location: .claude/templates/generic/
This suggests CCFlow installation issue.

Please ensure CCFlow is properly installed with template files.
```

**If file copy fails**:
```
⚠️ Agent Installation Failed

Template: codeImplementer.template.md
Error: [Error message]

Troubleshooting:
- Check template file exists and is valid
- Verify agent naming follows lowercase-with-hyphens convention
- See .claude/references/project-discovery-spec.md for details

Continuing with remaining agents...
```

---

### Phase 2: Guided Brief Creation (Default Interactive)

**Duration**: 10-20 minutes (Fresh) | 5-10 minutes (With discovery data - fewer questions)

**Invoke these agents in sequence**:
- 🔄 **facilitator subagent** (lead) - Guides the conversation
- 🎨 **product subagent** (expert) - Provides requirements expertise
- 🏗️ **architect subagent** (technical) - Validates feasibility

**Context Passing**: Include the discovery report from Phase 0 when invoking the facilitator agent.

**Introduction (Fresh Mode - No discovery data)**:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 PROJECT BRIEF CREATION

Guided conversation to create comprehensive project brief.
Typically takes 10-20 minutes.

Agents:
🔄 facilitator - Guides conversation, identifies gaps
🎨 product - Domain expertise, requirements structure
🏗️ architect - Technical feasibility, constraints

Ready to begin?
```

**Introduction (With Discovery Data)**:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 PROJECT BRIEF CREATION (WITH DISCOVERED CONTEXT)

Building on discovered project information.
Typically takes 5-10 minutes.

Agents (with discovery context):
🔄 facilitator - Uses discovery data to skip redundant questions
🎨 product - Validates and refines based on existing structure
🏗️ architect - Confirms detected tech stack

Discovered and incorporated:
✓ Project: [name from discovery]
✓ Tech Stack: [detected stack]
✓ Structure: [discovered patterns]

The facilitator will use this context to streamline questions.

Ready to build on this foundation?
```

---

**Brief Creation Process** (7 sections):

Each section follows **iteration pattern**:
1. Agent asks questions
2. User responds
3. facilitator captures and identifies gaps
4. Agent provides structure/validation
5. User refines
6. Iterate until user approves
7. Mark section complete (✓)

**Sections**:

#### 1. Executive Summary
- **🎨 product asks**: "In 1-2 sentences, what are you building and why?"
- **🔄 facilitator**: Captures, refines through iteration
- **Goal**: Clear, compelling summary (what + why)

#### 2. Problem Statement
- **🎨 product asks**: "What problem? Who has it? Current solutions?"
- **🎨 product structures**: Who / Current Pain / Impact / Existing Solutions → Limitations
- **🔄 facilitator**: Ensures clarity and specificity

#### 3. Objectives
- **🎨 product asks**: "What does success look like? Measurable goals?"
- **🎨 product validates**: Specific, measurable, prioritized
- **🔄 facilitator**: Refines until actionable

#### 4. Scope Definition
- **🎨 product asks**: "Must have? Should have? Out of scope?"
- **🏗️ architect checks**: Technical feasibility, complexity estimates
- **🔄 facilitator**: Structures into table (Must/Should/Out) with complexity
- **🎨 product validates**: "Anything critical forgotten?"

#### 5. Constraints
- **��️ Architect asks**: "Technical? Resource? Business constraints?"
- **🔄 facilitator**: Organizes by type with impact notes
- **🏗️ architect validates**: Constraints are workable together

#### 6. Success Criteria
- **🎨 product asks**: "How will we know project succeeded?"
- **🔄 facilitator**: Creates measurable checklist
- **🎨 product validates**: Aligns with objectives

#### 7. Complete Review
- **🔄 facilitator**: Presents complete brief draft
- **All agents**: Quality gate validation (see below)
- **User**: Final approval

---

**Quality Gates** (before writing files):

**🔄 facilitator**:
- [ ] All sections complete
- [ ] Information structured
- [ ] User approved

**🎨 product**:
- [ ] Problem clear
- [ ] Objectives measurable
- [ ] Scope well-defined
- [ ] Success criteria align

**🏗️ architect**:
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

1. **Configure team** (RECOMMENDED): /cf:configure-team
   [If discovery found matching team]:
   Based on your [detected stack], consider:
   → /cf:configure-team --type [recommended team]

   [If no matching team]:
   Generic agents will adapt to your [detected language/framework]
   No additional configuration needed.

2. **Review**: /cf:sync

3. **Start building**: /cf:feature [description]

Ready to configure team or jump to development?
```

---

### Phase 3: Quick Mode (--quick flag)

Skip Phase 2, create stubs:

```
🚀 Initializing CCFlow... (Quick Mode)

✓ Structure created
✓ Stub files with TODOs created

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚠️ QUICK MODE: Manual completion required

Complete: memory-bank/projectbrief.md

OR run /cf:init WITHOUT --quick for guided creation
```

---

## Agent Collaboration Patterns

### 🔄 facilitator (Primary)
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

### 🎨 product (Expert)
**Responsibilities**:
- Asks insightful domain questions
- Provides structure for requirements
- Validates measurability and alignment
- Ensures critical items not forgotten
- Shares best practices

### 🏗️ architect (Technical)
**Responsibilities**:
- Flags complex features early
- Identifies dependencies
- Validates feasibility
- Documents technical constraints
- Raises trade-offs

**Collaboration**: Agents work in sequence per section, with facilitator synthesizing.

---

## Examples

### Example: Interactive Session (Abbreviated)

```
User: /cf:init

[Structure creation...]

📋 PROJECT BRIEF CREATION
Ready to begin?

User: Yes

🎨 product: In 1-2 sentences, what are you building and why?

User: A task manager for developers that integrates with IDEs

🔄 facilitator: Let me capture that...

Draft: "A task manager for developers that integrates with IDEs"

Questions:
- What makes this different from existing task managers?
- What problem does IDE integration solve?
- Solo or team focused?

User: For solo developers who context-switch. Tasks show in IDE to reduce app-switching.

🔄 facilitator: Updated:
"A task manager for solo developers who context-switch between projects,
surfacing tasks directly in their IDE to reduce app-switching and maintain focus."

Better?

User: Perfect!

✓ Executive Summary captured

[Continues through all sections with same pattern...]

🔄 facilitator: Here's the complete brief:

[Shows full brief]

Review questions:
1. Accurate vision?
2. Anything missing?
3. Would guide others?
4. Right scope?

User: Add keyboard shortcuts requirement

🔄 facilitator: Added to constraints. Ready to finalize?

User: Yes

✓ Writing projectbrief.md...
✓ Complete!

🎯 NEXT STEPS: [as shown above]
```

---

## Edge Cases

### Minimal Information
**🔄 facilitator**: "Description is brief. Let me ask specific questions..." [targeted extraction]

### Wants to Skip Section
**🔄 facilitator**: "Skipping [X] means missing [Y], causes [Z]. Just 2-3 minutes? Or use --quick mode instead?"

### Changes Mind
**🔄 facilitator**: "No problem! Let's go back to [section]..." [re-iterate]

### Technical Issues
**🏗️ architect**: "[Feature] requires [dependencies] - adds complexity. Options: 1) Keep 2) Simplify 3) Defer. Your call?"

---

## Error Handling

### Already Initialized
```
⚠️ CCFlow Already Initialized
Memory bank exists. To view: /cf:sync
To reinitialize: Delete memory-bank/ first
```

### Templates Missing
```
❌ Error: CCFlow templates not found
Expected: memory-bank/templates/
Ensure running from CCFlow directory
```

### Partial Init Failure

If `/cf:init` fails partway through (e.g., creates some files but not others):

```
❌ Initialization failed partway through

Rollback Instructions:
1. Delete memory-bank directory:
   rm -rf memory-bank/

2. Delete .claude/agents directory:
   rm -rf .claude/agents/

3. Re-run initialization:
   /cf:init

Note: Check error message above for root cause before re-running.
```

**Common Causes**:
- Template file missing or malformed
- Permission issues in project directory
- Interrupted execution

**Prevention**:
- Verify templates exist before running (see Phase 2 ACTION 5 validation)
- Ensure write permissions in project directory

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
- **Implementation agents need customization** (fill TODOs before use)
- **AgentBuilder available** (use `/cf:refine-agent` to optimize verbose agents post-init)

---

**Command Version**: 2.0 (Enhanced with guided brief creation)
**Last Updated**: 2025-10-05
