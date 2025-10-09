# Code Command & Agent System Specification

## Overview

The `/code` command is the primary execution command for implementing tasks and plans. It enforces a **Test-Driven Development (TDD)** approach by default and uses **Claude Code's native sub-agent system** to provide specialized, context-aware development guidance.

---

## Agent-Based Development System

### Philosophy

Instead of a generic "Developer" agent, the system uses **project-specific agents** defined as Claude Code sub-agents. These agents understand the technology stack, patterns, and conventions of the current project and provide expert guidance tailored to the specific frameworks and tools being used.

### Agent Architecture

**Implementation Agents**: 
- Can handle implementation directly for straightforward tasks
- Can delegate to specialist agents for complex or varied work
- Make routing decisions based on task analysis and project architecture
- Same implementation agent can do both depending on task complexity
- Defined as Claude Code sub-agents in `.claude/agents/`

**Specialist Agents**:
- Optional - only created when needed
- Deep expertise in specific areas (e.g., controller development, component creation)
- Invoked by implementation agents when specialized knowledge required
- Also defined as Claude Code sub-agents in `.claude/agents/specialists/`

### Agent Storage Structure (Claude Code Native)

```
.claude/
├── agents/                          # Claude Code sub-agents (project-level)
│   ├── testing/
│   │   ├── testEngineer.md          # Implementation agent:routes or handles test creation
│   │   └── specialists/              # Optional specialists
│   │       ├── unitTestWriter.md
│   │       ├── integrationTestWriter.md
│   │       ├── controllerSpecWriter.md
│   │       └── e2eTestWriter.md
│   ├── development/
│   │   ├── codeImplementer.md        # Implementation agent:general code implementation
│   │   └── specialists/              # Optional specialists
│   │       ├── controllerDeveloper.md
│   │       ├── modelDeveloper.md
│   │       ├── serviceDeveloper.md
│   │       └── [custom specialists]
│   └── ui/
│       ├── uiDeveloper.md            # Implementation agent:UI/component development
│       └── specialists/              # Optional specialists
│           ├── componentDeveloper.md
│           ├── hookDeveloper.md
│           ├── styleDeveloper.md
│           └── [custom specialists]
└── commands/
    └── code.md                       # /code slash command

memory-bank/
├── tasks.md                          # Task tracking
├── activeContext.md                  # Current context
└── systemPatterns.md                 # Architecture patterns
```

### Agent Discovery

**Claude Code Automatic Discovery**: 
- Claude Code automatically discovers agents in `.claude/agents/`
- No configuration file needed
- Agents are project-specific and version-controlled
- Can be invoked naturally: "Use the codeImplementer agent to..."
- Each agent has its own context window

**User-Level Agents** (optional):
- Can also place agents in `~/.claude/agents/` for personal defaults
- Project-level agents take precedence over user-level

---

## Agent File Structure (Claude Code Format)

### Agent File Template

**Format**: Markdown with YAML frontmatter

```markdown
---
name: agentName
description: When this agent should be invoked and what it handles
tools: Read, Write, Edit, MultiEdit, Grep, Glob, Bash  # Optional - inherits all if omitted
model: sonnet  # Optional - haiku|sonnet|opus or 'inherit'
---

[Expert statement - what this agent specializes in]

## Responsibilities
- [What this agent handles]
- [When this agent is engaged]

## Decision Logic (Implementation agents only)
[How this implementation agent determines whether to handle directly or delegate]
[Pattern matching rules for routing to specialists]

### Specialist Routing (if applicable)
- [Condition/pattern] → Invoke [specialistName] specialist
- [Condition/pattern] → Invoke [specialistName] specialist

## Code Style and Structure
- [Style guidelines]
- [Structural patterns]
- [Best practices]

## Naming Conventions
- [File naming]
- [Variable/method naming]
- [Class/module naming]

## Framework/Technology Usage
- [Specific framework patterns]
- [Library usage guidelines]
- [Version-specific features]

## Syntax and Formatting
- [Code formatting rules]
- [Stylistic preferences]

## Error Handling and Validation
- [Error handling patterns]
- [Validation approaches]
- [Logging strategies]

## UI and Styling (if applicable)
- [UI framework usage]
- [Styling conventions]
- [Component patterns]

## Performance Optimization
- [Performance best practices]
- [Optimization strategies]

## Key Conventions
- [Project-specific conventions]
- [Pattern usage]
- [Architectural guidelines]

## Testing Approach
- [Testing framework]
- [Test structure]
- [Coverage expectations]
- [TDD practices]

## Security Considerations
- [Security patterns]
- [Authentication/authorization]
- [Common vulnerability prevention]

## Examples (optional)
[Example scenarios and expected outputs]

## Anti-Patterns
- [What to avoid]
- [Common mistakes]
```

### Example Implementation Agent File

**File**: `.claude/agents/development/codeImplementer.md`

