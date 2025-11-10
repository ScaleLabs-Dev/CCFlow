---
description: "Execute task using Test-Driven Development with appropriate implementation agents"
allowed-tools: ['Read', 'Edit', 'Write', 'Bash(npm:*|pytest:*|go:*)', 'Task']
argument-hint: "[task-id]"
---

# Command: /cf:code

## Usage

```
/cf:code [task-id]
/cf:code [task-id] --impl-only
/cf:code [task-id] --interactive
/cf:code [task-id] --agent=[agent-name]
```

## Parameters

- `[task-id]`: **Required** - Task ID to implement (e.g., TASK-003 or TASK-005-2)

## Flags

- `--tdd` (**default**): Full TDD cycle (tests first, then implementation)
- `--impl-only`: Skip TDD, implement directly (**use sparingly**)
- `--interactive`: Engage Facilitator for guidance during implementation
- `--agent=[name]`: Explicitly specify which implementation agent to use

---

## Purpose

**Core Principle: Test-Driven Completion**

Execute task implementation with:
1. **TDD workflow** (RED → GREEN → REFACTOR)
2. **100% GREEN rule** (all tests must pass before completion)
3. **Agent coordination** (testEngineer + implementation agents)
4. **Memory bank updates** (only when tests GREEN)

**ABSOLUTE REQUIREMENT**: A task is ONLY complete when ALL tests pass. No exceptions.

---

## Prerequisites

- **Memory bank initialized**: Run `/cf:init` first
- **Task exists**: Use `/cf:feature` or `/cf:plan` to create tasks
- **Implementation agents customized**: Complete TODO sections in `.claude/agents/`

---

## Process

### Step 1: Load Context

Read required memory bank files:
- `tasks.md` - Task details, acceptance criteria, sub-tasks
- `activeContext.md` - Current project state
- `systemPatterns.md` - Architectural patterns to follow
- `productContext.md` - User needs and UX requirements (for UI tasks)
- `CLAUDE.md` - Tech stack reference

Extract task information:
- Task ID and description
- Complexity level
- Acceptance criteria
- Files affected
- Related patterns

---

### Step 2: TDD Phase 1 - Write Tests (RED)

**CRITICAL: Tests BEFORE implementation**

**Engage testEngineer agent**:

"I need the testEngineer agent to write tests for this task first."

**testEngineer will**:
1. Analyze task requirements
2. Write comprehensive tests:
   - Happy path scenarios
   - Edge cases
   - Error conditions
   - Integration points
3. Run tests to confirm RED phase (tests fail as expected)
4. Report test file locations and RED confirmation

**Output Expected**:
```
🧪 TEST PHASE: RED

## Tests Written
**File**: spec/services/auth_service_spec.rb
**Test Count**: 8 tests
**Coverage**: Authentication service behavior

### Test Cases
1. ✅ should return token when credentials valid
2. ✅ should throw error when email not found
3. ✅ should throw error when password incorrect
...

## RED Verification
**Status**: ❌ FAILED (as expected)
**Failing Tests**: 8 tests
**Reason**: Implementation not yet written

[Test output showing expected failures]

→ RED phase confirmed. Ready for implementation.
```

**DO NOT proceed to Step 3 until RED phase confirmed.**

---

### Step 3: Identify Implementation Agent

**Multi-Step Selection Process**:

#### 3.1: Check for Team Configuration

**Read routing.md** (if exists):
```bash
if [ -f .claude/agents/routing.md ]; then
  # Team configured - use routing logic
else
  # No team - use generic agents
fi
```

#### 3.2: Extract Keywords from Task

Analyze task description for domain indicators:
- **Backend keywords**: api, endpoint, route, server, backend, database, auth
- **Frontend keywords**: component, ui, page, form, frontend, react, vue, hooks
- **Performance keywords**: optimization, memoization, performance, slow
- **Database keywords**: query, schema, migration, model, sequelize, database
- **Testing keywords**: test, spec, testing, coverage

#### 3.3: Select Agent Using Routing Logic

**If routing.md exists** (team configured):

1. Match task keywords to routing.md agent scopes
2. Select stack-specific agent:
   - Backend work → expressBackend (or stack-specific backend agent)
   - Frontend work → reactFrontend (or stack-specific frontend agent)
   - Testing → jestTest (or stack-specific test agent)

**IMPORTANT - Disambiguation**: If task matches multiple agents, **first match wins** (based on agent order in routing.md). Example:
```
Task: "Create API endpoint with form UI"
Keywords: api (backend), form (frontend)
Result: First matching agent in routing.md order (typically backend)
```

