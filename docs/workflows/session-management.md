# Session Management

**Purpose**: Patterns for loading context, regular checkpoints, and ending sessions properly
**Commands**: `/cf:context`, `/cf:checkpoint`, `/cf:sync`, `/cf:git`

---

## Overview

CCFlow maintains persistent context across sessions through the memory bank. Proper session management ensures work is preserved and context is efficiently loaded.

---

## Session Lifecycle

### Standard Pattern
```
Start → Load Context → Work → Checkpoint → End → Save & Commit
```

### Visual Flow
```mermaid
graph LR
    S[Session Start] --> L[/cf:context]
    L --> W[Work on tasks]
    W --> C[/cf:checkpoint]
    C --> W
    W --> E[Session End]
    E --> CP[/cf:checkpoint]
    CP --> G[/cf:git]

    style S fill:#e1f5fe
    style L fill:#fff3e0
    style W fill:#e8f5e9
    style C fill:#f3e5f5
    style E fill:#ffebee
    style CP fill:#f3e5f5
    style G fill:#fce4ec
```

---

## Session Start

### First-Time Initialization
If project not initialized:
```bash
/cf:init
```

This creates:
- memory-bank/ with 6 files
- Generic implementation agents
- Specialists directory

---

### Resuming Work
Load active project context:
```bash
/cf:context
```

**What it loads**:
- Current active task
- Recent progress
- Pending work
- Next recommended actions

**Example Output**:
```
📋 PROJECT CONTEXT LOADED

**Project**: E-Commerce Platform
**Active Task**: TASK-032 - Payment Gateway Integration
**Status**: 60% complete

**Recent Progress**:
- ✓ Webhook handlers (2 of 4 complete)
- ✓ Tests green

**Next Steps**:
1. Complete remaining webhook handlers
2. Integration testing
3. Code review

**Quick Commands**:
- Continue: /cf:code TASK-032
- New task: /cf:feature [description]
```

---

### Quick Status Check
For lightweight overview without full context:
```bash
/cf:status
```

Shows task list without loading full project context (faster).

---

## During Work

### Regular Checkpoints
**Frequency**: Every 30 minutes or after significant progress

```bash
/cf:checkpoint
```

**What it does**:
- Updates progress.md with completion status
- Updates activeContext.md with current focus
- Validates memory bank consistency
- Creates restore point

**When to checkpoint**:
- ✅ After completing a task
- ✅ Before starting risky operations
- ✅ Every 30 minutes during long tasks
- ✅ Before context switching to different task
- ✅ End of work session

**Example**:
```
User: /cf:checkpoint

Claude:
Creating checkpoint...

✓ Updated progress.md (65% complete)
✓ Updated activeContext.md (TASK-032: webhook #3 complete)
✓ Validated memory bank consistency
✓ Checkpoint created

**Current Status**:
- Task: TASK-032
- Progress: 3 of 4 webhooks complete
- Next: Complete final webhook, then integration tests

Ready to continue: /cf:code TASK-032
```

---

### Checkpoint with Message
Add context to checkpoint:
```bash
/cf:checkpoint --message "Completed webhook handlers, starting integration tests"
```

---

### Interactive Checkpoint
Guided checkpoint with facilitator:
```bash
/cf:checkpoint --interactive
```

Facilitator asks:
- What was accomplished?
- What's the current state?
- Any blockers?
- What's next?

---

## Session End

### Standard End Pattern
```bash
# 1. Final checkpoint
/cf:checkpoint --message "End of session: webhook integration 75% complete"

# 2. Commit changes
/cf:git
```

**Why this order?**
1. Checkpoint updates memory bank with current state
2. Git commits include up-to-date memory bank files
3. Next session can resume from accurate checkpoint

---

### Git Integration
```bash
/cf:git
```

**What it does**:
- Checks git status
- Reviews staged/unstaged changes
- Drafts commit message based on work done
- Creates commit with CCFlow signature
- Reports commit hash

**Example**:
```
User: /cf:git

Claude:
[Checks git status and diff...]

**Changes to commit**:
- memory-bank/activeContext.md (updated)
- memory-bank/progress.md (updated)
- src/webhooks/stripe.ts (new)
- tests/webhooks/stripe.test.ts (new)

**Proposed commit message**:
"feat: add Stripe webhook handler with tests

- Implement webhook signature verification
- Add handler for payment_intent.succeeded
- Include unit tests with 95% coverage

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"

Proceed with commit? (yes/no/edit)
```

---

### Commit Without Checkpoint
If you already checkpointed:
```bash
/cf:git --no-update
```

Skips memory bank update, just commits current state.

---

## Context Switching

### Switching Between Tasks
```bash
# 1. Checkpoint current work
/cf:checkpoint --message "Pausing webhook integration to fix critical bug"

# 2. Start new task
/cf:feature "Fix login timeout bug"

# 3. When returning
/cf:context
# Shows both tasks, prioritized
```

---

### Switching Between Projects
```bash
# Project A
cd /path/to/projectA
/cf:checkpoint
/cf:git

# Switch to Project B
cd /path/to/projectB
/cf:context
# Loads Project B state
```

