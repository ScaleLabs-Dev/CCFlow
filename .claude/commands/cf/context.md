---
description: "Load active project context to resume work efficiently"
allowed-tools: ['Read', 'Glob']
argument-hint: "[--full]"
---

# Command: /cf:context

## Usage

```
/cf:context [--full]
```

## Parameters

- `[--full]`: **Optional** - Load comprehensive context including all memory bank files (default: active context only)

---

## Purpose

Quickly load relevant project context to:
1. Resume work after interruption or session break
2. Understand current project state before starting tasks
3. Load active focus, recent changes, and next steps
4. Minimize time spent re-orienting to project state
5. Provide foundation for immediate productive work

---

## Prerequisites

**Memory bank must be initialized**. Run `/cf:init` first if needed.

**Some project history**. Works best after at least one checkpoint has been created.

---

## Process

### Step 1: Verify Memory Bank Exists

Check if `memory-bank/` directory exists:

**If NOT EXISTS**:
```
⚠️ Memory Bank Not Initialized

Run: /cf:init
```

**Stop execution.**

---

### Step 2: Determine Context Scope

**Default (no flags)**:
- Load **active context only** for quick resumption
- Minimal memory bank reading for fast operation
- Focus on "what to do next"

**With --full flag**:
- Load **comprehensive context** including all memory bank files
- Full project understanding
- Useful for deep work or after long time away

---

### Step 3: Load Active Context (Default Mode)

**Read activeContext.md**:

Extract and present:

1. **Current Focus**: What task/area is actively being worked on
2. **Recent Changes**: Last 5-10 entries from recent changes log
3. **Immediate Next Steps**: Prioritized next actions
4. **Active Decisions**: Decisions currently being made or considered
5. **Blockers**: Any impediments to progress

**Read tasks.md** (targeted):

Extract and present:

1. **Active Tasks**: Tasks currently in progress with their status
2. **Next Pending Task**: Highest priority not-yet-started task
3. **Blocked Tasks**: Tasks waiting on dependencies or external factors

**Optional Git Integration**:

If git is available, show:
- Current branch
- Uncommitted changes (if any)
- Recent commits (last 3-5)

---

### Step 4: Load Full Context (--full Flag Mode)

**Read ALL memory bank files**:

1. **projectbrief.md**: Scope, objectives, constraints
2. **productContext.md**: Features, requirements, user context
3. **systemPatterns.md**: Architecture, patterns, conventions
4. **activeContext.md**: Current state (same as default mode)
5. **progress.md**: Completed work, milestones, technical debt
6. **tasks.md**: All tasks (full list, not just active)

**Synthesize comprehensive understanding**:
- Project goals and current progress toward them
- Technical approach and established patterns
- Completed vs. remaining work
- Current focus in context of overall project

---

### Step 5: Format Context Output

#### Default Mode Output

