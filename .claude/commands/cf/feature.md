---
description: "Analyze task complexity and route to appropriate workflow (entry point for new work)"
allowed-tools: ['Read', 'Edit', 'Task', 'Write']
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

**Command Orchestration Pattern**: Coordinate Assessor and Product agents to analyze task complexity, generate specifications, and route to appropriate workflow.

Entry point for new work that:
1. Analyzes task complexity using Assessor agent
2. Validates requirements using Product agent
3. Creates structured task entry using template
4. Updates memory bank systematically
5. Routes to appropriate next command based on complexity

**Pattern**: Command Orchestration Pattern (systemPatterns.md:409-582)

---

## Prerequisites

**Memory bank must be initialized**. Run `/cf:init` first if needed.

---

## Process

### Step 1: Verify Prerequisites

Check if `memory-bank/` directory exists:

**If NOT EXISTS**:
```
⚠️ Memory Bank Not Initialized

Run: /cf:init
```

**Stop execution.**

---

### Step 2: Load Context

**ORCHESTRATION PATTERN**: Load memory bank context for agent invocations

**Read memory bank files** (parallel when possible):
- `tasks.md` - To generate next task ID and understand existing work
- `activeContext.md` - Current project state and focus
- `systemPatterns.md` - Technical patterns (if exists)
- `productContext.md` - Product features and requirements (if exists)
- `CLAUDE.md` - Tech stack reference (if exists)

**Extract context**:
- Next available task ID (highest TASK-NNN + 1)
- Current project focus
- Existing patterns that might apply
- Tech stack for scope estimation

---

### Step 3: Invoke Assessor Agent (Complexity Analysis)

**ORCHESTRATION PATTERN**: Invoke assessor agent for complexity analysis

