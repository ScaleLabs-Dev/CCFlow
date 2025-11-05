---
description: "Analyze task complexity and route to appropriate workflow (entry point for new work)"
allowed-tools: ['Read', 'Edit', 'Task']
argument-hint: "[description]"
---

# Command: /cf:feature

## Usage

```
/cf:feature [description]
```

## Parameters

- `[description]`: **Required** - Description of the feature or task to implement

---

## Purpose

Entry point for new work that:
1. Analyzes task complexity using Assessor agent
2. Creates task entry in tasks.md
3. Updates activeContext.md with task context
4. Routes to appropriate next command based on complexity

---

## Prerequisites

**Memory bank must be initialized**. Run `/cf:init` first if needed.

---

## Process

### Step 1: Verify Memory Bank Exists

Check if `memory-bank/` directory exists:

**If NOT EXISTS**:
```
⚠️ Memory Bank Not Initialized

Run: /cf:init
```

**Stop execution.**

---

### Step 2: Load Context

Read required memory bank files:
- `tasks.md` - To generate next task ID
- `activeContext.md` - For current project state
- `systemPatterns.md` - For technical context (if exists)
- `CLAUDE.md` - For tech stack reference (if exists)

---

### Step 3: Engage Assessor Agent

**Invoke Assessor agent** with task description.

Assessor will:
1. Analyze task description for complexity indicators
2. Estimate scope (may scan codebase if needed)
3. Evaluate risk factors
4. Calculate effort estimate
5. Assign complexity level (1-4)
6. Generate assessment output

**Assessor Output Format**:
```markdown
🎯 COMPLEXITY ASSESSMENT
─────────────────────────
Task: [description]
Level: [1-4] ([category])
Keywords: [complexity indicators identified]
Scope: ~[N] files ([component types if scanned])
Risk: [Low/Medium/High] ([risk factors])
Effort: [time estimate]
```

---

### Step 4: Generate Task ID

Extract task IDs from tasks.md and generate next sequential ID:

**Pattern**: `TASK-[NNN]` (zero-padded to 3 digits)

**Examples**: TASK-001, TASK-015, TASK-142

**Logic**:
- Find highest existing task ID
- Increment by 1
- Zero-pad to 3 digits

---

### Step 5: Update tasks.md

Add new task entry to "Pending Tasks" or "Active Tasks" section:

```markdown
### ⏳ TASK-[ID]: [Task Name] (Level [1-4])

**Status**: Pending
**Priority**: P1  # Default, user can change later
**Complexity**: Level [1-4]
**Assigned**: [Assessor recommendation or TBD]
**Created**: [YYYY-MM-DD]
**Target**: [TBD or estimated based on effort]
**Effort Estimate**: [From Assessor]

**Description**:
[User's task description]

**Acceptance Criteria**:
- [ ] [Auto-generated criterion based on description]
- [ ] All tests passing
- [ ] Code reviewed

**Prerequisites**: None

**Tests**: Not started

**Sub-tasks**: [If Level 2+, note that /cf:plan will break down]

**Blockers**: None

**Notes**: Created by /cf:feature - awaiting planning/implementation
```

**For Level 1 tasks**: Status can be "Active" since they can proceed directly to implementation.

---

### Step 6: Update activeContext.md

Add entry to "Recent Changes" section:

```markdown
### [YYYY-MM-DD HH:MM] - Task Created: [Task Name]
**Agent**: Assessor
**Task ID**: TASK-[ID]
**Complexity**: Level [1-4]
**Impact**: New task added to backlog
**Next Action**: [Routing recommendation]
```

**If no current focus** (project just started):
Update "Current Focus" section:
```markdown
### Primary Focus: [Task Name]

**Task**: TASK-[ID]
**Started**: [YYYY-MM-DD]
**Complexity**: Level [1-4]
**Progress**: Not started

**What we're doing**:
[Brief description]

**Why it matters**:
[Connection to project goals]

**Expected completion**:
[Based on effort estimate]
```

---

### Step 7: Output Assessment & Routing

