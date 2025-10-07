# Tasks

<!-- NOTE: This file tracks tasks and is created fresh during initialization -->

**Last Updated**: [YYYY-MM-DD HH:MM]

---

## Status Legend

- 🟢 **Active**: Currently being worked on
- ⏳ **Pending**: Scheduled for later, ready to start
- 🔄 **Blocked**: Cannot proceed due to dependencies or issues
- ✅ **Complete**: Done and verified (tests passing)
- ❌ **Cancelled**: No longer needed or out of scope

---

## Active Tasks

### 🟢 TASK-001: [Task Name] (Level [1-4])

**Status**: Active
**Priority**: [P0/P1/P2]
**Complexity**: Level [1-4]
**Assigned**: [Agent name or workflow phase]
**Started**: YYYY-MM-DD
**Target**: YYYY-MM-DD
**Effort Estimate**: [X hours/days]

**Description**:
[What needs to be done]

**Acceptance Criteria**:
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

**Tests**: [X/Y passing] ([RED/GREEN status])
**Coverage**: [X]%

**Sub-tasks**:
- [x] Sub-task 1 (Level 1) - Complete
- [ ] Sub-task 2 (Level 2) - In Progress (60%)
- [ ] Sub-task 3 (Level 1) - Pending

**Blockers**: [None / Description of blocker]

**Notes**:
[Any important context, decisions, or learnings]

---

### 🟢 TASK-002: [Task Name] (Level [1-4])

**Status**: Active
**Priority**: [P0/P1/P2]
**Complexity**: Level [1-4]
**Assigned**: [Agent name]
**Started**: YYYY-MM-DD
**Target**: YYYY-MM-DD

**Description**:
[What needs to be done]

**Acceptance Criteria**:
- [ ] [Criterion 1]
- [ ] [Criterion 2]

**Tests**: [RED/GREEN status]

**Sub-tasks**:
- [ ] Sub-task 1
- [ ] Sub-task 2

**Blockers**: [None / Description]

**Notes**: [Context]

---

## Pending Tasks

### ⏳ TASK-003: [Task Name] (Level [1-4])

**Status**: Pending
**Priority**: [P0/P1/P2]
**Complexity**: Level [1-4]
**Ready to Start**: [Yes/No - depends on TASK-XXX]
**Estimated Start**: YYYY-MM-DD
**Effort Estimate**: [X hours]

**Description**:
[What needs to be done]

**Prerequisites**:
- [ ] [Prerequisite 1]
- [ ] [Prerequisite 2]

**Acceptance Criteria**:
- [ ] [Criterion 1]
- [ ] [Criterion 2]

**Notes**: [Context or planning notes]

---

## Blocked Tasks

### 🔄 TASK-004: [Task Name] (Level [1-4])

**Status**: Blocked
**Priority**: [P0/P1/P2]
**Complexity**: Level [1-4]
**Blocked Since**: YYYY-MM-DD
**Assigned**: [Agent name]

**Description**:
[What needs to be done]

