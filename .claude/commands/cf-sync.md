# Command: /cf:sync

Read and summarize current memory bank state, providing project status snapshot.

---

## Usage

```
/cf:sync
/cf:sync --verbose
```

## Flags

- `--verbose`: Include detailed content from each memory bank file

---

## Purpose

Synchronize your understanding of the project by:
1. Loading all 6 core memory bank files
2. Summarizing current project state
3. Identifying any inconsistencies or gaps
4. Confirming readiness for development

---

## Prerequisites

**Memory bank must be initialized**. If not, command will suggest `/cf:init`.

---

## Process

### Step 1: Verify Memory Bank Exists

Check if `memory-bank/` directory exists:

**If NOT EXISTS**:
```
⚠️ Memory Bank Not Initialized

CCFlow memory bank not found.

To initialize, run: /cf:init [project-name]

Example: /cf:init MyProject
```

**Stop execution if not initialized.**

---

### Step 2: Load All Memory Bank Files

Read the following files:
1. `memory-bank/projectbrief.md`
2. `memory-bank/productContext.md`
3. `memory-bank/systemPatterns.md`
4. `memory-bank/activeContext.md`
5. `memory-bank/progress.md`
6. `memory-bank/tasks.md`

**If any file is missing**:
```
⚠️ Warning: Missing memory bank file

Expected: memory-bank/[filename].md
Status: Not found

This may indicate incomplete initialization or file deletion.

Consider reinitializing or creating the missing file from templates.
```

---

### Step 3: Extract Key Information

From each file, extract:

**From projectbrief.md**:
- Project name
- Project overview (first paragraph)
- P0 features (must-have)
- Primary objectives
- Critical constraints

**From productContext.md**:
- Key problems being solved
- Implemented features count
- Planned features count
- Primary user flows

**From systemPatterns.md**:
- Architecture style
- Key technologies (frontend, backend, database)
- Number of active patterns documented

**From activeContext.md**:
- Current focus (primary task)
- Last updated timestamp
- Immediate next steps (top 3)
- Active blockers (if any)
- Recent changes (last 5)

**From progress.md**:
- Current phase
- Overall completion percentage
- Status (On Track/At Risk/Behind)
- Next milestone
- Completed features count
- Remaining work (P0 count)
- Known issues (count by severity)

**From tasks.md**:
- Active tasks count
- Pending tasks count
- Blocked tasks count
- Completed tasks count
- Task summary by priority and complexity

---

### Step 4: Identify Gaps or Inconsistencies

Check for:

**Missing Information**:
- Empty or placeholder sections (e.g., "[Project Name]" still present)
- No active tasks or focus defined
- Objectives without success metrics

**Inconsistencies**:
- activeContext.md says task X is active, but tasks.md shows it as complete
- progress.md shows features complete that aren't in completed log
- Conflicting priorities or timelines

**Warnings**:
- Blocked tasks with no resolution plan
- Overdue milestones
- High-priority tasks pending for long time

---

### Step 5: Output Summary

**Standard Mode** (default):