**For Level 1 (Quick Fix)**:
```markdown
🎯 COMPLEXITY ASSESSMENT
─────────────────────────
Task: [description]
Level: 1 (Quick Fix)
Keywords: [indicators]
Scope: ~[N] files ([types])
Risk: Low ([factors])
Effort: [< 30 minutes]

✓ Created TASK-[ID] in tasks.md
✓ Updated activeContext.md

→ RECOMMENDATION: Task is straightforward and ready for implementation.

   Proceed with: /cf:code TASK-[ID]

   This will:
   1. testEngineer writes tests (RED phase)
   2. Implementation agent writes code (GREEN phase)
   3. Tests verified, task marked complete
```

**For Level 2-4 (Requires Planning)**:
```markdown
🎯 COMPLEXITY ASSESSMENT
─────────────────────────
Task: [description]
Level: [2-4] ([Intermediate Feature/Complex System])
Keywords: [indicators]
Scope: ~[N] files ([types])
Risk: [Medium/High] ([factors])
Effort: [estimate]

✓ Created TASK-[ID] in tasks.md
✓ Updated activeContext.md

→ RECOMMENDATION: This task requires planning.

   Please use: /cf:plan TASK-[ID]

   Planning will:
   1. Architect analyzes technical approach
   2. Product validates user requirements
   3. Task broken into sub-tasks
   4. Implementation approach documented

   Consider --interactive flag for collaborative planning:
   /cf:plan TASK-[ID] --interactive

   This engages Facilitator for iterative refinement.
```

---

## Examples

### Example 1: Simple Task (Level 1)

```
User: /cf:feature fix typo in header component

Claude:
[Assessor analyzes...]

🎯 COMPLEXITY ASSESSMENT
─────────────────────────
Task: Fix typo in header component
Level: 1 (Quick Fix)
Keywords: fix, typo
Scope: ~1 file (components/Header.tsx)
Risk: Low (isolated change, no dependencies)
Effort: < 15 minutes

✓ Created TASK-004 in tasks.md
✓ Updated activeContext.md

→ RECOMMENDATION: Task is straightforward and ready for implementation.

   Proceed with: /cf:code TASK-004
```

### Example 2: Medium Complexity (Level 2)

```
User: /cf:feature add search functionality to navbar

Claude:
[Assessor analyzes and scans codebase...]

🎯 COMPLEXITY ASSESSMENT
─────────────────────────
Task: Add search functionality to navbar
Level: 2 (Simple Enhancement)
Keywords: add, search, functionality
Scope: ~4 files (navbar component, search service, API endpoint, tests)
Risk: Low-Medium (new feature, integrates with existing nav)
Effort: 1-2 hours

✓ Created TASK-005 in tasks.md
✓ Updated activeContext.md

→ RECOMMENDATION: This task requires planning.

   Please use: /cf:plan TASK-005

   Planning will break down the implementation into steps:
   - Backend search endpoint
   - Frontend search component
   - Integration with navbar
   - Search results display

   Consider --interactive for collaborative planning:
   /cf:plan TASK-005 --interactive
```

### Example 3: Complex Task (Level 4)

```
User: /cf:feature migrate authentication system to OAuth 2.0

Claude:
[Assessor analyzes extensively, scans codebase...]

🎯 COMPLEXITY ASSESSMENT
─────────────────────────
Task: Migrate authentication system to OAuth 2.0
Level: 4 (Complex System)
Keywords: migrate, authentication, system, OAuth
Scope: ~25 files (auth services, middleware, database, frontend components, config)
Risk: High (breaking changes, security implications, data migration)
Effort: 12-16 hours (multi-day)

✓ Created TASK-006 in tasks.md
✓ Updated activeContext.md

→ RECOMMENDATION: This is a complex system change requiring careful planning.

   Please use: /cf:plan TASK-006 --interactive

   ⚠️ IMPORTANT: Given the complexity and risk:

   1. Interactive planning HIGHLY recommended (--interactive flag)
   2. Facilitator will guide through:
      - OAuth provider selection
      - Migration strategy (parallel vs sequential)
      - Data migration approach
      - Rollback plan
      - Testing strategy

   3. Consider breaking into phases:
      - Phase 1: OAuth integration (new feature)
      - Phase 2: Migration path (gradual transition)
      - Phase 3: Legacy auth removal

   Start with: /cf:plan TASK-006 --interactive
```