```markdown
📋 ACTIVE CONTEXT
─────────────────────────────

**Project**: [Project Name]
**Last Updated**: [YYYY-MM-DD HH:MM] (from last checkpoint)
**Session**: [New/Resumed]

## Current Focus

**Primary Task**: TASK-[ID] - [Task Name]
**Status**: [In Progress - X% complete / Not Started / Planning]
**Started**: [YYYY-MM-DD]
**Expected Completion**: [YYYY-MM-DD or estimate]

**What we're doing**:
[Brief description of current work]

**Why it matters**:
[Connection to project goals]

**Progress**:
[Specific progress indicators - e.g., "Tests written (GREEN ✅), implementation 60% complete"]

## Recent Activity (Last 5 Changes)

1. **[YYYY-MM-DD HH:MM]** - [Change description]
   - Impact: [What changed]
   - Agent/Action: [Who/what made the change]

2. **[YYYY-MM-DD HH:MM]** - [Change description]
   - Impact: [What changed]

3. **[YYYY-MM-DD HH:MM]** - [Change description]

4. **[YYYY-MM-DD HH:MM]** - [Change description]

5. **[YYYY-MM-DD HH:MM]** - [Change description]

## Immediate Next Steps

1. **[Next action 1]** (Priority: High)
   - Task: TASK-[ID] (if applicable)
   - Context: [Why this is next]

2. **[Next action 2]** (Priority: Medium)
   - Task: TASK-[ID] (if applicable)
   - Context: [Why this follows]

3. **[Next action 3]** (Priority: Low)
   - Context: [Future consideration]

## Active Tasks (In Progress)

- **TASK-[ID]**: [Name] (Level [1-4]) - [Progress description]
  - Status: [Specific status]
  - Blocker: [If any]

- **TASK-[ID]**: [Name] (Level [1-4]) - [Progress description]
  - Status: [Specific status]

**Total Active**: [N] tasks in progress

## Blockers (if any)

- **TASK-[ID]**: [Blocker description]
  - Since: [YYYY-MM-DD]
  - Resolution: [Proposed approach or waiting for...]

## Git Status (if available)

**Branch**: [branch-name]
**Uncommitted Changes**: [N] files modified
**Recent Commits**:
- [hash] - [commit message] ([time ago])
- [hash] - [commit message] ([time ago])

---

**Ready to Continue**:
Recommended next action: [Specific command or work to start]

**Estimated Context Load Time**: [seconds]
```

#### Full Context Mode Output

```markdown
📚 COMPREHENSIVE PROJECT CONTEXT
─────────────────────────────────

**Project**: [Project Name]
**Phase**: [Planning/Development/Testing/Refinement]
**Progress**: [X]% complete
**Status**: [On Track/At Risk]
**Last Updated**: [YYYY-MM-DD HH:MM]

## Project Overview

**Objective**:
[Primary project objective from projectbrief.md]

**Scope**:
- [Scope element 1]
- [Scope element 2]
- [Scope element 3]

**Constraints**:
- Timeline: [Duration or deadline]
- Resources: [Team size, budget, etc.]
- Technical: [Technology constraints]

## Features & Requirements

### Implemented Features (✅ [N] complete)
- [Feature 1]: [Brief description] - Completed [YYYY-MM-DD]
- [Feature 2]: [Brief description] - Completed [YYYY-MM-DD]

### In Progress Features (🔄 [N] active)
- [Feature 1]: [Brief description] - [X]% complete
- [Feature 2]: [Brief description] - [X]% complete

### Planned Features (⏳ [N] pending)
- [Feature 1]: [Brief description] - Priority [P1/P2/P3]
- [Feature 2]: [Brief description] - Priority [P1/P2/P3]

## Architecture & Patterns

**Architecture Style**: [Monolith/Microservices/Serverless/etc.]

**Tech Stack**:
- Backend: [Technologies]
- Frontend: [Technologies]
- Database: [Technologies]
- Infrastructure: [Technologies]

**Key Patterns** ([N] established):
- [Pattern 1]: [Brief description]
- [Pattern 2]: [Brief description]
- [Pattern 3]: [Brief description]

[See systemPatterns.md for full details]

## Progress Summary

**Completed Work**:
- ✅ [N] tasks completed
- ✅ [N] features delivered
- ✅ [N] milestones reached

**Timeline**:
- Started: [YYYY-MM-DD]
- Current Week: [Week N of M]
- Expected Completion: [YYYY-MM-DD]
- On Track: [Yes/No - with reason]

**Recent Milestones**:
- [YYYY-MM-DD]: [Milestone 1]
- [YYYY-MM-DD]: [Milestone 2]

**Upcoming Milestones**:
- [YYYY-MM-DD]: [Milestone 1]
- [YYYY-MM-DD]: [Milestone 2]

## Current Focus

**Primary Task**: TASK-[ID] - [Task Name]
**Status**: [Detailed status]
**Progress**: [Specific indicators]

[Same as Default Mode "Current Focus" section]

## Technical Debt

**Total Debt Items**: [N] ([High]/[Medium]/[Low] priority)

**High Priority** (🔴 [N] items):
- [Debt item 1] - Estimated effort: [time]

**Medium Priority** (🟡 [N] items):
- [Debt item 1] - Estimated effort: [time]

**Low Priority** (🟢 [N] items):
- [Summary of low priority items]

## Recent Activity

[Same as Default Mode "Recent Activity" section]

## All Tasks Summary

**Status Breakdown**:
- ✅ Complete: [N] tasks
- 🔄 In Progress: [N] tasks
- ⏳ Pending: [N] tasks
- 🚫 Blocked: [N] tasks

**By Priority**:
- P1 (High): [N] tasks ([breakdown by status])
- P2 (Medium): [N] tasks ([breakdown by status])
- P3 (Low): [N] tasks ([breakdown by status])

**By Complexity**:
- Level 1 (Quick): [N] tasks
- Level 2 (Simple): [N] tasks
- Level 3 (Intermediate): [N] tasks
- Level 4 (Complex): [N] tasks

## Immediate Next Steps

[Same as Default Mode section]

## Key Decisions

**Recent Decisions** (Last 5):
1. **[YYYY-MM-DD]**: [Decision 1]
   - Rationale: [Brief rationale]

2. **[YYYY-MM-DD]**: [Decision 2]
   - Rationale: [Brief rationale]

[See projectbrief.md for full decision log]

## Blockers & Risks

[Same as Default Mode "Blockers" section, plus:]

**Risk Assessment**:
- Active Risks: [N] risks being monitored
- Mitigation Plans: [Summary of risk responses]

## Git Status

[Same as Default Mode section]

---

**Context Fully Loaded** ✓

**Files Read**:
✓ projectbrief.md
✓ productContext.md
✓ systemPatterns.md
✓ activeContext.md
✓ progress.md
✓ tasks.md

**Recommended Next Action**: [Specific command or work to start]

**Estimated Context Load Time**: [seconds]
```