3. Check if agent file exists:
   ```
   .claude/agents/[agentName].md
   ```

4. If exists → Use stack-specific agent
5. If missing → Fall back to generic agent (from routing.md fallback path)

**If routing.md does NOT exist** (generic fallback):

Select based on task type:
- **Backend/server/API/business logic** → `codeImplementer` (generic)
- **UI/components/frontend** → `uiDeveloper` (generic)
- **Testing only** → `testEngineer` (generic)

**If user specified --agent flag**:
→ Override routing, use specified agent

**Agent Invocation Pattern**:

*For stack-specific agents*:
"Use the [stackAgent] agent to implement: [task description]"
→ Stack agent will delegate to specialists as needed per routing.md

*For generic agents*:
"Use the [genericAgent] agent to implement: [task description]"
→ Generic agent handles all work directly (no specialist delegation)

---

### Step 4: Agent Implementation

**Invoke selected implementation agent** with task context.

**Implementation agent will**:
1. Analyze task requirements
2. Review tests from testEngineer
3. **Decide**: Handle directly OR delegate to specialist
4. Implement solution following:
   - Code style from agent guidelines
   - Patterns from systemPatterns.md
   - Conventions from CLAUDE.md
   - Test requirements

**Delegation Pattern**:

Implementation agent may say:
"This task requires [specific expertise]. I need to use the [specialist-name] specialist for this work."

Claude Code will then:
- Switch to specialist agent context
- Specialist implements specific part
- Returns control to implementation agent
- Implementation agent continues coordination

**Example Workflow**:
```
codeImplementer analyzes task
  → "Need database expertise"
  → Delegates to databaseSpecialist
  → databaseSpecialist creates schema
  → Returns to codeImplementer
  → "Need API expertise"
  → Delegates to apiSpecialist
  → apiSpecialist creates endpoint
  → Returns to codeImplementer
  → codeImplementer confirms completion
```

---

### Step 5: Verify GREEN Phase

**CRITICAL: Tests MUST pass. Non-negotiable.**

**Run test suite**:

```bash
# Example test commands (customize for your framework)
npm test                    # JavaScript
pytest                      # Python
bundle exec rspec           # Ruby
go test ./...              # Go
```

**Check results**:
- ✅ **All new tests pass**
- ✅ **All existing tests still pass**
- ✅ **100% GREEN** (no failures, no errors)

**If tests FAIL**:

**Iteration Process** (max 3 attempts):

**Rationale for 3-attempt limit**:
- Balances persistence with recognizing genuine blockers
- Prevents runaway debugging loops
- Forces escalation to planning/facilitation for complex issues
- Monitor: <10% tasks hitting limit = appropriate, >20% = too restrictive

1. Analyze failure details:
   - What test failed?
   - What was expected vs actual?
   - What's the root cause?

2. Adjust implementation:
   - Fix the issue
   - Re-run tests

3. **If still failing after 3 attempts**:
   ```
   🚨 TEST VERIFICATION BLOCKED

   ## Status
   **Attempts**: 3/3 (max reached)
   **Passing Tests**: [N]/[Total]
   **Failing Tests**: [N]

   ### Persistent Failures
   1. ❌ [Test name]
      **Issue**: [Why it keeps failing]
      **Tried**: [What approaches were attempted]

   ## Blocker Report
   **Task**: TASK-[ID]
   **Blocker**: Tests not passing after 3 implementation attempts
   **Next Action Required**:
   - Manual investigation needed
   - Consider breaking into smaller sub-tasks
   - May need architectural review

   → ESCALATION: Task blocked

   Options:
   1. /cf:plan TASK-[ID] --interactive (re-plan with breakdown)
   2. /cf:facilitate debugging (interactive problem solving)
   3. /cf:ask architect [question] (architectural guidance)

   ❌ Task CANNOT be marked complete until tests pass
   ```

   **STOP execution**. Do NOT proceed to Step 6.

**If tests PASS** (✅ GREEN):

```
🧪 TEST PHASE: GREEN

## Test Execution
**Test Runner**: [framework]
**Tests Run**: [N] total

## Results
**Status**: ✅ ALL TESTS PASSING
**Passed**: [N] tests
**Failed**: 0 tests
**Warnings**: [N] warnings (if any)

[Test output showing all green]

## Coverage Report
**Lines Covered**: [X]%
**Branches Covered**: [X]%
**Functions Covered**: [X]%

→ GREEN GATE: ✅ PASSED
   Task verified and ready for completion.
```

**Proceed to Step 6.**

---

### Step 6: Refactor (Optional)

**Only if tests are GREEN**, suggest improvements:

