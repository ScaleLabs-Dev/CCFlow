---
description: "Create implementation plan with Architect + Product agents, breaking down complex tasks"
allowed-tools: ['Read', 'Edit', 'Task']
argument-hint: "[task-id] [--interactive] [--skip-facilitation]"
---

# Command: /cf:plan

## Usage

```
/cf:plan [task-id]
/cf:plan [task-id] --interactive
```

## Parameters

- `[task-id]`: **Required** - Task ID to plan (e.g., TASK-003)

## Flags

- `--interactive`: Engage Facilitator agent for collaborative planning refinement (auto-enabled for Level 3-4)
- `--skip-facilitation`: Skip Facilitator for Level 3-4 tasks (not recommended)

---

## Purpose

**Command Orchestration Pattern**: Coordinate Architect + Product + Facilitator agents to create comprehensive implementation plans through:
1. Parallel agent invocation (Architect + Product simultaneously)
2. Facilitator-based interactive refinement (for Level 3-4 or --interactive)
3. Template-driven synthesis (using checkpoint-template.md concepts)
4. Memory bank updates (tasks.md, activeContext.md, systemPatterns.md)

**Pattern**: Command Orchestration Pattern (systemPatterns.md:409-582)

---

## Prerequisites

- **Memory bank initialized**: Run `/cf:init` first
- **Task exists**: Use `/cf:feature [description]` to create task first
- **Task requires planning**: Level 2-4 complexity (Level 1 can skip directly to `/cf:code`)

---

## Process

### Step 1: Verify Prerequisites

**Check memory bank exists**:
```
If NOT EXISTS:
⚠️ Memory bank not initialized. Run: /cf:init
```

**Check task exists in tasks.md**:
```
If NOT FOUND:
❌ Task [task-id] not found in tasks.md

Available tasks:
- TASK-001: [name]
- TASK-002: [name]

Create new task with: /cf:feature [description]
```

**Check task complexity**:
```
If Level 1:
⚠️ Task [task-id] is Level 1 (Quick Fix)

Level 1 tasks don't require planning.

Proceed directly with: /cf:code [task-id]
```

---

### Step 2: Load Context

**Read memory bank files** to understand current state:

```markdown
Read memory-bank/tasks.md
Read memory-bank/activeContext.md
Read memory-bank/systemPatterns.md
Read memory-bank/productContext.md
Read memory-bank/projectbrief.md
Read CLAUDE.md
```

**Extract task information**:
- Task description and complexity
- Acceptance criteria
- Existing context/notes
- Related patterns from systemPatterns.md
- Tech stack from CLAUDE.md

---

### Step 3: Invoke Agents in Parallel

**ORCHESTRATION PATTERN**: Invoke agents concurrently for performance

**Parallel Agent Invocation**:

```markdown
## Invoke Architect Agent
Task(
  subagent_type="architect",
  description="Technical Analysis for Planning",
  prompt=`
    Analyze TASK-[ID] technical implementation approach.

    **Context**:
    - Task: [description]
    - Complexity: Level [2-4]
    - Patterns: [from systemPatterns.md]
    - Tech Stack: [from CLAUDE.md]

    **Provide**:
    1. Component architecture design
    2. Data flow analysis
    3. Technical decisions with trade-offs
    4. Patterns to follow
    5. Risks and mitigation

    Focus on technical design. Do NOT synthesize with other perspectives.
  `
)

## Invoke Product Agent (PARALLEL)
Task(
  subagent_type="product",
  description="Requirements Analysis for Planning",
  prompt=`
    Analyze TASK-[ID] user requirements and UX considerations.

    **Context**:
    - Task: [description]
    - Complexity: Level [2-4]
    - Product Context: [from productContext.md]

    **Provide**:
    1. Functional requirements (must/should/could have)
    2. Non-functional requirements
    3. UX considerations
    4. Success criteria
    5. Edge cases

    Focus on user needs. Do NOT synthesize with other perspectives.
  `
)
```

**IMPORTANT**: Both Task() calls sent in same message for parallel execution.

---

### Step 4: Determine Interaction Mode

**Auto-enable Facilitator for Level 3-4 tasks**:

