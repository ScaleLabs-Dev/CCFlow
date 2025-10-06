---
description: "Quick task status overview without detailed context loading"
allowed-tools: ['Read']
argument-hint: "[--filter status|priority|complexity]"
---

# Command: /cf:status

## Usage

```
/cf:status [--filter status|priority|complexity]
```

## Parameters

- `[--filter status]`: **Optional** - Filter by task status (pending|active|complete|blocked)
- `[--filter priority]`: **Optional** - Filter by priority level (p1|p2|p3)
- `[--filter complexity]`: **Optional** - Filter by complexity level (1|2|3|4)

---

## Purpose

Provide fast, lightweight task status view for:
1. Quick "what's on my plate" check
2. Task list without full context loading
3. Priority-based task selection
4. Blocker identification
5. Progress overview at a glance

---

## Prerequisites

**Memory bank must be initialized**. Run `/cf:init [project-name]` first if needed.

**Tasks exist**. Create tasks with `/cf:feature` before checking status.

---

## Process

### Step 1: Verify Memory Bank Exists

Check if `memory-bank/` directory exists:

**If NOT EXISTS**:
```
⚠️ Memory Bank Not Initialized

Run: /cf:init [project-name]
```

**Stop execution.**

---

### Step 2: Load Task Data

**Read tasks.md only** (minimal file reading for speed):

Extract:
- All task entries with their metadata
- Task IDs, names, status, priority, complexity
- Progress indicators for active tasks
- Blocker information if present

**Do NOT read** (for speed):
- Other memory bank files (unless needed for specific filters)
- Full task descriptions
- Detailed acceptance criteria
- Sub-task breakdowns

---

### Step 3: Apply Filters (If Specified)

**No filter (default)**:
- Show all tasks grouped by status

**--filter status=pending**:
- Show only pending (not started) tasks
- Sorted by priority (P1 → P2 → P3)

**--filter status=active**:
- Show only in-progress tasks
- Include progress indicators

**--filter status=complete**:
- Show only completed tasks
- Include completion dates

**--filter status=blocked**:
- Show only blocked tasks
- Include blocker descriptions

**--filter priority=p1** (or p2, p3):
- Show only tasks at specified priority
- Grouped by status

**--filter complexity=1** (or 2, 3, 4):
- Show only tasks at specified complexity level
- Grouped by status

---

### Step 4: Format Status Output

#### Default Output (All Tasks)

```markdown
📊 TASK STATUS
─────────────────────────────

**Project**: [Project Name]
**Total Tasks**: [N] ([breakdown by status])
**Last Updated**: [YYYY-MM-DD] (from tasks.md)

## 🔄 Active Tasks ([N])

**TASK-[ID]**: [Task Name] (Level [1-4], Priority [P1-3])
├─ Status: In Progress ([X]% complete or description)
├─ Started: [YYYY-MM-DD]
└─ [Progress indicator - e.g., "Tests GREEN ✅, implementation 60%"]

**TASK-[ID]**: [Task Name] (Level [1-4], Priority [P1-3])
├─ Status: In Progress
├─ Started: [YYYY-MM-DD]
└─ [Progress indicator]

---

## ⏳ Pending Tasks ([N])

### High Priority (P1) - [N] tasks
- **TASK-[ID]**: [Task Name] (Level [1-4])
- **TASK-[ID]**: [Task Name] (Level [1-4])

### Medium Priority (P2) - [N] tasks
- **TASK-[ID]**: [Task Name] (Level [1-4])
- **TASK-[ID]**: [Task Name] (Level [1-4])

### Low Priority (P3) - [N] tasks
- **TASK-[ID]**: [Task Name] (Level [1-4])

---

## ✅ Completed Tasks ([N]) [Last 5 shown]

- **TASK-[ID]**: [Task Name] - Completed [YYYY-MM-DD]
- **TASK-[ID]**: [Task Name] - Completed [YYYY-MM-DD]
- **TASK-[ID]**: [Task Name] - Completed [YYYY-MM-DD]
- **TASK-[ID]**: [Task Name] - Completed [YYYY-MM-DD]
- **TASK-[ID]**: [Task Name] - Completed [YYYY-MM-DD]

[+ [N] more completed tasks - use --filter status=complete to see all]

---

## 🚫 Blocked Tasks ([N])

**TASK-[ID]**: [Task Name] (Level [1-4], Priority [P1-3])
├─ Status: Blocked
├─ Blocker: [Blocker description]
├─ Since: [YYYY-MM-DD]
└─ Resolution: [Proposed approach or waiting for...]

---

**Summary**:
✅ Complete: [N] | 🔄 Active: [N] | ⏳ Pending: [N] | 🚫 Blocked: [N]

**Next Recommended Task**: TASK-[ID] - [Name] (Priority [P1-3])

**Quick Commands**:
- Start task: /cf:code TASK-[ID] (Level 1) or /cf:plan TASK-[ID] (Level 2+)
- Full context: /cf:context
- Filter tasks: /cf:status --filter [status|priority|complexity]=[value]
```

