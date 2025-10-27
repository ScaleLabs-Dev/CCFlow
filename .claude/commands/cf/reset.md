---
description: "Development tool to undo /cf:init for repeated testing (QA only)"
allowed-tools: ['Read', 'Bash', 'Glob']
argument-hint: "[--backup] [--force] [--dry-run]"
---

# Command: /cf:reset

## Usage

```
/cf:reset
/cf:reset --backup
/cf:reset --force
/cf:reset --dry-run
```

## Flags

- `--backup`: Create timestamped backup before deletion
- `--force`: Skip confirmation prompts (use with caution)
- `--dry-run`: Show what would be deleted without actually deleting

---

## ⚠️ DEVELOPMENT TOOL WARNING

**This is a DEVELOPMENT/QA tool for CCFlow framework contributors.**

**Purpose**: Enable repeated testing of `/cf:init` by completely removing initialization artifacts.

**NOT for routine use**: Do not use this in normal project workflows. This destroys project configuration and memory bank data.

---

## Purpose

Remove all CCFlow initialization artifacts to return project to pre-init state:
1. Delete memory bank directory
2. Delete project-specific agents (generic implementation agents)
3. Delete custom specialists
4. Delete team-specific agents (if configured)
5. Clean up old architecture (transition support)

**Framework agents remain untouched** (workflow and system agents).

---

## Prerequisites

None required. Safe to run even if already clean.

---

## What Gets Deleted

### Always Deleted
- `memory-bank/` - All memory bank files
- `.claude/agents/codeImplementer.md` - Generic implementation agent
- `.claude/agents/testEngineer.md` - Generic test agent
- `.claude/agents/uiDeveloper.md` - Generic UI agent
- `.claude/agents/specialists/` - Custom specialists directory
- `.claude/agents/[team-type]/` - Team-specific agent directories

### Transition Cleanup (Old Architecture)
- `.claude/agents/workflow/` - If found in project (old architecture)

---

## What Gets KEPT (Framework)

### Framework Agents (Never Deleted)
- `.claude/agents/workflow/` - Framework workflow agents
  - assessor.md, architect.md, product.md, facilitator.md, documentarian.md, reviewer.md
- `.claude/agents/system/` - Framework system agents
  - commandBuilder.md, agentBuilder.md, project-discovery.md

### Framework Components
- `.claude/commands/` - All commands
- `.claude/templates/` - All templates
- `.claude/references/` - All reference docs

---

## Process

### Step 1: Check if Initialized

Check if `memory-bank/` exists:

**If NOT EXISTS**:
```
✓ Already Clean

Memory bank not found at: memory-bank/
Project is already in pre-init state.

Nothing to reset.

To initialize: /cf:init
```

**Stop execution.**

---

### Step 2: Git Status Check

Check for uncommitted changes in memory-bank/:

```bash
git status --porcelain memory-bank/
```

**If uncommitted changes found**:
- Warn user
- Show which files are modified
- Recommend backup or commit

---

### Step 3: Dry Run (if --dry-run flag)

Scan and report what would be deleted:

```
🔍 DRY RUN MODE (No files will be deleted)

Would delete:
✓ memory-bank/
  ├─ projectbrief.md (12 KB)
  ├─ productContext.md (8 KB)
  ├─ systemPatterns.md (6 KB)
  ├─ activeContext.md (2 KB)
  ├─ progress.md (3 KB)
  └─ tasks.md (14 KB)
  Total: 45 KB

✓ .claude/agents/
  ├─ codeImplementer.md (30 KB)
  ├─ testEngineer.md (28 KB)
  └─ uiDeveloper.md (22 KB)
  Total: 80 KB

✓ .claude/agents/specialists/
  ├─ authGuard.md (18 KB)
  └─ dbMigration.md (22 KB)
  Total: 40 KB

[Old Architecture Detected]
⚠️  .claude/agents/workflow/ (120 KB) - Will be cleaned

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total to delete: 285 KB across 17 files in 4 directories

To actually delete: /cf:reset
To create backup first: /cf:reset --backup
To skip confirmation: /cf:reset --force
```

**Exit after reporting.**

---

### Step 4: Confirmation (unless --force)

Present deletion summary and request confirmation:

```
⚠️ DESTRUCTIVE OPERATION WARNING

This will DELETE:
- memory-bank/ (6 files, 45 KB)
- .claude/agents/ (3 generic agents, 80 KB)
- .claude/agents/specialists/ (2 custom specialists, 40 KB)

[If old architecture detected]
⚠️  Old architecture detected:
- .claude/agents/workflow/ (6 agents, 120 KB) - will be cleaned

Git Status: [No uncommitted changes ✓ | ⚠️  Uncommitted changes detected]

This is a DEVELOPMENT TOOL for testing /cf:init repeatedly.
Are you sure you want to proceed?

Type 'yes' to confirm, 'backup' to backup first, 'no' to cancel:
```

**User responses**:
- `yes` → Proceed to deletion
- `backup` → Enable backup flag, proceed to backup then deletion
- `no` / timeout → Cancel operation

---

### Step 5: Backup (if --backup flag)

Create timestamped backup:

```bash
# Create backup directory
mkdir -p .ccflow-backups
timestamp=$(date +%Y-%m-%d-%H%M%S)
backup_dir=".ccflow-backups/backup-$timestamp"
mkdir -p "$backup_dir"

# Copy memory bank
[ -d "memory-bank/" ] && cp -r memory-bank/ "$backup_dir/"

# Copy agents
[ -d ".claude/agents/" ] && cp -r .claude/agents/ "$backup_dir/.claude/"

# Create manifest
cat > "$backup_dir/manifest.json" <<EOF
{
  "backup_date": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "backup_trigger": "manual /cf:reset --backup",
  "contents": {
    "memory_bank": true,
    "generic_agents": true,
    "specialists": true
  }
}
EOF
```

**Output**:
```
Creating backup before reset...

✓ Backup created: .ccflow-backups/backup-2025-10-23-143045/
  ├─ memory-bank/ (6 files)
  ├─ .claude/agents/ (agents)
  └─ manifest.json

Proceeding with reset...
```

---

### Step 6: Deletion

Execute deletion in safe order:

```bash
# Memory bank (always delete)
rm -rf memory-bank/

# Generic implementation agents (always delete)
rm -f .claude/agents/codeImplementer.md
rm -f .claude/agents/testEngineer.md
rm -f .claude/agents/uiDeveloper.md

# Specialists directory (always delete if exists)
rm -rf .claude/agents/specialists/

# Team-specific agents (delete if exists)
# Find and delete any subdirectories except system, workflow
for dir in .claude/agents/*/; do
  dirname=$(basename "$dir")
  if [ "$dirname" != "system" ] && [ "$dirname" != "workflow" ]; then
    rm -rf "$dir"
  fi
done

# OLD ARCHITECTURE CLEANUP (transition period)
# Check if workflow agents exist in project location (shouldn't in new arch)
if [ -d ".claude/agents/workflow/" ]; then
  # Check if it's in project location (not framework)
  # Framework location would be in CCFlow itself
  echo "⚠️  Detected old architecture - cleaning workflow agents"
  rm -rf .claude/agents/workflow/
fi
```

**Output**:
```
Resetting CCFlow initialization...

✓ Deleted memory-bank/ (6 files, 45 KB)
✓ Deleted .claude/agents/codeImplementer.md
✓ Deleted .claude/agents/testEngineer.md
✓ Deleted .claude/agents/uiDeveloper.md
✓ Deleted .claude/agents/specialists/ (2 specialists, 40 KB)

[If old architecture found]
⚠️  Detected old architecture - cleaning workflow agents
✓ Deleted .claude/agents/workflow/ (6 agents, 120 KB)
```

---

### Step 7: Verification

Verify directories no longer exist:

```bash
# Check memory bank deleted
[ ! -d "memory-bank/" ] && echo "✓ memory-bank/ removed"

# Check generic agents deleted
[ ! -f ".claude/agents/codeImplementer.md" ] && echo "✓ Generic agents removed"

# Check specialists deleted
[ ! -d ".claude/agents/specialists/" ] && echo "✓ Specialists removed"
```

**If any fail to delete**: Report specific files and suggest manual cleanup.

---

### Step 8: Next Steps

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ CCFlow initialization reset complete

Project is now in pre-init state.

