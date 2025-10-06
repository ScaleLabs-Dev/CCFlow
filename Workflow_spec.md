# Custom Claude Workflow Specification

## Document Purpose
This specification defines a custom workflow system for Claude, inspired by Cline's memory bank, adapted for solo coding projects with command-driven interaction and specialized sub-agents.

**Companion Document**: This specification works together with the **Code Command & Agent System Specification**, which provides detailed implementation guidance for the `/code` command, TDD workflow, and Claude Code sub-agent system.

## Design Philosophy
- **Explicit Control**: Commands give clear control over workflow stages
- **Specialized Expertise**: Sub-agents provide focused perspectives
- **Flexible Documentation**: Memory bank grows with project needs
- **Solo-Optimized**: Streamlined for individual developer workflows
- **Progressive Enhancement**: Start simple, add complexity as needed

---

## Memory Bank Structure

### File Hierarchy
Following Cline's proven structure with modifications for solo work:

```
memory-bank/
├── projectbrief.md       # Foundation: scope, goals, requirements
├── productContext.md     # Why and how: problems, solutions, UX
├── systemPatterns.md     # Architecture: patterns, decisions, structure  
├── techContext.md        # Stack: technologies, setup, constraints
├── activeContext.md      # Now: current focus, recent changes, next steps
├── progress.md           # Status: what works, what's left, issues
└── [additional]/         # Optional: features, integrations, etc.
```

### Core Files (Required)

#### 1. projectbrief.md
- **Purpose**: Foundation document, source of truth for scope
- **Contains**: Core requirements, goals, constraints, success criteria
- **Created**: At project initialization
- **Updates**: Rarely (only when scope fundamentally changes)

#### 2. productContext.md  
- **Purpose**: The "why" and "what" of the project
- **Contains**: Problems solved, user needs, feature descriptions, UX goals
- **Created**: At project initialization
- **Updates**: When adding major features or pivoting direction

#### 3. systemPatterns.md
- **Purpose**: Technical architecture and design decisions
- **Contains**: System architecture, patterns, component relationships, critical paths, ADR index
- **Created**: After initial architecture decisions
- **Updates**: When architectural patterns emerge or change

#### 4. activeContext.md
- **Purpose**: Current working context (most frequently updated)
- **Contains**: Current focus, recent changes, immediate next steps, active decisions, learnings
- **Created**: At project initialization
- **Updates**: Frequently during development

#### 5. progress.md
- **Purpose**: Project status and evolution
- **Contains**: Completed features, remaining work, known issues, decision history
- **Created**: At project initialization
- **Updates**: After significant milestones or checkpoint commands

#### 6. tasks.md
- **Purpose**: Single source of truth for all task tracking
- **Contains**: Active tasks with status, priority, complexity, sub-tasks, blockers
- **Created**: At project initialization
- **Updates**: Every command that changes task status

### External Reference

#### CLAUDE.md
- **Purpose**: Technical stack and development setup (managed by Claude Code)
- **Contains**: Technologies, dependencies, setup instructions, environment configuration
- **Created**: By Claude Code initialization
- **Updates**: When technical stack changes
- **Note**: This file is referenced by memory bank but not part of memory bank structure

### Additional Context
Create additional files/folders when needed:
- Feature specifications
- API documentation  
- Testing strategies
- Integration guides
- Deployment procedures

---

## Commands System

### Command Syntax
Commands follow the pattern: `/command [required] [optional]`

### Core Commands

#### `/cf:feature [description]`
**Purpose**: Entry point for new work - analyzes complexity and routes appropriately
**Behavior**:
- Engage Assessor agent
- Analyze task complexity (Level 1-4)
- Update tasks.md with new task entry
- Update activeContext.md with task context
- Route based on complexity:
  - **Level 1**: "Task assessed as Level 1. Ready to implement. Proceed with `/cf:code [task]`"
  - **Level 2-4**: "Task assessed as Level [X]. Planning required. Please use `/cf:plan [task]`"

**Output**: Complexity assessment + routing recommendation + memory bank updates

**Example**:
```
User: /cf:feature add user authentication
Claude:
🎯 COMPLEXITY ASSESSMENT
─────────────────────────
Task: Add user authentication
Level: 3 (Intermediate Feature)
Keywords: authentication, security, user management
Scope: ~8 files (backend routes, middleware, frontend components)
Risk: Medium (security implications, session management)
Effort: 4-6 hours

✓ Updated tasks.md with new task entry
✓ Updated activeContext.md with task context

→ RECOMMENDATION: This task requires planning.
   Please use: /cf:plan authentication
```

