# Command: /cf:init

Initialize CCFlow memory bank and agent system for a new project.

---

## Usage

```
/cf:init [project-name]
/cf:init [project-name] --interactive
```

## Parameters

- `[project-name]`: **Required** - Name of the project to initialize

## Flags

- `--interactive`: Engage Facilitator agent for guided project brief creation

---

## Purpose

Initialize the CCFlow workflow system by:
1. Creating memory bank directory structure
2. Copying templates to create initial memory bank files
3. Creating .claude agent directory structure (if not exists)
4. Optionally guiding interactive project brief creation

---

## Prerequisites

**None** - This is the bootstrap command, first command to run.

---

## Process

### Step 1: Check if Already Initialized

Check if `memory-bank/` directory exists:

**If EXISTS**:
```
⚠️ CCFlow Already Initialized

Memory bank exists at: memory-bank/

To view current state, run: /cf:sync
To reinitialize, manually delete memory-bank/ first (⚠️ destroys existing data)
```

**Stop execution if already initialized.**

---

### Step 2: Create Memory Bank Structure

If NOT initialized, create directory and copy templates:

```bash
# Create memory-bank directory
mkdir -p memory-bank

# Copy all template files, removing .template extension
cp memory-bank/templates/projectbrief.template.md memory-bank/projectbrief.md
cp memory-bank/templates/productContext.template.md memory-bank/productContext.md
cp memory-bank/templates/systemPatterns.template.md memory-bank/systemPatterns.md
cp memory-bank/templates/activeContext.template.md memory-bank/activeContext.md
cp memory-bank/templates/progress.template.md memory-bank/progress.md
cp memory-bank/templates/tasks.template.md memory-bank/tasks.md
```

### Step 3: Populate Initial Values

**Update each file** with project name and current date:

**In ALL memory bank files**, replace:
- `[Project Name]` → `{project-name from user input}`
- `[YYYY-MM-DD]` → `{current date}`
- `[YYYY-MM-DD HH:MM]` → `{current timestamp}`

**In projectbrief.md specifically**:
- Add initial revision history entry
- Set version to 1.0
- Mark status as "Planning"

**In tasks.md specifically**:
- Initialize summary tables with zeros
- Set up structure ready for first task

**In progress.md specifically**:
- Set "Current Phase" to "Planning"
- Set "Completion" to "0%"
- Set "Overall Status" to "Not Started"

**In activeContext.md specifically**:
- Set "Current Focus" to "Project initialization"
- Add initial change log entry for initialization

---

### Step 4: Create .claude Structure (if needed)

Check if `.claude/` exists:

**If NOT EXISTS**:
```bash
mkdir -p .claude/agents/workflow
mkdir -p .claude/agents/development/specialists
mkdir -p .claude/agents/testing/specialists
mkdir -p .claude/agents/ui/specialists
mkdir -p .claude/commands
```

**Copy hub agent templates** to `.claude/agents/`:
```bash
# Copy the 3 hub agent templates with TODO sections
cp [CCFlow location]/.claude/agents/testing/testEngineer.md .claude/agents/testing/
cp [CCFlow location]/.claude/agents/development/codeImplementer.md .claude/agents/development/
cp [CCFlow location]/.claude/agents/ui/uiDeveloper.md .claude/agents/ui/
```

**Note**: Workflow agents are NOT copied - they are invoked from CCFlow location directly.

---

### Step 5: Interactive Mode (if --interactive flag)

If `--interactive` flag is present:

**Engage Facilitator agent** for guided project brief creation:

```markdown
🔄 INTERACTIVE PROJECT SETUP

I'll help you create a comprehensive project brief through guided questions.

## Project Overview

**Q1: What is this project?**
[User answers]

**Q2: What problem does it solve?**
[User answers]

**Q3: Who is it for?**
[User answers]

---

## Scope & Objectives

**Q4: What are the must-have features (P0)?**
[User lists features]

**Q5: What are your primary objectives?**
[User lists objectives with success metrics]

**Q6: What are your constraints (technical, timeline, resources)?**
[User describes constraints]

---

## Success Criteria

**Q7: How will you know this project is successful?**
[User defines success criteria]

---

[Facilitator refines and validates responses]

✅ Project brief created and saved to memory-bank/projectbrief.md

Would you like to continue refining, or proceed with this brief?
```

**Facilitator updates projectbrief.md** with responses.

---

### Step 6: Output Success Confirmation

