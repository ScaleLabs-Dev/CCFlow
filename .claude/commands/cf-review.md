# Command: /cf:review

Assess code quality, evaluate progress, and identify technical debt using Reviewer agent.

---

## Usage

```
/cf:review [task-id|all] [--focus area]
```

## Parameters

- `[task-id|all]`: **Optional** - Specific task ID to review, or "all" for full project review (default: current focus)
- `[--focus area]`: **Optional** - Specific focus area (quality|debt|progress|patterns)

---

## Purpose

Engage the Reviewer agent to:
1. Assess code quality and adherence to patterns
2. Evaluate project progress against goals
3. Identify technical debt with priority levels
4. Recommend improvements and next actions
5. Update memory bank with findings

---

## Prerequisites

**Memory bank must be initialized**. Run `/cf:init [project-name]` first if needed.

**Active code to review**. Use after implementation work, not before starting.

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

### Step 2: Determine Review Scope

**No parameter or specific task ID**:
- Read `activeContext.md` to determine current focus
- Review code related to current active task

**"all" parameter**:
- Comprehensive project-wide review
- All implemented code and patterns
- Full technical debt assessment

**Specific task ID (e.g., TASK-042)**:
- Read task from `tasks.md`
- Review code related to that specific task
- Check if task completion criteria met

---

### Step 3: Load Context

Read required memory bank files based on scope:

**For task-specific review**:
- `tasks.md` - Task details and acceptance criteria
- `activeContext.md` - Current work context
- `systemPatterns.md` - Established patterns to validate against

**For full project review**:
- `projectbrief.md` - Original objectives and scope
- `productContext.md` - Feature status and requirements
- `systemPatterns.md` - Architecture and conventions
- `tasks.md` - All tasks and completion status
- `progress.md` - Historical progress data

**For focused review** (--focus flag):
- Load only files relevant to focus area
- `quality` → systemPatterns.md
- `debt` → progress.md (technical debt section)
- `progress` → progress.md + tasks.md
- `patterns` → systemPatterns.md

---

### Step 4: Engage Reviewer Agent

**Invoke Reviewer agent** from `.claude/agents/workflow/reviewer.md`.

**Provide context**:
- Review scope (task/all/focus area)
- Loaded memory bank content
- Files to review (from codebase scan)

**Reviewer will**:
1. Scan relevant code files
2. Assess quality across multiple dimensions
3. Identify technical debt with severity ratings
4. Compare implementation against patterns
5. Evaluate progress toward goals
6. Generate detailed assessment report

---

### Step 5: Process Reviewer Output

**Reviewer provides**:

```markdown
🔍 CODE REVIEW ASSESSMENT
─────────────────────────────
**Scope**: [Task ID or "Full Project"]
**Reviewed**: [N] files across [M] components

## Quality Assessment

**Code Organization**: ⭐⭐⭐⭐☆ (4/5)
- Strengths: [What's working well]
- Improvements: [Specific recommendations]

**Pattern Adherence**: ⭐⭐⭐⭐⭐ (5/5)
- Strengths: [Consistent with systemPatterns.md]
- Improvements: [If any deviations]

**Test Coverage**: ⭐⭐⭐☆☆ (3/5)
- Strengths: [Areas well-tested]
- Improvements: [Missing test coverage]

**Documentation**: ⭐⭐⭐⭐☆ (4/5)
- Strengths: [Clear inline docs]
- Improvements: [Areas needing better docs]

**Maintainability**: ⭐⭐⭐⭐☆ (4/5)
- Strengths: [Easy to understand/modify]
- Improvements: [Complexity concerns]

## Technical Debt Identified

### 🔴 High Priority (Address Soon)
1. **[Issue Name]** - [file:line]
   - **Impact**: [Performance/Security/Maintainability]
   - **Effort**: [Small/Medium/Large]
   - **Recommendation**: [Specific action]

### 🟡 Medium Priority (Plan For)
1. **[Issue Name]** - [file:line]
   - **Impact**: [Description]
   - **Effort**: [Estimate]
   - **Recommendation**: [Action]

### 🟢 Low Priority (Future Consideration)
1. **[Issue Name]** - [file:line]
   - **Impact**: [Minor]
   - **Effort**: [Small]
   - **Recommendation**: [Optional improvement]

## Progress Evaluation

**Completed vs Planned**: [X]% complete
- ✅ Completed: [List of done features]
- 🔄 In Progress: [Active work]
- ⏳ Pending: [Not started]

**On Track**: [Yes/No/At Risk]
- **Reason**: [Why assessment made]
- **Blockers**: [Any impediments]

## Pattern Compliance

**Followed Patterns**:
- ✅ [Pattern 1 from systemPatterns.md]
- ✅ [Pattern 2 from systemPatterns.md]

**Pattern Deviations**:
- ⚠️ [Deviation 1] - [file:line]
  - **Rationale**: [If intentional] or **Issue**: [If accidental]

**New Patterns Emerging**:
- 🆕 [Pattern description]
  - **Files**: [Where used]
  - **Recommendation**: Document in systemPatterns.md?

## Recommendations

### Immediate Actions
1. [Action 1 with priority]
2. [Action 2 with priority]

### Next Steps
1. [Suggested next task or improvement]
2. [Suggested next task or improvement]

### Refactoring Opportunities
1. [Opportunity 1 with benefit/effort ratio]
2. [Opportunity 2 with benefit/effort ratio]
```

