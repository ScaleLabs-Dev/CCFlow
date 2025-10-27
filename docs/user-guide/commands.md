# CCFlow Command Reference

Complete reference for all 15 `/cf:*` commands.

## Initialization Commands

### /cf:init [project-name]

**Purpose:** Bootstrap CCFlow memory bank with auto-import from existing project docs

**Syntax:**
```bash
/cf:init MyProject                    # Auto-detect (import or fresh)
/cf:init MyProject --quick            # Skip guided brief, create stubs
/cf:init MyProject --force-fresh      # Ignore existing docs, start fresh
```

**What it does:**

**Phase 0: Discovery** (Auto-detection)
- Scans for README.md, CLAUDE.md, package.json, code structure
- Parses content for project information
- If found: Offers to import existing documentation
- If not found: Proceeds with fresh initialization

**Import Mode** (if docs detected and user accepts):
1. Pre-populates memory bank from discovered content
2. Validates imported information with user (5-10 minutes)
3. Fills gaps through guided questions
4. Creates complete project foundation

**Fresh Mode** (new projects or --force-fresh):
1. Creates `memory-bank/` directory with 6 core files
2. Runs guided project brief creation (10-20 minutes)
3. Facilitator + Product + Architect guide you through requirements

**Import Sources:**
- README.md → Executive Summary, Features, Problem Statement
- CLAUDE.md → Tech Stack, Constraints, Patterns
- package.json → Dependencies, Framework detection
- Code structure (src/, components/, api/) → Architecture style

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

### /cf:git

**Purpose:** Create focused git commits with intelligent message generation

**Syntax:**
```bash
/cf:git                          # Interactive: analyze and suggest message
/cf:git -m "commit message"      # Quick commit with custom message
/cf:git --all                    # Stage all changes before committing
/cf:git --staged                 # Commit only staged files
/cf:git --no-update              # Skip memory bank update
```

**What it does:**
1. Analyzes git changes (staged/unstaged/untracked files)
2. Detects sensitive files (.env, credentials, keys) and blocks if found
3. Warns if on main/master branch (suggests feature branch)
4. Generates intelligent commit message based on changes (or uses custom message)
5. Follows project's commit message convention (auto-detected)
6. Creates git commit
7. Updates `activeContext.md` Recent Changes (unless --no-update)

**Key Features:**
- **Safety checks**: Blocks sensitive files, warns about main/master branch
- **Smart messages**: Analyzes changes, follows project conventions
- **Memory integration**: Updates activeContext.md with commit info
- **Flexible staging**: Interactive, --all, or --staged modes
- **Standalone mode**: Works without memory bank (git-only)

**vs /cf:checkpoint:**
- `/cf:git` = VERSION CONTROL (git commits, code history)
- `/cf:checkpoint` = PROJECT MEMORY (documentation state, milestones)
- Different purposes, complementary use

**When to use:**
- After implementing features (`/cf:code` completion)
- Incremental commits during development
- End of session (commit work in progress)
- Quick fixes and updates

**Examples:**
```bash
# After feature implementation
/cf:code TASK-005
/cf:git -m "feat(auth): implement JWT token authentication"

# Interactive mode (AI suggests message)
/cf:git
# Shows changes, suggests message, asks for approval

# Bulk commit at end of session
/cf:git --all -m "refactor: simplify error handling logic"

# Quick fix without memory update
/cf:git -m "fix: typo in login button" --no-update
```

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
2. Implementation agent implements to make tests pass (GREEN)
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

### /cf:configure-team [--quick|--template NAME|--custom]

**Purpose:** Configure stack-specific implementation team with core agents and specialists

**Syntax:**
```bash
/cf:configure-team                          # Interactive with auto-detection
/cf:configure-team --quick                  # Use auto-detected stack
/cf:configure-team --template web/react-express  # Direct template selection
/cf:configure-team --custom                 # Facilitator-guided custom team
```

**What it does:**

Replaces generic fallback agents with **stack-specific teams** tailored to your technology stack. Provides:

1. **Core Agents**: Framework-aware implementation agents (e.g., expressBackend, reactFrontend, jestTester)
2. **Specialists**: Domain experts for specific technologies (e.g., sequelizeDb, jwtAuth, reactPerformance)
3. **Routing Configuration**: Keyword-based intelligent delegation system
4. **Memory Bank Integration**: Team configuration documented in systemPatterns.md

**Architecture Models:**

```
GENERIC AGENTS (Default after /cf:init)
├── codeImplementer, testEngineer, uiDeveloper
├── NO specialists (handle everything directly)
├── Framework-agnostic patterns
└── Good for simple projects or prototypes

STACK-SPECIFIC TEAMS (After /cf:configure-team)
├── Core agents (framework-aware)
├── Specialists (domain experts)
├── routing.md (keyword-based delegation)
└── Optimal for production projects with defined stack
```

**When to use:**
- After `/cf:init` when you have a defined tech stack
- When generic agents lack stack-specific knowledge
- When you want framework-aware TDD patterns
- When project grows beyond simple full-stack needs

**Process:**

**Phase 1: Detection** (unless --template specified)
1. Analyzes package.json, systemPatterns.md, directory structure
2. Detects frameworks: React, Express, Jest, etc.
3. Matches to template: web/react-express, mobile/react-native, ai/langchain-python
4. Presents recommendation with confidence score
5. User confirms or chooses alternative

**Phase 2: Installation**
1. Copies core agents to `.claude/agents/[domain]/[stack]/core/`
2. Copies specialists to `.claude/agents/[domain]/[stack]/specialists/`
3. Creates routing.md with keyword mappings
4. Updates systemPatterns.md with team configuration
5. Validates all agent files and routing references

**Phase 3: Verification**
- Verifies agent files exist and have valid YAML frontmatter
- Confirms routing.md references only existing agents
- Reports success with agent capabilities summary