---

## Common Patterns

### Quick Work Session (< 1 hour)
```bash
/cf:context                    # Load state (30 sec)
/cf:code TASK-032              # Work
/cf:checkpoint && /cf:git      # Save and commit
```

---

### Extended Work Session (> 1 hour)
```bash
/cf:context                    # Load state
/cf:code TASK-032              # Work (30 min)
/cf:checkpoint                 # Regular checkpoint
# Continue working...
/cf:checkpoint                 # Another checkpoint (30 min)
# More work...
/cf:checkpoint && /cf:git      # Final save
```

---

### High-Risk Operation
```bash
/cf:checkpoint                 # Create restore point BEFORE
# Risky operation (refactoring, migrations, etc.)
/cf:checkpoint                 # Checkpoint AFTER
/cf:git                        # Commit if successful
```

---

### Context-Heavy Task
```bash
/cf:context --full            # Load complete context
# Review all files, history, patterns
/cf:plan --interactive        # Plan with full context
/cf:checkpoint                # Save plan
/cf:code                      # Execute
```

---

## Memory Bank Inspection

### Check Memory Bank Health
```bash
/cf:sync
```

**Shows**:
- All memory bank files with status
- Last updated timestamps
- Consistency checks
- Gaps or issues
- Recommended actions

**Example**:
```
📊 MEMORY BANK STATUS

**Files**:
✓ projectbrief.md (immutable)
✓ productContext.md (updated 2 days ago)
✓ systemPatterns.md (updated 1 week ago)
✓ activeContext.md (updated 5 min ago)
✓ progress.md (updated 5 min ago)
✓ tasks.md (updated today)

**Health**: Good
**Last Checkpoint**: 5 minutes ago
**Consistency**: All files valid

**Recommendations**:
- systemPatterns.md hasn't been updated recently
  Consider: /cf:review to update patterns

**Quick Commands**:
- Update context: /cf:context
- Create checkpoint: /cf:checkpoint
```

---

## Troubleshooting

### Context Won't Load
```bash
# Check if initialized
ls memory-bank/

# If missing
/cf:init

# If corrupted
/cf:sync
# Follow recommendations
```

---

### Checkpoint Fails
```bash
# Check memory bank consistency
/cf:sync

# Manual fix if needed
# Edit memory-bank files directly
# Then retry
/cf:checkpoint
```

---

### Git Conflicts
```bash
# Resolve conflicts manually
git status
# Fix conflicted files

# Then checkpoint and commit
/cf:checkpoint
/cf:git
```

---

## Best Practices

### DO
- ✅ Start every session with `/cf:context`
- ✅ Checkpoint every 30 minutes
- ✅ Always checkpoint before risky operations
- ✅ End sessions with `/cf:checkpoint` && `/cf:git`
- ✅ Use `--message` for important checkpoints
- ✅ Check `/cf:sync` periodically for memory bank health

### DON'T
- ❌ Skip checkpoints during long sessions
- ❌ Commit without final checkpoint
- ❌ Edit memory bank files without checkpointing after
- ❌ Context-switch without checkpointing
- ❌ End sessions without saving work

---

## Advanced Patterns

### Checkpoint with Facilitator Validation
```bash
/cf:checkpoint --interactive
```

Facilitator walks through:
1. What was accomplished
2. Current state validation
3. Next steps clarity
4. Blocker identification

---

### Batch Operations
```bash
# Multiple tasks in one session
/cf:context
/cf:code TASK-001
/cf:checkpoint  # After task 1
/cf:code TASK-002
/cf:checkpoint  # After task 2
/cf:code TASK-003
/cf:checkpoint && /cf:git  # Final
```

---

### Recovery from Interruption
```bash
# Session interrupted, resuming
/cf:context
# Shows last checkpoint state
# Review what was in progress
/cf:status
# Continue from where left off
```

---

## Session Management Checklist

### Session Start
- [ ] Navigate to project directory
- [ ] Run `/cf:context` to load state
- [ ] Review active tasks and next steps
- [ ] Verify memory bank is healthy

### During Session
- [ ] Checkpoint every 30 minutes
- [ ] Checkpoint after task completion
- [ ] Checkpoint before risky operations
- [ ] Monitor memory bank health

### Session End
- [ ] Final checkpoint with status
- [ ] Commit changes with `/cf:git`
- [ ] Verify commit successful
- [ ] Clean workspace if needed

---

## Related Documentation

- **Commands**:
  - `/cf:context` - Load active context
  - `/cf:checkpoint` - Create checkpoint
  - `/cf:sync` - Memory bank health check
  - `/cf:git` - Commit with smart messaging
  - `/cf:status` - Quick task overview

- **Memory Bank**: See CLAUDE.md for structure
- **Git Workflow**: See CLAUDE.md for commit patterns
- **Task Management**: See `docs/workflows/task-management.md`

---

**Version**: 1.0
**Last Updated**: 2025-10-23
**Status**: Active - Core workflow pattern