```markdown
📊 MEMORY BANK STATUS

## Project: [Project Name]

**Status**: [Current Phase] - [On Track/At Risk/Behind]
**Completion**: [X]% complete
**Last Updated**: [Timestamp from activeContext.md]
**Next Milestone**: [Milestone name] - [Target date]

---

## Current Focus

**Active Work**: [Primary task from activeContext.md]
**Started**: [Date]
**Progress**: [Status]

**Immediate Next Steps**:
1. [Next step 1]
2. [Next step 2]
3. [Next step 3]

---

## Project Overview

[First paragraph from projectbrief.md]

**Key Objectives**:
- [Primary objective 1]
- [Primary objective 2]

**Critical Constraints**:
- [Constraint 1]
- [Constraint 2]

---

## Progress Summary

### Completed
- ✅ [X] features completed
- ✅ [X] tasks completed

### Remaining (P0)
- [ ] [Feature 1]
- [ ] [Feature 2]

### Current Tasks
- 🟢 Active: [X] tasks
- ⏳ Pending: [X] tasks
- 🔄 Blocked: [X] tasks

---

## Technology Stack

- **Architecture**: [Architecture style]
- **Frontend**: [Framework]
- **Backend**: [Framework]
- **Database**: [Database]

**Patterns Documented**: [X] active patterns in systemPatterns.md

---

## Issues & Blockers

### Active Blockers
[If any blockers from activeContext.md or tasks.md]:
- [Blocker 1]
- [Blocker 2]

[If no blockers]:
✅ No active blockers

### Known Issues
- High Severity: [X]
- Medium Severity: [X]
- Low Severity: [X]

---

## Recent Activity

[Last 5 changes from activeContext.md]:
- [YYYY-MM-DD HH:MM] [Change 1]
- [YYYY-MM-DD HH:MM] [Change 2]
- [YYYY-MM-DD HH:MM] [Change 3]

---

## Gaps Detected

[If any gaps or inconsistencies found]:
⚠️ **Potential Issues**:
- [Gap/inconsistency 1]
- [Gap/inconsistency 2]

**Recommendations**:
- [Action to resolve gap 1]
- [Action to resolve gap 2]

[If no issues]:
✅ Memory bank consistent and up-to-date

---

## Readiness Check

✅ Memory bank initialized
✅ Project brief defined
✅ Tech stack documented
[✅/⚠️] Active work defined
[✅/⚠️] Next steps clear
[✅/⚠️] No critical blockers

**Status**: [Ready for development / Needs attention / Review recommended]

---

## Next Actions

[Context-aware recommendations]:
- [Recommendation 1 based on current state]
- [Recommendation 2]

**Quick Commands**:
- `/cf:feature [description]` - Start new feature
- `/cf:plan [task]` - Plan an existing task
- `/cf:code [task]` - Implement a task
- `/cf:status` - Quick status check
```

---

**Verbose Mode** (with `--verbose` flag):

```markdown
📊 MEMORY BANK STATUS (Verbose Mode)

[Same header and summary as standard mode]

---

## Detailed File Contents

### projectbrief.md

**Overview**:
[Full overview section]

**Scope**:
[Feature table or list]

**Objectives**:
[Full objectives with metrics]

**Constraints**:
[All constraints listed]

**Recent Decisions**:
[Last 3 entries from decision log]

---

### productContext.md

**Problems Solving**:
[Problem descriptions]

**Features**:
| Feature | Status | Priority |
|---------|--------|----------|
[Feature table]

**User Flows**:
[Primary flow descriptions]

**UX Requirements**:
[Must-have requirements]

---

### systemPatterns.md

**Architecture**:
[Architecture overview and diagram]

**Active Patterns**:
[List of patterns with brief descriptions]

**Coding Conventions**:
[Key conventions listed]

**Critical Paths**:
[Critical path descriptions]

---

### activeContext.md

**Current Focus**: [Full current focus section]

**Recent Changes**: [All recent changes]

**Active Decisions**: [All decisions under consideration]

**Learnings**: [All key learnings]

**Session Context**: [Context for next session]

---

### progress.md

**Status**: [Full status section]

**Completed Work**: [Recent completions]

**Remaining Work**: [Full remaining work breakdown]

**Milestones**: [Milestone table]

**Technical Debt**: [Debt inventory]

**Latest Checkpoint**: [Full checkpoint entry]

---

### tasks.md

**Active Tasks**: [Full active task entries]

**Pending Tasks**: [Full pending task entries]

**Blocked Tasks**: [Full blocked task entries]

**Summary Tables**: [All summary tables]

---

[Same Gaps, Readiness, and Next Actions sections as standard mode]
```

---

## Examples

### Newly Initialized Project

```
User: /cf:sync

Claude:
📊 MEMORY BANK STATUS

## Project: TaskManager

**Status**: Planning - Not Started
**Completion**: 0% complete
**Last Updated**: 2025-10-05 14:30
**Next Milestone**: Not set

---

## Current Focus

**Active Work**: Project initialization
**Started**: 2025-10-05

**Immediate Next Steps**:
1. Define first feature
2. Set up development environment
3. Customize hub agents

---

## Project Overview

A task management application for solo developers to organize work...

**Key Objectives**:
- Streamline task tracking workflow
- Integrate with development tools

---

## Progress Summary

### Completed
- ✅ 0 features completed
- ✅ 0 tasks completed

### Remaining (P0)
- None defined yet

### Current Tasks
- 🟢 Active: 0 tasks
- ⏳ Pending: 0 tasks
- 🔄 Blocked: 0 tasks

---

## Gaps Detected

⚠️ **Project Needs Setup**:
- No features defined yet
- No active tasks
- Hub agents need customization

**Recommendations**:
- Customize hub agents in .claude/agents/ for your tech stack
- Define first feature with /cf:feature [description]

---

## Readiness Check

✅ Memory bank initialized
✅ Project brief defined
⚠️ Active work not yet defined
⚠️ Hub agents need customization

**Status**: Needs setup

---

## Next Actions

1. Customize hub agents for your tech stack
2. Run: /cf:feature [description] to define first feature
```