---
**Purpose**: Initialize memory bank for new project  
**Behavior**:
- Create memory-bank directory structure
- Generate projectbrief.md with guided questions
- Create stub files for other core documents
- Set up initial activeContext.md

**Output**: Confirmation + next steps

**Interactive Mode**: `/cf:init [project-name] --interactive`
- Engages Facilitator agent
- Iteratively builds project brief with user feedback
- Uses Product + Architect agents for content
- Refines until user approves

---

#### `/cf:sync`
**Purpose**: Read and summarize current memory bank state  
**Behavior**:
- Load all core memory bank files
- Provide concise summary of:
  - Project status
  - Current focus
  - Recent changes
  - Next planned steps
- Identify any gaps or inconsistencies

**Output**: Status summary + readiness confirmation

---

#### `/cf:plan [feature|task]`
**Purpose**: Enter planning mode for a feature or task
**Behavior**:
- Load relevant memory bank context
- Engage Architect + Product sub-agents
- Break down feature into steps
- Identify technical considerations
- Propose implementation approach

**Output**: Structured plan with steps and considerations

**Interactive Mode**: `/cf:plan [feature] --interactive`
- Engages Facilitator agent
- Presents draft plan for feedback
- Identifies ambiguities and asks clarifying questions
- Refines plan iteratively based on input
- Validates against existing patterns

---

#### `/cf:code [task]`
**Purpose**: Execute coding task with full context
**Behavior**:
- Load relevant memory bank files
- Engage Developer sub-agent
- Implement the requested task
- Follow established patterns from systemPatterns.md
- Update activeContext.md with changes

**Output**: Code implementation + context update

---

#### `/cf:review`
**Purpose**: Review recent changes and update memory bank
**Behavior**:
- Engage Reviewer sub-agent
- Analyze recent changes since last review
- Update relevant memory bank files:
  - activeContext.md (always)
  - progress.md (if milestone reached)
  - systemPatterns.md (if patterns emerged)
- Identify technical debt or improvements

**Output**: Review summary + updated documentation

---

#### `/cf:checkpoint [message]`
**Purpose**: Save current state with summary
**Behavior**:
- Engage Documentarian sub-agent
- Update ALL memory bank files
- Add checkpoint entry to progress.md
- Summarize current state
- Document key learnings and decisions

**Output**: Checkpoint summary + state snapshot

**Interactive Mode**: `/cf:checkpoint [message] --interactive`
- Engages Facilitator agent
- Reviews proposed updates to each file
- Asks for clarification on ambiguous changes
- Ensures nothing important is missed
- Validates consistency across files

---

#### `/cf:ask [agent] [question]`
**Purpose**: Query a specific sub-agent
**Behavior**:
- Engage specified sub-agent
- Load relevant context for that agent's domain
- Provide focused answer from that perspective

**Agents**: assessor, architect, product, documentarian, reviewer, facilitator

**Output**: Agent-specific response

---

#### `/cf:context [file|topic]`
**Purpose**: Focus on specific memory bank file or topic
**Behavior**:
- Load specified file or search for topic across files
- Display relevant content
- Allow focused discussion/updates

**Output**: Focused context view

---

#### `/cf:status`
**Purpose**: Quick project status check
**Behavior**:
- Read activeContext.md and progress.md
- Provide brief status update
- List immediate next actions

**Output**: Concise status report

---

#### `/cf:facilitate [topic]`
**Purpose**: Start an interactive refinement session on any topic
**Behavior**:
- Engage Facilitator agent
- Load relevant context
- Guide collaborative exploration and refinement
- Can work with any other agent as needed

**Output**: Refined understanding and documented decisions

---

## Complexity Assessment System

### Complexity Levels

Claude evaluates tasks across four dimensions to determine complexity:

**Assessment Criteria:**
1. **Keywords** - Presence of complexity indicators (refactor, migrate, integrate, system, architecture)
2. **Scope Impact** - Number of files/components affected
3. **Risk Level** - Potential for breaking changes or data loss
4. **Implementation Effort** - Estimated time and technical challenge

**Complexity Levels:**