```markdown
✅ CCFlow Initialized Successfully

## Structure Created

📁 **Memory Bank** (`memory-bank/`):
   ✓ projectbrief.md     - Foundation document (scope, goals, requirements)
   ✓ productContext.md   - User needs and features
   ✓ systemPatterns.md   - Architecture and coding patterns
   ✓ activeContext.md    - Current work tracking
   ✓ progress.md         - Status and milestones
   ✓ tasks.md            - Task management

📁 **Agent System** (`.claude/agents/`):
   ✓ testing/testEngineer.md       - TDD coordination (⚠️ Needs customization)
   ✓ development/codeImplementer.md - General implementation (⚠️ Needs customization)
   ✓ ui/uiDeveloper.md              - UI development (⚠️ Needs customization)

   Workflow agents available from CCFlow:
   - Assessor, Architect, Product, Documentarian, Reviewer, Facilitator

## Next Steps

### 1. Customize Hub Agents for Your Tech Stack

**Action Required**: Edit the hub agent files and fill in TODO sections

**Files to customize**:
- `.claude/agents/testing/testEngineer.md`
- `.claude/agents/development/codeImplementer.md`
- `.claude/agents/ui/uiDeveloper.md`

**What to customize**:
- Testing framework and commands
- Tech stack details
- Coding conventions
- Specialist routing rules

**Example**:
```markdown
<!-- In testEngineer.md, find TODO sections like: -->

### Testing Framework
framework: "jest"  # ← Fill in your framework
test_directory: "__tests__/"  # ← Your test directory
```

### 2. Review Memory Bank

Run: `/cf:sync`

This will load and summarize your memory bank state.

### 3. Start Your First Feature

Run: `/cf:feature [description]`

Example: `/cf:feature add user authentication`

This will:
- Assess task complexity
- Route to appropriate workflow
- Update tasks.md with new task

---

## Project: {project-name}

**Status**: Initialized and ready for development
**Memory Bank**: 6 core files created
**Agent System**: Hub agents ready for customization

Happy coding! 🚀
```

---

## Examples

### Basic Initialization

```
User: /cf:init TaskManager

Claude:
✅ CCFlow Initialized Successfully

## Structure Created
[... full output as shown above ...]

## Next Steps
1. Customize hub agents for your tech stack
2. Run /cf:sync to review memory bank
3. Run /cf:feature [description] to start first task
```

### Interactive Initialization

```
User: /cf:init TaskManager --interactive

Claude:
🔄 INTERACTIVE PROJECT SETUP

I'll help you create a comprehensive project brief through guided questions.

## Project Overview

**Q1: What is this project?**
```

[... Facilitator guides through questions ...]

```
✅ Project brief created and saved to memory-bank/projectbrief.md

[... rest of initialization output ...]
```

---

## Error Handling

### If Already Initialized

```
⚠️ CCFlow Already Initialized

Memory bank exists at: memory-bank/

Current status: [Read from progress.md]
Last updated: [Read from activeContext.md]

To view current state, run: /cf:sync

To reinitialize:
1. ⚠️ WARNING: This will destroy existing project data
2. Manually delete memory-bank/ directory
3. Run /cf:init [project-name] again
```

### If Project Name Missing

```
❌ Error: Project name required

Usage: /cf:init [project-name]

Example: /cf:init MyAwesomeProject
```

### If Template Files Missing

```
❌ Error: CCFlow templates not found

Expected location: memory-bank/templates/

This command requires the CCFlow system to be set up with template files.

Please ensure you're running from the CCFlow directory or that templates are available.
```

---

## What Gets Created

### Memory Bank Files (6)

1. **projectbrief.md**: Foundation document
   - Project overview
   - Scope and features
   - Objectives with success metrics
   - Constraints and risks
   - Decision log

2. **productContext.md**: Product and UX focus
   - Problem → Solution mapping
   - Features (implemented, planned, deferred)
   - User flows
   - UX requirements
   - Non-functional requirements

3. **systemPatterns.md**: Technical architecture
   - Architecture overview
   - Active patterns
   - Coding conventions
   - Testing patterns
   - ADR index

4. **activeContext.md**: Current work state
   - Current focus
   - Recent changes log
   - Immediate next steps
   - Active decisions
   - Key learnings
   - Session context

5. **progress.md**: Status tracking
   - Project status and completion
   - Completed work log
   - Remaining work by priority
   - Known issues
   - Technical debt
   - Decision history
   - Checkpoints

6. **tasks.md**: Task management
   - Active tasks
   - Pending tasks
   - Blocked tasks
   - Completed tasks
   - Task summaries and metrics

### Agent Files (3 hub agents)

1. **testEngineer.md**: TDD coordination
   - With TODO sections for customization

2. **codeImplementer.md**: General implementation
   - With TODO sections for customization

3. **uiDeveloper.md**: UI development
   - With TODO sections for customization

---

## Related Commands

- `/cf:sync` - Review memory bank state after initialization
- `/cf:feature` - Start first feature after initialization

---

## Notes

- This command is idempotent - running it twice won't break anything (it will just warn and stop)
- Template files remain in `memory-bank/templates/` for reference
- Hub agents must be customized for your tech stack before use
- Workflow agents (Assessor, Architect, etc.) are used directly from CCFlow, no copying needed

---

**Command Version**: 1.0
**Last Updated**: 2025-10-05