To reinitialize: /cf:init

[If backup created]
Backup available at: .ccflow-backups/backup-2025-10-23-143045/
To restore: manually copy contents back

Note: This is a development tool for framework QA.
```

---

## Examples

### Example 1: Basic Reset (with confirmation)

```
User: /cf:reset

Claude:
⚠️ DESTRUCTIVE OPERATION WARNING

This will DELETE:
- memory-bank/ (6 files, 45 KB)
- .claude/agents/ (3 generic agents, 80 KB)
- .claude/agents/specialists/ (0 custom specialists)

Git Status: No uncommitted changes ✓

This is a DEVELOPMENT TOOL for testing /cf:init repeatedly.
Are you sure you want to proceed?

Type 'yes' to confirm, 'backup' to backup first, 'no' to cancel:

User: yes

Claude:
Resetting CCFlow initialization...

✓ Deleted memory-bank/ (6 files, 45 KB)
✓ Deleted .claude/agents/codeImplementer.md
✓ Deleted .claude/agents/testEngineer.md
✓ Deleted .claude/agents/uiDeveloper.md
✓ Deleted .claude/agents/specialists/ (0 specialists)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ CCFlow initialization reset complete

Project is now in pre-init state.

To reinitialize: /cf:init

Note: This is a development tool for framework QA.
```

### Example 2: Reset with Backup

```
User: /cf:reset --backup

Claude:
Creating backup before reset...

✓ Backup created: .ccflow-backups/backup-2025-10-23-143045/
  ├─ memory-bank/ (6 files)
  ├─ .claude/agents/ (3 agents)
  └─ manifest.json

Proceeding with reset...

✓ Deleted memory-bank/ (6 files, 45 KB)
✓ Deleted .claude/agents/codeImplementer.md
✓ Deleted .claude/agents/testEngineer.md
✓ Deleted .claude/agents/uiDeveloper.md
✓ Deleted .claude/agents/specialists/ (2 specialists, 40 KB)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ CCFlow initialization reset complete

Backup available at: .ccflow-backups/backup-2025-10-23-143045/

To restore backup: manually copy contents back
To reinitialize fresh: /cf:init
```

### Example 3: Dry Run

```
User: /cf:reset --dry-run

Claude:
🔍 DRY RUN MODE (No files will be deleted)

Would delete:
✓ memory-bank/
  ├─ projectbrief.md (12 KB)
  ├─ productContext.md (8 KB)
  ├─ systemPatterns.md (6 KB)
  ├─ activeContext.md (2 KB)
  ├─ progress.md (3 KB)
  └─ tasks.md (14 KB)
  Total: 45 KB

✓ .claude/agents/
  ├─ codeImplementer.md (30 KB)
  ├─ testEngineer.md (28 KB)
  └─ uiDeveloper.md (22 KB)
  Total: 80 KB

✓ .claude/agents/specialists/
  ├─ authGuard.md (18 KB)
  └─ dbMigration.md (22 KB)
  Total: 40 KB

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total to delete: 165 KB across 11 files in 3 directories

To actually delete: /cf:reset
To create backup first: /cf:reset --backup
To skip confirmation: /cf:reset --force
```

### Example 4: Uncommitted Changes Warning

```
User: /cf:reset

Claude:
⚠️ DESTRUCTIVE OPERATION WARNING

This will DELETE:
- memory-bank/ (6 files, 45 KB)
- .claude/agents/ (3 generic agents, 80 KB)
- .claude/agents/specialists/ (0 specialists)

⚠️ Uncommitted changes detected in memory-bank/:
  modified: memory-bank/activeContext.md
  modified: memory-bank/progress.md

These changes will be lost unless you:
1. Commit them first (git add & commit)
2. Use --backup flag to save a copy
3. Cancel and save manually

Type 'yes' to proceed, 'backup' to backup first, 'no' to cancel:
```

### Example 5: Already Clean

```
User: /cf:reset

Claude:
✓ Already Clean

Memory bank not found at: memory-bank/
Project is already in pre-init state.

Nothing to reset.

To initialize: /cf:init
```

### Example 6: Force Mode

```
User: /cf:reset --force

Claude:
⚠️ Force mode enabled - skipping confirmation