#### Level 1: Quick Fix
- **Characteristics**: Bug fix, small update, single file change
- **Keywords**: fix, bug, typo, update, adjust
- **Scope**: 1-3 files
- **Risk**: Low (isolated change)
- **Effort**: < 30 minutes
- **Action**: Proceed directly to implementation

#### Level 2: Simple Enhancement  
- **Characteristics**: Small feature, straightforward addition
- **Keywords**: add, create, simple feature
- **Scope**: 3-5 files
- **Risk**: Low-Medium (affects one module)
- **Effort**: 30 minutes - 2 hours
- **Action**: Requires `/plan` mode

#### Level 3: Intermediate Feature
- **Characteristics**: Multi-component feature, moderate complexity
- **Keywords**: feature, integrate, refactor section
- **Scope**: 5-10 files  
- **Risk**: Medium (cross-module changes)
- **Effort**: 2-8 hours
- **Action**: Requires `/plan` mode, may need `/creative` for complex sub-steps

#### Level 4: Complex System
- **Characteristics**: Major system change, architectural impact
- **Keywords**: architecture, migrate, system refactor, infrastructure
- **Scope**: 10+ files or entire system
- **Risk**: High (breaking changes possible)
- **Effort**: 8+ hours or multi-day
- **Action**: Requires `/plan` → `/creative` → careful implementation

### Complexity Assessment Agent

A specialized sub-agent evaluates task complexity:

**Assessment Process:**
```
1. Parse task description for complexity keywords
2. Estimate scope based on known codebase structure
3. Evaluate risk factors (dependencies, breaking changes)
4. Calculate implementation effort
5. Assign complexity level (1-4)
6. Recommend appropriate workflow path
```

---

### Sub-Agent Roles

#### 🎯 Assessor (Complexity Evaluation)
**Focus**: Task complexity analysis and workflow routing  
**Responsibilities**:
- Analyze task requirements
- Evaluate complexity across 4 dimensions
- Assign complexity level (1-4)
- Recommend workflow path
- Update memory bank with assessment

**Primary Files**: activeContext.md, tasks.md

**Engaged By**: `/cf:feature` (automatically)

**Output Format**:
```
🎯 COMPLEXITY ASSESSMENT
─────────────────────────
Task: [description]
Level: [1-4]
Keywords: [identified complexity indicators]
Scope: [estimated files/components]
Risk: [Low/Medium/High]
Effort: [time estimate]

→ RECOMMENDATION: [proceed/plan/creative]
```

---

#### 🏗️ Architect
**Focus**: System design, architecture, technical decisions  
**Responsibilities**:
- Design system architecture
- Make technical trade-off decisions
- Define component relationships
- Establish design patterns
- Ensure scalability and maintainability

**Primary Files**: systemPatterns.md, CLAUDE.md (for tech stack reference)

**Engaged By**: `/cf:plan`, `/cf:ask architect`

---

#### 💻 Developer
**Focus**: Implementation, coding, debugging
**Responsibilities**:
- Write clean, functional code
- Follow established patterns
- Debug issues
- Optimize implementations
- Maintain code quality

**Primary Files**: systemPatterns.md, activeContext.md, CLAUDE.md (for tech stack reference)

**Engaged By**: `/cf:code`, `/cf:ask developer`

**Note**: This workflow agent coordinates with implementation agents (testEngineer, codeImplementer, uiDeveloper) during `/cf:code` execution.

---

#### 🎨 Product
**Focus**: User experience, requirements, features
**Responsibilities**:
- Define feature requirements
- Consider user experience
- Prioritize work
- Validate solutions meet needs
- Guide product decisions

**Primary Files**: productContext.md, projectbrief.md

**Engaged By**: `/cf:plan`, `/cf:ask product`

---

#### 📝 Documentarian
**Focus**: Documentation, memory bank maintenance
**Responsibilities**:
- Maintain memory bank accuracy
- Document decisions and patterns
- Organize information clearly
- Track project evolution
- Ensure knowledge preservation

**Primary Files**: ALL (particularly activeContext.md, progress.md)

**Engaged By**: `/cf:checkpoint`, `/cf:review`, `/cf:ask documentarian`

---

#### 🔍 Reviewer
**Focus**: Quality, progress assessment, improvements
**Responsibilities**:
- Review code quality
- Assess progress against goals
- Identify technical debt
- Suggest improvements
- Validate implementations

**Primary Files**: progress.md, systemPatterns.md

**Engaged By**: `/cf:review`, `/cf:ask reviewer`

