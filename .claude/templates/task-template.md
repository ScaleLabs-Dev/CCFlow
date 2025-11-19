# Task Template & Guidelines

**Purpose**: Reference template and guidelines for task management in CCFlow

**Usage**: Commands like /cf:feature and /cf:plan reference this template when populating tasks.md

---

## New Task Template

When creating a new task, use this structure:

```markdown
### [🟢/⏳] TASK-[ID]: [Task Name] (Level [1-4])

**Status**: [Active/Pending/Blocked]
**Priority**: [P0/P1/P2]
**Complexity**: Level [1-4]
**Created**: YYYY-MM-DD
**Planned**: YYYY-MM-DD (if planned)
**Effort Estimate**: [X hours]

**Description**:
[What needs to be done]

**User Value**:
[Why this matters to users]

**Acceptance Criteria**:
- [ ] [Criterion 1]
- [ ] [Criterion 2]

**Prerequisites**:
[If any]

**Tests**: [Not started/RED/GREEN]

**Sub-tasks**:
[If Level 2+]

**Blockers**: None

**Notes**: [Context]
```

---

## Complexity Assessment Guidelines

Use these guidelines to assign complexity levels:

### Level 1: Quick Fix
- **Scope**: 1-3 files
- **Effort**: < 30 minutes
- **Examples**: Bug fixes, typos, small updates, single function changes
- **Keywords**: fix, bug, typo, update, adjust
- **Risk**: Low (isolated change)
- **Planning**: Can proceed directly to `/cf:code`

### Level 2: Simple Enhancement
- **Scope**: 3-5 files
- **Effort**: 30 minutes - 2 hours
- **Examples**: Small features, straightforward additions, component updates
- **Keywords**: add, create, simple feature
- **Risk**: Low-Medium (affects one module)
- **Planning**: Requires `/cf:plan`

### Level 3: Intermediate Feature
- **Scope**: 5-10 files
- **Effort**: 2-8 hours
- **Examples**: Multi-component features, moderate complexity, cross-module changes
- **Keywords**: feature, integrate, refactor section
- **Risk**: Medium (cross-module changes)
- **Planning**: Requires `/cf:plan`, may benefit from `--interactive`

### Level 4: Complex System
- **Scope**: 10+ files or entire system
- **Effort**: 8+ hours or multi-day
- **Examples**: Major system changes, architectural impact, large integrations
- **Keywords**: architecture, migrate, system refactor, infrastructure
- **Risk**: High (breaking changes possible)
- **Planning**: Requires `/cf:plan --interactive`, careful breakdown into sub-tasks

---

## Task Workflow

### Standard Task Lifecycle

```
1. Created (via /cf:feature)
   ↓
2. Assessed (Assessor assigns complexity)
   ↓
3a. Level 1 → Active (proceed to /cf:code)
3b. Level 2-4 → Pending (requires /cf:plan)
   ↓
4. Planned (breakdown into sub-tasks if needed)
   ↓
5. Active (implementation begins)
   ↓
6a. Tests RED → Implementation → Tests GREEN → Complete
6b. Tests failing after 3 attempts → Blocked
   ↓
7. Complete (tests passing, criteria met)
   ↓
8. Archived (milestone summary to progress.md, task cleared from tasks.md)
```

### Task State Transitions

- **Pending → Active**: Prerequisites met, ready to start
- **Active → Blocked**: Dependency issue or persistent test failures
- **Blocked → Active**: Blocker resolved
- **Active → Complete**: All acceptance criteria met, tests passing
- **Any → Cancelled**: No longer needed or out of scope

---

## Sub-Task Management

### When to Create Sub-Tasks

- **Level 4 tasks**: Always break down into smaller sub-tasks (required)
- **Level 3 tasks**: Usually break down into sub-tasks
- **Level 2 tasks**: Create sub-tasks if natural phases exist
- **Level 1 tasks**: No sub-tasks needed

### Sub-Task Format

```markdown
**Sub-tasks**:
- [x] TASK-XXX-1: [Sub-task name] (Level 1) - Complete YYYY-MM-DD
  - Description: [Brief description]
  - Files: [file1.js, file2.ts]
  - Result: [What was accomplished]

- [ ] TASK-XXX-2: [Sub-task name] (Level 2) - In Progress
  - Description: [Brief description]
  - Files: [files affected]
  - Actions: [What needs to be done]

- [ ] TASK-XXX-3: [Sub-task name] (Level 1) - Pending
  - Description: [Brief description]
  - Prerequisites: Sub-task 2 must complete
```

---

## Task Conventions

### Task ID Convention
- **Format**: TASK-[sequential number, zero-padded to 3 digits]
- **Examples**: TASK-001, TASK-042, TASK-153
- **Rule**: IDs are never reused, even for cancelled tasks

### Sub-Task ID Convention
- **Format**: TASK-[parent]-[number]
- **Examples**: TASK-156-1, TASK-156-2, TASK-003-12
- **Rule**: Sub-tasks numbered sequentially within parent

### Priority Definitions
- **P0 (Critical)**: Must have for project success, blocking other work
- **P1 (High)**: Important, high value, should do soon
- **P2 (Medium)**: Nice to have, can defer if needed

### Effort Estimation
- Include time for: testing, documentation, review, integration
- Review and adjust estimates based on completed task actuals
- Track estimation accuracy to improve future estimates
- Prefer ranges for Level 3-4 tasks (e.g., "2-4 hours")

---

## Status Legend

- 🟢 **Active**: Currently being worked on
- ⏳ **Pending**: Scheduled for later, ready to start
- 🔄 **Blocked**: Cannot proceed due to dependencies or issues
- ✅ **Complete**: Done and verified (tests passing)
- ❌ **Cancelled**: No longer needed or out of scope

---

## Milestone-Centric Architecture Notes

**tasks.md Lifecycle**:
- tasks.md contains ONLY current milestone's tasks and sub-tasks
- When milestone completes via `/cf:checkpoint`:
  - Summary written to progress.md
  - tasks.md cleared to empty state
  - Ready for next milestone

**File Purposes**:
- **tasks.md**: Current milestone work only (ephemeral)
- **progress.md**: Completed milestone summaries (permanent)
- **productContext.md**: Roadmap with planned/active/complete features
- **activeContext.md**: Implementation notes and recent changes

---

**Template Version**: 2.0 (Milestone-Centric)
**Last Updated**: 2025-11-11
**Location**: .claude/templates/task-template.md
**Used By**: /cf:feature, /cf:plan, /cf:code, /cf:checkpoint
