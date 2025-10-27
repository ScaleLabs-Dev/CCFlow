# CCFlow System Architecture

Core architectural concepts requiring cross-file understanding.

## 1. Two-Layer Agent System

**Design rationale:** Separation of concerns between workflow orchestration and code implementation

**Workflow Layer** (`.claude/agents/workflow/`):
- **Purpose:** Analyze, plan, coordinate, document
- **Agents:** Assessor, Architect, Product, Facilitator, Documentarian, Reviewer
- **Characteristics:** Tech-stack agnostic, high-level decision making
- **Invoked by:** Commands for coordination tasks

**Implementation Layer** (`.claude/agents/{testing,development,ui}/`):
- **Purpose:** Execute code changes with TDD enforcement
- **Implementation agents:** testEngineer, codeImplementer, uiDeveloper
- **Specialists:** Created on-demand in `specialists/` subdirectories
- **Characteristics:** Tech-stack specific, low-level execution
- **Pattern:** Implementation agents delegate to specialists after 3+ uses

**Key distinction:** Workflow agents plan and decide; implementation agents build and test.

---

## 2. Memory Bank as Single Source of Truth

**Location:** `memory-bank/` directory (created per-project)

**6 Core Files:**

| File | Update Frequency | Primary Owner | Purpose |
|------|------------------|---------------|----------|
| `projectbrief.md` | Rarely | Manual + Documentarian | Immutable scope definition |
| `productContext.md` | Occasionally | Product + Documentarian | Feature specs, user needs |
| `systemPatterns.md` | As patterns emerge | Architect + Documentarian | Architecture, ADRs, patterns |
| `activeContext.md` | Constantly | All agents | Current focus, recent changes |
| `progress.md` | At milestones | Reviewer + Documentarian | Completed work, tech debt |
| `tasks.md` | Per task operation | Assessor + various | Task tracking, status |

**Update Strategy:**
- **Automatic:** Commands update relevant files during execution
- **Explicit:** `/cf:checkpoint` creates formal savepoints across ALL files
- **Consistency:** Documentarian ensures no conflicts between files

**Why this works:** Single source of truth prevents context drift and duplicate state.

---

## 3. Complexity-Based Routing

**4-Level Assessment System:**

```
User request
    ↓
Assessor analyzes: keywords + scope + risk + effort
    ↓
Assigns Level 1-4
    ↓
Routes to appropriate workflow
```

**Level Criteria:**

| Level | Files | Time | Keywords | Routing |
|-------|-------|------|----------|---------|
| 1 | 1-2 | <2h | fix, update, simple | → `/cf:code` |
| 2 | 3-5 | 2-6h | add, create, feature | → `/cf:plan` → `/cf:code` |
| 3 | 5-15 | 1-3d | integrate, system | → `/cf:plan` (auto-interactive) → `/cf:code` |
| 4 | 15+ | 3+d | migrate, architecture | → `/cf:plan` (auto-interactive) → `/cf:creative` → `/cf:code` |

**Auto-Facilitation:**
- Level 3-4 tasks automatically enable Facilitator
- Override with `--skip-facilitation` (not recommended)
- Ensures complex tasks get proper planning and refinement

**High-Complexity Sub-Task Detection:**
- During planning, sub-tasks may be flagged as Level 3+
- Recommendation: Use `/cf:creative` for deep exploration
- Prevents rework through upfront design investment

---

## 4. TDD Enforcement (GREEN Gate)

**Absolute Rule:** Tests MUST pass before task completion

**RED → GREEN → REFACTOR Workflow:**

```
/cf:code TASK-001
    ↓
testEngineer: Write failing tests (RED)
    ↓
Implementation agent: Implement to make tests pass
    ↓
Run tests
    ↓
    ├─ PASS → Update memory bank, mark complete (GREEN gate passed)
    ├─ FAIL → Retry (max 3 attempts)
    └─ Still FAIL → STOP, report blocker
```

**Why enforced:**
- Prevents shipping broken code
- Ensures test coverage
- Documents expected behavior
- Enables confident refactoring

**No exceptions:** Implementation cannot complete with failing tests.

---

## 5. Command Namespace: `/cf:*`

**Design decision:** All commands use `/cf:` prefix

**Benefits:**
- Avoids conflicts with other Claude Code commands
- Clear identification of CCFlow commands
- Consistent user experience