```markdown
## Invoke Assessor Agent
Task(
  subagent_type="assessor",
  description="Task Complexity Assessment",
  prompt=`
    Analyze task complexity and provide routing recommendation.

    **Task Description**: [user's description]

    **Context**:
    - Project: [from projectbrief.md if available]
    - Tech Stack: [from CLAUDE.md]
    - Existing Patterns: [from systemPatterns.md]

    **Analysis Required**:
    1. Keyword analysis (fix, add, implement, migrate, etc.)
    2. Scope estimation (approximate files affected)
    3. Risk assessment (Low/Medium/High)
    4. Effort estimate
    5. Complexity level assignment (1-4)

    **Complexity Levels**:
    - Level 1 (Quick Fix): 1-2 files, <30 min, low risk
    - Level 2 (Intermediate): 3-5 files, 1-4 hours, medium risk
    - Level 3 (Complex Feature): 5-15 files, 1-2 days, medium-high risk
    - Level 4 (System Change): 15+ files, 2+ days, high risk

    **Output Format**:
    - Task: [description]
    - Level: [1-4] ([category name])
    - Keywords: [complexity indicators found]
    - Scope: ~[N] files ([component types])
    - Risk: [Low/Medium/High] ([risk factors])
    - Effort: [time estimate]
    - Routing: [Recommended next command]

    Assessor: Analyze task and provide complexity assessment.
    Do NOT create task entries or update memory bank (command handles this).
  `
)
```

**Assessor will**:
1. Analyze task description keywords
2. Estimate scope (may scan codebase if Level 2+)
3. Assess risk factors
4. Calculate effort estimate
5. Assign complexity level (1-4)
6. Recommend routing (→ /cf:code or → /cf:plan)

---

### Step 4: Invoke Product Agent (Requirements Validation)

**ORCHESTRATION PATTERN**: Invoke product agent for acceptance criteria

```markdown
## Invoke Product Agent
Task(
  subagent_type="product",
  description="Requirements Analysis",
  prompt=`
    Generate acceptance criteria for task.

    **Task Description**: [user's description]
    **Complexity Level**: [from assessor]

    **Context**:
    - Product Features: [from productContext.md]
    - User Needs: [from productContext.md]
    - Success Criteria: [from existing features]

    **Analysis Required**:
    1. User value proposition (why this matters)
    2. Acceptance criteria (3-5 specific criteria)
    3. Edge cases to consider
    4. Non-functional requirements (if applicable)

    **Output Format**:
    - User Value: [Why this task matters to users/project]
    - Acceptance Criteria:
      - [ ] [Criterion 1]
      - [ ] [Criterion 2]
      - [ ] [Criterion 3]
    - Edge Cases: [Cases to handle]
    - Non-Functional: [Performance, accessibility, security considerations]

    Product: Analyze requirements and provide acceptance criteria.
    Do NOT create task entries or update memory bank (command handles this).
  `
)
```

**Product will**:
1. Analyze user value
2. Generate acceptance criteria (3-5 items)
3. Identify edge cases
4. Note non-functional requirements

---

### Step 5: Collect Agent Outputs

**Assessor returns**:
- Complexity level (1-4)
- Scope estimate
- Risk assessment
- Effort estimate
- Routing recommendation

**Product returns**:
- User value statement
- Acceptance criteria list
- Edge cases
- Non-functional requirements

---

### Step 6: Generate Task ID

Extract task IDs from tasks.md and generate next sequential ID:

**Pattern**: `TASK-[NNN]` (zero-padded to 3 digits)

**Examples**: TASK-001, TASK-015, TASK-142

**Logic**:
- Find highest existing task ID (e.g., TASK-012)
- Increment by 1 (→ TASK-013)
- Zero-pad to 3 digits

---

### Step 7: Synthesize Using Template

**ORCHESTRATION PATTERN**: Command synthesizes agent outputs using template

**Read template**:
```
.claude/templates/workflow/feature-task-template.md
```

**Apply synthesis logic**:

**Task Header**:
- Task ID: TASK-[NNN]
- Task Name: [Extracted from description]
- Complexity: Level [1-4] (from assessor)
- Status: Pending (or Active for Level 1)
- Priority: P1 (default)
- Created: [YYYY-MM-DD]

**Description**:
- [User's original description]

**User Value** (from product):
- [Why this matters from product agent]

**Acceptance Criteria** (from product):
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]
- [ ] All tests passing
- [ ] Code reviewed

**Complexity Details** (from assessor):
- Scope: ~[N] files ([types])
- Risk: [Low/Medium/High] ([factors])
- Effort: [estimate]

**Edge Cases** (from product):
- [Edge case 1]
- [Edge case 2]

**Non-Functional Requirements** (from product):
- [Requirement 1 if any]

**Prerequisites**: None (or [list if known])

**Tests**: Not started

**Sub-tasks**: [For Level 2+: Note that /cf:plan will break down]

**Blockers**: None

**Notes**: Created by /cf:feature - [routing recommendation]

---

### Step 8: Update Memory Bank

**ORCHESTRATION PATTERN**: Update memory bank files systematically

**Update tasks.md**:

Add to "Pending Tasks" or "Active Tasks" section:

```markdown
### ⏳ TASK-[ID]: [Task Name] (Level [1-4])

**Status**: [Pending or Active]
**Priority**: P1
**Complexity**: Level [1-4]
**Created**: [YYYY-MM-DD]
**Effort Estimate**: [From assessor]

**Description**:
[User's task description]

**User Value**:
[From product agent - why this matters]

**Acceptance Criteria**:
[From product agent - 3-5 criteria with checkboxes]
- [ ] All tests passing
- [ ] Code reviewed

**Complexity Details**:
- Scope: [From assessor]
- Risk: [From assessor]
- Effort: [From assessor]

**Edge Cases**:
[From product agent]

**Non-Functional Requirements**:
[From product agent if any]

**Prerequisites**: None

**Tests**: Not started

**Sub-tasks**: [For Level 2+: Will be created by /cf:plan]

**Blockers**: None

**Notes**: Created by /cf:feature - [routing recommendation from assessor]
```

**Update activeContext.md**:

Add to **Recent Changes**:
```markdown
### [YYYY-MM-DD HH:MM] - Task Created: [Task Name]
**Agent**: Assessor + Product
**Task ID**: TASK-[ID]
**Complexity**: Level [1-4]
**Routing**: [Next command recommendation]
**User Value**: [Brief value statement]
**Next Action**: [/cf:code or /cf:plan command]
```

**If no current focus** (first task or higher priority):
Update "Current Focus" section:
```markdown
### Primary Focus: [Task Name]

**Task**: TASK-[ID]
**Started**: [YYYY-MM-DD]
**Complexity**: Level [1-4]
**Progress**: Not started

**What we're doing**:
[Task description]

**Why it matters**:
[User value from product agent]

**Expected completion**:
[Based on effort estimate from assessor]
```

---

### Step 9: Output Assessment & Routing

**Present synthesis to user**:

**For Level 1 (Quick Fix)**:
```markdown
🎯 TASK CREATED: TASK-[ID]

## Task: [Task Name]

**Complexity**: Level 1 (Quick Fix)
**Effort**: [<30 minutes estimate]

---

### 📋 ASSESSMENT (Assessor)

**Scope**: ~[N] files ([types])
**Risk**: Low ([factors])
**Keywords**: [indicators found]

---

### 🎯 USER VALUE (Product)

**Why This Matters**: [Value statement]

**Acceptance Criteria**:
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] All tests passing
- [ ] Code reviewed

**Edge Cases**: [Cases to handle]

---

### 📊 MEMORY BANK

✓ tasks.md updated (TASK-[ID] created)
✓ activeContext.md updated (task logged)

---

### ⏭️ NEXT STEP

→ **RECOMMENDATION**: Task is straightforward and ready for implementation.

**Proceed with**:
```bash
/cf:code TASK-[ID]
```

This will:
1. testEngineer writes tests (RED phase)
2. Implementation agent writes code (GREEN phase)
3. Tests verified, task marked complete
```

**For Level 2-4 (Requires Planning)**:
```markdown
🎯 TASK CREATED: TASK-[ID]

## Task: [Task Name]

**Complexity**: Level [2-4] ([Intermediate Feature/Complex System])
**Effort**: [estimate]

---

### 📋 ASSESSMENT (Assessor)

**Scope**: ~[N] files ([types])
**Risk**: [Medium/High] ([factors])
**Keywords**: [indicators found]

---

### 🎯 USER VALUE (Product)

**Why This Matters**: [Value statement]

**Acceptance Criteria**:
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]
- [ ] All tests passing
- [ ] Code reviewed

**Edge Cases**: [Cases to handle]

**Non-Functional**: [Requirements if any]

---

### 📊 MEMORY BANK

✓ tasks.md updated (TASK-[ID] created)
✓ activeContext.md updated (task logged)

---

### ⏭️ NEXT STEP

→ **RECOMMENDATION**: This task requires planning before implementation.

**Proceed with**:
```bash
/cf:plan TASK-[ID]
```

Planning will:
1. Architect analyzes technical approach
2. Product validates requirements
3. Task broken into sub-tasks
4. Implementation approach documented

**For complex tasks** (Level 3-4), consider interactive mode:
```bash
/cf:plan TASK-[ID] --interactive
```

This engages Facilitator for iterative refinement and validation.
```

---

## Examples

### Example 1: Simple Task (Level 1)

```
User: /cf:feature fix typo in header component

Claude:
📋 LOADING CONTEXT
- Reading tasks.md (highest task: TASK-003)
- Next ID: TASK-004
- Project: CCFlow development framework

---

🔍 INVOKING AGENTS

**Assessor**: Analyzing complexity...
**Product**: Analyzing requirements...

---

🎯 TASK CREATED: TASK-004

## Task: Fix typo in header component

**Complexity**: Level 1 (Quick Fix)
**Effort**: <15 minutes

---

### 📋 ASSESSMENT (Assessor)

**Scope**: ~1 file (UI component)
**Risk**: Low (isolated change, no breaking changes)
**Keywords**: fix, typo

---

### 🎯 USER VALUE (Product)

**Why This Matters**: Improves UI professionalism and user trust

**Acceptance Criteria**:
- [ ] Typo corrected in header component
- [ ] Visual regression test confirms no layout changes
- [ ] All tests passing
- [ ] Code reviewed

**Edge Cases**: None identified

---

### 📊 MEMORY BANK

✓ tasks.md updated (TASK-004 created)
✓ activeContext.md updated (task logged)

---

### ⏭️ NEXT STEP

→ **RECOMMENDATION**: Task is straightforward and ready for implementation.

**Proceed with**:
```bash
/cf:code TASK-004
```
```

### Example 2: Complex Task (Level 3)

```
User: /cf:feature implement real-time collaborative editing

Claude:
📋 LOADING CONTEXT
- Reading tasks.md (highest task: TASK-015)
- Next ID: TASK-016
- Tech stack: React, Node.js, WebSockets

---

🔍 INVOKING AGENTS

**Assessor**: Analyzing complexity... (scanning codebase)
**Product**: Analyzing requirements...

---

🎯 TASK CREATED: TASK-016

## Task: Implement real-time collaborative editing

**Complexity**: Level 3 (Complex Feature)
**Effort**: 1-2 days

---

### 📋 ASSESSMENT (Assessor)

**Scope**: ~12 files (WebSocket infrastructure, state sync, UI components, middleware)
**Risk**: Medium-High (complex state management, concurrency handling, WebSocket lifecycle)
**Keywords**: implement, real-time, collaborative

---

### 🎯 USER VALUE (Product)

**Why This Matters**: Enables team collaboration, core differentiator for product, significant user value

**Acceptance Criteria**:
- [ ] Multiple users can edit same document simultaneously
- [ ] Changes propagate in real-time (<100ms latency)
- [ ] Conflict resolution handles concurrent edits gracefully
- [ ] User presence indicators show who's editing
- [ ] Offline users can rejoin without data loss
- [ ] All tests passing (unit, integration, E2E)
- [ ] Code reviewed

**Edge Cases**:
- Concurrent edits to same line
- Network interruptions during edit
- User disconnects mid-edit
- Scaling to 10+ simultaneous users

**Non-Functional**:
- Performance: <100ms latency for change propagation
- Scalability: Support 10+ concurrent users per document
- Reliability: No data loss on network interruption

---

### 📊 MEMORY BANK

✓ tasks.md updated (TASK-016 created)
✓ activeContext.md updated (task logged, current focus set)

---

### ⏭️ NEXT STEP

→ **RECOMMENDATION**: This task requires planning before implementation.

**Proceed with**:
```bash
/cf:plan TASK-016 --interactive
```

Interactive planning will:
1. Facilitator guides multi-perspective exploration
2. Architect analyzes WebSocket architecture options
3. Product validates UX requirements
4. Task broken into phased sub-tasks
5. Implementation approach documented

**Alternative** (if requirements are clear):
```bash
/cf:plan TASK-016
```

Standard planning without interactive refinement.
```

---

## Error Handling

### Memory Bank Not Initialized

```
⚠️ Memory Bank Not Initialized

Memory bank not found at: memory-bank/

Run: /cf:init
```

### Empty Task Description

```
❌ Missing Task Description

Usage: /cf:feature [description]

Examples:
/cf:feature fix authentication bug
/cf:feature add user profile page
/cf:feature migrate to React 18
```

---

## Memory Bank Updates

### tasks.md
- New task entry created with synthesized details
- Task ID auto-generated (sequential)
- Complexity level from assessor
- Acceptance criteria from product
- User value documented

### activeContext.md
- Recent change entry added (task creation logged)
- Current focus updated (if appropriate)
- Routing recommendation documented

---

## Orchestration Notes

**Pattern Compliance**:
- ✅ **Context Loading**: Command loads memory bank files for agent context
- ✅ **Agent Invocation**: Command invokes assessor + product agents (parallel possible)
- ✅ **Output Collection**: Command collects complexity assessment + acceptance criteria
- ✅ **Template Synthesis**: Command uses feature-task-template.md for consistent structure
- ✅ **Memory Bank Updates**: Command updates tasks.md + activeContext.md systematically
- ✅ **User Communication**: Command presents structured routing recommendation

**Command Responsibilities**:
- Context loading from memory bank
- Assessor invocation (complexity analysis)
- Product invocation (requirements validation)
- Task ID generation
- Template-based task entry synthesis
- Memory bank updates
- Routing recommendation output

**Agent Responsibilities**:
- **Assessor**: Analyze complexity, estimate scope/effort, assess risk, recommend routing
- **Product**: Define user value, generate acceptance criteria, identify edge cases
- **NO task creation**: Agents analyze only, command synthesizes and creates entries

---

## Related Commands

- `/cf:init` - Initialize before using /cf:feature
- `/cf:sync` - Review memory bank state
- `/cf:plan` - Plan Level 2+ tasks
- `/cf:code` - Implement Level 1 tasks or planned sub-tasks
- `/cf:status` - Quick check on tasks
- `/cf:checkpoint` - Save feature creation work

---

**Command Version**: 2.0 (Command Orchestration Pattern)
**Last Updated**: 2025-11-03 (TASK-003-8)
**Pattern**: Command Orchestration Pattern (systemPatterns.md:409-582)