**Available Templates:**
- `web/react-express`: React frontend + Express backend + Jest testing
- `mobile/react-native`: React Native mobile apps (iOS/Android)
- `ai/langchain-python`: LangChain AI applications with Python

**Custom Team Creation:**
- `--custom` flag engages Facilitator for guided team design
- Answers questions about tech stack and domains
- Creates custom core agents and specialists
- Uses AgentBuilder for token-efficient agents

**Examples:**

```bash
# Auto-detect and configure
/cf:configure-team
# Detects React+Express → Recommends web/react-express → User confirms

# Quick mode (no prompts)
/cf:configure-team --quick
# Auto-detects and installs without confirmation

# Direct template
/cf:configure-team --template web/react-express
# Installs React+Express team immediately

# Custom team for unique stack
/cf:configure-team --custom
# Facilitator guides through custom agent creation
```

**After Configuration:**

Generic agents remain as fallbacks. Routing priority:
1. Stack-specific core agent (if keywords match)
2. Stack-specific specialist (if core agent delegates)
3. Generic agent fallback (if no match)

**Related:** After configuring team, use `/cf:create-specialist` to add more specialists to the team.

---

### /cf:create-specialist [domain] --type [type] --name [name]

**Purpose:** Add domain-specific specialist to configured stack-specific team

**Prerequisites:** Must run `/cf:configure-team` first to set up stack-specific team

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

**When to use:** After 3+ delegations to same domain from stack-specific core agents

**Important:** This command only works with stack-specific teams. Generic agents do NOT delegate to specialists - they handle everything directly. If you haven't configured a team yet, run `/cf:configure-team` first.

---

## Meta-Agent System Commands

### /cf:refine-agent [agent-name] [--report-only] [--interactive]

**Purpose:** Optimize existing agents for token efficiency and clarity

**Syntax:**
```bash
/cf:refine-agent assessor                    # Refine and update agent
/cf:refine-agent testEngineer --report-only  # Analysis only, no changes
/cf:refine-agent facilitator --interactive   # Interactive refinement with validation
```

**What it does:**
1. AgentBuilder analyzes existing agent structure and content
2. Identifies verbosity issues (excessive examples, redundancy, tutorial-style)
3. Optimizes for token efficiency (target: 500-1500 tokens based on type)
4. Validates against quality rubric (structure, content, efficiency, effectiveness)
5. Writes refined agent file or generates report

**Agent Types Supported:**
- **Workflow agents** (700-1300 tokens): Assessor, Architect, Product, Facilitator, Documentarian, Reviewer
- **Core agents** (800-1200 tokens): codeImplementer, testEngineer, uiDeveloper
- **Specialists** (400-800 tokens): Domain-specific agents in `specialists/` subdirs
- **Generic agents** (600-900 tokens): Stack-agnostic fallback agents

**Optimization Principles:**
- Structure over content (clear structure beats verbose explanation)
- Patterns over examples (teach reasoning, not procedures)
- Reference over duplicate (point to CLAUDE.md/systemPatterns.md)
- ONE comprehensive example maximum

**When to use:**
- Agent exceeds token budget for its type
- Verbosity detected (multiple examples, tutorial content, redundancy)
- Performance optimization needed
- Systematic refinement across all agents

**Examples:**
```bash
# Refine verbose workflow agent
/cf:refine-agent facilitator

# Check specialist without changing
/cf:refine-agent jwtAuth --report-only

# Interactive refinement with validation
/cf:refine-agent architect --interactive
```

---

### /cf:refine-command [command-name] [--report-only] [--interactive]

**Purpose:** Optimize command clarity, completeness, and maintainability

**Syntax:**
```bash
/cf:refine-command feature                   # Refine and update command
/cf:refine-command code --report-only        # Analysis only, no changes
/cf:refine-command plan --interactive        # Interactive refinement with validation
```

**What it does:**
1. CommandBuilder analyzes existing command structure and content
2. Identifies issues (missing sections, unclear decision trees, insufficient examples)
3. Optimizes for clarity and completeness (target: 800-5000 tokens by complexity)
4. Validates against quality rubric (structure, content, efficiency, effectiveness)
5. Writes refined command file or generates report

**Command Complexity Levels:**
- **Simple** (800-1500 tokens): sync, status, ask, context
- **Moderate** (1500-3000 tokens): code, plan, review, checkpoint
- **Complex** (3000-5000 tokens): init, creative, configure-team

**Essential Sections** (always required):
- YAML frontmatter (description, allowed-tools, argument-hint)
- Usage (command syntax with examples)
- Purpose (what it does and why)
- Process (step-by-step execution with decision points)
- Examples (2-3 scenarios showing different use cases)
- Error Handling (common errors with actionable recovery)

**Conditional Sections** (only when meaningful):
- Parameters (if command accepts positional arguments)
- Flags (if optional flags exist)
- Prerequisites (ONLY if specific beyond memory bank initialization)
- Memory Bank Updates (ONLY if command modifies files)
- Related Commands (ONLY if strong integration points)

**When to use:**
- Command missing essential sections
- Unclear process or decision logic
- Insufficient examples (<2 scenarios)
- Incomplete error handling
- Redundant Prerequisites section
- Verbosity (>20% over token budget)

**Examples:**
```bash
# Refine command with missing sections
/cf:refine-command checkpoint

# Check command without changing
/cf:refine-command init --report-only

# Interactive refinement with validation
/cf:refine-command creative --interactive
```

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

**Meta-agent system maintenance:**
```bash
/cf:refine-agent [name] --report-only  # Check agent quality
/cf:refine-command [name] --report-only  # Check command quality
```

---

For detailed usage examples and error handling, see the command files in `.claude/commands/`.
