# CCFlow Command Reference

Complete reference for all 12 `/cf:*` commands.

## Initialization Commands

### /cf:init [project-name]

**Purpose:** Bootstrap CCFlow memory bank and guided project brief creation

**Syntax:**
```bash
/cf:init MyProject
/cf:init MyProject --quick  # Skip guided brief, create stubs
```

**What it does:**
1. Creates `memory-bank/` directory with 6 core files
2. Runs guided project brief creation (Facilitator + Product + Architect)
3. Creates project foundation (10-20 minutes investment)

**When to use:** Once per project, at the very beginning

---

### /cf:sync

**Purpose:** Read-only summary of current memory bank state

**Syntax:**
```bash
/cf:sync
```

**Output:**
- Project status
- Current focus
- Recent changes
- Next planned steps
- Gaps or inconsistencies

**When to use:** To understand current project state without making changes

---

## Core Workflow Commands

### /cf:feature [description]

**Purpose:** Entry point for all new work - analyzes complexity and routes appropriately

**Syntax:**
```bash
/cf:feature "add user authentication"
/cf:feature "fix login button styling"
```

**What it does:**
1. Assessor agent analyzes complexity (Level 1-4)
2. Creates task entry in `tasks.md`
3. Updates `activeContext.md`
4. Recommends next command based on complexity

**Routing:**
- Level 1 → `/cf:code TASK-ID`
- Level 2-4 → `/cf:plan TASK-ID`

---

### /cf:plan TASK-[ID]

**Purpose:** Create implementation plan by breaking down complex tasks

**Syntax:**
```bash
/cf:plan TASK-001
/cf:plan TASK-001 --interactive     # Manual interactive mode
/cf:plan TASK-001 --skip-facilitation  # Override auto-facilitation
```

**What it does:**
1. Architect designs technical approach
2. Product defines requirements
3. **Level 3-4**: Facilitator auto-enabled for collaborative refinement
4. Creates sub-tasks in `tasks.md`
5. May flag high-complexity sub-tasks for `/cf:creative`

**When to use:** Required for Level 2-4 tasks before implementation

---

### /cf:creative TASK-[ID]|[topic]

**Purpose:** Deep exploration for high-complexity technical challenges

**Syntax:**
```bash
/cf:creative TASK-042-3
/cf:creative "distributed cache synchronization"
```

**4-Phase Process:**
1. Problem Deep-Dive (with "think")
2. Solution Exploration (with "think hard/harder/ultrathink")
3. Design Refinement (with "think hard")
4. Validation & Documentation (with "think")

**When to use:**
- Novel technical challenges without established patterns
- High-risk architectural decisions
- Complex algorithm/data structure design
- Sub-tasks flagged during `/cf:plan` as high complexity

**Duration:** 20-35 minutes (worth investment to prevent rework)

**Always interactive** - cannot skip Facilitator

---

### /cf:code TASK-[ID]

**Purpose:** TDD implementation with GREEN gate enforcement

**Syntax:**
```bash
/cf:code TASK-001
/cf:code TASK-001-2  # Sub-task
```

**TDD Workflow:**
1. testEngineer writes failing tests (RED)
2. Hub agent implements to make tests pass (GREEN)
3. GREEN gate: Tests MUST pass
4. Updates memory bank on completion

**When to use:**
- Level 1 tasks (direct after `/cf:feature`)
- Level 2-4 sub-tasks (after `/cf:plan`)

---

## Support Commands

### /cf:review [task-id|all]

**Purpose:** Quality assessment and technical debt identification

**Syntax:**
```bash
/cf:review TASK-001
/cf:review all
```

**What it analyzes:**
- Code quality
- Progress against goals
- Technical debt
- Improvement recommendations

**When to use:**
- After completing tasks
- Weekly for `all` review
- Before marking major features complete

---

### /cf:checkpoint [--message "..."]

**Purpose:** Save current state across all memory bank files

**Syntax:**
```bash
/cf:checkpoint
/cf:checkpoint --message "OAuth migration complete"
```

**What it does:**
- Documentarian reviews all 6 memory bank files
- Creates checkpoint entry in `progress.md`
- Ensures cross-file consistency
- Captures key learnings and decisions

**When to use:**
- Every 30-60 minutes
- After completing significant work
- Before risky operations
- End of day

---

### /cf:ask [question]

**Purpose:** Semantic search across memory bank

**Syntax:**
```bash
/cf:ask "What patterns exist for authentication?"
/cf:ask "What's the status of the API integration?"
```

**Searches:** All memory bank files for relevant context

**When to use:** To find information in project context

---

### /cf:context [--full]

**Purpose:** Load current work context

**Syntax:**
```bash
/cf:context
/cf:context --full  # Load all memory bank files
```

**When to use:**
- Start of session
- After interruptions
- When resuming work

---

### /cf:status [--filter ...]

**Purpose:** Quick task overview

**Syntax:**
```bash
/cf:status
/cf:status --filter active
/cf:status --filter blocked
```

**Shows:**
- Active tasks
- Blocked tasks
- Recent completions
- Priority tasks

**When to use:** To quickly orient on what's active

---

### /cf:facilitate [topic] [--mode ...]

**Purpose:** Interactive refinement and collaborative exploration

**Syntax:**
```bash
/cf:facilitate "notification system" --mode explore
/cf:facilitate TASK-042 --mode refine
/cf:facilitate TASK-035 --mode validate
```

**Modes:**
- `explore`: Open-ended discovery, ambiguous requirements
- `refine` (default): Improve existing plans, fill gaps
- `validate`: Pre-implementation check, catch assumptions

**When to use:**
- Exploring new ideas
- Refining existing plans
- Validating before implementation

---

## Agent Management

### /cf:create-specialist [domain] --type [type] --name [name]

**Purpose:** Create domain-specific specialist agents

**Syntax:**
```bash
/cf:create-specialist database --type development --name databaseSpecialist
/cf:create-specialist data-visualization --type ui --name chartSpecialist
/cf:create-specialist api-integration --type testing --name apiTestSpecialist
```

**Types:**
- `development`: Business logic, backend
- `ui`: Frontend, components
- `testing`: Test strategies, quality

**When to use:** After 3+ delegations to same domain from hub agents

---

## Command Cheat Sheet

### Common Workflows

**Simple task (Level 1):**
```bash
/cf:feature "fix styling" → /cf:code TASK-001
```

**Complex feature (Level 3):**
```bash
/cf:feature "order management" → /cf:plan TASK-002 → /cf:code TASK-002-1 → /cf:checkpoint
```

**With creative exploration:**
```bash
/cf:plan TASK-003 → /cf:creative TASK-003-2 → /cf:code TASK-003-2
```

**Daily routine:**
```bash
/cf:context → /cf:status → [work] → /cf:checkpoint (regularly)
```

---

For detailed usage examples and error handling, see the command files in `.claude/commands/`.