- Extract functions for clarity
- Remove code duplication
- Improve naming
- Optimize performance

**For each refactoring**:
1. Make change
2. **Re-run tests to ensure still GREEN**
3. If tests fail, revert change
4. If tests pass, keep improvement

**Skip refactoring if**:
- Code is already clean
- No obvious improvements
- Time constraints

---

### Step 7: Update Memory Bank

**PREREQUISITE: Can ONLY execute if ALL tests are GREEN**

If tests are NOT passing, **SKIP this step** and return to Step 5.

**Clear Completed Work from activeContext**:

Edit activeContext.md:
- Replace "## Current Focus" section with:
  ```markdown
  ## Current Focus

  (No active work - start new feature with /cf:feature)
  ```
- Trim "## Recent Changes" to last 5 entries (keep most recent 5 `### YYYY-MM-DD` sections, remove older entries)

**Update tasks.md**:

```markdown
### ✅ TASK-[ID]: [Task Name] (Level [1-4])

**Status**: Complete  ← ONLY if tests 100% GREEN
**Completed**: YYYY-MM-DD
**Priority**: [P0/P1/P2]
**Complexity**: Level [1-4]
**Tests**: ✅ [X]/[X] passing (100% GREEN - VERIFIED)
**Coverage**: [X]%

**Implementation**:
[Brief description of what was implemented]

**Files Created/Modified**:
- [file1.js]: [what was done]
- [file2.ts]: [what was done]

**Agents Used**:
- testEngineer [→ specialists if any]
- [implementation agent] [→ specialists if any]

**Pattern**: [Pattern from systemPatterns.md used]

**Duration**: [Actual time spent]

**Notes**: [Any important decisions or learnings]
```

**If tests failing**, mark as:
```markdown
### 🔄 TASK-[ID]: [Task Name] (Level [1-4])

**Status**: Blocked  ← If ANY tests fail
**Started**: YYYY-MM-DD
**Tests**: ❌ [X]/[Y] passing ([Y-X] tests FAILING)
**Blocker**: [Description of what's failing]
**Next Steps**: [What needs to be fixed]
```

**Update activeContext.md**:

Add to **Recent Changes**:
```markdown
### [YYYY-MM-DD HH:MM] - [Task Name] Implemented
**Agent**: [testEngineer + implementation agent]
**Task ID**: TASK-[ID]
**Files**: [file1, file2, file3]
**Impact**: [What changed and why]
**Tests**: ✅ All passing ([N] tests, [X]% coverage)
**Pattern**: [Pattern used]
```

**Update systemPatterns.md** (if new pattern emerged):

Add to **Active Patterns** section:
```markdown
### [New Pattern Name]

**Category**: [Type]
**Added**: YYYY-MM-DD (from TASK-[ID])

**Context**: [When/where this applies]

**Problem**: [What it solves]

**Solution**: [How the pattern works]
```[language]
[Example code]
```

**Benefits**:
- ✅ [Benefit 1]

**Trade-offs**:
- ⚠️ [Trade-off 1]

**Examples in Codebase**: [file:line references]
```

---

### Step 8: Report Completion

**ONLY if tests are GREEN:**

```markdown
✅ TASK COMPLETE: TASK-[ID]

## Task: [Task Name]

**Complexity**: Level [1-4]
**Duration**: [Actual time]

---

### 📋 CONTEXT
- Task ID: TASK-[ID]
- Description: [Brief description]
- Acceptance Criteria: All met ✓

---

### 🧪 TDD CYCLE

**RED Phase**:
- testEngineer wrote [N] tests
- Tests confirmed failing (RED)

**GREEN Phase**:
- [implementation agent] implemented solution
- All [N] tests passing (GREEN) ✅

**REFACTOR Phase**:
- [Improvements made, or "No refactoring needed"]

---

### 💻 IMPLEMENTATION

**Files Created/Modified**:
- [file1]: [description]
- [file2]: [description]

**Pattern Used**: [Pattern name]

**Agents Involved**:
- testEngineer [→ specialists]
- [implementation agent] [→ specialists]

---

### ✅ VERIFICATION

**Test Status**: ALL PASSING
**Tests**: [N]/[N] passing
**Coverage**: [X]%
**Warnings**: [None/details]

---

### 📚 MEMORY BANK

✓ tasks.md updated (task marked complete)
✓ activeContext.md updated (changes logged)
[✓] systemPatterns.md updated (if pattern added)

---

→ NEXT: [Suggested next action based on project state]
```

**If tests NOT GREEN:**