---

### Step 6: Update Memory Bank

**Update progress.md**:

Add new section to "Technical Debt Inventory":
```markdown
### [YYYY-MM-DD] - Review: [Scope]

**High Priority Debt**:
- [Issue 1 from Reviewer output]

**Medium Priority Debt**:
- [Issue 1 from Reviewer output]

**Low Priority Debt**:
- [Issue 1 from Reviewer output]
```

**Update activeContext.md**:

Add entry to "Recent Changes" section:
```markdown
### [YYYY-MM-DD HH:MM] - Code Review: [Scope]
**Agent**: Reviewer
**Quality Score**: [Average of ratings]/5
**Debt Identified**: [N] high, [M] medium, [P] low priority items
**Next Action**: [Top recommendation from Reviewer]
```

**Update systemPatterns.md** (if new patterns found):

If Reviewer identified new patterns worth documenting:
```markdown
### [YYYY-MM-DD] - New Pattern: [Name]

**Context**: [When to use]
**Problem**: [What it solves]
**Solution**: [Implementation approach]
**Example**:
[code example or file reference]

**Source**: Identified during code review ([review scope])
```

**Update tasks.md** (if reviewing specific task):

If review reveals task is NOT complete (missing criteria):
```markdown
**Status**: In Progress (failing review)
**Blockers**: Review identified issues:
- [Issue 1 from Reviewer]
- [Issue 2 from Reviewer]
```

If review confirms task IS complete:
```markdown
**Status**: Complete
**Completed**: [YYYY-MM-DD]
**Quality**: [Average rating from Reviewer]/5
**Notes**: Code review passed on [date]
```

---

### Step 7: Output Review Summary

**For task-specific review**:
```markdown
🔍 REVIEW COMPLETE: TASK-[ID]
─────────────────────────────

**Overall Quality**: [Average rating]/5 ⭐

**Status**: [Pass/Needs Work]

**Technical Debt**: [N] items identified
- 🔴 High: [count]
- 🟡 Medium: [count]
- 🟢 Low: [count]

**Top Recommendation**:
[Most important action from Reviewer]

✓ Updated progress.md with debt inventory
✓ Updated activeContext.md with review results
[✓ Updated systemPatterns.md with new patterns - if applicable]
[✓ Updated tasks.md task status - if applicable]

→ NEXT STEPS:
1. [Immediate action 1]
2. [Immediate action 2]

Full review details available in memory bank.
```