```markdown
---
name: codeImplementer
description: General code implementation for application features. Use for feature development, bug fixes, and enhancements. Can delegate to specialists for complex work.
tools: Read, Write, Edit, MultiEdit, Grep, Glob, Bash
model: sonnet
---

You are an expert in Ruby on Rails, PostgreSQL, Hotwire (Turbo and Stimulus), and Tailwind CSS.

## Responsibilities
- General code implementation for application features
- Route to specialists when task requires specific expertise
- Handle straightforward implementations directly
- Coordinate with testEngineer for TDD workflow

## Decision Logic

### Handle Directly When:
- Task is straightforward CRUD operation
- Single file modification
- Simple feature addition following existing patterns
- Bug fix using established patterns

### Delegate to Specialists When:
- Task involves complex controller logic → Invoke controllerDeveloper specialist
- Task requires data modeling → Invoke modelDeveloper specialist  
- Task involves complex UI components → Invoke componentDeveloper specialist
- Task needs service layer logic → Invoke serviceDeveloper specialist

### How to Delegate:
When delegating, explicitly state: "I need to use the [specialistName] specialist for this task: [description]"

The specialist will be invoked with its own context and will handle the specific work.

### Pattern Matching for Routing
- Keywords: "controller", "endpoint", "route", "action" → controllerDeveloper
- Keywords: "model", "schema", "migration", "association" → modelDeveloper
- Keywords: "component", "turbo frame", "stimulus controller" → componentDeveloper
- Keywords: "service", "business logic", "workflow" → serviceDeveloper

### Architecture Awareness
- Check systemPatterns.md for project architecture
- Use established patterns to determine appropriate specialist
- If unclear which specialist to use, handle directly with conservative approach

## Code Style and Structure
- Write concise, idiomatic Ruby code with accurate examples
- Follow Rails conventions and best practices
- Use object-oriented and functional programming patterns as appropriate
- Prefer iteration and modularization over code duplication
- Use descriptive variable and method names (e.g., user_signed_in?, calculate_total)
- Structure files according to Rails conventions (MVC, concerns, helpers, etc.)

## Naming Conventions
- Use snake_case for file names, method names, and variables
- Use CamelCase for class and module names
- Follow Rails naming conventions for models, controllers, and views

## Framework/Technology Usage
- Use Ruby 3.x features when appropriate (e.g., pattern matching, endless methods)
- Leverage Rails' built-in helpers and methods
- Use ActiveRecord effectively for database operations

## Syntax and Formatting
- Follow the Ruby Style Guide (https://rubystyle.guide/)
- Use Ruby's expressive syntax (e.g., unless, ||=, &.)
- Prefer single quotes for strings unless interpolation is needed

## Error Handling and Validation
- Use exceptions for exceptional cases, not for control flow
- Implement proper error logging and user-friendly messages
- Use ActiveModel validations in models
- Handle errors gracefully in controllers and display appropriate flash messages

## UI and Styling
- Use Hotwire (Turbo and Stimulus) for dynamic, SPA-like interactions
- Implement responsive design with Tailwind CSS
- Use Rails view helpers and partials to keep views DRY

## Performance Optimization
- Use database indexing effectively
- Implement caching strategies (fragment caching, Russian Doll caching)
- Use eager loading to avoid N+1 queries
- Optimize database queries using includes, joins, or select

## Key Conventions
- Follow RESTful routing conventions
- Use concerns for shared behavior across models or controllers
- Implement service objects for complex business logic
- Use background jobs (e.g., Sidekiq) for time-consuming tasks

## Testing Approach
**CRITICAL: Always coordinate with testEngineer BEFORE implementation**
- Announce: "I need the testEngineer agent to write tests for this task first"
- Wait for tests to be written and RED phase confirmed
- Only then proceed with implementation
- **ABSOLUTE REQUIREMENT: All tests MUST be GREEN before task can be marked complete**
- **NO EXCEPTIONS: Failing tests = task is NOT done**
- Write comprehensive tests using RSpec
- Follow TDD/BDD practices
- Use factories (FactoryBot) for test data generation

**Verification Rule:**
- If ANY test fails, task status = "In Progress" or "Blocked"
- Only when ALL tests pass, task status = "Complete"
- This is non-negotiable and applies to all implementations

## Security Considerations
- Implement proper authentication and authorization (e.g., Devise, Pundit)
- Use strong parameters in controllers
- Protect against common web vulnerabilities (XSS, CSRF, SQL injection)

Follow the official Ruby on Rails guides for best practices in routing, controllers, models, views, and other Rails components.
```

### Example Specialist Agent File

**File**: `.claude/agents/development/specialists/controllerDeveloper.md`