```markdown
❌ TASK INCOMPLETE: TASK-[ID]

## Task: [Task Name]

**Status**: Blocked
**Attempts**: 3/3

---

### 🚨 BLOCKER

**Test Status**: FAILING
**Passing**: [N]/[Total] tests
**Failing**: [Total-N] tests

**Persistent Failures**:
1. [Test name] - [Issue]
2. [Test name] - [Issue]

---

### 📊 ANALYSIS

**Root Cause**: [Analysis of why tests failing]

**Attempted Fixes**:
1. [Attempt 1] - Did not resolve
2. [Attempt 2] - Did not resolve
3. [Attempt 3] - Did not resolve

---

### 🔄 NEXT STEPS

**Options**:
1. Break into smaller sub-tasks: /cf:plan TASK-[ID] --interactive
2. Interactive debugging: /cf:facilitate test-debugging
3. Architectural guidance: /cf:ask architect [question]
4. Review requirements: Check acceptance criteria

**Task remains BLOCKED until tests pass**

❌ Cannot mark complete with failing tests
```

---

## Examples

### Example 1: Simple Implementation (Level 1)

```
User: /cf:code TASK-004

Claude:
📋 LOADING CONTEXT
- Task: TASK-004 - Fix typo in header component
- Level: 1 (Quick Fix)
- Files: components/Header.tsx

---

🧪 TDD PHASE: RED

testEngineer: Writing tests for header typo fix...

Tests written:
- components/Header.test.tsx (1 test)

Running tests... ❌ RED confirmed

---

💻 IMPLEMENTATION PHASE

uiDeveloper: Fixing typo in header component...

File modified:
- components/Header.tsx (line 42: "Heelo" → "Hello")

---

🧪 TDD PHASE: GREEN

Running tests... ✅ ALL PASSING

Tests: 1/1 passing
Coverage: 100%

→ GREEN GATE PASSED

---

✅ TASK COMPLETE: TASK-004

Duration: 5 minutes
Files: components/Header.tsx
Tests: ✅ 1/1 passing

→ NEXT: Ready for next task
```

### Example 2: Complex Implementation with Specialists (Level 3)

```
User: /cf:code TASK-006-3

Claude:
📋 LOADING CONTEXT
- Task: TASK-006-3 - Implement OAuth token management
- Level: 2 (from Level 3 parent task breakdown)
- Parent: TASK-006 - Migrate authentication to OAuth

---

🧪 TDD PHASE: RED

testEngineer: Writing OAuth token management tests...

→ Delegating to authTestSpecialist for OAuth-specific tests

Tests written:
- services/oauthTokenService.test.ts (15 tests)
  * Token generation
  * Token validation
  * Token refresh
  * Token expiration handling
  * Error cases

Running tests... ❌ RED confirmed (all 15 failing as expected)

---

💻 IMPLEMENTATION PHASE

codeImplementer: Analyzing OAuth token requirements...

→ This requires security and OAuth expertise
→ Delegating to authSecuritySpecialist

authSecuritySpecialist: Implementing OAuth token service...

Files created:
- services/oauthTokenService.ts (token management)
- utils/jwtHelper.ts (JWT utilities)
- middleware/oauthValidator.ts (token validation)

---

🧪 TDD PHASE: GREEN (Attempt 1)

Running tests... ❌ 12/15 passing

Failing:
- Token refresh with expired token
- Concurrent token refresh handling
- Token revocation propagation

Analyzing failures...

---

💻 IMPLEMENTATION (Iteration 2)

authSecuritySpecialist: Fixing token refresh logic...

Updated:
- services/oauthTokenService.ts (refresh mechanism improved)

---

🧪 TDD PHASE: GREEN (Attempt 2)

Running tests... ✅ ALL PASSING

Tests: 15/15 passing
Coverage: 94%

→ GREEN GATE PASSED

---

♻️ REFACTOR PHASE

Extracting token generation to separate function...
Re-running tests... ✅ Still passing

---

📚 MEMORY BANK UPDATES

✓ tasks.md: TASK-006-3 marked complete
✓ activeContext.md: OAuth token management implemented
✓ systemPatterns.md: OAuth token pattern added

---

✅ TASK COMPLETE: TASK-006-3

Duration: 45 minutes

Files Created:
- services/oauthTokenService.ts
- utils/jwtHelper.ts
- middleware/oauthValidator.ts

Agents Used:
- testEngineer → authTestSpecialist
- codeImplementer → authSecuritySpecialist

Pattern: OAuth 2.0 token lifecycle management

Tests: ✅ 15/15 passing (94% coverage)

---

→ NEXT: Proceed with TASK-006-4 (OAuth provider integration)
   /cf:code TASK-006-4
```