---

#### 🔄 Facilitator
**Focus**: Human-in-the-loop iterative refinement  
**Responsibilities**:
- Present drafts and proposals for feedback
- Identify gaps, ambiguities, or missing information
- Ask targeted questions for clarification
- Guide iterative improvement process
- Ensure alignment with project patterns and user intent
- Synthesize feedback into refined outputs
- **Recommend next action** based on refinement state

**Primary Files**: ALL (context-dependent)

**Engaged By**: Automatically when commands use `--interactive` flag, or explicitly via `/cf:facilitate`

**Action Recommendation Pattern**:
After each refinement cycle, Facilitator provides:
1. **Status Update**: What was addressed
2. **Remaining Concerns**: What still needs attention (if any)
3. **Recommendation**: Clear next action
   - Ready to proceed? → Suggest next command
   - Need more refinement? → Identify what aspect
   - Need different expertise? → Suggest `/ask [agent]` or different command

**Example Output**:
```
🔄 Refinement Complete

✓ Addressed: Token storage approach, refresh strategy
⚠️ Remaining: Session management complexity seems high

→ RECOMMENDATION:
  • Sub-task 3 (session management) may benefit from /creative
  • Otherwise ready to proceed with /checkpoint
  • Continue refining? Let me know which aspect.
```

**No Iteration Limits**: Human controls the loop. Facilitator guides toward resolution but never blocks or enforces arbitrary limits.

---

## Workflow Patterns

### Complexity-Based Routing Pattern

**Level 1 Task (Quick Fix):**
```
1. User: /cf:feature fix typo in header
2. Claude: (Assessor) Level 1 - Ready to implement
3. User: /cf:code fix-header-typo
4. Claude: (testEngineer + codeImplementer) TDD implementation
5. System: Auto-updates tasks.md (task complete after tests GREEN)
```

**Level 2 Task (Simple Enhancement):**
```
1. User: /cf:feature add search functionality to navbar
2. Claude: (Assessor) Level 2 - Requires planning
3. User: /cf:plan navbar-search
4. Claude: (Architect + Product) Creates plan with steps
5. System: Updates tasks.md with sub-tasks, activeContext.md
6. User: /cf:code [each step]
7. Claude: (testEngineer + implementation agent) Implements each step with TDD
```

**Level 3-4 Task (Complex Feature):**
```
1. User: /cf:feature migrate authentication to OAuth
2. Claude: (Assessor) Level 4 - Complex, requires planning
3. User: /cf:plan oauth-migration --interactive
4. Claude: (Architect + Product + Facilitator) Creates plan, identifies complex sub-steps
5. Facilitator: Refines plan through iteration based on user feedback
6. System: Updates tasks.md, activeContext.md
7. User: /cf:code [each step]
8. Claude: (testEngineer + specialist agents) Implements with TDD
9. User: /cf:checkpoint "OAuth migration complete"
10. Claude: (Documentarian) Updates all memory bank files with learnings
```

---

### Iterative Refinement Pattern (Facilitator-Led)
```
1. User: Provides initial request or draft
2. Claude: (Facilitator) Presents initial proposal
3. Claude: Identifies gaps: "I notice X is unclear. Could you clarify?"
4. User: Provides additional context
5. Claude: Refines and shows updated version
6. Claude: "Does this address Y concern? Should we adjust Z?"
7. User: Provides feedback
8. Claude: Further refinement
9. Repeat steps 5-8 until user is satisfied
10. Claude: Finalizes and documents
```

---

## Configuration Options

### Memory Bank Update Strategy
**DECISION: Hybrid (Option C) ✅**

**Automatic Tracking**:
- Commands update activeContext.md during execution
- Changes logged with timestamp and attribution
- Lightweight, non-intrusive updates

**Explicit Commit**:
- `/cf:checkpoint`: Full memory bank review and formal save
- `/cf:review`: Quality assessment with memory bank updates
- User controls when to "commit" state

**Benefits**: Balance between automation and control, continuous tracking without overhead

---

### Context Loading Strategy
**DECISION: Smart Auto-Load (Option A with enhancements) ✅**

**Approach**:
- Each command declares required memory bank files
- System auto-loads only needed files on execution
- `/cf:sync` forces full reload and provides summary
- Caching within session for efficiency

**Example**: `/cf:code` command requires: tasks.md, activeContext.md, systemPatterns.md, CLAUDE.md