#### Filtered Output Examples

**Filter by Status (--filter status=pending)**:

```markdown
⏳ PENDING TASKS
─────────────────────────────

**Project**: [Project Name]
**Total Pending**: [N] tasks

### High Priority (P1) - [N] tasks

**TASK-[ID]**: [Task Name]
├─ Complexity: Level [1-4]
├─ Effort Estimate: [time]
└─ Prerequisites: [If any]

**TASK-[ID]**: [Task Name]
├─ Complexity: Level [1-4]
├─ Effort Estimate: [time]
└─ Prerequisites: TASK-[ID] (must complete first)

### Medium Priority (P2) - [N] tasks

**TASK-[ID]**: [Task Name] (Level [1-4])
**TASK-[ID]**: [Task Name] (Level [1-4])

### Low Priority (P3) - [N] tasks

**TASK-[ID]**: [Task Name] (Level [1-4])

---

**Recommended Next**: TASK-[ID] (highest priority with no prerequisites)

**Start with**: /cf:code TASK-[ID] or /cf:plan TASK-[ID]
```

**Filter by Priority (--filter priority=p1)**:

```markdown
🎯 HIGH PRIORITY TASKS (P1)
─────────────────────────────

**Project**: [Project Name]
**Total P1 Tasks**: [N]

## Status Breakdown

### ✅ Complete ([N])
- TASK-[ID]: [Name] - Completed [YYYY-MM-DD]
- TASK-[ID]: [Name] - Completed [YYYY-MM-DD]

### 🔄 Active ([N])
**TASK-[ID]**: [Name] (Level [1-4])
└─ Progress: [X]% complete, [description]

### ⏳ Pending ([N])
**TASK-[ID]**: [Name] (Level [1-4])
**TASK-[ID]**: [Name] (Level [1-4])

### 🚫 Blocked ([N])
**TASK-[ID]**: [Name] (Level [1-4])
└─ Blocker: [Description]

---

**P1 Progress**: [X] of [N] P1 tasks complete ([Y]%)

**Next P1 Task**: TASK-[ID] - [Name]
```

**Filter by Complexity (--filter complexity=1)**:

```markdown
⚡ QUICK TASKS (Level 1)
─────────────────────────────

**Project**: [Project Name]
**Total Level 1 Tasks**: [N]

## Status Breakdown

### ✅ Complete ([N])
- TASK-[ID]: [Name] - Completed [YYYY-MM-DD] ([duration])
- TASK-[ID]: [Name] - Completed [YYYY-MM-DD] ([duration])

### 🔄 Active ([N])
**TASK-[ID]**: [Name] (Priority [P1-3])
└─ Status: [Description]

### ⏳ Pending ([N])

#### Priority P1 ([N] tasks)
- TASK-[ID]: [Name]

#### Priority P2 ([N] tasks)
- TASK-[ID]: [Name]
- TASK-[ID]: [Name]

---

**Level 1 Velocity**: [N] tasks completed (avg [X] hours each)

**Next Quick Win**: TASK-[ID] - [Name] (Priority [P1-3])

💡 Tip: Level 1 tasks are great for quick progress or warm-up work
```

**Filter by Blocked (--filter status=blocked)**:

```markdown
🚫 BLOCKED TASKS
─────────────────────────────

**Project**: [Project Name]
**Total Blocked**: [N] tasks

**TASK-[ID]**: [Task Name] (Level [1-4], Priority [P1-3])
├─ Blocker: [Detailed blocker description]
├─ Blocked Since: [YYYY-MM-DD] ([duration] ago)
├─ Impact: [What's delayed by this blocker]
├─ Owner: [Person responsible - if assigned]
└─ Resolution Approach: [Proposed solution or waiting for...]

**TASK-[ID]**: [Task Name] (Level [1-4], Priority [P1-3])
├─ Blocker: [Detailed blocker description]
├─ Blocked Since: [YYYY-MM-DD] ([duration] ago)
├─ Impact: [What's delayed]
└─ Resolution Approach: [Approach]

---

**Critical Blockers**: [N] P1 tasks blocked
**Action Required**: [Summary of what needs to happen to unblock]

**Alternative Tasks** (unblocked work available):
- TASK-[ID]: [Name] (Priority [P1-3])
- TASK-[ID]: [Name] (Priority [P1-3])
```

---

## Examples

### Example 1: Default Status (All Tasks)

```
User: /cf:status

Claude:
[Reads tasks.md only...]

📊 TASK STATUS
─────────────────────────────

**Project**: E-Commerce Platform
**Total Tasks**: 31 (18 complete, 1 active, 12 pending, 0 blocked)
**Last Updated**: 2025-10-05

## 🔄 Active Tasks (1)

**TASK-032**: Payment Gateway Integration (Level 3, Priority P1)
├─ Status: In Progress (60% complete)
├─ Started: 2025-10-03
└─ Tests GREEN ✅, webhook handlers 2 of 4 complete

---

## ⏳ Pending Tasks (12)

### High Priority (P1) - 2 tasks
- **TASK-035**: Order Management System (Level 3)
- **TASK-040**: End-to-End Integration Tests (Level 2)

### Medium Priority (P2) - 5 tasks
- **TASK-042**: Email Notification Service (Level 2)
- **TASK-043**: Product Review System (Level 2)
- **TASK-045**: Advanced Search Filters (Level 3)
- **TASK-048**: Seller Dashboard MVP (Level 4)
- **TASK-050**: Performance Optimization (Level 2)

### Low Priority (P3) - 5 tasks
- **TASK-052**: Wishlist Feature (Level 1)
- **TASK-053**: Product Recommendations (Level 3)
- **TASK-055**: Admin Analytics (Level 3)
- **TASK-058**: Mobile App Exploration (Level 4)
- **TASK-060**: Code Cleanup Sprint (Level 1)

---

## ✅ Completed Tasks (18) [Last 5 shown]

- **TASK-031**: Checkout Flow UI - Completed 2025-10-02
- **TASK-028**: Shopping Cart Implementation - Completed 2025-10-01
- **TASK-024**: Product Catalog Search - Completed 2025-09-28
- **TASK-018**: User Profile Management - Completed 2025-09-25
- **TASK-011**: Authentication Integration Tests - Completed 2025-09-22

[+ 13 more completed tasks - use --filter status=complete to see all]

---

## 🚫 Blocked Tasks (0)

No tasks currently blocked.

---

**Summary**:
✅ Complete: 18 | 🔄 Active: 1 | ⏳ Pending: 12 | 🚫 Blocked: 0

**Next Recommended Task**: TASK-032 (continue current) or TASK-035 (next P1)

**Quick Commands**:
- Continue current: /cf:code TASK-032
- Start next: /cf:plan TASK-035 (Level 3 requires planning)
- Full context: /cf:context
```

### Example 2: Pending Tasks Only

```
User: /cf:status --filter status=pending

Claude:
[Reads tasks.md, filters pending tasks...]

⏳ PENDING TASKS
─────────────────────────────

**Project**: E-Commerce Platform
**Total Pending**: 12 tasks

### High Priority (P1) - 2 tasks

**TASK-035**: Order Management System
├─ Complexity: Level 3 (Intermediate Feature)
├─ Effort Estimate: 8-12 hours
└─ Prerequisites: TASK-032 (Payment integration - currently in progress)

**TASK-040**: End-to-End Integration Tests
├─ Complexity: Level 2 (Simple Enhancement)
├─ Effort Estimate: 4-6 hours
└─ Prerequisites: TASK-035 (Order system must exist)

### Medium Priority (P2) - 5 tasks

**TASK-042**: Email Notification Service (Level 2)
**TASK-043**: Product Review System (Level 2)
**TASK-045**: Advanced Search Filters (Level 3)
**TASK-048**: Seller Dashboard MVP (Level 4)
**TASK-050**: Performance Optimization (Level 2)

### Low Priority (P3) - 5 tasks

**TASK-052**: Wishlist Feature (Level 1)
**TASK-053**: Product Recommendations (Level 3)
**TASK-055**: Admin Analytics (Level 3)
**TASK-058**: Mobile App Exploration (Level 4)
**TASK-060**: Code Cleanup Sprint (Level 1)

---

**Recommended Next**: Complete TASK-032 first, then TASK-035 becomes available

**Start with**: /cf:code TASK-032 (finish current task)
```