### Example 3: Test Failure After 3 Attempts

```
User: /cf:code TASK-008

Claude:
📋 LOADING CONTEXT
- Task: TASK-008 - Implement real-time notifications
- Level: 3 (Intermediate Feature)

---

🧪 TDD PHASE: RED
[Tests written and confirmed RED]

---

💻 IMPLEMENTATION (Attempt 1)
[Implementation completed]

🧪 TEST: ❌ 8/12 passing

---

💻 IMPLEMENTATION (Attempt 2)
[Fixes applied]

🧪 TEST: ❌ 10/12 passing

---

💻 IMPLEMENTATION (Attempt 3)
[More fixes applied]

🧪 TEST: ❌ 11/12 passing

---

🚨 TEST VERIFICATION BLOCKED

Attempts: 3/3 (max reached)
Status: 11/12 tests passing

Persistent Failure:
❌ should deliver notification when user offline
   Issue: WebSocket connection persists after disconnect
   Tried: Connection cleanup, timeout handling, manual close

---

📊 BLOCKER ANALYSIS

Root Cause: WebSocket lifecycle management complexity
- Connection state not properly tracked
- Reconnection logic interfering with tests
- Race condition in cleanup

This appears to need architectural review of WebSocket management.

---

🔄 RECOMMENDED NEXT STEPS

1. Break down WebSocket concerns:
   /cf:plan TASK-008 --interactive

   Suggested breakdown:
   - TASK-008a: WebSocket connection management
   - TASK-008b: Message delivery (online users)
   - TASK-008c: Offline notification queuing

2. OR get architectural guidance:
   /cf:ask architect "How to handle WebSocket lifecycle in tests?"

3. OR interactive debugging:
   /cf:facilitate websocket-debugging

---

❌ TASK-008 BLOCKED

Status: In Progress (blocked by persistent test failure)
Tests: 11/12 passing (1 failing)

Task CANNOT be marked complete with failing tests.

Memory bank NOT updated (tests must be GREEN first).
```

---

## Error Handling

### Memory Bank Not Initialized

```
⚠️ Memory Bank Not Initialized

Run: /cf:init
```

### Task Not Found

```
❌ Task TASK-099 not found in tasks.md

Available tasks:
- TASK-001: Fix header typo
- TASK-002: Add search functionality

Create new task: /cf:feature [description]
```

### Implementation Agents Not Customized

```
⚠️ Implementation Agent Needs Customization

Agent: .claude/agents/testing/testEngineer.md

This agent has TODO sections that need to be filled in for your tech stack.

Please customize:
- Testing framework
- Test commands
- Coverage thresholds
- Specialist routing rules

See agent file for details.

Proceeding with template defaults (may not work correctly)...
```

### Agent Not Found

```
❌ Agent Not Found

Looking for: .claude/agents/development/apiDeveloper.md
File does not exist.

Available agents:
- codeImplementer (development)
- uiDeveloper (ui)
- testEngineer (testing)

Options:
1. Use codeImplementer instead (recommended)
2. Create specialist: /cf:create-specialist apiDeveloper development

Proceeding with codeImplementer...
```

---

## Memory Bank Updates

### tasks.md
- Task status updated to "Complete" (ONLY if tests GREEN)
- OR status "Blocked"/"In Progress" (if tests failing)
- Test results documented
- Files modified listed
- Agents used recorded

### activeContext.md
- Recent change entry added
- Pattern used documented
- Key learnings captured

### systemPatterns.md (if applicable)
- New pattern documented
- Example code references added

---

## Notes

- **GREEN GATE is absolute** - no task complete without all tests passing
- TDD is enforced by default, use `--impl-only` sparingly
- **Agent routing**: Reads `routing.md` (if exists) for stack-specific agent selection
- **Fallback chain**: Stack-specific → Generic → Error
- **Generic agents** handle all work directly (no specialist delegation)
- **Stack-specific agents** can delegate to specialists per routing.md
- Interactive mode (`--interactive`) useful for complex or unclear tasks
- Maximum 3 iteration attempts before escalation
- Memory bank only updated when tests GREEN
- Configure team with `/cf:configure-team` for stack-specific agents

---

## Related Commands

- `/cf:feature` - Create task before coding
- `/cf:plan` - Plan Level 2+ tasks before coding
- `/cf:configure-team` - Configure stack-specific implementation team
- `/cf:review` - Review code quality after implementation
- `/cf:checkpoint` - Save state with all changes
- `/cf:create-specialist` - Create specialist agents as needed

---

**Command Version**: 1.0
**Last Updated**: 2025-10-05
**Based On**: Command_and_role_spec.md v0.4