```markdown
---
name: controllerDeveloper
description: Specialist for Rails controller implementation. Use when task specifically involves controller actions, routing, or request/response handling.
tools: Read, Write, Edit, MultiEdit, Grep, Bash
model: sonnet
---

You are a Rails controller specialist with deep expertise in request handling, authentication, authorization, and RESTful design.

## Responsibilities
Focus exclusively on controller-layer concerns:
- Action methods and routing
- Strong parameters
- Before/after filters and callbacks
- Session and cookie management
- Response formats (JSON, HTML, etc.)
- Authentication and authorization at controller level

## Controller Patterns to Follow
- Keep controllers thin - delegate business logic to models or services
- Use before_action for DRY filtering
- Return early from actions when conditions aren't met
- Use respond_to for format-specific responses
- Implement proper error handling and user feedback

## Strong Parameters
Always use strong parameters for mass assignment protection:
```ruby
def user_params
  params.require(:user).permit(:name, :email, :password)
end
```

## RESTful Actions
Follow RESTful conventions:
- index, show, new, create, edit, update, destroy
- Use custom actions sparingly and with clear naming

## Response Handling
- Use flash messages for user feedback
- Redirect appropriately after state-changing actions
- Return proper HTTP status codes

## Testing Approach
Work with testEngineer to ensure controller specs exist before implementation:
- Request specs for integration testing
- Controller specs for isolated testing
- Test authentication and authorization
- Test error cases and edge conditions

## Security Considerations
- Always use strong parameters
- Implement authorization checks (Pundit, CanCanCan)
- Protect against CSRF
- Validate user permissions before actions
- Sanitize user input

## Anti-Patterns to Avoid
- Fat controllers with business logic
- Skipping authorization checks
- Direct model attribute assignment
- Missing strong parameters
- Not handling error cases
```

---

## /code Command Specification

### Core Principle: Test-Driven Completion

**ABSOLUTE REQUIREMENT:**
A task is ONLY complete when ALL tests pass (100% GREEN). This is non-negotiable and applies to every task, regardless of urgency, complexity, or context. Failing tests mean the task is incomplete, blocked, or in-progress - never "done".

**Verification Gate:**
Before any task can be marked as complete in tasks.md, the system MUST verify:
1. All new tests pass
2. All existing tests still pass  
3. Test suite shows 100% GREEN
4. Zero failing tests

If this verification fails, the task CANNOT be marked complete under any circumstances.

### Command Location

**File**: `.claude/commands/code.md`

This is a **slash command**, not an agent. It orchestrates agents to complete work.

### Command Signature

```
/code [task-identifier] [flags]
```

**Parameters:**
- `task-identifier`: Task name or ID from tasks.md
- `flags`: Optional flags to modify behavior

**Flags:**
- `--tdd` (default): Full TDD cycle (test first, then implementation)
- `--impl-only`: Skip TDD, implement directly (override)
- `--interactive`: Engage Facilitator for guidance during implementation
- `--agent=[agentName]`: Explicitly specify which implementation agent to use

### Default Behavior

**Interactive Mode**: Non-interactive by default
- Fast execution for development workflow
- Can add `--interactive` flag for Facilitator guidance

**TDD Mode**: TDD enforced by default
- Tests written first (RED)
- Implementation follows (GREEN)
- Refactoring as needed
- Can override with `--impl-only` flag

### Command File Content

**File**: `.claude/commands/code.md`

