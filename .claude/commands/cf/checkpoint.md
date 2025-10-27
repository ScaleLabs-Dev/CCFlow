---
description: "Create comprehensive memory bank checkpoint with Documentarian agent"
allowed-tools: ['Read', 'Edit', 'Task']
argument-hint: "[--message \"description\"] [--interactive]"
---

# Command: /cf:checkpoint

## Usage

```
/cf:checkpoint [--message "description"]
```

## Parameters

- `[--message "description"]`: **Optional** - Custom checkpoint description (default: auto-generated from recent work)

---

## Purpose

Engage the Documentarian agent to:
1. Capture current project state across all memory bank files
2. Document recent work, decisions, and learnings
3. Update ALL memory bank files with latest context
4. Create checkpoint entry in progress.md for session continuity
5. Preserve knowledge for future sessions and team members

---

## Prerequisites

**Memory bank must be initialized**. Run `/cf:init` first if needed.

**Active work to checkpoint**. Use after completing meaningful work, not at project start.

---

## When to Use

**Recommended checkpoint triggers**:
- After completing significant task or milestone
- Before ending work session (session boundaries)
- After making important architectural decisions
- Before risky operations (creates restore point)
- Every 30-60 minutes during intensive work sessions
- After discovering new patterns or learnings
- When switching between major tasks or focus areas

**Time-based guideline**: Every 30-60 minutes of active development work.

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

### Step 2: Gather Checkpoint Context

**Load all memory bank files**:
- `projectbrief.md` - Original scope for comparison
- `productContext.md` - Feature status
- `systemPatterns.md` - Patterns and conventions
- `activeContext.md` - Current state before checkpoint
- `progress.md` - Historical checkpoints for continuity
- `tasks.md` - Task statuses and completion

**Scan recent work**:
- Use Git (if available): `git log --since="last checkpoint time" --oneline`
- Review `activeContext.md` "Recent Changes" section
- Identify completed tasks from tasks.md since last checkpoint
- Note any new files created or significant edits

**Determine checkpoint scope**:
- What work was completed since last checkpoint?
- What decisions were made?
- What patterns emerged or changed?
- What was learned?
- What's the current project state?

---

### Step 3: Engage Documentarian Agent

**Invoke Documentarian agent** from `.claude/agents/workflow/documentarian.md`.

**Provide context**:
- All loaded memory bank files
- Recent work summary (git log, file changes, task completions)
- Custom message (if --message flag provided)
- Timestamp for checkpoint entry

**Documentarian will**:
1. Analyze recent work and changes
2. Identify key accomplishments and learnings
3. Update ALL memory bank files systematically
4. Create comprehensive checkpoint entry
5. Ensure cross-file consistency
6. Preserve important context for continuity

---

### Step 4: Documentarian Updates Memory Bank

**Documentarian performs systematic updates** to all memory bank files:

#### progress.md - Add Checkpoint Entry

**Add to "Checkpoint Entries" section**:

```markdown
---

## Checkpoint [YYYY-MM-DD HH:MM]

**Completed This Session**:
- ✅ [Completed task 1 - TASK-ID if applicable]
- ✅ [Completed task 2 - TASK-ID if applicable]
- ✅ [Decision made: description]
- ✅ [Pattern established: name]

**Current Status**:
- **Active Focus**: [Current primary work area]
- **Project Phase**: [Planning/Development/Testing/Refinement]
- **Overall Progress**: [X]% complete
- **On Track**: [Yes/No - with reason if at risk]

**Key Learnings**:
- 💡 [Learning 1 - technical insight or pattern discovery]
- 💡 [Learning 2 - process improvement or decision rationale]
- 💡 [Learning 3 - architectural understanding]

**Decisions Made**:
- 🎯 [Decision 1 - with rationale and alternatives considered]
- 🎯 [Decision 2 - with impact assessment]

**Technical Debt**:
- 🔴 [High priority debt item added/resolved]
- 🟡 [Medium priority debt item added/resolved]

**Blockers** (if any):
- ⚠️ [Blocker 1 - description and proposed resolution]
- ⚠️ [Blocker 2 - description and help needed]

**Next Priorities**:
1. [Immediate next task - TASK-ID if exists]
2. [Following task - TASK-ID if exists]
3. [Future consideration]

**Files Changed**: [N] files ([list of significant files or patterns])

**Notes**: [Any additional context, observations, or concerns]
```

#### activeContext.md - Update Current State

**Update "Current Focus" section**:
```markdown
### Primary Focus: [Current Work Area]

**Task**: TASK-[ID] (if applicable)
**Started**: [YYYY-MM-DD]
**Last Updated**: [YYYY-MM-DD HH:MM] (checkpoint)
**Progress**: [Status description - e.g., "Implementation 60% complete"]

**What we're doing**:
[Brief description of current work and approach]

**Why it matters**:
[Connection to project goals and user value]

**Expected completion**:
[Estimate based on current progress]

**Recent changes** (last checkpoint):
- [Change 1 with impact]
- [Change 2 with impact]
```