### Example 3: High Priority Tasks Only

```
User: /cf:status --filter priority=p1

Claude:
[Reads tasks.md, filters P1 tasks...]

🎯 HIGH PRIORITY TASKS (P1)
─────────────────────────────

**Project**: E-Commerce Platform
**Total P1 Tasks**: 8

## Status Breakdown

### ✅ Complete (5)
- TASK-011: Authentication Integration Tests - Completed 2025-09-22
- TASK-015: Product Catalog Core - Completed 2025-09-25
- TASK-020: Shopping Cart Backend - Completed 2025-09-30
- TASK-028: Shopping Cart Implementation - Completed 2025-10-01
- TASK-031: Checkout Flow UI - Completed 2025-10-02

### 🔄 Active (1)
**TASK-032**: Payment Gateway Integration (Level 3)
└─ Progress: 60% complete, webhook handlers 2 of 4 done

### ⏳ Pending (2)
**TASK-035**: Order Management System (Level 3)
**TASK-040**: End-to-End Integration Tests (Level 2)

### 🚫 Blocked (0)
No P1 tasks blocked.

---

**P1 Progress**: 5 of 8 P1 tasks complete (63%)

**Next P1 Task**: Complete TASK-032, then start TASK-035
```

### Example 4: Quick Tasks (Level 1)

```
User: /cf:status --filter complexity=1

Claude:
[Reads tasks.md, filters Level 1 tasks...]

⚡ QUICK TASKS (Level 1)
─────────────────────────────

**Project**: E-Commerce Platform
**Total Level 1 Tasks**: 10

## Status Breakdown

### ✅ Complete (8)
- TASK-003: Fix login form validation - Completed 2025-09-15 (45 min)
- TASK-007: Update error messages - Completed 2025-09-18 (30 min)
- TASK-012: Add product image placeholders - Completed 2025-09-23 (20 min)
- TASK-019: Fix cart quantity bug - Completed 2025-09-28 (1 hour)
- TASK-025: Update checkout button styling - Completed 2025-10-01 (15 min)
- TASK-029: Add loading spinners - Completed 2025-10-02 (30 min)
- TASK-033: Fix responsive nav menu - Completed 2025-10-03 (45 min)
- TASK-038: Update footer links - Completed 2025-10-04 (10 min)

### 🔄 Active (0)
No Level 1 tasks currently in progress.

### ⏳ Pending (2)

#### Priority P3 (2 tasks)
- TASK-052: Wishlist Feature
- TASK-060: Code Cleanup Sprint

---

**Level 1 Velocity**: 8 tasks completed (avg 34 minutes each)

**Next Quick Win**: TASK-052 - Wishlist Feature (Priority P3)

💡 Tip: Level 1 tasks are great for quick progress or warm-up work
```

### Example 5: Blocked Tasks

```
User: /cf:status --filter status=blocked

Claude:
[Reads tasks.md, filters blocked tasks...]

🚫 BLOCKED TASKS
─────────────────────────────

**Project**: E-Commerce Platform
**Total Blocked**: 2 tasks

**TASK-027**: Analytics Dashboard Integration (Level 3, Priority P2)
├─ Blocker: Waiting for third-party analytics API credentials
├─ Blocked Since: 2025-10-01 (4 days ago)
├─ Impact: Delaying TASK-055 (Admin Analytics)
├─ Owner: Sarah (external vendor coordination)
└─ Resolution Approach: Vendor ticket #12345 open, expected resolution 2025-10-07

**TASK-033**: Staging Environment Performance Testing (Level 2, Priority P1)
├─ Blocker: Staging environment configuration incomplete
├─ Blocked Since: 2025-10-03 (2 days ago)
├─ Impact: Cannot validate performance optimizations
├─ Owner: Mike (DevOps)
└─ Resolution Approach: AWS ECS configuration in progress (80% complete)

---

**Critical Blockers**: 1 P1 task blocked (TASK-033)
**Action Required**:
- TASK-027: Follow up with vendor (Sarah)
- TASK-033: Complete staging config (Mike) - expected tomorrow

**Alternative Tasks** (unblocked work available):
- TASK-032: Payment Gateway Integration (Priority P1) - in progress
- TASK-042: Email Notification Service (Priority P2)
- TASK-043: Product Review System (Priority P2)
```