**Blocker**:
[Detailed description of what's blocking this task]

**Waiting On**:
- [Dependency 1] - Expected: YYYY-MM-DD
- [Dependency 2] - Expected: YYYY-MM-DD

**Unblock Actions**:
1. [Action needed to unblock]
2. [Action needed to unblock]

**Notes**: [Context]

---

## Recently Completed Tasks

### ✅ TASK-010: [Task Name] (Level 2)

**Completed**: YYYY-MM-DD
**Priority**: P0
**Actual Effort**: [X hours] (Estimated: [Y hours])
**Assigned**: [Agent name]

**Description**:
[What was done]

**Outcome**:
[What was achieved]

**Tests**: ✅ All passing ([X] tests, [Y]% coverage)

**Lessons Learned**:
- [Learning 1]
- [Learning 2]

**Files Modified**:
- [file1.js]: [What changed]
- [file2.ts]: [What changed]

---

### ✅ TASK-009: [Task Name] (Level 1)

**Completed**: YYYY-MM-DD
**Priority**: P1
**Actual Effort**: [X hours]
**Outcome**: [Brief summary]
**Tests**: ✅ All passing

---

## Cancelled Tasks

### ❌ TASK-999: [Task Name] (Level 3)

**Cancelled**: YYYY-MM-DD
**Reason**: [Why this was cancelled]
**Original Priority**: P2

**Alternative**: [What we're doing instead, if anything]

---

## Task Summary

### By Status

| Status | Count | Total Complexity Points |
|--------|-------|------------------------|
| 🟢 Active | [X] | [Y points] |
| ⏳ Pending | [X] | [Y points] |
| 🔄 Blocked | [X] | [Y points] |
| ✅ Complete | [X] | [Y points] |
| ❌ Cancelled | [X] | [Y points] |

### By Priority

| Priority | Active | Pending | Blocked | Complete |
|----------|--------|---------|---------|----------|
| P0 | [X] | [X] | [X] | [X] |
| P1 | [X] | [X] | [X] | [X] |
| P2 | [X] | [X] | [X] | [X] |

### By Complexity

| Level | Active | Pending | Blocked | Complete | Avg Effort |
|-------|--------|---------|---------|----------|------------|
| Level 1 | [X] | [X] | [X] | [X] | [Y hours] |
| Level 2 | [X] | [X] | [X] | [X] | [Y hours] |
| Level 3 | [X] | [X] | [X] | [X] | [Y hours] |
| Level 4 | [X] | [X] | [X] | [X] | [Y hours] |

---

## Task Dependencies

### Dependency Graph

```
TASK-001 → TASK-003
         → TASK-004

TASK-002 → TASK-005

TASK-003 + TASK-004 → TASK-006
```

### Critical Path

**Critical path tasks** (blocking other work):
1. TASK-001 → blocks 2 tasks
2. TASK-002 → blocks 1 task

---

## Task Templates

### New Task Template

When creating a new task, use this structure:

```markdown
### [🟢/⏳] TASK-[ID]: [Task Name] (Level [1-4])

**Status**: [Active/Pending/Blocked]
**Priority**: [P0/P1/P2]
**Complexity**: Level [1-4]
**Assigned**: [Agent name or TBD]
**Created**: YYYY-MM-DD
**Target**: YYYY-MM-DD
**Effort Estimate**: [X hours]

**Description**:
[What needs to be done]

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
8. Archived (moved to "Recently Completed")
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

- **Level 3-4 tasks**: Always break down into smaller sub-tasks
- **Level 2 tasks**: Create sub-tasks if natural phases exist
- **Level 1 tasks**: Generally no sub-tasks needed

### Sub-Task Format

```markdown
**Sub-tasks**:
- [x] 1. [Sub-task name] (Level 1) - Complete YYYY-MM-DD
  - Description: [Brief description]
  - Files: [file1.js, file2.ts]
  - Tests: ✅ Passing

- [ ] 2. [Sub-task name] (Level 2) - In Progress (40%)
  - Description: [Brief description]
  - Blocker: [If any]
  - Tests: 🔄 In development

- [ ] 3. [Sub-task name] (Level 1) - Pending
  - Description: [Brief description]
  - Prerequisites: Sub-task 2 must complete
  - Tests: Not started
```

---

## Archived Tasks

### Archive Policy

- Move tasks to archive after: [X days/weeks] of completion
- Keep recent completions visible for: [Duration]
- Archive location: [Archive file or section]

### Archive Entry Format

```markdown
### ✅ TASK-XXX: [Task Name] - Completed YYYY-MM-DD
**Priority**: [P0/P1/P2] | **Complexity**: Level [X] | **Effort**: [Y hours]
**Outcome**: [Brief summary]
```

---

## Notes

### Task ID Convention
- Format: TASK-[sequential number, zero-padded to 3 digits]
- Example: TASK-001, TASK-042, TASK-153
- IDs are never reused, even for cancelled tasks

### Priority Definitions
- **P0 (Critical)**: Must have for project success, blocking other work
- **P1 (High)**: Important, high value, should do soon
- **P2 (Medium)**: Nice to have, can defer if needed

### Effort Estimation
- Include time for: testing, documentation, review, integration
- Review and adjust estimates based on completed task actuals
- Track estimation accuracy to improve future estimates

---

**Template Version**: 1.0
**Template Last Updated**: 2025-10-05