```markdown
---
# /code command - Orchestrates TDD workflow with agents
---

# Code Implementation Command

Execute the task using Test-Driven Development with appropriate agents.

## Process

When user runs `/code [task-identifier]`:

### Step 1: Load Context
- Read tasks.md for task details: `@memory-bank/tasks.md`
- Load activeContext.md: `@memory-bank/activeContext.md`
- Load systemPatterns.md: `@memory-bank/systemPatterns.md`
- Reference CLAUDE.md for tech stack: `@CLAUDE.md`

### Step 2: TDD First - Engage Test Engineer
**CRITICAL: Tests must be written BEFORE implementation**

Say: "I need the testEngineer agent to write tests for this task first."

Wait for testEngineer to:
- Write comprehensive tests
- Run tests to confirm RED phase (tests fail as expected)
- Report back with test file locations

Do NOT proceed to implementation until RED phase confirmed.

### Step 3: Identify Implementation Agent
Based on task type from context, invoke appropriate implementation agent:

**If task involves backend/server/API work:**
"Use the codeImplementer agent to implement: [task description]"

**If task involves UI/components/frontend work:**
"Use the uiDeveloper agent to implement: [task description]"

**If user specified --agent flag:**
Use the specified agent.

### Step 4: Agent Implementation
The invoked implementation agent will:
- Analyze the task
- Decide: handle directly OR delegate to specialist
- If delegating, invoke appropriate specialist agent
- Implement the solution following all guidelines
- Follow code style, patterns, and conventions

### Step 5: Verify GREEN Phase
**CRITICAL: Tests MUST pass before proceeding. This is non-negotiable.**

Run the test suite to confirm:
- All new tests pass
- No existing tests broken
- GREEN phase achieved

**If tests fail:**
- Analyze failure details
- Iterate on implementation
- Re-run tests
- Repeat until GREEN

**If tests still fail after 3 iterations:**
- STOP implementation
- Report persistent failures
- DO NOT mark task as complete
- DO NOT update memory bank with completion status
- Recommend: break into smaller tasks or use /creative

**VERIFICATION REQUIREMENT:**
✅ ALL tests MUST be GREEN before task can be marked complete
❌ If ANY test fails, task CANNOT be marked as done
❌ No exceptions - failing tests = incomplete task

Only proceed to Step 6 when verification confirms GREEN phase.

### Step 6: Refactor (Optional)
If improvements possible while maintaining GREEN:
- Suggest refactoring opportunities
- If user approves, refactor
- Re-run tests to ensure still GREEN

### Step 7: Update Memory Bank
**PREREQUISITE: Can ONLY execute this step if ALL tests are GREEN**

If tests are not passing, SKIP this step and return to Step 5.

Update the following files:

**tasks.md:**
- Mark task as complete (ONLY if tests GREEN)
- Add implementation notes
- Record files modified
- Note any decisions made

**activeContext.md:**
- Add to recent changes
- Document patterns used
- Note any learnings

**systemPatterns.md (if applicable):**
- Add new patterns that emerged
- Update architectural decisions

**CRITICAL VERIFICATION:**
Before marking any task complete in tasks.md:
1. Confirm test suite shows 100% GREEN
2. Verify no failing tests
3. Double-check test output
4. Only then mark task as "Complete"

**If tests are failing:**
- Mark task as "In Progress" or "Blocked"
- Document what's failing in task notes
- DO NOT mark as "Complete"

### Step 8: Report Completion
**ONLY execute if tests are GREEN**

Provide summary:
- Task completed successfully
- Tests status: ALL GREEN (X/X passing)
- Files created/modified
- Agents used (implementation agent and/or specialists)
- Next recommended action

**If tests are not GREEN:**
Do NOT report completion. Instead report:
- Task incomplete
- Test status: X/Y passing (Y-X failing)
- Blockers preventing completion
- Recommended next steps to achieve GREEN

## Flags

### --impl-only (Override TDD)
Skip steps 2 and 5 (test creation and verification).
**WARNING**: This bypasses TDD. Use only for:
- Trivial changes (typos, formatting)
- Emergency hotfixes
- When comprehensive tests already exist

### --interactive
Engage Facilitator at key decision points:
- Before agent selection
- After test creation (review tests)
- After implementation (review code)
- During refactoring decisions

### --agent=[agentName]
Override automatic agent selection.
Example: `--agent=apiDeveloper`

## Examples

```bash
# Standard TDD workflow (default)
/code implement-user-authentication

# Skip TDD for trivial change
/code fix-typo-in-header --impl-only

# Interactive mode for complex feature
/code add-payment-processing --interactive

# Force specific agent
/code optimize-database-query --agent=apiDeveloper
```

## Error Handling

**If agent not found:**
- Report which agent was requested
- List available agents
- Suggest fallback to codeImplementer

**If tests never reach GREEN:**
- After 3 iterations, pause
- Report persistent failures
- Suggest breaking into smaller tasks or using /creative

**If task unclear:**
- Request clarification
- Do not proceed with assumptions
```

### Command Flow Diagram

```
User: /code implement-feature

↓
Load Context (tasks.md, activeContext.md, systemPatterns.md, CLAUDE.md)
↓
Invoke testEngineer agent → Write tests → Confirm RED
↓
Identify implementation agent (apiDeveloper, uiDeveloper, or codeImplementer)
↓
Invoke implementation agent
↓
Implementation agent decides: Direct OR Delegate to specialist
↓
Implementation (following all agent guidelines)
↓
Run tests → Verify GREEN (iterate if needed)
↓
Optional: Refactor (while maintaining GREEN)
↓
Update memory bank (tasks.md, activeContext.md, systemPatterns.md)
↓
Report completion
```

---

## Agent Invocation & Coordination

### How Commands Invoke Agents

Commands use natural language to invoke agents:

```markdown
"I need the testEngineer agent to write tests for this task."
"Use the codeImplementer agent to implement: [description]"
"Invoke the controllerDeveloper specialist for this work."
```

Claude Code automatically:
- Recognizes the agent name
- Loads the agent's context and instructions
- Executes the work in agent's context window
- Returns control when complete

### How Implementation Agents Delegate to Specialists

Implementation agents delegate by explicitly invoking specialists:

```markdown
# Inside codeImplementer agent's thinking:
"This task requires controller expertise. I need to use the controllerDeveloper specialist for this task: implement user sessions controller"
```

Claude Code then:
- Switches to controllerDeveloper agent context
- Specialist executes the work
- Returns results to implementation agent
- Implementation agent continues coordination

### Multiple Specialists in Sequence

For complex tasks requiring multiple specialists:

```markdown
# Implementation agent coordinates:
1. "Use modelDeveloper specialist to create User model"
   [waits for completion]
   
2. "Use controllerDeveloper specialist to create SessionsController"
   [waits for completion]
   
3. "Use componentDeveloper specialist to create login component"
   [waits for completion]
```

Each specialist:
- Works in its own context
- Follows full TDD cycle
- Updates relevant files
- Reports completion

---

## Test Engineering Integration

### testEngineer Implementation Agent

**File**: `.claude/agents/testing/testEngineer.md`

```markdown
---
name: testEngineer
description: Write and manage tests following TDD. Use PROACTIVELY before any implementation. Routes to test specialists for complex testing scenarios.
tools: Read, Write, Edit, Grep, Bash
model: sonnet
---

You are a test engineering expert specializing in Test-Driven Development.

## Responsibilities
- Write tests BEFORE implementation (RED phase)
- Ensure tests fail for the right reasons
- Route to specialist test writers when needed
- Verify test quality and coverage

## Decision Logic

### Handle Directly When:
- Simple unit tests
- Straightforward integration tests
- Standard CRUD testing

### Delegate to Specialists When:
- Controller/API tests → controllerSpecWriter specialist
- Model/validation tests → modelSpecWriter specialist
- Complex integration tests → integrationTestWriter specialist
- E2E tests → e2eTestWriter specialist

## TDD Process
1. Understand the requirement
2. Write failing tests (RED)
3. Run tests to confirm they fail correctly
4. Report RED phase confirmation
5. After implementation, verify GREEN phase
6. **CRITICAL: Confirm ALL tests pass before allowing task completion**
7. **If ANY test fails, task CANNOT be marked as done**

## Test Verification
**Absolute Rule:**
- Tests must be 100% GREEN for task to be complete
- No partial completion allowed
- Failing tests = task is blocked/in-progress, NOT done
- This rule has NO exceptions

## Testing Approach
- Write clear, descriptive test names
- Test behavior, not implementation
- Cover edge cases and error conditions
- Ensure tests are isolated and independent
- Use factories for test data (FactoryBot)

## RSpec Best Practices
- Use descriptive context and describe blocks
- One expectation per example when possible
- Use let for test data setup
- Use before hooks sparingly
- Keep tests readable and maintainable
```

---

## Agent Creation & Management

### System-Provided Agent Templates

When `/init` is run, basic implementation agent templates are created in `.claude/agents/`:

**Created Structure:**
```
.claude/agents/
├── testing/
│   └── testEngineer.md (template with TODOs)
├── development/
│   └── codeImplementer.md (template with TODOs)
└── ui/
    └── uiDeveloper.md (template with TODOs)
```

Templates include:
- Complete YAML frontmatter structure
- TODO sections for user to fill in
- Example content for reference
- Comments explaining each section
- Stack-agnostic structure ready for customization

### Creating Specialist Agents

Use the `/create-specialist` command to add specialist agents as needed.

---

## /create-specialist Command Specification

### Command Signature

```
/create-specialist [name] [domain]
```

**Parameters:**
- `name`: Specialist name (e.g., "controllerDeveloper", "modelDeveloper")
- `domain`: Which implementation domain (testing/development)

**Default Behavior**: Interactive by default

### Command File Content

**File**: `.claude/commands/create-specialist.md`

```markdown
---
# /create-specialist command - Create new specialist agent
---

# Create Specialist Agent

Create a new specialist agent for project-specific patterns.

## Process

When user runs `/create-specialist [name] [domain]`:

### Step 1: Validate Inputs
- Ensure name follows naming convention (camelCase)
- Verify domain is one of: "testing", "development", or "ui"
- Check if specialist already exists

### Step 2: Engage Facilitator
Ask user the following questions:

**Q1: What will this specialist focus on?**
- Get detailed description of specialist's responsibilities
- Understand specific expertise area

**Q2: What tools does this specialist need?**
- Read, Write, Edit, MultiEdit, Grep, Glob, Bash
- Default to common set if uncertain

**Q3: Which model should it use?**
- haiku (fast, simple tasks)
- sonnet (balanced, most tasks)
- opus (complex reasoning)
- Default to sonnet

**Q4: What key patterns should it follow?**
- Project-specific conventions
- Framework patterns
- Code style preferences

**Q5: What are common anti-patterns to avoid?**
- Mistakes this specialist should never make
- Project-specific pitfalls

### Step 3: Generate Specialist File
Create file at: `.claude/agents/[domain]/specialists/[name].md`

Use this structure:
```markdown
---
name: [name]
description: [Generated from Q1]
tools: [From Q2]
model: [From Q3]
---

You are a specialist in [focus area from Q1].

## Responsibilities
[Detailed list from Q1]

## Patterns to Follow
[From Q4]

## Key Conventions
[Project-specific guidelines]

## Testing Approach
Coordinate with testEngineer for TDD workflow.
[Test-specific guidelines for this specialist]