---

### Step 6: Provide Next Action Recommendation

**Based on loaded context, suggest specific next action**:

**If active task exists and is clear**:
```
**Recommended Next Action**:
Continue TASK-[ID]: [Task name]
Command: /cf:code TASK-[ID]
Context: [Why this is the right next step]
```

**If no clear active task**:
```
**Recommended Next Action**:
Start highest priority pending task: TASK-[ID]
Command: /cf:code TASK-[ID] (Level 1) or /cf:plan TASK-[ID] (Level 2+)
Context: [Why this should be next]
```

**If blockers exist**:
```
**Recommended Next Action**:
Address blocker for TASK-[ID]: [Blocker description]
Suggested approach: [How to unblock]
Context: [Why unblocking is priority]
```

**If checkpoint is overdue**:
```
**Recommended Next Action**:
Create checkpoint to preserve recent work
Command: /cf:checkpoint
Context: Last checkpoint was [duration] ago
```

---

## Examples

### Example 1: Quick Resume (Default Mode)

```
User: /cf:context

Claude:
[Loads activeContext.md and tasks.md...]

📋 ACTIVE CONTEXT
─────────────────────────────

**Project**: E-Commerce Platform
**Last Updated**: 2025-10-05 14:30 (from last checkpoint)
**Session**: Resumed

## Current Focus

**Primary Task**: TASK-032 - Payment Gateway Integration
**Status**: In Progress - 60% complete
**Started**: 2025-10-03
**Expected Completion**: 2025-10-08

**What we're doing**:
Integrating Stripe payment gateway with checkout flow. Implementing webhook
handlers for payment confirmations and refunds.

**Why it matters**:
Critical path feature for Q4 launch. Enables revenue generation. Highest
priority P1 task.

**Progress**:
Tests written (GREEN ✅), webhook handlers implemented (2 of 4 complete),
checkout integration 60% done.

## Recent Activity (Last 5 Changes)

1. **2025-10-05 14:30** - Checkpoint Created
   - Impact: Session work documented
   - Agent: Documentarian

2. **2025-10-05 13:15** - Payment webhook handler completed
   - Impact: payment.succeeded event now handled correctly
   - Action: Implementation (codeImplementer)

3. **2025-10-05 11:45** - Tests written for webhook handlers
   - Impact: TDD RED phase complete, 8 tests written
   - Agent: testEngineer

4. **2025-10-04 16:20** - Stripe SDK integrated
   - Impact: Foundation for payment processing in place
   - Action: Dependency added

5. **2025-10-03 10:00** - TASK-032 started (Planning)
   - Impact: Architect and Product analysis complete
   - Agent: Architect, Product

## Immediate Next Steps

1. **Complete remaining webhook handlers** (Priority: High)
   - Task: TASK-032 (current)
   - Context: 2 of 4 handlers remain (refund, dispute)

2. **Integrate webhooks with checkout flow** (Priority: High)
   - Task: TASK-032 (current)
   - Context: Follows webhook handler completion

3. **End-to-end payment testing** (Priority: High)
   - Task: TASK-032 (current)
   - Context: Final step before marking task complete

## Active Tasks (In Progress)

- **TASK-032**: Payment Gateway Integration (Level 3) - 60% complete
  - Status: Webhook handlers in progress (2 of 4 done)
  - No blockers

**Total Active**: 1 task in progress

## Blockers

No active blockers.

## Git Status

**Branch**: feature/payment-integration
**Uncommitted Changes**: 3 files modified
**Recent Commits**:
- a3f9d21 - Add payment webhook handler (2 hours ago)
- 8b4c156 - Integrate Stripe SDK (yesterday)
- 2e7a093 - Write webhook handler tests (yesterday)

---

**Ready to Continue**:
Recommended next action: Continue TASK-032 - implement refund webhook handler

Command: /cf:code TASK-032

**Estimated Context Load Time**: 2 seconds
```