### Active Development Project

```
User: /cf:sync

Claude:
📊 MEMORY BANK STATUS

## Project: TaskManager

**Status**: Development - On Track
**Completion**: 35% complete
**Last Updated**: 2025-10-05 16:45
**Next Milestone**: MVP Release - 2025-10-20

---

## Current Focus

**Active Work**: User authentication system (TASK-003)
**Started**: 2025-10-03
**Progress**: 60% (4/6 sub-tasks complete)

**Immediate Next Steps**:
1. Complete frontend auth context (TASK-003-5)
2. Implement protected routes (TASK-003-6)
3. Begin user profile feature planning

---

## Project Overview

A task management application for solo developers...

**Key Objectives**:
- Streamline task tracking workflow (✅ 40% complete)
- Integrate with development tools (⏳ Not started)

---

## Progress Summary

### Completed
- ✅ 2 features completed (Task CRUD, Basic UI)
- ✅ 12 tasks completed

### Remaining (P0)
- [ ] User authentication
- [ ] User profiles
- [ ] Data persistence

### Current Tasks
- 🟢 Active: 1 task (TASK-003)
- ⏳ Pending: 3 tasks
- 🔄 Blocked: 0 tasks

---

## Technology Stack

- **Architecture**: Monolithic web application
- **Frontend**: React 18 with TypeScript
- **Backend**: Node.js/Express
- **Database**: PostgreSQL

**Patterns Documented**: 5 active patterns in systemPatterns.md

---

## Issues & Blockers

✅ No active blockers

### Known Issues
- High Severity: 0
- Medium Severity: 1 (Token refresh strategy needs design)
- Low Severity: 2

---

## Recent Activity

- [2025-10-05 16:45] Implemented auth middleware (testEngineer + codeImplementer)
- [2025-10-05 15:30] All auth backend tests passing (testEngineer)
- [2025-10-05 14:20] Completed user login service (codeImplementer)
- [2025-10-04 17:10] Completed auth service unit tests (testEngineer)
- [2025-10-04 16:00] Started authentication implementation (TASK-003)

---

✅ Memory bank consistent and up-to-date

---

## Readiness Check

✅ Memory bank initialized
✅ Project brief defined
✅ Tech stack documented
✅ Active work defined
✅ Next steps clear
✅ No critical blockers

**Status**: Ready for development

---

## Next Actions

Continue with current task:
- `/cf:code TASK-003-5` - Implement frontend auth context

OR start next priority:
- `/cf:plan user-profiles` - Plan user profile feature
```

---

## Error Handling

### Memory Bank Not Initialized

```
⚠️ Memory Bank Not Initialized

CCFlow memory bank not found at: memory-bank/

To initialize, run: /cf:init [project-name]

Example: /cf:init TaskManager

This will create the memory bank structure and initialize all required files.
```

### Missing Memory Bank Files

```
⚠️ Warning: Incomplete Memory Bank

Missing files:
- memory-bank/systemPatterns.md
- memory-bank/tasks.md

This may indicate:
- Incomplete initialization
- Files were deleted
- Corrupted memory bank

To resolve:
1. Check if files exist but in wrong location
2. Copy from memory-bank/templates/ if available
3. Run /cf:init again (⚠️ may overwrite changes)
```

### Corrupted or Malformed Files

```
⚠️ Warning: Memory Bank File Error

File: memory-bank/progress.md
Issue: Unable to parse or extract information

Continuing with available files...

Recommendation: Review the file for formatting issues or restore from backup.
```

---

## Integration with Other Commands

After `/cf:sync`, you typically:

- **If newly initialized**: `/cf:feature [description]` to start first feature
- **If active work**: `/cf:code [task]` to continue implementation
- **If planning phase**: `/cf:plan [task]` to create implementation plan
- **If milestone reached**: `/cf:checkpoint [message]` to save state

---

## Notes

- This command is read-only - it never modifies memory bank files
- Safe to run frequently for status checks
- Verbose mode useful for deep debugging or detailed reviews
- Output designed to be human-readable and actionable

---

**Command Version**: 1.0
**Last Updated**: 2025-10-05