```
If complexity is Level 3 OR Level 4:
  If --skip-facilitation flag NOT present:
    ℹ️ Task [task-id] is Level [3/4] - Facilitator required for complex planning

    Setting --interactive mode automatically.

    Why: Complex tasks benefit from collaborative refinement to:
    - Clarify scope and identify hidden requirements
    - Validate technical approach and trade-offs
    - Break down work into manageable sub-tasks
    - Identify high-complexity sub-tasks needing /cf:creative

    To skip Facilitator (not recommended): add --skip-facilitation flag

    interactive_mode = true

  Else (--skip-facilitation present):
    ⚠️ Skipping Facilitator for Level [3/4] task (user override)

    Proceeding with standard planning mode.

    interactive_mode = false
```

---

### Step 5a: Invoke Facilitator (If Interactive Mode)

**If interactive_mode is true**:

```markdown
## Invoke Facilitator Agent
Task(
  subagent_type="facilitator",
  description="Interactive Planning Refinement",
  prompt=`
    Generate clarifying questions for TASK-[ID] planning refinement.

    **Context**:
    - Architect Analysis: [output from Step 3]
    - Product Analysis: [output from Step 3]
    - Task Complexity: Level [3/4]

    **Generate questions about**:
    1. Scope clarity (in/out of scope features)
    2. Technical approach alternatives
    3. User flow validation
    4. Phasing strategy
    5. Risk mitigation
    6. Sub-task complexity assessment

    Output ONLY questions. Do NOT provide recommendations or synthesis.
  `
)
```

**Facilitator generates questions** → Present to user → Collect answers

**Update context with user answers**:
- Document decisions made
- Update scope/requirements based on feedback
- Flag any high-complexity sub-tasks for /cf:creative

**Iterative Refinement**:
- If user responses reveal gaps, Facilitator asks follow-up questions
- Continue until user confirms plan is ready
- Maximum 3 refinement cycles (prevent analysis paralysis)

---

### Step 5b: Skip Facilitation (If Standard Mode)

**If interactive_mode is false**:

```markdown
ℹ️ Standard planning mode (no interactive refinement)

Proceeding with Architect + Product synthesis.
```

---

### Step 6: Synthesize Plan

**ORCHESTRATION PATTERN**: Command synthesizes agent outputs using structured format

**Synthesis Process**:
1. Collect Architect output (technical analysis)
2. Collect Product output (requirements analysis)
3. Collect Facilitator output (user decisions if interactive)
4. Apply synthesis logic to create integrated plan
5. Structure using template format

**Plan Synthesis Output**:

```markdown
## 📋 IMPLEMENTATION PLAN: [Task Name]

**Task ID**: TASK-[ID]
**Complexity**: Level [2-4]
**Estimated Effort**: [X hours]
**Planning Mode**: [Standard / Interactive with Facilitator]

---

### 🎨 PRODUCT PERSPECTIVE

[Synthesize Product agent output]

**User Need**: [What user problem this solves]
**User Value**: [Why this matters to users]

**Requirements**:

**Must Have**:
- [Core requirement 1 from Product]
- [Core requirement 2 from Product]

**Should Have**:
- [Nice-to-have from Product]

**UX Considerations**:
- [Usability requirement from Product]
- [Accessibility requirement from Product]

**Success Criteria**:
- ✅ [Measurable outcome 1 from Product]
- ✅ [Measurable outcome 2 from Product]

---

### 🏗️ ARCHITECT PERSPECTIVE

[Synthesize Architect agent output]

**Technical Approach**: [High-level design strategy from Architect]

**Component Architecture**:
[Components from Architect with purposes, responsibilities, dependencies]

**Data Flow**:
```
[Data flow diagram from Architect]
```

**Technical Decisions**:
[Decisions from Architect with options, rationale, trade-offs]

**Patterns to Follow**:
- [Patterns from Architect referencing systemPatterns.md]

**Risks & Mitigation**:
- [Risks from Architect with mitigation strategies]

---

### 🔄 USER DECISIONS (If Interactive)

[If Facilitator was used, document user decisions]

**Decisions Made During Planning**:
1. **[Decision Topic]**: [What was decided and why]
2. **[Decision Topic]**: [What was decided and why]

**Scope Clarifications**:
- In Scope: [Features confirmed in scope]
- Out of Scope: [Features deferred]

---

### 🔨 IMPLEMENTATION STEPS

[Synthesize sub-task breakdown from Architect + Product]

**Phase 1: [Phase Name]**
1. **[Step Name]** (Sub-task 1, Level [1-2])
   - Actions: [What to do]
   - Files: [Files to modify/create]
   - Tests: [What to test]
   - Effort: [Time estimate]

2. **[Step Name]** (Sub-task 2, Level [1-2])
   - Actions: [What to do]
   - Files: [Files to modify/create]
   - Tests: [What to test]
   - Effort: [Time estimate]
   - Prerequisites: TASK-[ID]-1

**Phase 2: [Phase Name]**
3. **[Step Name]** (Sub-task 3, Level [1-2])
   - Actions: [What to do]
   - Files: [Files to modify/create]
   - Tests: [What to test]
   - Effort: [Time estimate]

**High-Complexity Sub-Task Detection**:

If any sub-task appears to be Level 3+ during breakdown:

```
⚠️ Sub-task [N] appears to be high complexity