### Example 2: Deep Context After Time Away (--full Mode)

```
User: /cf:context --full

Claude:
[Loads ALL memory bank files for comprehensive synthesis...]

📚 COMPREHENSIVE PROJECT CONTEXT
─────────────────────────────────

**Project**: E-Commerce Platform
**Phase**: Development
**Progress**: 73% complete
**Status**: On Track ✅
**Last Updated**: 2025-10-05 14:30

## Project Overview

**Objective**:
Build B2C marketplace for handmade goods, enabling artisans to sell directly
to consumers with integrated payment processing and order management.

**Scope**:
- User authentication and authorization (JWT-based)
- Product catalog with search and filtering
- Shopping cart and checkout flow
- Payment processing (Stripe integration)
- Order management and tracking
- Seller dashboard (Phase 2)

**Constraints**:
- Timeline: 16 weeks (Q4 2025 launch - Week 12 of 16)
- Resources: 6-person team, $50k budget
- Technical: Must support 10k concurrent users, WCAG 2.1 AA compliance

## Features & Requirements

### Implemented Features (✅ 4 complete)
- User Authentication: JWT-based auth with refresh tokens - Completed 2025-09-22
- Product Catalog: Search, filtering, pagination - Completed 2025-09-28
- Shopping Cart: Add/remove, quantity management - Completed 2025-10-01
- Checkout Flow: Address, shipping, payment UI - Completed 2025-10-02

### In Progress Features (🔄 1 active)
- Payment Processing: Stripe integration - 60% complete (TASK-032)

### Planned Features (⏳ 2 pending)
- Order Management: Order tracking, history, status updates - Priority P1
- Email Notifications: Order confirmations, shipping updates - Priority P2

## Architecture & Patterns

**Architecture Style**: Microservices (3 services)

**Tech Stack**:
- Backend: Node.js 18, Express 4.18, TypeScript 5.1
- Frontend: React 18.2, Vite 4.3, TailwindCSS 3.3
- Database: PostgreSQL 15, Prisma ORM 5.0
- Infrastructure: Docker, AWS (ECS, RDS, S3)

**Key Patterns** (12 established):
- Error Handling: RFC 7807 Problem Details format
- Validation: Joi schemas, centralized validators
- API Response: Consistent JSON envelope structure
- Authentication: JWT with refresh token rotation
- Database Access: Repository pattern with Prisma

[See systemPatterns.md for full details]

## Progress Summary

**Completed Work**:
- ✅ 18 tasks completed
- ✅ 4 features delivered
- ✅ 3 milestones reached (Auth, Catalog, Cart)

**Timeline**:
- Started: 2025-07-15
- Current Week: Week 12 of 16
- Expected Completion: 2025-11-08 (Q4 launch target)
- On Track: Yes ✅ (ahead by 3 days)

**Recent Milestones**:
- 2025-09-22: Authentication feature complete
- 2025-09-28: Product catalog complete
- 2025-10-01: Shopping cart complete

**Upcoming Milestones**:
- 2025-10-08: Payment processing complete (current)
- 2025-10-22: Order management complete
- 2025-11-01: Beta testing begins

## Current Focus

**Primary Task**: TASK-032 - Payment Gateway Integration
**Status**: In Progress - 60% complete
**Progress**: Tests GREEN ✅, 2 of 4 webhook handlers complete

[Rest same as Default Mode example...]

## Technical Debt

**Total Debt Items**: 14 (2 High / 7 Medium / 5 Low)

**High Priority** (🔴 2 items):
- Database connection pooling inefficiency - Estimated effort: 4 hours
- Missing integration tests for cart edge cases - Estimated effort: 6 hours

**Medium Priority** (🟡 7 items):
- API response caching not implemented - Estimated effort: 8 hours
- Error logging missing correlation IDs - Estimated effort: 3 hours
- [5 more items...]

**Low Priority** (🟢 5 items):
- Code cleanup and refactoring opportunities - Estimated effort: 8 hours total

## Recent Activity

[Same as Default Mode example...]

## All Tasks Summary

**Status Breakdown**:
- ✅ Complete: 18 tasks
- 🔄 In Progress: 1 task (TASK-032)
- ⏳ Pending: 12 tasks
- 🚫 Blocked: 0 tasks

**By Priority**:
- P1 (High): 8 tasks (6 complete, 1 in progress, 1 pending)
- P2 (Medium): 15 tasks (10 complete, 0 in progress, 5 pending)
- P3 (Low): 8 tasks (2 complete, 0 in progress, 6 pending)

**By Complexity**:
- Level 1 (Quick): 10 tasks (8 complete)
- Level 2 (Simple): 12 tasks (7 complete)
- Level 3 (Intermediate): 7 tasks (3 complete, 1 in progress)
- Level 4 (Complex): 2 tasks (0 complete)

## Immediate Next Steps

[Same as Default Mode example...]

## Key Decisions

**Recent Decisions** (Last 5):
1. **2025-10-03**: Use Stripe over PayPal for payment processing
   - Rationale: Better developer experience, lower fees, stronger fraud detection

2. **2025-09-15**: PostgreSQL over MongoDB for data storage
   - Rationale: ACID guarantees needed for financial data, team expertise

3. **2025-09-10**: Microservices architecture (3 services)
   - Rationale: Team scale, independent deployment, service boundaries clear

4. **2025-08-28**: React with Vite over Next.js
   - Rationale: SPA sufficient, no SSR needed, team preference

5. **2025-08-20**: TypeScript enforcement across codebase
   - Rationale: Type safety, better IDE support, fewer runtime errors

[See projectbrief.md for full decision log with alternatives considered]

## Blockers & Risks

**Blockers**: None currently

**Risk Assessment**:
- Active Risks: 2 risks being monitored
  - Risk: Stripe API rate limits in production
  - Mitigation: Implementing request queuing and retry logic

## Git Status

[Same as Default Mode example...]

---

**Context Fully Loaded** ✓

**Files Read**:
✓ projectbrief.md
✓ productContext.md
✓ systemPatterns.md
✓ activeContext.md
✓ progress.md
✓ tasks.md

**Recommended Next Action**:
Continue TASK-032: Complete refund webhook handler
Command: /cf:code TASK-032

**Estimated Context Load Time**: 8 seconds
```