**Add to "Recent Changes" log**:
```markdown
### [YYYY-MM-DD HH:MM] - Checkpoint Created
**Agent**: Documentarian
**Session Work**: [Summary of completed work]
**Files Changed**: [N] files
**Next Action**: [Top priority from checkpoint]
```

**Update "Immediate Next Steps"**:
```markdown
## Immediate Next Steps

1. **[Next action 1]** (Priority: High)
   - Context: [Why this is next]
   - Task: [TASK-ID if applicable]

2. **[Next action 2]** (Priority: Medium)
   - Context: [Why this follows]
   - Task: [TASK-ID if applicable]

3. **[Next action 3]** (Priority: Low)
   - Context: [Future consideration]
```

#### systemPatterns.md - Update Patterns (if needed)

**If new patterns emerged**, add to "Active Patterns" section:
```markdown
### [YYYY-MM-DD] - [Pattern Name]

**Context**: [When this pattern applies]

**Problem**: [What problem it solves]

**Solution**:
[Implementation approach]

**Example**:
```[language]
[code example or file reference]
```

**Rationale**: [Why this approach over alternatives]

**Related Patterns**: [Connections to other patterns]

**Source**: Emerged during [work description] - documented in checkpoint [date]
```

**If existing patterns changed**, update descriptions and examples.

**If patterns were violated with justification**, add to "Pattern Exceptions":
```markdown
### [File/Component] - [Pattern] Exception

**Pattern**: [Which pattern not followed]
**Location**: [file:line or component]
**Rationale**: [Why exception is justified]
**Approved**: [YYYY-MM-DD]
**Review Date**: [When to re-evaluate - if applicable]
```

#### productContext.md - Update Features (if needed)

**If features completed**, move from "Planned Features" to "Implemented Features":
```markdown
| Feature | Priority | Status | Notes |
|---------|----------|--------|-------|
| [Feature name] | P1 | ✅ Implemented | Completed [YYYY-MM-DD], [any notes] |
```

**If feature status changed**, update accordingly (Started, In Progress, Blocked).

**If new requirements emerged**, add to "Requirements" section with source and rationale.

#### tasks.md - Update Task Statuses (if needed)

**If tasks completed**, update status:
```markdown
**Status**: Complete
**Completed**: [YYYY-MM-DD]
**Notes**: [Completion details, any deviations from plan]
```

**If tasks progressed**, update status:
```markdown
**Status**: In Progress
**Progress**: [Description of current state - e.g., "Tests written, implementation 50%"]
**Last Updated**: [YYYY-MM-DD]
```

**If new blockers identified**, add to task entry:
```markdown
**Blockers**:
- [Blocker description discovered during session]
- [Resolution approach or help needed]
```

#### projectbrief.md - Update Decisions Log (if applicable)

**If architectural or scope decisions made**, add to "Decision Log":
```markdown
| Date | Decision | Rationale | Alternatives Considered |
|------|----------|-----------|-------------------------|
| [YYYY-MM-DD] | [Decision description] | [Why this choice] | [What else was considered] |
```

---

### Step 5: Documentarian Output Summary

**Documentarian provides checkpoint summary**:

```markdown
📝 CHECKPOINT SUMMARY
─────────────────────────────
**Time**: [YYYY-MM-DD HH:MM]
**Session Duration**: [Estimated time since last checkpoint or session start]

## What Was Accomplished

✅ **Tasks Completed**: [N] tasks
- TASK-[ID]: [Name] (Level [1-4])
- TASK-[ID]: [Name] (Level [1-4])

✅ **Features Delivered**: [N] features
- [Feature name]: [Brief description]

✅ **Decisions Made**: [N] decisions
- [Decision 1]: [Brief description]

✅ **Patterns Established**: [N] patterns
- [Pattern name]: [Brief context]

## Current Project State

**Progress**: [X]% complete
**Phase**: [Planning/Development/Testing/Refinement]
**Status**: [On Track/At Risk - with reason]

**Active Focus**: [Current primary work]
**Next Priority**: [Immediate next task]

## Knowledge Preserved

💡 **Key Learnings**: [N] insights documented
🎯 **Decisions**: [N] decisions recorded
🔧 **Patterns**: [N] patterns updated
📊 **Progress**: Checkpoint entry added

## Files Updated

✓ progress.md - Checkpoint entry created
✓ activeContext.md - Current state updated
[✓ systemPatterns.md - [N] patterns added/updated]
[✓ productContext.md - Feature status updated]
[✓ tasks.md - [N] task statuses updated]
[✓ projectbrief.md - Decision log updated]

## Next Session Starting Point

**Resume with**: [Clear action to start next session]
**Context**: [Key context needed for next work]
**Files to review**: [Specific files to load for continuity]

---

**Memory bank fully synchronized ✓**
```