**Benefits**: Efficient token usage, fast execution, user control with /cf:sync for full context

---

### Sub-Agent Interaction Mode
**DECISION: Two-Layer Agent Architecture ✅**

**Workflow Agents** (`.claude/agents/workflow/`):
- Assessor, Architect, Product, Documentarian, Reviewer, Facilitator
- Responsible for: Workflow orchestration, analysis, documentation
- Invoked by: Commands for coordination tasks

**Implementation Agents** (`.claude/agents/development/`, `testing/`, `ui/`):
- testEngineer, codeImplementer, uiDeveloper
- Responsible for: Code generation, testing, implementation
- Invoked by: `/cf:code` command and workflow agents

**Specialists** (`.claude/agents/[domain]/specialists/`):
- Created as needed for specific expertise
- Invoked by: Hub agents for delegation

**Command Routing**:
- `/cf:feature` → Assessor (workflow)
- `/cf:plan` → Architect + Product (workflow, + Facilitator if --interactive)
- `/cf:code` → testEngineer + implementation hub (implementation)
- `/cf:review` → Reviewer (workflow)
- `/cf:checkpoint` → Documentarian (workflow)

**Transparency**: Claude indicates which agent(s) are active:
```
"🎯 Assessor: Analyzing task complexity..."
"🏗️ Architect + 🎨 Product: Developing implementation plan..."
"🧪 testEngineer: Writing tests for authentication..."
```

**User can explicitly call**: `/cf:ask [agent] [question]` to get specific perspective

---

### File Structure Modifications
**DECISION: Keep Core Structure (Option A) ✅**

All 6 core files remain as-is (proven structure from Cline):
- projectbrief.md
- productContext.md
- systemPatterns.md
- activeContext.md
- progress.md
- tasks.md

Additional specialized files can be added in `memory-bank/[additional]/` as needed per project.

---

### Flag Parsing Pattern
**DECISION: Pattern Matching in Command Instructions ✅**

Commands use pattern matching for flags:
```markdown
## Process
### Step 1: Parse Flags
Check user input for flags:
- If contains "--interactive": Engage Facilitator agent for refinement
- If contains "--impl-only": Skip TDD steps (test verification still required)
- If contains "--agent=X": Override default agent selection with X
- If contains "--verbose": Include detailed explanations in output
```

**Benefits**: Simple, clear pattern for Claude Code to follow, extensible

---

### Bootstrap & Error Handling
**DECISION: Graceful Initialization with Helpful Guidance ✅**

**Bootstrap Flow**:
1. User runs: `/cf:init [project-name]`
2. System checks: memory-bank/ exists?
   - If yes: "Already initialized. Run /cf:sync to view state."
   - If no: Proceed with initialization
3. Create structure, copy templates, customize
4. Confirm: "✅ Initialized. Next: /cf:sync then /cf:feature"

**Error Handling**:
- All commands check prerequisites
- If memory-bank/ missing: "⚠️ Memory bank not initialized. Run /cf:init [project-name] first."
- If .claude/ missing: "⚠️ Agent system not initialized. Run /cf:init [project-name] first."
- If task not found: "❌ Task [id] not found in tasks.md. Run /cf:feature to create tasks."

---

### Command Namespace
**DECISION: All commands under `/cf:` namespace ✅**

All custom workflow commands use the `/cf:` prefix:
- `/cf:init`, `/cf:sync`, `/cf:feature`, `/cf:plan`, `/cf:code`
- `/cf:review`, `/cf:checkpoint`, `/cf:ask`, `/cf:context`
- `/cf:status`, `/cf:facilitate`, `/cf:create-specialist`

**Benefits**: Clear separation from native Claude Code commands, prevents conflicts, professional namespace

---

## Document Templates

**IMPORTANT**: All memory bank document templates are stored in `memory-bank/templates/` folder. Each template can be individually modified and iterated on over time to suit project-specific needs without affecting the core workflow system.

### Template Files Location
```
memory-bank/
└── templates/
    ├── projectbrief.template.md
    ├── productContext.template.md
    ├── systemPatterns.template.md
    ├── activeContext.template.md
    ├── progress.template.md
    └── tasks.template.md
```

### Template Usage
- When creating new memory bank files, system uses templates from `memory-bank/templates/`
- Templates are versioned (noted in template header)
- Users can customize templates per project
- Template modifications do not affect other projects
- Templates can evolve with project needs