## Anti-Patterns
[From Q5]

## Examples
[Generate examples based on specialist type]
```

### Step 4: Update Implementation Agent
Suggest updating the relevant implementation agent's decision logic:

"I've created the [name] specialist. You should update `.claude/agents/[domain]/[hubName].md` to include routing logic for when to use this specialist."

Provide specific text to add to implementation agent's "Delegate to Specialists" section.

### Step 5: Confirm Creation
Report:
- Specialist created at [file path]
- Implementation agent update suggestion
- How to invoke: "Use the [name] specialist to..."

## Example Usage

```bash
/create-specialist serviceDeveloper development
```

Facilitator asks questions:
```
Q: What will serviceDeveloper focus on?
A: Complex business logic and multi-step workflows

Q: What tools needed?
A: Read, Write, Edit, Grep, Bash

Q: Which model?
A: sonnet

Q: Key patterns?
A: Single Responsibility, clear method naming, proper error handling

Q: Anti-patterns to avoid?
A: God objects, mixing concerns, direct database access
```

Creates: `.claude/agents/development/specialists/serviceDeveloper.md`

Suggests updating: `.claude/agents/development/codeImplementer.md`
```

---

## Agent Customization Journey

### Timeline Example

**Day 1 - Project Start:**
```bash
/init my-rails-app

Created:
- .claude/agents/development/codeImplementer.md (template)
- .claude/agents/ui/uiDeveloper.md (template)
- .claude/agents/testing/testEngineer.md (template)
```

**Week 1 - Customize Implementation Agents:**
```
User edits agents:
- Fill in Ruby on Rails specifics in codeImplementer.md
- Add RSpec testing info to testEngineer.md
- Define code style preferences
- Add project-specific patterns
```

**Month 1 - Add First Specialists:**
```bash
/create-specialist controllerDeveloper development
/create-specialist modelDeveloper development
/create-specialist controllerSpecWriter testing

User updates implementation agents to route to these specialists
```

**Month 3 - Refine and Expand:**
```bash
/create-specialist serviceDeveloper development
/create-specialist jobDeveloper development
/create-specialist integrationTestWriter testing

User refines decision logic in implementation agents based on patterns learned
Updates specialist instructions with real project examples
```

---

## Integration with Other Commands

### /code with /plan

`/plan` creates implementation plan with sub-tasks:
```bash
/plan user-authentication

Output in tasks.md:
- TASK-042: Create User model (Level 2)
- TASK-043: Create SessionsController (Level 3)
- TASK-044: Add login views (Level 2)
```

`/code` executes individual sub-tasks:
```bash
/code TASK-042  # testEngineer + modelDeveloper
/code TASK-043  # testEngineer + controllerDeveloper
/code TASK-044  # testEngineer + componentDeveloper
```

### /code with /creative

`/creative` recommends specific agents or specialists:
```bash
/creative complex-authentication-flow

Output:
- Recommends using serviceDeveloper specialist
- Suggests creating authenticationService.md specialist
- Provides implementation approach
```

Then `/code` uses that guidance:
```bash
/code implement-auth-flow --agent=serviceDeveloper
```

### /code with /review

`/review` analyzes code quality after implementation:
```bash
/code implement-feature
/review

Output from review:
- Code quality assessment
- Pattern adherence check
- Suggests refactoring opportunities
- May update systemPatterns.md with learnings
```

---

## Output Format

### Success Output

```
✓ Task: implement-user-authentication (TASK-042)

📋 CONTEXT LOADED
- Task: Level 3 - Add user authentication
- Files: User model, SessionsController, login views
- Pattern: Rails authentication with sessions

🧪 TDD - RED PHASE
Agent: testEngineer
→ Delegated to controllerSpecWriter specialist
✗ Tests Written:
  - spec/controllers/sessions_controller_spec.rb (12 tests)
  - spec/models/user_spec.rb (8 tests)
✗ RED confirmed: All tests failing as expected

💻 IMPLEMENTATION - GREEN PHASE
Agent: codeImplementer
→ Delegated to controllerDeveloper specialist for SessionsController
→ Delegated to modelDeveloper specialist for User model
✓ Implementation Complete:
  - app/controllers/sessions_controller.rb
  - app/models/user.rb
  - db/migrate/20240115_create_users.rb
✓ GREEN confirmed: All 20 tests passing

♻️ REFACTOR PHASE
- No refactoring needed
- Code follows established patterns

📚 MEMORY BANK UPDATED
✓ tasks.md: TASK-042 marked complete
✓ activeContext.md: Recent changes documented
✓ systemPatterns.md: Authentication pattern added

Files Created/Modified:
- spec/controllers/sessions_controller_spec.rb (created)
- spec/models/user_spec.rb (created)
- app/controllers/sessions_controller.rb (created)
- app/models/user.rb (created)
- db/migrate/20240115_create_users.rb (created)

Agents Used:
- testEngineer (implementation agent) → controllerSpecWriter (specialist)
- codeImplementer (implementation agent) → controllerDeveloper + modelDeveloper (specialists)

→ NEXT: Run migration with `rails db:migrate`, then implement login views (TASK-044)
```