---

### Step 6: Output Checkpoint Confirmation

**Standard output**:
```markdown
📝 CHECKPOINT CREATED
─────────────────────────────

**Time**: [YYYY-MM-DD HH:MM]
[**Message**: [Custom message if --message flag used]]

**Session Summary**:
- ✅ [N] tasks completed
- 🎯 [N] decisions made
- 💡 [N] learnings documented
- 🔧 [N] patterns established/updated

**Project Progress**: [X]% complete, [On Track/At Risk]

**Memory Bank Updates**:
✓ progress.md - Checkpoint entry
✓ activeContext.md - Current focus updated
✓ systemPatterns.md - [N] patterns updated
✓ productContext.md - Feature status updated
✓ tasks.md - [N] tasks updated
✓ projectbrief.md - Decisions logged

**Next Session**:
Resume with: [Clear starting action]

Full checkpoint details in memory-bank/progress.md
```

---

## Examples

### Example 1: After Completing Tasks

```
User: /cf:checkpoint

Claude:
[Loads memory bank, scans git log, engages Documentarian...]

📝 CHECKPOINT CREATED
─────────────────────────────

**Time**: 2025-10-05 14:30

**Session Summary**:
- ✅ 2 tasks completed (TASK-023, TASK-024)
- 🎯 1 decision made (API versioning strategy)
- 💡 3 learnings documented
- 🔧 1 pattern established (error response format)

**Project Progress**: 68% complete, On Track ✅

**Memory Bank Updates**:
✓ progress.md - Checkpoint entry
✓ activeContext.md - Current focus updated
✓ systemPatterns.md - 1 pattern added
✓ productContext.md - 2 features marked complete
✓ tasks.md - 2 tasks marked complete
✓ projectbrief.md - API versioning decision logged

**Next Session**:
Resume with: Begin TASK-025 (Search functionality implementation)

Full checkpoint details in memory-bank/progress.md
```

### Example 2: Custom Checkpoint Message

```
User: /cf:checkpoint --message "Before attempting database migration - restore point"

Claude:
[Loads memory bank, engages Documentarian...]

📝 CHECKPOINT CREATED
─────────────────────────────

**Time**: 2025-10-05 16:45
**Message**: Before attempting database migration - restore point

**Session Summary**:
- ✅ 1 task completed (TASK-030: Migration script preparation)
- 🎯 2 decisions made (migration strategy, rollback plan)
- 💡 1 learning documented (zero-downtime migration pattern)
- 🔧 0 patterns established

**Project Progress**: 72% complete, On Track ✅

**Memory Bank Updates**:
✓ progress.md - Checkpoint entry with restore point marker
✓ activeContext.md - Migration context preserved
✓ systemPatterns.md - No changes
✓ productContext.md - No changes
✓ tasks.md - TASK-030 marked complete
✓ projectbrief.md - Migration decisions logged

**Next Session**:
Resume with: Execute database migration (TASK-031)
**Restore Point**: This checkpoint available for rollback if needed

Full checkpoint details in memory-bank/progress.md
```

### Example 3: End of Work Session

```
User: /cf:checkpoint --message "End of day - in progress work saved"

Claude:
[Loads memory bank, scans recent work, engages Documentarian...]

📝 CHECKPOINT CREATED
─────────────────────────────

**Time**: 2025-10-05 18:00
**Message**: End of day - in progress work saved

**Session Summary**:
- ✅ 0 tasks completed
- 🔄 1 task in progress (TASK-032: 60% complete)
- 🎯 1 decision made (state management approach)
- 💡 2 learnings documented
- 🔧 0 patterns established

**Project Progress**: 73% complete, On Track ✅

**Current Work State**:
- TASK-032 (User dashboard): Tests written (GREEN ✅), implementation 60% complete
- Next: Complete remaining UI components and integration

**Memory Bank Updates**:
✓ progress.md - Session checkpoint with in-progress state
✓ activeContext.md - Detailed current work state for resumption
✓ systemPatterns.md - No changes
✓ productContext.md - No changes
✓ tasks.md - TASK-032 progress updated
✓ projectbrief.md - State management decision logged

**Next Session**:
Resume with: Continue TASK-032 implementation (components/Dashboard.tsx)
Files to review: tests/Dashboard.test.tsx, systemPatterns.md (state management section)

Full checkpoint details in memory-bank/progress.md
```

### Example 4: After Major Decision