---

## Error Handling

### Memory Bank Not Initialized

```
⚠️ Memory Bank Not Initialized

Memory bank not found at: memory-bank/

To initialize, run: /cf:init

Example: /cf:init MyProject
```

### Missing Task Description

```
❌ Error: Task description required

Usage: /cf:feature [description]

Example: /cf:feature add user authentication

The description should clearly state what needs to be built or fixed.
```

### Tasks.md Missing or Corrupted

```
⚠️ Warning: tasks.md not found or corrupted

Expected: memory-bank/tasks.md

Creating new task entry with ID TASK-001.

Recommendation: Verify tasks.md exists and is properly formatted.
```

### Codebase Scan Failure (Level 2+ tasks)

```
⚠️ Codebase scan failed

Could not analyze project structure for scope estimation.

Proceeding with keyword-based assessment only.

Assessment may be less accurate. Consider manual scope verification.

[Continues with assessment based on keywords only]
```

---

## Assessor Decision Logic

The Assessor agent uses this logic:

### Keyword Analysis (Primary)

**Level 1 Indicators**:
- fix, bug, typo, update, adjust, tweak, correct
- Single file change implied
- Minor updates

**Level 2 Indicators**:
- add, create, simple, small feature
- New component or endpoint
- Enhancement to existing feature

**Level 3 Indicators**:
- feature, implement, integrate
- Multi-component change
- Moderate complexity implied

**Level 4 Indicators**:
- architecture, migrate, system, refactor, infrastructure
- Large-scale change
- High impact or risk

### Scope Analysis (If Level 2+)

**Codebase Scan**:
```bash
# Count potential files affected
Glob: Search for relevant files by pattern
Grep: Search for related code/imports

# Adjust complexity based on findings
If file_count > 10: Consider upgrading to Level 4
If file_count < 3: Consider downgrading to Level 1
```

### Risk Assessment

**Low Risk**:
- Isolated change
- No breaking changes
- Well-understood domain

**Medium Risk**:
- Cross-module changes
- Some breaking changes possible
- Moderate dependencies

**High Risk**:
- System-wide impact
- Breaking changes likely
- Security/data implications
- Complex dependencies

### Final Complexity Assignment

Assessor considers all factors and assigns level:
- Primary: Keyword analysis
- Secondary: Scope estimation
- Validation: Risk assessment
- Conservative: When in doubt, assign higher complexity

---

## Integration with Other Commands

After `/cf:feature`, typical flow:

**Level 1**:
```
/cf:feature [task] → /cf:code TASK-[ID] → Complete
```

**Level 2-4**:
```
/cf:feature [task] → /cf:plan TASK-[ID] → /cf:code TASK-[ID-subtask] → ... → Complete
```

**With Interactive Planning**:
```
/cf:feature [task] → /cf:plan TASK-[ID] --interactive → [Refinement] → /cf:code ... → Complete
```

---

## Memory Bank Updates

### tasks.md Changes

**New Task Entry Added**:
- Task ID generated
- Status: Pending (or Active for Level 1)
- Complexity level assigned
- Effort estimated
- Description captured
- Acceptance criteria generated

### activeContext.md Changes

**Recent Changes Log**:
- Entry added with timestamp
- Agent: Assessor
- Task ID reference
- Next action noted

**Current Focus** (if appropriate):
- Updated if this is first task or higher priority
- Includes task context and expected timeline

---

## Notes

- Task IDs are sequential and never reused
- Default priority is P1 (user can adjust in tasks.md)
- Assessor may take 10-30 seconds for complex tasks (codebase scanning)
- Level 1 tasks can skip planning and go directly to `/cf:code`
- Level 2+ tasks MUST use `/cf:plan` before implementation
- `--interactive` flag highly recommended for Level 3-4 tasks

---

## Related Commands

- `/cf:init` - Initialize before using /cf:feature
- `/cf:sync` - Review memory bank state
- `/cf:plan` - Plan Level 2+ tasks
- `/cf:code` - Implement Level 1 tasks or planned sub-tasks
- `/cf:status` - Quick check on tasks

---

**Command Version**: 1.0
**Last Updated**: 2025-10-05