**For full project review**:
```markdown
🔍 PROJECT REVIEW COMPLETE
───��─────────────────────────

**Project**: [Name]
**Overall Quality**: [Average rating]/5 ⭐
**Progress**: [X]% complete, [On Track/At Risk]

**Files Reviewed**: [N] files across [M] components

**Technical Debt Summary**:
- 🔴 High Priority: [count] items
- 🟡 Medium Priority: [count] items
- 🟢 Low Priority: [count] items

**Pattern Compliance**: [Y] patterns followed, [Z] deviations

**Top 3 Recommendations**:
1. [Critical recommendation]
2. [Important recommendation]
3. [Helpful recommendation]

✓ Updated progress.md with technical debt inventory
✓ Updated activeContext.md with review summary
[✓ Updated systemPatterns.md with [N] new patterns]

→ SUGGESTED NEXT TASK:
[Highest value next action based on review]

Full detailed assessment available in memory bank.
```

**For focused review** (--focus flag):
```markdown
🔍 FOCUSED REVIEW: [Focus Area]
─────────────────────────────

**Focus**: [quality|debt|progress|patterns]
**Rating**: [Relevant score]/5

**Key Findings**:
- [Finding 1]
- [Finding 2]
- [Finding 3]

**Recommendations**:
1. [Action 1]
2. [Action 2]

✓ Memory bank updated with findings

Full details in [relevant memory bank file].
```

---

## Examples

### Example 1: Task-Specific Review

```
User: /cf:review TASK-023

Claude:
[Loads task from tasks.md, engages Reviewer agent...]

🔍 REVIEW COMPLETE: TASK-023
─────────────────────────────

**Overall Quality**: 4.2/5 ⭐

**Status**: Pass ✅

**Technical Debt**: 3 items identified
- 🔴 High: 0
- 🟡 Medium: 2
- 🟢 Low: 1

**Top Recommendation**:
Add integration tests for error handling paths (Medium priority)

✓ Updated progress.md with debt inventory
✓ Updated activeContext.md with review results
✓ Updated tasks.md - marked TASK-023 as Complete

→ NEXT STEPS:
1. Consider adding integration tests (2-3 hours)
2. Proceed to TASK-024 (next pending task)

Full review details available in memory bank.
```

### Example 2: Full Project Review

```
User: /cf:review all

Claude:
[Loads all memory bank files, scans entire codebase, engages Reviewer...]

🔍 PROJECT REVIEW COMPLETE
─────────────────────────────

**Project**: E-Commerce Platform
**Overall Quality**: 3.8/5 ⭐
**Progress**: 67% complete, On Track ✅

**Files Reviewed**: 42 files across 8 components

**Technical Debt Summary**:
- 🔴 High Priority: 2 items
- 🟡 Medium Priority: 7 items
- 🟢 Low Priority: 5 items

**Pattern Compliance**: 12 patterns followed, 1 deviation (auth middleware - documented exception)

**Top 3 Recommendations**:
1. Address database connection pooling issue (High priority, 4 hours)
2. Add missing test coverage for payment service (Medium priority, 6 hours)
3. Document API versioning pattern (Low priority, 1 hour)

✓ Updated progress.md with technical debt inventory
✓ Updated activeContext.md with review summary
✓ Updated systemPatterns.md with 2 new patterns

→ SUGGESTED NEXT TASK:
Fix database connection pooling (TASK-031 or create new high-priority task)

Full detailed assessment available in memory bank.
```

### Example 3: Focused Debt Review

```
User: /cf:review all --focus debt

Claude:
[Loads progress.md, scans for technical debt, engages Reviewer...]

🔍 FOCUSED REVIEW: Technical Debt
─────────────────────────────

**Focus**: debt
**Total Debt Items**: 14

**Breakdown**:
- 🔴 High Priority: 2 items (12 hours estimated)
- 🟡 Medium Priority: 7 items (28 hours estimated)
- 🟢 Low Priority: 5 items (8 hours estimated)

**Total Estimated Effort**: ~48 hours (6 days)

**Key Findings**:
- Security: 1 high-priority item (auth token expiry)
- Performance: 3 medium-priority items (caching, query optimization)
- Maintainability: Most low-priority items (code cleanup)

**Recommendations**:
1. Create TASK for auth token expiry fix (security risk)
2. Schedule "debt reduction sprint" for medium-priority items
3. Address low-priority items during feature work (opportunistic refactoring)

✓ Memory bank updated with prioritized debt analysis

Full details in progress.md technical debt inventory.
```

