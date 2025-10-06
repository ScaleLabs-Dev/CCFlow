# Getting Started with CCFlow

**5-minute quick start guide**

## What is CCFlow?

CCFlow is a comprehensive workflow system for Claude Code that provides:
- ✅ **TDD-enforced development** (tests must pass)
- 📚 **Persistent memory bank** for project context
- 🤖 **Intelligent agent coordination** (9 specialized agents)
- 📊 **Complexity-based routing** (4 levels: quick → simple → intermediate → complex)

## Installation

### Step 1: Copy CCFlow to Your Project

```bash
# From CCFlow repository
cd /path/to/your-project
cp -r /path/to/CCFlow/.claude .
```

This copies:
- 12 commands (`.claude/commands/`)
- 9 agents (`.claude/agents/`)
- 6 memory bank templates (`.claude/templates/`)

### Step 2: Initialize Your Project

```bash
/cf:init MyProject
```

**What happens:**
- Creates `memory-bank/` directory with 6 core files
- Runs guided project brief creation (10-20 minutes)
- Facilitator agent helps you define scope, goals, and requirements

**Quick mode** (skip guided creation):
```bash
/cf:init MyProject --quick
```

## Your First Feature

### 1. Create a Task

```bash
/cf:feature "add user authentication"
```

**Output:**
```
🎯 COMPLEXITY ASSESSMENT
─────────────────────────
Task: Add user authentication
Level: 3 (Intermediate Feature)
...
→ RECOMMENDATION: This task requires planning.
   Please use: /cf:plan TASK-001
```

### 2. Plan It (if Level 2-4)

```bash
/cf:plan TASK-001
```

For Level 3-4, Facilitator automatically activates:
- Breaks down into sub-tasks
- Identifies technical considerations
- May recommend `/cf:creative` for complex sub-steps

### 3. Implement with TDD

```bash
/cf:code TASK-001-1  # First sub-task
```

**TDD workflow:**
1. testEngineer writes failing tests (RED)
2. Implementation agent makes tests pass (GREEN)
3. Tests must pass before completion (GREEN gate)

### 4. Save Your Progress

```bash
/cf:checkpoint "Completed auth foundation"
```

Updates all memory bank files with current state.

## Quick Reference

### Essential Commands

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/cf:feature [desc]` | Entry point for new work | Always start here |
| `/cf:plan TASK-ID` | Plan Level 2-4 tasks | When Assessor recommends it |
| `/cf:code TASK-ID` | TDD implementation | Ready to build |
| `/cf:checkpoint` | Save progress | Every 30-60 minutes |
| `/cf:status` | See task overview | Check what's active |
| `/cf:context` | Load work context | Start of session |

### Typical Workflow

```bash
# Morning
/cf:context          # Load where you left off
/cf:status          # See active tasks

# Work
/cf:feature "new feature description"
/cf:plan TASK-XXX   # If Level 2-4
/cf:code TASK-XXX   # Implement with TDD

# Regular saves
/cf:checkpoint      # Every 30-60 min

# End of day
/cf:checkpoint "End of day checkpoint"
```

## Understanding Complexity Levels

CCFlow routes tasks based on assessed complexity:

**Level 1 (Quick):**
- 1-2 files, <2 hours
- Example: "Fix button styling"
- Route: Direct to `/cf:code`

**Level 2 (Simple):**
- 3-5 files, 2-6 hours
- Example: "Add search to navbar"
- Route: `/cf:plan` → `/cf:code`

**Level 3 (Intermediate):**
- 5-15 files, 1-3 days
- Example: "Implement order management"
- Route: `/cf:plan` (auto-interactive) → `/cf:code`

**Level 4 (Complex):**
- 15+ files, 3+ days
- Example: "Migrate to OAuth"
- Route: `/cf:plan` (auto-interactive) → `/cf:creative` (for sub-tasks) → `/cf:code`

## Next Steps

**Learn more:**
- [Command Reference](commands.md) - All 12 commands with examples
- [Agent Reference](agents.md) - Understanding the 9 agents
- [Workflow Patterns](workflows.md) - Common development patterns

**Deep dive:**
- [System Architecture](../system/architecture.md) - Core concepts
- [Extending CCFlow](../system/extending.md) - Customization guide
- [Specifications](../specifications/) - Complete technical specs

## Common Questions

**Q: Do I need to write tests manually?**
A: No. The testEngineer agent writes tests first (TDD), then implementation agents make them pass.

**Q: What if tests fail?**
A: The system retries up to 3 times. If still failing, it stops and reports the blocker. Tests MUST pass.

**Q: Can I skip planning for complex tasks?**
A: Level 2-4 tasks require planning. Level 3-4 auto-enable interactive mode (Facilitator helps). You can override with `--skip-facilitation` but it's not recommended.

**Q: How often should I checkpoint?**
A: Every 30-60 minutes, or after completing significant work. Checkpoints save all memory bank files.

**Q: What's the memory bank?**
A: 6 files that track your project's scope, architecture, progress, and tasks. It's the single source of truth for project context.

---

**Ready to build!** Start with `/cf:init YourProject` and let CCFlow guide you through structured development.
