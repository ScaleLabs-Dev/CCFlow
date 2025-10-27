# CCFlow Agent Reference

Understanding the 9 specialized agents in CCFlow's two-layer architecture.

## Architecture Overview

**Workflow Layer** (`.claude/agents/workflow/`):
- Orchestrate, analyze, document
- 6 agents: Assessor, Architect, Product, Documentarian, Reviewer, Facilitator

**Implementation Layer** (`.claude/agents/{testing,development,ui}/`):
- Execute code changes
- 3 implementation agents: testEngineer, codeImplementer, uiDeveloper
- Implementation agents delegate to specialists (created on-demand)

---

## Workflow Agents

### 🎯 Assessor

**Responsibilities:**
- Analyze task complexity (4-level system)
- Scan codebase to estimate scope
- Evaluate risk factors
- Recommend workflow routing

**Activated by:** `/cf:feature`

**Output:** Complexity assessment with routing recommendation

**Example:**
```
Level: 3 (Intermediate Feature)
Scope: ~8 files
Risk: Medium
→ RECOMMENDATION: Use /cf:plan TASK-001
```

---

### 🏗️ Architect

**Responsibilities:**
- Design system architecture
- Make technical trade-off decisions
- Define component relationships
- Identify and document patterns

**Activated by:** `/cf:plan`, `/cf:creative`, `/cf:ask architect`

**Primary files:** `systemPatterns.md`, `CLAUDE.md` (tech stack reference)

**Output:** Technical implementation plans with architecture decisions

---

### 🎨 Product

**Responsibilities:**
- Analyze user requirements
- Define feature specifications
- Establish success criteria
- Prioritize features (must/should/could have)

**Activated by:** `/cf:plan`, `/cf:creative`, `/cf:init`, `/cf:ask product`

**Primary files:** `productContext.md`, `projectbrief.md`

**Output:** User-focused requirements and UX considerations

---

### 📝 Documentarian

**Responsibilities:**
- Maintain memory bank accuracy
- Ensure cross-file consistency
- Create checkpoint summaries
- Preserve knowledge and decisions

**Activated by:** `/cf:checkpoint`, `/cf:review`

**Primary files:** ALL (particularly `activeContext.md`, `progress.md`)

**Output:** Updated memory bank files, checkpoint entries

---

### 🔍 Reviewer

**Responsibilities:**
- Assess code quality
- Evaluate progress against goals
- Identify technical debt
- Suggest improvements

**Activated by:** `/cf:review`

**Primary files:** `progress.md`, `systemPatterns.md`

**Output:** Quality assessment with improvement recommendations

---

### 🔄 Facilitator

**Responsibilities:**
- Guide interactive refinement (Action Recommendation Pattern)
- Identify gaps and ambiguities
- Ask targeted clarifying questions
- Synthesize feedback into refined outputs
- **Always recommend next action**

**Activated by:**
- Automatically for Level 3-4 planning
- `--interactive` flag on commands
- `/cf:facilitate` command

**Primary files:** Context-dependent (all files)

**Output:** Refined proposals with clear next action

**Key pattern:**
1. Present current state
2. Identify gaps
3. Ask questions
4. Refine based on feedback
5. Recommend next action

---

## Implementation Agents

### ⚗️ testEngineer

**Responsibilities:**
- Coordinate TDD workflow (RED → GREEN → REFACTOR)
- Write failing tests FIRST
- Enforce GREEN gate (tests must pass)
- Delegate to testing specialists

**Activated by:** `/cf:code` (always, first step)

**Primary files:** `systemPatterns.md`, `activeContext.md`

**Output:** Test suites, coverage reports

**GREEN Gate:**
- Tests must pass before task completion
- Retries up to 3 times
- If still failing → STOP and report blocker

---

### 💻 codeImplementer

**Responsibilities:**
- Coordinate backend and business logic implementation
- Follow established patterns
- Delegate to development specialists
- Ensure code quality

**Activated by:** `/cf:code` (after tests are written)

**Primary files:** `systemPatterns.md`, `activeContext.md`, `CLAUDE.md`

**Delegates to:**
- Database specialists
- API specialists
- Business logic specialists
- Backend framework specialists

---

### 🎨 uiDeveloper

**Responsibilities:**
- Coordinate UI and frontend implementation
- Ensure accessibility and responsiveness
- Delegate to UI specialists
- Follow component patterns

**Activated by:** `/cf:code` (for frontend tasks)

**Primary files:** `systemPatterns.md`, `activeContext.md`, `CLAUDE.md`

**Delegates to:**
- Component specialists
- Styling specialists
- Animation specialists
- Frontend framework specialists

---

## Specialist Creation

**When to create:**
After 3+ delegations from a implementation agent to the same domain

**How to create:**
```bash
/cf:create-specialist database --type development --name databaseSpecialist
```

**Specialists live in:**
- `.claude/agents/testing/specialists/`
- `.claude/agents/development/specialists/`
- `.claude/agents/ui/specialists/`

**Example specialists:**
- `databaseSpecialist` (ORM, queries, migrations)
- `apiIntegrationSpecialist` (REST, GraphQL integration tests)
- `chartSpecialist` (Data visualization components)
- `animationSpecialist` (UI animations and transitions)

---

## Agent Coordination Patterns

### Planning (Level 3-4):
```
Assessor → Architect + Product + Facilitator → tasks.md update
```

### Creative Session:
```
Facilitator + Architect + Product + Sequential MCP → systemPatterns.md update
```

### Implementation:
```
testEngineer (writes tests) → Implementation agent (implements) → Specialist (if needed) → GREEN gate
```

### Quality Review:
```
Reviewer → Documentarian → memory bank updates
```

---

For detailed agent processes and output formats, see agent files in `.claude/agents/`.