### Template Descriptions

#### projectbrief.template.md
**Purpose**: Foundation document optimized for AI consumption and implementation tracking
**Key Features**:
- Table-based scope definition with complexity levels
- Ranked objectives with success metrics
- Clear constraint documentation
- Decision log in tabular format
- Explicit priority hierarchy (P0, P1, P2)

#### productContext.template.md
**Purpose**: Concise user-focused context
**Key Features**:
- Problem → Solution mapping
- Feature table with priorities and complexity
- Streamlined user flows
- UX requirements in must/should format
- Non-functional requirements table

#### systemPatterns.template.md
**Purpose**: Architectural patterns with ADR integration
**Key Features**:
- Minimal architecture overview
- Active patterns with examples
- Coding conventions table
- Critical path documentation
- ADR index and references
- Focus on quick reference, points to detailed ADRs

#### activeContext.template.md
**Purpose**: Current work tracking
**Key Features**:
- Current focus section
- Recent changes log
- Immediate next steps
- Active decisions and blockers
- Patterns and learnings
- Context for next session

#### progress.template.md
**Purpose**: Status and milestone tracking
**Key Features**:
- Completed features log
- Remaining work by priority
- Known issues tracking
- Decision history
- Milestone progress
- Metrics and insights

#### tasks.template.md
**Purpose**: Single source of truth for task management
**Key Features**:
- Task status with priority levels
- Complexity ratings (Level 1-4)
- Sub-task tracking
- Blocker documentation
- Status legend
- Completed task archive

**Template Access**: Full template contents are stored in individual files in the `memory-bank/templates/` folder. See those files for complete template structure and formatting.

---

### Phase 1: Core System
- Implement basic commands
- Set up memory bank structure
- Basic sub-agent switching

### Phase 2: Enhancement  
- Advanced sub-agent interactions
- Smart context loading
- Pattern recognition

### Phase 3: Optimization
- Workflow shortcuts
- Automated updates
- Custom extensions

---

## Open Questions

1. **Memory Bank Updates**: Automatic, manual, or hybrid approach?
2. **Context Loading**: When and how should memory bank be loaded?
3. **Sub-Agent Interaction**: Explicit calls, automatic, or multi-perspective?
4. **File Structure**: Keep as-is, merge files, or add specialized files?
5. **Additional Commands**: Are there other commands that would be useful?
6. **Error Handling**: How should the system handle missing or incomplete memory bank files?
7. **Interactive Mode Default**: Should `--interactive` be default behavior, opt-in, or configurable per command type?
8. **Facilitator Boundaries**: Should Facilitator have limits on iteration cycles to prevent endless refinement loops?

---

## Next Steps

1. ✅ Review specification structure
2. ✅ Answer open questions and finalize configuration options
3. ✅ Define complexity assessment system
4. ✅ Define memory bank update strategy
5. ✅ Create document template specifications
6. ✅ Define implementation commands (`/code`, etc.) - See Code Command & Agent System Specification
7. ⬜ Generate implementation guide
8. ⬜ Create command reference document
9. ⬜ Build example workflows
10. ⬜ Create actual template files for `memory-bank/templates/`
11. ⬜ Test with sample project

---

## Related Specifications

### Code Command & Agent System Specification
**Purpose**: Companion document providing detailed implementation for code execution and agent system.

**This document covers:**
- `/code` command - TDD-driven implementation workflow
- Claude Code sub-agent architecture (hub and specialist agents)
- Agent file structure and format (YAML frontmatter + Markdown)
- Test verification and completion gates
- `/create-specialist` command for creating new agents
- Agent coordination and delegation patterns
- Complete examples and best practices

**Location**: Provided as separate document alongside this specification.

**When to reference**: 
- Implementing the `/code` command
- Creating or customizing agents
- Understanding TDD workflow enforcement
- Setting up agent directory structure

**Key Concept**: The agent system lives in `.claude/agents/` and uses Claude Code's native sub-agent functionality, while the memory bank system (defined in this document) lives in `memory-bank/` and provides project context.

---

## Revision History
- v0.1 - Initial specification draft
- v0.2 - Added complexity assessment system, memory bank update strategy, Assessor agent
- v0.3 - Resolved configuration decisions, added templates section, finalized Facilitator pattern
- v0.4 - Template management strategy, removed techContext.md in favor of CLAUDE.md reference