**Indicators**: [novel problem/multiple unknowns/high risk/significant trade-offs]

**Recommendation**: Use /cf:creative TASK-[ID]-[N] before implementation

Why: Deep exploration will identify best approach and prevent rework.
```

---

### 📊 SUMMARY

**Total Sub-tasks**: [N]
**Estimated Total Effort**: [Sum of sub-task efforts]
**Recommended Approach**: [Implementation strategy]
**Interactive Refinement**: [Yes/No - if Facilitator was used]

**Sub-tasks Created in tasks.md**:
- TASK-[ID]-1: [Sub-task name] (Level [1-2])
- TASK-[ID]-2: [Sub-task name] (Level [1-2])
- TASK-[ID]-3: [Sub-task name] (Level [1-2])

---

→ NEXT: Proceed with first sub-task

   /cf:code TASK-[ID]-1

   OR review/refine plan with:
   /cf:facilitate plan-review
```

---

### Step 7: Update Memory Bank

**ORCHESTRATION PATTERN**: Command updates memory bank with synthesized plan

**Update tasks.md**:

Create sub-task entries for each implementation step:

```markdown
### 🟢 TASK-[ID]: [Original Task Name] (Level [2-4])

**Status**: Active → Planning Complete
**Priority**: [P0/P1/P2]
**Complexity**: Level [2-4]
**Assigned**: Planning complete, ready for implementation
**Created**: [Original date]
**Planned**: [YYYY-MM-DD]
**Target**: [Estimated completion based on effort]

**Description**:
[Original description]

**Implementation Plan**: ✅ Complete (see below)

**Planning Approach**: [Standard / Interactive with Facilitator]

**Sub-tasks**:
- [ ] TASK-[ID]-1: [Sub-task name] (Level [1-2]) - Pending
  - Effort: [X hours]
  - Description: [What this subtask does]
  - Files: [files]
  - Tests: [test scope]

- [ ] TASK-[ID]-2: [Sub-task name] (Level [1-2]) - Pending
  - Effort: [X hours]
  - Description: [What this subtask does]
  - Files: [files]
  - Tests: [test scope]
  - Prerequisites: TASK-[ID]-1

**Total Estimated Effort**: [Sum of sub-task efforts]

**Key Decisions** (if interactive):
- [Decision 1]
- [Decision 2]

**Notes**:
Implementation plan created [YYYY-MM-DD] using [Architect + Product + Facilitator]
Plan includes [N] sub-tasks across [N] phases
[Any high-complexity sub-tasks flagged for /cf:creative]
```

**Update activeContext.md**:

Add entry to **Recent Changes**:

```markdown
### [YYYY-MM-DD HH:MM] - Implementation Plan Created: [Task Name]
**Agents**: Architect + Product [+ Facilitator if interactive]
**Task ID**: TASK-[ID]
**Planning Mode**: [Standard / Interactive]
**Impact**: Task broken into [N] sub-tasks, ready for implementation
**Sub-tasks**: TASK-[ID]-1 through TASK-[ID]-[N]
**Pattern Used**: Command Orchestration Pattern
**Next Action**: /cf:code TASK-[ID]-1
```

Update **Immediate Next Steps** if high priority:

```markdown
**Immediate Next Steps**:
1. **TASK-[ID]-1: [Sub-task name]** (Priority: P0)
   - Action: [Brief description]
   - Prerequisite: None
   - Estimated Effort: [X hours]
   - Why now: [Rationale]
```