**Command Categories:**
- **Init:** `/cf:init`, `/cf:sync`
- **Core workflow:** `/cf:feature`, `/cf:plan`, `/cf:creative`, `/cf:code`
- **Support:** `/cf:review`, `/cf:checkpoint`, `/cf:ask`, `/cf:context`, `/cf:status`, `/cf:facilitate`
- **Agent management:** `/cf:create-specialist`

**Self-documenting:** Each command file in `.claude/commands/` follows consistent structure.

---

## 6. Facilitator Action Recommendation Pattern

**Used throughout:** All interactive modes follow this pattern

**5-Step Cycle:**
1. Present Current State
2. Identify Gaps/Concerns
3. Ask Clarifying Questions
4. Refine Based on Feedback
5. **Recommend Next Action** (critical - never leave user without clear next step)

**Why effective:**
- Structured exploration prevents aimless discussion
- Gap identification surfaces hidden requirements
- Action recommendations maintain momentum
- No iteration limits - user controls the loop

**Implementation:**
- `Facilitator_defaults_spec.md` contains question templates
- Used in `/cf:init`, `/cf:plan --interactive`, `/cf:facilitate`, `/cf:creative`

---

## 7. Creative Session for Deep Exploration

**Purpose:** Systematic exploration of high-complexity technical challenges

**When to use:**
- Novel problems without established patterns
- Multiple viable solution approaches
- High-risk architectural decisions
- Sub-tasks flagged as Level 3+ during planning

**4-Phase Process:**

```
Phase 1: Problem Deep-Dive
    ↓ (with "think")
Phase 2: Solution Exploration
    ↓ (with "think hard/harder/ultrathink")
Phase 3: Design Refinement
    ↓ (with "think hard")
Phase 4: Validation & Documentation
    ↓ (with "think")
Result: Comprehensive solution design + patterns documented
```

**Extended Thinking Integration:**
- Uses Claude's thinking modes for deeper analysis
- Progressive budget levels based on complexity
- Sequential MCP for structured reasoning

**Duration:** 20-35 minutes (investment prevents hours/days of rework)

**Always interactive:** Facilitator required, cannot skip.

---

## 8. Specialist Delegation Pattern

**Implementation Agent Behavior:**

```
Task assigned to implementation agent (e.g., codeImplementer)
    ↓
Check: Does specialist exist for this domain?
    ↓
    ├─ YES → Delegate to specialist
    └─ NO → Implement directly, track delegation count
        ↓
        Delegation count for domain >= 3?
            ↓
            YES → Recommend specialist creation
```

**Benefits:**
- Start simple (no specialists needed initially)
- Scale as patterns emerge
- Avoid premature optimization
- Natural evolution toward specialized expertise

---

## 9. Memory Bank Synchronization

**Commands that modify state follow pattern:**

```
1. Pre-read relevant files
2. Execute operation
3. Update activeContext.md (always)
4. Update domain-specific files (as needed)
5. Offer checkpoint opportunity
```

**Documentarian ensures:**
- No conflicts between files
- Cross-file consistency
- Complete information preservation
- Checkpoint integrity

**Result:** Memory bank remains accurate and consistent across all operations.

---

## Integration Points

**MCP Servers:**
- **Sequential:** Used in `/cf:creative` for extended thinking and hypothesis testing
- **Context7:** Recommended for library documentation lookup
- **Magic:** Recommended for UI component generation
- **Playwright:** Recommended for browser testing

**Claude Code Features:**
- Custom commands (`.claude/commands/`)
- Sub-agents (`.claude/agents/`)
- File-based memory (memory bank)
- Multi-agent coordination

---

## Quality Principles

**Non-Negotiables:**
1. TDD with GREEN gate (tests must pass)
2. Memory bank as SSOT (no duplicate state)
3. Action Recommendation Pattern (always recommend next action)
4. Two-layer agent architecture (workflow vs implementation)
5. Complexity-based routing (can't skip planning for Level 2-4)

**Extensibility Points:**
1. Create specialists for new tech stacks
2. Add memory bank files for specific needs
3. Custom facilitation templates for domains
4. Additional commands for workflows

---

For implementation details, see [specifications](../specifications/).
For extending the system, see [extending.md](extending.md).