### Example 3: First Session (No Active Context)

```
User: /cf:context

Claude:
[Loads activeContext.md - finds no current focus...]

📋 ACTIVE CONTEXT
─────────────────────────────

**Project**: New Project
**Last Updated**: 2025-10-05 09:00 (initialization)
**Session**: New (No active work yet)

## Current Focus

**No active focus set**

The project was recently initialized but no tasks have been started yet.

## Recent Activity

1. **2025-10-05 09:00** - Project initialized
   - Impact: Memory bank created
   - Action: /cf:init command

## Immediate Next Steps

1. **Create first task** (Priority: High)
   - Command: /cf:feature [task description]
   - Context: Define what needs to be built first

2. **Review project brief** (Priority: Medium)
   - File: memory-bank/projectbrief.md
   - Context: Understand project scope and objectives

3. **Set up development environment** (Priority: Medium)
   - Context: Initialize git, install dependencies, configure tools

## Active Tasks

**No tasks created yet**

Use /cf:feature [description] to create your first task.

## Blockers

None.

## Git Status

**Branch**: main (or not initialized)
**Status**: Clean working directory

---

**Ready to Start**:
Recommended next action: Create your first task

Command: /cf:feature [description of first feature to build]

Example: /cf:feature set up user authentication system

**Estimated Context Load Time**: 1 second
```