**Update systemPatterns.md** (if new patterns identified):

Add to **Active Patterns** section:

```markdown
### [New Pattern Name]

**Category**: [Architectural/Design/etc]
**Added**: YYYY-MM-DD (from TASK-[ID] planning)

**Context**: [When/where this applies]

**Problem**: [What it solves]

**Solution**: [How the pattern works]

**Benefits**:
- ✅ [Benefit 1]

**Trade-offs**:
- ⚠️ [Trade-off 1]

**Examples in Codebase**: To be added during TASK-[ID] implementation

**Related Patterns**: [Similar patterns]
```

---

## Examples

[Examples remain the same as before - showing the OUTPUT format, not the orchestration internals]

### Example 1: Level 2 Task (Standard Mode)

```
User: /cf:plan TASK-005

Claude:
[Loads context from memory bank...]
[Invokes Architect + Product agents in parallel...]
[Synthesizes plan using template structure...]

## 📋 IMPLEMENTATION PLAN: Add Search Functionality to Navbar

[Full plan output as before...]

✓ Updated tasks.md with 4 sub-tasks
✓ Updated activeContext.md

→ NEXT: Proceed with first sub-task
   /cf:code TASK-005-1
```

### Example 2: Level 3 Task (Interactive Mode)

```
User: /cf:plan TASK-006

Claude:
[Loads context...]
[Invokes Architect + Product in parallel...]

ℹ️ Task TASK-006 is Level 3 - Facilitator required for complex planning
Setting --interactive mode automatically.

[Invokes Facilitator agent...]

🔄 INTERACTIVE PLANNING: Migrate Authentication to OAuth 2.0

Facilitator: I've reviewed the initial analysis from Architect and Product. Let me ask some clarifying questions:

**Q1: OAuth Provider**
[Question details...]

[User responds...]

Facilitator: [Follow-up based on response...]

[Iterative refinement continues...]

## ✅ FINAL PLAN

[Complete refined plan incorporating user decisions...]

✓ Updated tasks.md with 8 sub-tasks
✓ Updated activeContext.md
✓ User decisions documented

→ RECOMMENDATION: Plan is comprehensive and ready
   Begin with: /cf:code TASK-006-1
```

---

## Error Handling

[Error handling remains the same as before]

---

## Memory Bank Updates

### tasks.md
- Parent task marked as "Planning Complete"
- Sub-tasks created with IDs TASK-[ID]-1, TASK-[ID]-2, etc.
- Effort estimates added
- Dependencies noted
- User decisions documented (if interactive)

### activeContext.md
- Recent change entry added
- Immediate next steps updated if high priority
- Pattern usage documented

### systemPatterns.md (if applicable)
- New patterns documented
- ADR reference added if architectural decision made

---

## Orchestration Notes

**Pattern Compliance**:
- ✅ **Parallel Agent Invocation**: Architect + Product invoked simultaneously
- ✅ **Facilitator as Question Broker**: Facilitator only generates questions, never synthesizes
- ✅ **Template-Driven Synthesis**: Command uses structured template format for consistency
- ✅ **Memory Bank Updates**: Systematic updates to tasks.md, activeContext.md, systemPatterns.md
- ✅ **Read-Only Agents**: Workflow agents only Read/Grep/Glob, no Write/Edit

**Command Responsibilities**:
- Context loading from memory bank
- Parallel agent invocation (architect + product)
- Conditional facilitator engagement (interactive mode)
- Synthesis of agent outputs into integrated plan
- Memory bank updates with synthesized results

**Agent Responsibilities**:
- **Architect**: Technical analysis only, no synthesis
- **Product**: Requirements analysis only, no synthesis
- **Facilitator**: Questions only, no analysis or synthesis

---

## Related Commands

- `/cf:feature` - Create task before planning
- `/cf:code` - Implement sub-tasks after planning
- `/cf:facilitate` - Refine plan interactively
- `/cf:creative` - Deep exploration for high-complexity sub-tasks
- `/cf:checkpoint` - Save planning work before implementation

---

**Command Version**: 2.0 (Orchestration Pattern)
**Last Updated**: 2025-10-29
**Pattern**: Command Orchestration Pattern (systemPatterns.md:409-582)
