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

### Orchestration Flow Summary

**Complete execution sequence with conditional logic**:

```
1. Verify Prerequisites
   └─> Check memory-bank/ exists → STOP if missing

2. Load Context
   └─> Read memory bank files (tasks.md, activeContext.md, systemPatterns.md, etc.)
   └─> Extract: task ID, patterns, tech stack

3. Invoke Assessor Agent
   └─> Analyze complexity → Get Level (1-4)
   └─> Output: complexity_level, scope, risk, effort, routing

4. Conditional Architect Invocation
   ┌─ IF complexity_level >= 2:
   │  └─> Invoke Architect Agent
   │  └─> Perform rapid technical pre-analysis (6-8 min)
   │  └─> Output: technical_analysis (integration, data, algorithm, constraints, signals)
   │  └─> Store architect_output for Product
   │
   └─ ELSE (Level 1):
      └─> SKIP Architect
      └─> Set architect_output = null

5. Invoke Product Agent
   ┌─ IF architect_output exists (Level 2+):
   │  └─> Pass technical_analysis to Product
   │  └─> Generate technically-informed requirements
   │
   └─ ELSE (Level 1):
      └─> Standard requirements analysis (no technical context)

   └─> Output: user_value, acceptance_criteria, edge_cases, nfrs

6. Collect Outputs
   └─> assessor_output: complexity, scope, risk, effort
   └─> architect_output: technical_analysis (if Level 2+) OR null (if Level 1)
   └─> product_output: requirements, criteria, edge cases

7. Generate Task ID
   └─> Find highest TASK-NNN from tasks.md
   └─> Increment by 1 → new_task_id

8. Synthesize Using Template
   └─> Read feature-task-template.md
   └─> Populate with agent outputs
   ┌─ IF architect_output exists:
   │  └─> Fill Technical Pre-Analysis section
   │
   └─ ELSE:
      └─> Leave Technical Pre-Analysis section empty (add note: "Level 1 - no pre-analysis needed")

9. Update Memory Bank
   └─> Append to tasks.md
   └─> Update activeContext.md

10. Output Routing Recommendation
    └─> Based on assessor routing: /cf:code (L1) or /cf:plan (L2+)
```

**Key Conditional Points**:
- **Step 4**: Architect invoked ONLY if `complexity_level >= 2`
- **Step 5**: Product receives Architect context ONLY if Level 2+
- **Step 8**: Template Technical Pre-Analysis populated ONLY if Level 2+

---

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

### Step 4: Conditional Architect Pre-Analysis (Level 2+ Only)

**ORCHESTRATION PATTERN**: Conditionally invoke architect for technical pre-analysis

**Pattern**: Conditional Expert Pre-Analysis Pattern (systemPatterns.md:585-716)

**Conditional Logic**:
```
IF complexity_level >= 2:
  INVOKE Architect for rapid technical pre-analysis
  Product receives Architect analysis → technically-informed questions
ELSE (Level 1):
  SKIP Architect (preserve simplicity)
  Product proceeds with standard requirements analysis
```

**Why Conditional**:
- **Level 1 tasks** (quick fixes): Simple scope, no hidden complexity → skip Architect
- **Level 2+ tasks** (features/changes): May have hidden complexity (integration, data, algorithm) → invoke Architect to catch issues before implementation

---

#### 4.1: Architect Invocation (Level 2+ Only)

**ONLY invoke if Assessor returned Level 2, 3, or 4**