---

## Error Handling

### Memory Bank Not Initialized

```
⚠️ Memory Bank Not Initialized

Memory bank not found at: memory-bank/

To initialize, run: /cf:init

Example: /cf:init MyProject
```

### Memory Bank Empty

```
⚠️ No Context Available

Memory bank exists but contains no active context.

Suggestions:
1. Create your first task: /cf:feature [description]
2. Review project brief: Read memory-bank/projectbrief.md
3. Check initialization: /cf:sync

The memory bank needs content before context can be loaded.
```

---

## Integration with Other Commands

**Typical workflow patterns**:

```
# Starting new session
/cf:context → Load where you left off
[Resume work on current task]
/cf:checkpoint → Save progress

# After long break
/cf:context --full → Deep re-immersion
/cf:ask [questions] → Clarify any confusion
[Resume work with full understanding]

# Multiple times per session
/cf:context → Quick re-orient before switching tasks
/cf:code TASK-[ID] → Work on task
/cf:context → Check what's next

# New team member
/cf:context --full → Understand entire project
/cf:ask [questions] → Deep dive on specific areas
[Get up to speed efficiently]
```

**When to use each mode**:

**Default mode** (/cf:context):
- Starting work session
- Quick re-orientation
- Checking next steps
- Multiple times per day

**Full mode** (/cf:context --full):
- After vacation or long break
- New team member onboarding
- Before major planning sessions
- Deep project understanding needed
- First time working on project area

---

## Notes

- **Read-only operation**: Never modifies memory bank
- **Fast default mode**: 1-3 seconds to load active context
- **Comprehensive full mode**: 5-10 seconds for complete project understanding
- **Smart recommendations**: Suggests specific next action based on state
- **Git integration**: Shows uncommitted work and recent commits if available
- **Session awareness**: Detects new vs. resumed sessions
- **Efficient resumption**: Minimize "where was I?" time
- **Pairs with /cf:ask**: Use /cf:context for overview, /cf:ask for specific questions

**Best practices**:
- Run /cf:context at start of every work session
- Use default mode for quick daily resumption
- Use --full mode after time away (>1 week) or for deep understanding
- Follow recommended next action for efficient workflow
- Combine with /cf:ask for clarification on specific items
- Create checkpoint before ending session to ensure context is current

---

## Related Commands

- `/cf:sync` - Full memory bank status (more detailed than /cf:context)
- `/cf:ask` - Query specific information (targeted vs. overview)
- `/cf:status` - Quick task list (less context than /cf:context)
- `/cf:checkpoint` - Create checkpoint to update context
- `/cf:code` - Typical next action after loading context

---

**Command Version**: 1.0
**Last Updated**: 2025-10-05