```
User: /cf:checkpoint --message "Architecture decision: microservices approach finalized"

Claude:
[Loads memory bank, engages Documentarian...]

📝 CHECKPOINT CREATED
─────────────────────────────

**Time**: 2025-10-05 11:15
**Message**: Architecture decision: microservices approach finalized

**Session Summary**:
- ✅ 0 tasks completed
- 🎯 3 decisions made (microservices, service boundaries, communication patterns)
- 💡 4 learnings documented (domain-driven design insights)
- 🔧 2 patterns established (service contract, event messaging)

**Project Progress**: 45% complete, On Track ✅

**Memory Bank Updates**:
✓ progress.md - Architecture decision checkpoint
✓ activeContext.md - Updated with new architecture context
✓ systemPatterns.md - 2 new architectural patterns added
✓ productContext.md - Non-functional requirements updated
✓ tasks.md - No changes
✓ projectbrief.md - 3 major architecture decisions logged

**Next Session**:
Resume with: Begin implementation of first microservice (Auth service - TASK-015)

Full checkpoint details in memory-bank/progress.md
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

### No Recent Work to Checkpoint

```
⚠️ No Recent Changes Detected

Last checkpoint: [YYYY-MM-DD HH:MM] ([duration] ago)

No significant changes detected since last checkpoint:
- No tasks completed
- No files changed
- No new decisions or learnings

Consider working on tasks first, then checkpoint.

Alternatively, use --message flag to create manual checkpoint:
/cf:checkpoint --message "your reason for checkpoint"
```

### Git Not Available (Warning Only)

```
ℹ️ Git not available

Could not access git log for recent changes analysis.

Proceeding with checkpoint based on memory bank changes only.

For best checkpoint quality, consider using git for version control.

[Continues with checkpoint...]
```

---

## Integration with Other Commands

**Typical workflow patterns**:

```
# Task completion checkpoint
/cf:code TASK-023 → Implementation complete
/cf:review TASK-023 → Quality check passes
/cf:checkpoint → Document completion and learnings

# Session boundary checkpoint
[Work on multiple tasks...]
/cf:checkpoint --message "End of work session"
[Next day: Resume with context from checkpoint]

# Decision checkpoint
/cf:plan TASK-030 --interactive → Major architectural decision made
/cf:checkpoint --message "Architecture decision: [description]"

# Pre-risky operation checkpoint
/cf:checkpoint --message "Before database migration - restore point"
/cf:code TASK-031 → Execute risky operation
[If successful] /cf:checkpoint
[If failed] Restore from last checkpoint context

# Periodic checkpoint during intensive work
[30 minutes of work...]
/cf:checkpoint
[Continue working...]
[30 minutes more...]
/cf:checkpoint
```

**Recommended checkpoint frequency**:
- **After every completed task**: Capture learnings and progress
- **Every 30-60 minutes**: During intensive development sessions
- **Before risky operations**: Create restore points
- **End of work sessions**: Preserve context for next session
- **After major decisions**: Document rationale and alternatives
- **When new patterns emerge**: Preserve knowledge for team

---

## Memory Bank Updates

### ALL Files Updated

**progress.md**:
- New checkpoint entry with full session summary
- Technical debt updates if discovered
- Completed work log if tasks finished

**activeContext.md**:
- Current focus updated with latest state
- Recent changes log entry added
- Immediate next steps refreshed

**systemPatterns.md** (if applicable):
- New patterns added with context
- Existing patterns updated with examples
- Pattern exceptions documented

**productContext.md** (if applicable):
- Feature status updated
- Requirements added/modified
- User flows updated if changed

**tasks.md** (if applicable):
- Task statuses updated (Complete/In Progress)
- Progress notes added
- Blockers documented

**projectbrief.md** (if applicable):
- Decision log updated with rationale
- Scope changes documented if any
- Risk assessment updated if needed

---

## Notes

- Checkpoint is **non-invasive**: Doesn't change code, only memory bank
- **All memory bank files updated** for comprehensive state preservation
- Documentarian ensures **cross-file consistency** (no contradictions)
- Checkpoints create **session continuity** for resuming work
- **Custom messages** (`--message`) useful for restore points and context markers
- Git integration **enhances but not required** for checkpointing
- Checkpoints **preserve learnings** that might otherwise be forgotten
- **Team knowledge sharing**: Checkpoints document "why" behind decisions
- Can be used as **rollback reference** if needed to understand prior state
- **Lightweight operation**: Reads/writes memory bank only, no code changes

---

## Related Commands

- `/cf:code` - Implementation (checkpoint after completion)
- `/cf:review` - Quality assessment (checkpoint often includes review)
- `/cf:sync` - Read-only status (checkpoint is write operation)
- `/cf:plan` - Planning (checkpoint after significant planning sessions)
- `/cf:status` - Quick status without full checkpoint

---

**Command Version**: 1.0
**Last Updated**: 2025-10-05