### Failure Output

```
✗ Task: implement-user-authentication (TASK-042)

📋 CONTEXT LOADED
✓ Task details retrieved

🧪 TDD - RED PHASE
Agent: testEngineer
✓ Tests written

💻 IMPLEMENTATION - GREEN PHASE
Agent: codeImplementer → controllerDeveloper specialist
✗ Tests Still Failing After 3 Iterations

Status: 16/20 tests passing
Failing:
  - SessionsController#create handles invalid credentials (expected redirect, got 500)
  - SessionsController#create sets session on success (session[:user_id] is nil)
  - SessionsController#destroy clears session (session not destroyed)
  - User.authenticate returns user on valid credentials (returns nil)

❌ BLOCKER: Authentication logic incomplete

Analysis:
- Session creation not persisting
- User.authenticate method needs implementation
- Missing password encryption

Options:
1. Continue iterating on implementation
2. Break into smaller sub-tasks
3. Use /creative to explore alternative approaches
4. Review authentication requirements

→ RECOMMENDATION: 
Use /creative to design robust authentication approach, then retry /code
Or break down: 
  - TASK-042a: User password encryption
  - TASK-042b: Session management
  - TASK-042c: Authentication logic
```

---

## Memory Bank Updates

### tasks.md Updates

```markdown
### ✅ TASK-042: Implement User Authentication (Level 3)
- **Status**: Complete  ← ONLY set to "Complete" when ALL tests GREEN
- **Completed**: 2024-01-15
- **Complexity**: Level 3
- **Tests**: ✅ 20/20 passing (100% GREEN - VERIFIED)
- **Implementation**:
  - Created User model with secure password
  - Created SessionsController with login/logout
  - All tests passing - completion verified
- **Files Created/Modified**:
  - spec/controllers/sessions_controller_spec.rb (created)
  - spec/models/user_spec.rb (created)
  - app/controllers/sessions_controller.rb (created)
  - app/models/user.rb (created)
  - db/migrate/20240115_create_users.rb (created)
- **Agents Used**: 
  - testEngineer → controllerSpecWriter specialist
  - codeImplementer → controllerDeveloper + modelDeveloper specialists
- **Pattern**: Rails session-based authentication
- **Duration**: 45 minutes
```

**Alternative if tests failing:**
```markdown
### 🔴 TASK-042: Implement User Authentication (Level 3)
- **Status**: Blocked  ← Must be "Blocked" or "In Progress" if ANY test fails
- **Started**: 2024-01-15
- **Complexity**: Level 3
- **Tests**: ❌ 16/20 passing (4 tests FAILING - task incomplete)
- **Blocker**: Authentication logic incomplete, 4 tests failing
- **Next Steps**: Fix session creation and User.authenticate method
```

### activeContext.md Updates

```markdown
## Recent Changes

### 2024-01-15 - User Authentication Implementation
- **Changed**: Added complete user authentication system
- **Reason**: TASK-042 - Secure user login/logout functionality
- **Files**: 
  - Controllers: `app/controllers/sessions_controller.rb` (created)
  - Models: `app/models/user.rb` (created)
  - Migrations: `db/migrate/20240115_create_users.rb` (created)
  - Tests: `spec/controllers/sessions_controller_spec.rb` (created)
  - Tests: `spec/models/user_spec.rb` (created)
- **Pattern Used**: Rails session-based authentication with bcrypt
- **Tests**: 20 specs, all passing (12 controller + 8 model)
- **Agents**: 
  - testEngineer (coordinated testing)
  - controllerSpecWriter (wrote controller tests)
  - codeImplementer (coordinated implementation)
  - controllerDeveloper (implemented SessionsController)
  - modelDeveloper (implemented User model)
- **Status**: Complete, ready for views (TASK-044)
- **Next**: Implement login/logout UI
```

### systemPatterns.md Updates

```markdown
## Active Patterns

### Authentication Pattern
- **Where Used**: SessionsController, User model
- **Why**: Secure session-based authentication for web application
- **Implementation**: 
  - User model with `has_secure_password` (bcrypt)
  - SessionsController manages login/logout
  - Session storage for user_id
- **Example**: `app/controllers/sessions_controller.rb:15-30`
- **Established**: 2024-01-15 via TASK-042
- **Agents**: Implemented by controllerDeveloper + modelDeveloper specialists
```

---

## Error Handling

### Missing Agent Files

```
❌ Error: Agent not found

Looking for: .claude/agents/development/apiDeveloper.md
File does not exist

Available agents:
- codeImplementer (development)
- uiDeveloper (ui)
- testEngineer (testing)

Options:
1. Use codeImplementer implementation agent instead (recommended)
2. Create new agent from template using /create-specialist
3. Specify different agent with --agent flag

→ Proceeding with codeImplementer agent
```