Checking git status...
Git Status: No uncommitted changes ✓

Proceeding with reset...

✓ Deleted memory-bank/ (6 files, 45 KB)
✓ Deleted .claude/agents/codeImplementer.md
✓ Deleted .claude/agents/testEngineer.md
✓ Deleted .claude/agents/uiDeveloper.md
✓ Deleted .claude/agents/specialists/ (0 specialists)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ CCFlow initialization reset complete

To reinitialize: /cf:init
```

### Example 7: Old Architecture Cleanup

```
User: /cf:reset

Claude:
⚠️ DESTRUCTIVE OPERATION WARNING

This will DELETE:
- memory-bank/ (6 files, 45 KB)
- .claude/agents/ (3 generic agents, 80 KB)
- .claude/agents/specialists/ (0 specialists)

⚠️  Old architecture detected:
- .claude/agents/workflow/ (6 agents, 120 KB) - will be cleaned

Git Status: No uncommitted changes ✓

This is a DEVELOPMENT TOOL for testing /cf:init repeatedly.
Are you sure you want to proceed?

Type 'yes' to confirm, 'backup' to backup first, 'no' to cancel:

User: yes

Claude:
Resetting CCFlow initialization...

✓ Deleted memory-bank/ (6 files, 45 KB)
✓ Deleted .claude/agents/codeImplementer.md
✓ Deleted .claude/agents/testEngineer.md
✓ Deleted .claude/agents/uiDeveloper.md
✓ Deleted .claude/agents/specialists/ (0 specialists)

⚠️  Detected old architecture - cleaning workflow agents
✓ Deleted .claude/agents/workflow/ (6 agents, 120 KB)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ CCFlow initialization reset complete
✓ Old architecture cleaned up

Project is now in pre-init state.

To reinitialize: /cf:init
```

---

## Error Handling

### Permission Denied

```
❌ Error: Permission denied

Failed to delete: memory-bank/tasks.md

Possible causes:
- File is open in another application
- Insufficient file permissions
- File is locked

Resolution:
1. Close any applications using CCFlow files
2. Check file permissions (chmod)
3. Run with appropriate permissions

Partial reset completed. Rerun /cf:reset to retry.
```

### Backup Creation Failed

```
❌ Error: Backup creation failed

Failed to create: .ccflow-backups/backup-2025-10-23-143045/

Possible causes:
- Insufficient disk space
- Permission issues

Resolution:
1. Check available disk space
2. Check write permissions in project directory
3. Try /cf:reset without --backup flag (destructive)

No files have been deleted yet.
```

### Partial Deletion

```
⚠️ Warning: Partial deletion

Successfully deleted:
✓ memory-bank/ (6 files)
✓ .claude/agents/codeImplementer.md

Failed to delete:
❌ .claude/agents/specialists/authGuard.md (Permission denied)

Resolution:
- Close applications using the file
- Check file permissions
- Manually delete remaining files
- Rerun /cf:reset

Project is in inconsistent state. Complete reset before /cf:init.
```

---

## Integration with Other Commands

### Before Reset

**Recommended workflow**:
```bash
# Save important work
git add memory-bank/
git commit -m "Save work before reset"

# Or create backup
/cf:reset --backup

# Or just check what would happen
/cf:reset --dry-run
```

### After Reset

**Next steps**:
```bash
# Reinitialize fresh
/cf:init

# Or restore from backup (manual)
cp -r .ccflow-backups/backup-[timestamp]/memory-bank/ memory-bank/
```

### Related Commands

- `/cf:init` - What this command undoes
- `/cf:sync` - Verify state before reset
- `/cf:checkpoint` - Create memory bank checkpoint before reset

---

## Notes

- **Development Tool**: For CCFlow framework QA, not routine use
- **Safety First**: Multiple safety checks and confirmation
- **Git Integration**: Warns about uncommitted changes
- **Idempotent**: Safe to run multiple times
- **Backup Support**: Optional timestamped backup
- **Transition Support**: Cleans up old architecture automatically
- **Framework Preservation**: Never deletes framework agents
- **Clear Feedback**: Always reports what was deleted

---

**Command Version**: 1.0
**Last Updated**: 2025-10-23
**Purpose**: Development/QA tool for repeated /cf:init testing