```markdown
## Invoke Architect Agent (Technical Pre-Analysis)
Task(
  subagent_type="architect",
  description="Rapid Technical Pre-Analysis",
  prompt=`
    Perform rapid technical pre-analysis to identify hidden complexity.

    **Task Description**: [user's description]
    **Complexity Level**: [Level 2/3/4 from assessor]
    **Scope Estimate**: [~N files from assessor]

    **Context**:
    - Project: [from projectbrief.md if available]
    - Tech Stack: [from CLAUDE.md]
    - Existing Patterns: [from systemPatterns.md]
    - Current Architecture: [from systemPatterns.md]

    **Analysis Type**: RAPID PRE-ANALYSIS (6-8 minutes)
    This is NOT comprehensive planning. Focus on identifying WHAT complexity exists, not HOW to solve.

    **Analysis Required**:

    1. **Integration Analysis**
       - Which existing components does this feature touch?
       - What are the integration points and dependencies?
       - Read systemPatterns.md to identify affected patterns

    2. **Data Modeling Assessment**
       - What entities/relationships are involved?
       - What schema changes or data structures are needed?
       - Any data migration or transformation concerns?

    3. **Algorithmic Complexity Scan**
       - Are there computational complexity concerns? (e.g., O(n²), real-time constraints)
       - Any complex business logic or calculation requirements?
       - Performance-sensitive operations?

    4. **Technical Constraints Check**
       - Platform limits or technical boundaries?
       - Security requirements or compliance needs?
       - External API constraints or rate limits?

    5. **Dependency Analysis**
       - External libraries or services required?
       - Internal component dependencies?
       - Version compatibility or upgrade needs?

    6. **Hidden Complexity Signals**
       - Flag areas requiring deeper specification
       - Prioritize signals: HIGH (must specify), MEDIUM (should specify), LOW (nice to have)
       - Mark assumptions clearly (if context insufficient for certainty)

    **Time Budget**: 6-8 minutes (rapid identification, not solution design)

    **Output Format**:

    ## 🏗️ TECHNICAL PRE-ANALYSIS

    ### Integration Concerns
    **Affected Components**: [List components this touches]
    **Integration Points**: [External/internal systems]
    **Pattern Impact**: [Existing patterns affected]

    ### Data Modeling Needs
    **Entities**: [Data structures required]
    **Relationships**: [How data connects]
    **Schema Changes**: [Database/state changes if any]

    ### Algorithmic Complexity
    **Computational Concerns**: [Performance considerations]
    **Business Logic**: [Complex calculation/logic areas]

    ### Technical Constraints
    **Platform Limits**: [Constraints to work within]
    **Security/Compliance**: [Requirements to meet]
    **External Dependencies**: [APIs, services, libraries]

    ### Hidden Complexity Signals
    **🔴 HIGH Priority** (must specify before implementation):
    - [Signal 1]: [Why this needs specification]

    **🟡 MEDIUM Priority** (should specify):
    - [Signal 1]: [Why this should be specified]

    **🟢 LOW Priority** (optional specification):
    - [Signal 1]: [Nice to have but not critical]

    ### Assumptions & Uncertainties
    [Mark any assumptions made due to limited context]

    ---

    Architect: Perform rapid technical pre-analysis following above format.
    Focus on IDENTIFICATION of complexity, not SOLUTION design.
    Do NOT create task entries or update memory bank (command handles this).
  `
)
```

**Architect will** (6-8 minutes):
1. Read systemPatterns.md to understand existing architecture
2. Identify which components feature touches (integration analysis)
3. Assess data modeling needs (entities, relationships, schema)
4. Scan for algorithmic complexity concerns
5. Check technical constraints (platform, security, dependencies)
6. Flag hidden complexity signals (prioritized HIGH/MEDIUM/LOW)
7. Mark assumptions if context insufficient

**Architect Output**:
- Integration concerns and affected components
- Data modeling needs
- Algorithmic complexity areas
- Technical constraints
- Hidden complexity signals (prioritized)
- Assumptions marked

---

### Step 5: Invoke Product Agent (Requirements Validation)

**ORCHESTRATION PATTERN**: Invoke product agent for acceptance criteria

**Integration Note**: If Architect pre-analysis was performed (Level 2+), Product agent receives Architect's output to generate technically-informed questions.

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

    [CONDITIONAL BLOCK - Include ONLY if complexity_level >= 2]
    ═══════════════════════════════════════════════════════════
    **Technical Pre-Analysis from Architect**:

    [Paste complete Architect output here, including all sections:]

    ### Integration Concerns
    [Architect's integration analysis]

    ### Data Modeling Needs
    [Architect's data modeling analysis]

    ### Algorithmic Complexity
    [Architect's algorithmic analysis]

    ### Technical Constraints
    [Architect's constraints analysis]

    ### Hidden Complexity Signals
    [Architect's prioritized signals: 🔴 HIGH, 🟡 MEDIUM, 🟢 LOW]

    ### Assumptions & Uncertainties
    [Architect's assumptions]

    **Integration Instructions**: Use the above technical analysis to:
    1. Generate technically-informed acceptance criteria addressing HIGH/MEDIUM signals
    2. Validate user expectations against identified technical constraints
    3. Include edge cases related to integration/data/algorithm concerns
    4. Specify NFRs related to constraint/complexity findings
    ═══════════════════════════════════════════════════════════
    [END CONDITIONAL BLOCK]

    **Analysis Required**:
    1. User value proposition (why this matters to users/project)

    2. Acceptance criteria (3-5 specific, testable criteria)
       - Base criteria for core functionality
       - IF Technical Pre-Analysis provided (Level 2+):
         * Ensure criteria address Architect's HIGH/MEDIUM complexity signals
         * Validate expectations against identified technical constraints
         * Add criteria for integration points, data modeling, or algorithmic concerns

    3. Edge cases to consider
       - Standard edge cases (empty input, invalid data, etc.)
       - IF Technical Pre-Analysis provided (Level 2+):
         * Include edge cases from Architect's integration analysis
         * Include edge cases from Architect's data/algorithm concerns

    4. Non-functional requirements (if applicable)
       - IF Technical Pre-Analysis provided (Level 2+):
         * Performance requirements from Architect's algorithmic analysis
         * Security/compliance from Architect's constraints
         * Scalability from Architect's platform limits

    **Output Format**:
    - User Value: [Why this task matters to users/project]

    - Acceptance Criteria:
      - [ ] [Core functionality criterion 1]
      - [ ] [Core functionality criterion 2]
      - [ ] [Core functionality criterion 3]
      - IF Level 2+: [ ] [Technical criterion addressing Architect HIGH signal]
      - IF Level 2+: [ ] [Technical criterion addressing Architect MEDIUM signal]

    - Edge Cases: [Cases to handle]
      - IF Level 2+: [Edge cases from Architect's technical analysis]

    - Non-Functional: [Performance, accessibility, security considerations]
      - IF Level 2+: [NFRs addressing Architect's constraints/complexity]

    - IF Level 2+: Technical Validation Notes: [How requirements address Architect's findings]

    Product: Analyze requirements and provide acceptance criteria.
    [Level 2+] Generate technically-informed questions based on Architect's pre-analysis.
    Do NOT create task entries or update memory bank (command handles this).
  `
)
```

**Product will**:
1. Analyze user value
2. Generate acceptance criteria (3-5 items)
   - [Level 2+] Technically-informed based on Architect findings
3. Identify edge cases
   - [Level 2+] Including technical edge cases from Architect analysis
4. Note non-functional requirements
   - [Level 2+] Including NFRs related to Architect's constraints/complexity
5. [Level 2+] Validate requirements address Architect's hidden complexity signals

---

### Step 6: Collect Agent Outputs

**Assessor returns**:
- Complexity level (1-4)
- Scope estimate
- Risk assessment
- Effort estimate
- Routing recommendation

**Architect returns** (Level 2+ only):
- Integration concerns and affected components
- Data modeling needs (entities, relationships, schema)
- Algorithmic complexity areas
- Technical constraints (platform, security, dependencies)
- Hidden complexity signals (prioritized HIGH/MEDIUM/LOW)
- Assumptions and uncertainties

**Product returns**:
- User value statement
- Acceptance criteria list (3-5 items)
  - [Level 2+] Technically-informed based on Architect analysis
- Edge cases
  - [Level 2+] Including technical edge cases
- Non-functional requirements
  - [Level 2+] Including Architect-identified NFRs
- [Level 2+] Technical validation notes

---

### Step 7: Generate Task ID

Extract task IDs from tasks.md and generate next sequential ID:

**Pattern**: `TASK-[NNN]` (zero-padded to 3 digits)

**Examples**: TASK-001, TASK-015, TASK-142

**Logic**:
- Find highest existing task ID (e.g., TASK-012)
- Increment by 1 (→ TASK-013)
- Zero-pad to 3 digits

---

### Step 8: Synthesize Using Template

**ORCHESTRATION PATTERN**: Command synthesizes agent outputs using template

**Read template**:
```
.claude/templates/workflow/feature-task-template.md
```

**Synthesis Strategy** (Command Orchestration Pattern):

Command synthesizes outputs from multiple agents:
- **Assessor** → complexity, scope, risk, effort
- **Architect** (Level 2+ only) → technical analysis (integration, data, algorithm, constraints, signals)
- **Product** → user requirements (value, criteria, edge cases, NFRs)

**Synthesis Logic**:

1. **Compute has_technical_analysis flag**:
   ```
   has_technical_analysis = (complexity_level >= 2 AND architect_output exists)
   ```

2. **Conditional section rendering**:
   - IF has_technical_analysis == TRUE:
     * Fill Technical Pre-Analysis section with all 6 Architect subsections
     * **Synthesize Acceptance Criteria**: Combine Product criteria + Architect HIGH/MEDIUM signals
     * **Synthesize Edge Cases**: Combine Product edge cases + Architect technical edge cases
     * **Synthesize NFRs**: Combine Product NFRs + Architect constraints/complexity
   - IF has_technical_analysis == FALSE:
     * Leave Technical Pre-Analysis section empty with note
     * Use Product criteria only (no synthesis needed)
     * Use Product edge cases only
     * Use Product NFRs only

**Key Pattern**: Command performs synthesis, agents provide independent outputs (no cross-agent dependencies)

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

**[CONDITIONAL] Technical Pre-Analysis**:
- IF has_technical_analysis:
  ```
  ## Technical Pre-Analysis

  *This section is populated by Architect agent for **Level 2+ features only**.*

  **From Architect Agent**:

  ### Integration Concerns
  **Affected Components**: [from architect]
  **Integration Points**: [from architect]
  **Pattern Impact**: [from architect]

  ### Data Modeling Needs
  **Entities**: [from architect]
  **Relationships**: [from architect]
  **Schema Changes**: [from architect]

  ### Algorithmic Complexity
  **Computational Concerns**: [from architect]
  **Business Logic**: [from architect]

  ### Technical Constraints
  **Platform Limits**: [from architect]
  **Security/Compliance**: [from architect]
  **External Dependencies**: [from architect]

  ### Hidden Complexity Signals
  **🔴 HIGH Priority** (must specify before implementation):
  - [from architect]

  **🟡 MEDIUM Priority** (should specify):
  - [from architect]

  **🟢 LOW Priority** (optional specification):
  - [from architect]

  ### Assumptions & Uncertainties
  [from architect]
  ```
- ELSE (Level 1):
  ```
  ## Technical Pre-Analysis

  *This section is empty - the feature was assessed as Level 1 (Simple) and does not require technical pre-analysis.*
  ```

**Acceptance Criteria** (synthesized by command):
- [ ] [Product criterion 1]
- [ ] [Product criterion 2]
- [ ] [Product criterion 3]
- IF has_technical_analysis:
  - [ ] [Synthesized: Product criterion addressing Architect HIGH signal - e.g., "API handles concurrent user sessions correctly" combines Product user requirement + Architect concurrency concern]
  - [ ] [Synthesized: Product criterion addressing Architect MEDIUM signal - e.g., "Error messages are user-friendly" combines Product UX requirement + Architect error handling pattern]
- [ ] All tests passing
- [ ] Code reviewed

**Complexity Details** (from assessor):
- Scope: ~[N] files ([types])
- Risk: [Low/Medium/High] ([factors])
- Effort: [estimate]

**Edge Cases** (synthesized by command):
- [Product edge case 1]
- [Product edge case 2]
- IF has_technical_analysis:
  - [Synthesized: Technical edge case combining Product user scenario + Architect concern - e.g., "User submits form during database migration" combines Product user action + Architect data concern]

**Non-Functional Requirements** (synthesized by command):
- IF has_technical_analysis:
  - [Synthesized: NFR from Architect constraints - e.g., "Response time <200ms under 100 concurrent users" from Architect performance constraint]
  - [Synthesized: NFR from Product UX requirement - e.g., "Mobile responsive design" from Product accessibility requirement]
- ELSE:
  - [Product NFRs only - e.g., "Keyboard accessible", "WCAG AA compliant"]

**Prerequisites**: None (or [list if known])

**Tests**: Not started

**Sub-tasks**: [For Level 2+: Note that /cf:plan will break down]

**Blockers**: None

**Notes**:
- Created by /cf:feature
- IF has_technical_analysis: Architect pre-analysis performed (Level 2+)
- ELSE: Direct to implementation (Level 1)
- Routing: [routing recommendation]

---

### Step 9: Update Memory Bank

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

**[CONDITIONAL] Technical Pre-Analysis** (Level 2+ only):

**Integration Concerns**:
- Affected Components: [from architect]
- Integration Points: [from architect]
- Pattern Impact: [from architect]

**Data Modeling Needs**:
- Entities: [from architect]
- Relationships: [from architect]
- Schema Changes: [from architect]

**Algorithmic Complexity**:
- Computational Concerns: [from architect]
- Business Logic: [from architect]

**Technical Constraints**:
- Platform Limits: [from architect]
- Security/Compliance: [from architect]
- External Dependencies: [from architect]

**Hidden Complexity Signals**:
- 🔴 HIGH: [must specify items]
- 🟡 MEDIUM: [should specify items]
- 🟢 LOW: [optional items]

**Acceptance Criteria**:
[From product agent - 3-5 criteria with checkboxes]
- [ ] [Level 2+] [Technical criterion addressing Architect concern]
- [ ] All tests passing
- [ ] Code reviewed

**Complexity Details**:
- Scope: [From assessor]
- Risk: [From assessor]
- Effort: [From assessor]

**Edge Cases**:
[From product agent]
- [Level 2+] [Technical edge case from Architect]

**Non-Functional Requirements**:
[From product agent if any]
- [Level 2+] [NFR from Architect]

**Prerequisites**: None

**Tests**: Not started

**Sub-tasks**: [For Level 2+: Will be created by /cf:plan]

**Blockers**: None

**Notes**:
- Created by /cf:feature
- [Level 2+] Architect pre-analysis performed
- Routing: [routing recommendation from assessor]
```

**Update activeContext.md**:

Add to **Recent Changes**:
```markdown
### [YYYY-MM-DD HH:MM] - Task Created: [Task Name]
**Agent**: Assessor + [Level 2+: Architect +] Product
**Task ID**: TASK-[ID]
**Complexity**: Level [1-4]
**Routing**: [Next command recommendation]
**User Value**: [Brief value statement]
**[Level 2+] Technical Analysis**: Architect pre-analysis performed
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

### Step 10: Output Assessment & Routing

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

### 🏗️ TECHNICAL PRE-ANALYSIS (Architect)

**Integration Concerns**:
- Affected Components: [List]
- Integration Points: [Systems]
- Pattern Impact: [Patterns affected]

**Data Modeling Needs**:
- Entities: [Data structures]
- Relationships: [Connections]
- Schema Changes: [If any]

**Algorithmic Complexity**:
- Computational Concerns: [Performance considerations]
- Business Logic: [Complex areas]

**Technical Constraints**:
- Platform Limits: [Constraints]
- Security/Compliance: [Requirements]
- External Dependencies: [APIs, libraries]

**Hidden Complexity Signals**:
- 🔴 HIGH: [Must specify before implementation]
- 🟡 MEDIUM: [Should specify]
- 🟢 LOW: [Optional]

---

### 🎯 USER VALUE (Product)

**Why This Matters**: [Value statement]

**Acceptance Criteria**:
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]
- [ ] [Technical criterion addressing Architect concern]
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

### Example 2: Level 2+ Task with Architect Pre-Analysis

For detailed examples demonstrating Architect pre-analysis for Level 2+ features, see:

**`.claude/references/examples/cf-feature-examples.md`**

Examples include:
- **Example 1**: Level 3 Complex Feature (real-time collaborative editing) - Full integration + data + algorithm analysis
- **Example 2**: Integration-Heavy (dashboard export) - 4-component integration analysis
- **Example 3**: Data Structure (team workspaces) - Entity-relationship modeling and migration
- **Example 4**: Algorithmic (smart scheduling) - Computational complexity and algorithm selection

Each example shows:
1. Assessor detecting Level 2+ complexity
2. Architect performing rapid 6-8 minute pre-analysis (integration, data, algorithm, constraints, hidden complexity signals)
3. Product receiving Architect output and generating technically-informed acceptance criteria and edge cases

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
- [Level 2+] Technical pre-analysis from architect
- Acceptance criteria from product (technically-informed for L2+)
- User value documented

### activeContext.md
- Recent change entry added (task creation logged)
- Current focus updated (if appropriate)
- Routing recommendation documented
- [Level 2+] Architect pre-analysis noted

---

## Orchestration Notes

**Pattern Compliance**:
- ✅ **Context Loading**: Command loads memory bank files for agent context
- ✅ **Agent Invocation**: Command invokes assessor + [conditional architect] + product agents
- ✅ **Conditional Logic**: L1 skips Architect, L2+ invokes Architect for pre-analysis
- ✅ **Output Collection**: Command collects complexity + [technical analysis] + requirements
- ✅ **Template Synthesis**: Command uses feature-task-template.md for consistent structure
- ✅ **Memory Bank Updates**: Command updates tasks.md + activeContext.md systematically
- ✅ **User Communication**: Command presents structured routing recommendation

**Command Responsibilities**:
- Context loading from memory bank
- Assessor invocation (complexity analysis)
- **[NEW] Conditional Architect invocation** (Level 2+ only - technical pre-analysis)
- Product invocation (requirements validation with Architect context if L2+)
- Task ID generation
- Template-based task entry synthesis (conditional Architect section for L2+)
- Memory bank updates
- Routing recommendation output

**Agent Responsibilities**:
- **Assessor**: Analyze complexity, estimate scope/effort, assess risk, recommend routing
- **Architect** (Level 2+ only): Rapid technical pre-analysis (6-8 min) - identify integration, data, algorithm, constraint concerns; flag hidden complexity signals
- **Product**: Define user value, generate acceptance criteria, identify edge cases
  - [Level 2+] Generate technically-informed questions based on Architect's findings
  - [Level 2+] Validate requirements address Architect's hidden complexity signals
- **NO task creation**: Agents analyze only, command synthesizes and creates entries

**Conditional Expert Pre-Analysis Pattern**:
- **Pattern**: systemPatterns.md:585-716
- **Trigger**: Complexity Level >= 2
- **Purpose**: Catch hidden complexity (integration, data, algorithm, constraints) before implementation
- **Integration**: Architect output feeds into Product analysis → technically-informed requirements
- **Benefits**: Reduces mid-implementation "stop and spec" pauses, improves specification completeness
- **Trade-off**: 30-60 second overhead for L2+ features (acceptable for quality improvement)

---

## Related Commands

- `/cf:init` - Initialize before using /cf:feature
- `/cf:sync` - Review memory bank state
- `/cf:plan` - Plan Level 2+ tasks
- `/cf:code` - Implement Level 1 tasks or planned sub-tasks
- `/cf:status` - Quick check on tasks
- `/cf:checkpoint` - Save feature creation work

---

**Command Version**: 2.1 (Command Orchestration + Conditional Expert Pre-Analysis)
**Last Updated**: 2025-11-04 (TASK-004-1)
**Patterns**:
- Command Orchestration Pattern (systemPatterns.md:409-582)
- Conditional Expert Pre-Analysis Pattern (systemPatterns.md:585-716)