---

## Error Handling

### Memory Bank Not Initialized

```
⚠️ Memory Bank Not Initialized

Memory bank not found at: memory-bank/

To initialize, run: /cf:init [project-name]

Example: /cf:init MyProject
```

### No Tasks Found

```
📊 TASK STATUS
─────────────────────────────

**Project**: [Project Name]
**Total Tasks**: 0

No tasks have been created yet.

**Get Started**:
1. Create your first task: /cf:feature [description]
2. Plan a feature: /cf:plan [description]

Example: /cf:feature implement user login
```

### Invalid Filter

```
❌ Error: Invalid filter syntax

Provided: [user input]

Valid filter formats:
- --filter status=pending
- --filter status=active
- --filter status=complete
- --filter status=blocked
- --filter priority=p1 (or p2, p3)
- --filter complexity=1 (or 2, 3, 4)

Usage: /cf:status --filter [type]=[value]
```

### No Tasks Match Filter

```
📊 FILTERED TASK STATUS
─────────────────────────────

**Filter**: [filter description]
**Matching Tasks**: 0

No tasks match this filter criteria.

**All Tasks**: [N] total tasks in project

Remove filter to see all tasks: /cf:status
```

---

## Integration with Other Commands

**Typical usage patterns**:

```
# Start of session - quick check
/cf:status → See what's on plate
/cf:code TASK-[ID] → Start work

# Throughout day - quick re-orient
/cf:status → What's my priority?
[Continue appropriate task]

# Planning next work
/cf:status --filter status=pending → What's available?
/cf:status --filter priority=p1 → What's critical?
/cf:plan TASK-[ID] → Plan next task

# Checking progress
/cf:status --filter status=complete → What's done?
/cf:status --filter priority=p1 → How are priorities?

# Identifying blockers
/cf:status --filter status=blocked → What's stuck?
[Address blockers or work on unblocked tasks]

# Finding quick wins
/cf:status --filter complexity=1 → Quick tasks?
/cf:code TASK-[ID] → Knock out quick task
```

**When to use /cf:status vs other commands**:
- `/cf:status` - **Quick task list** (fast, minimal context)
- `/cf:context` - **Full context load** (active work, recent changes, next steps)
- `/cf:sync` - **Memory bank health check** (all files, gaps, inconsistencies)
- `/cf:ask` - **Specific question** (targeted query vs. overview)

---

## Notes

- **Lightweight operation**: Reads tasks.md only (< 1 second)
- **Filter combinations**: Currently supports one filter at a time
- **Completed task limit**: Shows last 5 complete tasks by default (full list with filter)
- **Smart recommendations**: Suggests next task based on priority and dependencies
- **No context loading**: Intentionally minimal for speed (use /cf:context for context)
- **Task metadata**: Shows key info (ID, name, complexity, priority, progress)
- **Blocker visibility**: Highlights blocked tasks for attention
- **Priority-based**: Default pending task list sorted by priority

**Best practices**:
- Use /cf:status for quick "what should I do next?" checks
- Use filters to focus on specific task subsets
- Run multiple times per day for quick re-orientation
- Combine with /cf:context when you need full project context
- Check blocked tasks regularly to identify resolution opportunities
- Track Level 1 tasks for quick wins and warm-up work

**Performance**:
- Default view: < 1 second
- Filtered views: < 1 second
- No agent invocation (pure file read and filter)
- Minimal token usage

---

## Related Commands

- `/cf:context` - Load active work context (more detailed)
- `/cf:sync` - Full memory bank status (all files)
- `/cf:ask` - Query specific information (targeted)
- `/cf:feature` - Create new tasks
- `/cf:code` - Start working on tasks
- `/cf:plan` - Plan complex tasks before implementation

---

**Command Version**: 1.0
**Last Updated**: 2025-10-05