### Example 4: Pattern Compliance Review

```
User: /cf:review all --focus patterns

Claude:
[Loads systemPatterns.md, scans codebase, engages Reviewer...]

🔍 FOCUSED REVIEW: Pattern Compliance
─────────────────────────────

**Focus**: patterns
**Patterns Evaluated**: 12 established patterns

**Compliance Score**: 92% (11/12 patterns consistently followed)

**Key Findings**:
- ✅ Excellent adherence to error handling pattern
- ✅ Repository pattern used consistently across data layer
- ⚠️ API response format has 2 deviations (products.js, orders.js)
- 🆕 New pagination pattern emerging (3 files using same approach)

**Recommendations**:
1. Standardize API response format in products.js and orders.js
2. Document pagination pattern in systemPatterns.md (already in use)
3. Consider creating linter rule for error handling pattern

✓ Updated systemPatterns.md with pagination pattern
✓ Updated activeContext.md with compliance findings

Full pattern analysis in systemPatterns.md.
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

### No Code to Review

```
⚠️ No Code Found to Review

Review scope: [task-id/all]

The codebase appears empty or no code exists for this task.

Have you run /cf:code yet to implement the task?
```

### Task ID Not Found

```
❌ Error: Task not found

Task ID: TASK-[ID]

Could not find this task in memory-bank/tasks.md

Available tasks:
- TASK-001: [Name] (Status)
- TASK-002: [Name] (Status)

Check task ID and try again, or use /cf:status to see all tasks.
```

### Invalid Focus Area

```
❌ Error: Invalid focus area

Provided: [user input]

Valid focus areas:
- quality: Code quality assessment
- debt: Technical debt analysis
- progress: Progress evaluation
- patterns: Pattern compliance check

Usage: /cf:review [task-id|all] --focus [area]
```

---

## Integration with Other Commands

**Typical workflow**:

```
/cf:code TASK-023 → Implementation complete
/cf:review TASK-023 → Quality check before closing task
[If review passes] → Task marked complete
[If review fails] → Fix issues, repeat /cf:code

/cf:checkpoint → Includes review in checkpoint
/cf:review all → Periodic health check
```

**When to use**:
- After completing implementation (/cf:code)
- Before marking tasks complete
- Periodic project health checks (weekly/bi-weekly)
- Before major milestones or releases
- When planning refactoring work (use --focus debt)
- When establishing new patterns (use --focus patterns)

---

## Memory Bank Updates

### progress.md Changes

**Technical Debt Inventory Section**:
- New debt items added with dates and priority
- Existing debt items updated if resolved
- Effort estimates included

### activeContext.md Changes

**Recent Changes Log**:
- Review entry with timestamp
- Agent: Reviewer
- Quality score
- Debt summary
- Next action recommendation

### systemPatterns.md Changes

**Active Patterns Section** (if new patterns identified):
- New pattern entries
- Source attribution (code review)
- Examples from codebase

### tasks.md Changes

**Task Status** (if reviewing specific task):
- Status updated (Complete/In Progress with blockers)
- Quality rating added
- Completion date if passing review

---

## Notes

- Review can be run anytime after code exists (doesn't require task completion)
- Full project reviews (`all`) can be time-intensive for large codebases
- Use `--focus` flag to limit scope and save time for targeted analysis
- Reviewer agent uses 5-star rating system (1-5 stars) for quality dimensions
- Technical debt priority (🔴🟡🟢) helps triage improvement work
- Review does NOT block task completion (informational only)
- Review findings guide future work prioritization
- Pattern deviations aren't always bad (may be justified exceptions)
- New patterns emerging from code are candidates for systemPatterns.md documentation

---

## Related Commands

- `/cf:code` - Implement tasks (reviewed after completion)
- `/cf:checkpoint` - Includes review as part of checkpoint
- `/cf:status` - Quick status (no detailed review)
- `/cf:plan` - Planning phase (review happens post-implementation)
- `/cf:sync` - Memory bank status (complementary to review)

---

**Command Version**: 1.0
**Last Updated**: 2025-10-05