### Test Failures After Multiple Iterations

```
⚠️ Tests still failing after 3 implementation iterations

Current status: 10/15 tests passing

Failing tests suggest:
- Requirements may need clarification
- Task complexity underestimated  
- Missing dependencies or setup

→ RECOMMENDATION: 
  1. Use /review to analyze the failures in detail
  2. Consider breaking into smaller sub-tasks with /plan
  3. Use /creative for alternative architectural approach
  4. Check systemPatterns.md for related patterns
```

### Ambiguous Agent Selection

```
🤔 Multiple agents could handle this task:

Task: "Add form with validation and API endpoint"

Matches:
- codeImplementer (matches: "API endpoint")
- uiDeveloper (matches: "form validation")

This task spans both backend and UI concerns.

Recommendation:
1. Break into two tasks:
   - TASK-A: Create API endpoint (use codeImplementer)
   - TASK-B: Create form with validation (use uiDeveloper)
2. Or start with codeImplementer to coordinate both areas

What would you like to do?
```

---

## Best Practices

### When to Create Specialists

**Create specialists when:**
- Same type of work repeated 3+ times
- Specific expertise needed (complex queries, specific framework features)
- Clear separation of concerns exists
- Team has specialized knowledge to capture
- Pattern is established and worth codifying

**Don't create specialists when:**
- Task is one-off or rare
- Implementation agent can handle effectively
- Would create unnecessary complexity
- Pattern hasn't stabilized yet

### Agent File Maintenance

**Good practices:**
- Update agent files as project conventions evolve
- Add real examples from actual project code
- Document anti-patterns encountered in practice
- Keep decision logic aligned with actual usage patterns
- Version control agents with project (they're in `.claude/`)

**Bad practices:**
- Copying agent files from other projects without customization
- Over-specifying with unnecessary rules
- Leaving TODO sections unfilled
- Creating specialists that are never used
- Inconsistent agent instructions across specialists

### TDD Bypass Guidelines

**Use `--impl-only` when:**
- Fixing obvious typos or formatting issues
- Making trivial configuration changes
- Tests already exist and comprehensively cover the change
- Emergency hotfix (document why in commit message)

**⚠️ WARNING: Even with `--impl-only`:**
- Existing tests MUST still pass
- If any test breaks, task is NOT complete
- Run test suite after changes
- Verify no regressions introduced

**Don't use `--impl-only` for:**
- New features or functionality
- Bug fixes without existing test coverage
- Refactoring existing behavior
- Anything that changes application behavior
- Security-related changes

**ABSOLUTE RULE applies regardless of flag:**
- Failing tests = task incomplete
- ALL tests must be GREEN for completion
- No exceptions, even for urgent work

---

## Agent System Best Practices

### Agent Invocation Patterns

**Explicit Invocation (Recommended):**
```
"Use the testEngineer agent to write tests for user authentication"
"I need the controllerDeveloper specialist for this controller work"
```

**Natural Language (Also Works):**
```
"Let's write tests first with the test engineer"
"Have the controller developer specialist handle this"
```

### Agent Context Management

**Each agent has its own context window:**
- Implementation agents maintain high-level task context
- Specialist agents focus on specific implementation details
- Context doesn't bleed between agents
- Memory bank provides shared project context

**Best practices:**
- Let agents complete their work before moving to next agent
- Don't mix concerns across agents
- Use memory bank for cross-agent information sharing

### Agent Tool Permissions

**Configure tools based on agent responsibilities:**

```markdown
# Read-only planner agent
tools: Read, Grep, Glob, Bash

# Implementation specialist
tools: Read, Write, Edit, MultiEdit, Grep, Bash

# Test runner (can execute tests)
tools: Read, Grep, Bash
```

---

## Future Enhancements

### Potential Additions

1. **Agent Analytics**:
   - Track which agents/specialists used most frequently
   - Identify candidates for new specialist creation
   - Suggest agent improvements based on usage patterns

2. **Agent Validation**:
   - Verify agent file structure and YAML frontmatter
   - Check for required sections
   - Warn about outdated patterns or conventions

3. **Cross-Project Agent Sharing**:
   - Export agent files for reuse across projects
   - Import community agent files
   - Agent library/marketplace

4. **AI-Assisted Agent Creation**:
   - Analyze codebase to suggest needed specialists
   - Auto-generate agent decision logic
   - Learn from implementation patterns to refine agents

5. **Agent Orchestration Patterns**:
   - Pre-defined multi-agent workflows
   - Complex feature templates using multiple agents
   - Agent composition for common scenarios

---

## Revision History

- v0.1 - Initial code command and role system specification
- v0.2 - Updated to use Claude Code native sub-agent system
- v0.3 - Restructured agents to live in `.claude/agents/`
- v0.4 - Added `/create-specialist` command and agent coordination patterns