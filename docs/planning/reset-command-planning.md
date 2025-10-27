# /cf:reset Command - Planning Document

**Status**: Planning Phase
**Created**: 2025-10-23
**Purpose**: Development/QA tool to undo `/cf:init` for repeated testing

---

## Purpose & Use Case

### Primary Goal
Enable CCFlow framework developers to repeatedly test the `/cf:init` command by completely removing initialization artifacts.

### Target Users
- CCFlow framework developers
- Contributors doing QA on initialization flows
- NOT intended for routine end-user workflows

### User Story
> "As a framework developer, I need to test `/cf:init` repeatedly during development. I want to cleanly undo initialization so I can run it again fresh without manually deleting directories."

---

## Command Design

### Command Signature
```bash
/cf:reset [flags]
```

### Flags (Proposed)
- `--backup` - Create timestamped backup before deletion
- `--force` - Skip confirmation prompts (use with caution)
- `--dry-run` - Show what would be deleted without actually deleting

### File Location
`.claude/commands/cf/reset.md`

### Allowed Tools
- `Read` - Check file/directory existence
- `Bash` - Directory operations (rm, cp, git status)
- `Glob` - Find files to delete

---

## What Gets Deleted (DRAFT - Needs Architectural Review)

### ⚠️ PENDING ARCHITECTURAL DECISION ⚠️

**Question**: Should workflow agents be framework-level (never copied) or project-level (copied during init)?

**Current /cf:init behavior** (copies from templates):
- ❌ `.claude/agents/workflow/` (6 agents copied from templates)
- ❌ `.claude/agents/` (3 generic agents copied from templates)
- ❌ `.claude/agents/specialists/` (custom specialists directory)
- ❌ `memory-bank/` (all 6 memory bank files)

**Alternative architecture** (see agent-organization-analysis.md):
- Workflow agents might stay in framework (never copied/deleted)
- Only implementation agents + specialists + memory bank deleted

### Definite Deletions (Regardless of Architecture)
1. **Memory Bank** (`memory-bank/`):
   - `projectbrief.md`
   - `productContext.md`
   - `systemPatterns.md`
   - `activeContext.md`
   - `progress.md`
   - `tasks.md`

2. **Custom Specialists** (`.claude/agents/specialists/`):
   - Any agents created via `/cf:create-specialist`

3. **Team-Specific Agents** (if `/cf:configure-team` was run):
   - Stack-specific agents in configured directories

### Pending Architectural Decision
**Workflow Agents** (`.claude/agents/workflow/`):
- Current: Copied from templates during init, deleted during reset
- Alternative: Stay in framework permanently, never copied/deleted
- **Decision needed before implementation**

**Generic Implementation Agents** (`.claude/agents/`):
- Current: Copied from templates during init, deleted during reset
- Alternative: Could also stay in framework, or remain copyable for customization
- **Decision needed before implementation**

---

## What Gets KEPT (Core Framework)

### Always Preserved
1. **Commands** (`.claude/commands/cf/`):
   - All command markdown files

2. **System Agents** (`.claude/agents/system/`):
   - `commandBuilder.md`
   - `agentBuilder.md`
   - `project-discovery.md`

3. **Templates** (`.claude/templates/`):
   - All template files (source templates)
   - Memory bank templates
   - Agent templates
   - Team type templates

4. **References** (`.claude/references/`):
   - Documentation
   - Stack patterns
   - Specifications

---

## Safety Features

### Pre-flight Checks
1. **Existence Check**: Verify memory-bank/ exists (skip if already clean)
2. **Git Status Check**: Warn if uncommitted changes in memory-bank/
3. **Dry Run Option**: Show what would be deleted without deleting

### Confirmation Flow
**Default (interactive)**:
```
⚠️ DESTRUCTIVE OPERATION WARNING

This will DELETE:
- memory-bank/ (6 files)
- .claude/agents/workflow/ (6 agents) [if applicable]
- .claude/agents/ (3 generic agents) [if applicable]
- .claude/agents/specialists/ (N custom specialists)

⚠️ Uncommitted changes detected in memory-bank/

Options:
  yes      - Proceed with deletion
  backup   - Create backup then proceed
  no       - Cancel operation

Your choice:
```

**With --force flag**:
- Skips confirmation
- Still performs git status check
- Shows warning about uncommitted changes
- Proceeds immediately

**With --dry-run flag**:
```
🔍 DRY RUN MODE (No files will be deleted)

Would delete:
✓ memory-bank/ (6 files, 45 KB)
✓ .claude/agents/workflow/ (6 agents, 120 KB)
✓ .claude/agents/ (3 agents, 80 KB)
✓ .claude/agents/specialists/ (2 specialists, 40 KB)

Total: 285 KB across 17 files

To actually delete: /cf:reset
To create backup first: /cf:reset --backup
```

### Backup Feature (--backup flag)
**Backup Location**: `.ccflow-backups/backup-YYYY-MM-DD-HHmmss/`

**Backup Contents**:
- Copy of memory-bank/
- Copy of .claude/agents/
- manifest.json with metadata

**Manifest Example**:
```json
{
  "backup_date": "2025-10-23T14:30:00Z",
  "project_name": "extracted from projectbrief.md",
  "backup_trigger": "manual /cf:reset --backup",
  "contents": {
    "memory_bank": true,
    "workflow_agents": true,
    "generic_agents": true,
    "specialists": ["authGuard", "dbMigration"]
  }
}
```

---

## Process Flow

### Step 1: Pre-flight Checks
```
ACTION: Check if memory-bank/ exists
├─ NOT EXISTS → "✓ Already clean (nothing to reset)"
└─ EXISTS → Continue

ACTION: Check git status
├─ Uncommitted changes → Warn user
└─ Clean → Note in output
```

### Step 2: Dry Run Analysis (if --dry-run)
```
ACTION: Scan and report what would be deleted
- Count files and directories
- Calculate total size
- Show detailed list
EXIT: Don't actually delete
```

### Step 3: Confirmation (unless --force)
```
ACTION: Present deletion summary
ACTION: Request user confirmation
├─ "yes" → Proceed to Step 4
├─ "backup" → Enable backup flag, proceed to Step 4
└─ "no" / timeout → Cancel operation
```

### Step 4: Backup (if --backup flag set)
```
ACTION: Create .ccflow-backups/ directory
ACTION: Create timestamped subdirectory
ACTION: Copy memory-bank/ → backup/memory-bank/
ACTION: Copy .claude/agents/ → backup/.claude/agents/
ACTION: Write manifest.json
OUTPUT: "✓ Backup created: .ccflow-backups/backup-[timestamp]/"
```

### Step 5: Deletion
```
ACTION: Remove memory-bank/
OUTPUT: "✓ Deleted memory-bank/ (6 files)"

[IF workflow agents should be deleted - pending architectural decision]
ACTION: Remove .claude/agents/workflow/
OUTPUT: "✓ Deleted .claude/agents/workflow/ (6 agents)"

ACTION: Remove .claude/agents/[generic agents]
OUTPUT: "✓ Deleted generic implementation agents (3 agents)"

ACTION: Remove .claude/agents/specialists/
OUTPUT: "✓ Deleted specialists directory (N custom specialists)"

[IF team-specific agents exist]
ACTION: Remove team-specific agent directories
OUTPUT: "✓ Deleted team-specific agents"
```

### Step 6: Verification
```
ACTION: Verify directories no longer exist
├─ All deleted → Success
└─ Some remain → Report what failed to delete

OUTPUT: Final status summary
```

### Step 7: Next Steps Recommendation
```
OUTPUT:
"✓ CCFlow initialization reset complete

To reinitialize:
  /cf:init

To restore from backup:
  [manual instructions for copying from .ccflow-backups/]

Note: This is a development tool. Do not use in production workflows."
```

---

## Output Examples

### Example 1: Basic Reset (with confirmation)
```
User: /cf:reset

Claude:
⚠️ DESTRUCTIVE OPERATION WARNING

This will DELETE:
- memory-bank/ (6 files, 45 KB)
- .claude/agents/workflow/ (6 agents, 120 KB)
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
✓ Deleted .claude/agents/workflow/ (6 agents, 120 KB)
✓ Deleted .claude/agents/ (3 generic agents, 80 KB)
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
  ├─ .claude/agents/ (9 agents)
  └─ manifest.json

Proceeding with reset...

✓ Deleted memory-bank/ (6 files, 45 KB)
✓ Deleted .claude/agents/workflow/ (6 agents, 120 KB)
✓ Deleted .claude/agents/ (3 generic agents, 80 KB)
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

✓ .claude/agents/workflow/
  ├─ assessor.md (18 KB)
  ├─ architect.md (22 KB)
  ├─ product.md (20 KB)
  ├─ facilitator.md (25 KB)
  ├─ documentarian.md (18 KB)
  └─ reviewer.md (17 KB)
  Total: 120 KB

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

Total to delete: 285 KB across 17 files in 4 directories

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
- [additional items...]

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
⚠️ Uncommitted changes detected in memory-bank/

Proceeding with reset...

✓ Deleted memory-bank/ (6 files, 45 KB)
✓ Deleted .claude/agents/workflow/ (6 agents, 120 KB)
✓ Deleted .claude/agents/ (3 generic agents, 80 KB)
✓ Deleted .claude/agents/specialists/ (0 specialists)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ CCFlow initialization reset complete

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
✓ .claude/agents/workflow/ (6 agents)

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

## Implementation Notes

### Git Integration
**Check for uncommitted changes**:
```bash
git status --porcelain memory-bank/
```

**Output interpretation**:
- Empty → Clean
- Non-empty → Uncommitted changes exist

### Backup Naming
**Format**: `backup-YYYY-MM-DD-HHmmss`
**Example**: `backup-2025-10-23-143045`
**Rationale**: Sortable, unambiguous, avoids conflicts

### Idempotency
**Safe to run multiple times**:
- If already clean → Report "already clean", exit gracefully
- If partially reset → Complete remaining deletions
- No error if directories already deleted

---

## Open Questions / Decisions Needed

### Critical Architectural Decision
**⚠️ BLOCKS IMPLEMENTATION ⚠️**

**Question**: Should workflow agents be framework-level or project-level?

**Current State**: Copied from templates during init, deleted during reset

**Alternative**: Stay in framework permanently, never copied/deleted

**Impact on /cf:reset**:
- Option A (project-level): Reset deletes them
- Option B (framework-level): Reset skips them

**Decision needed**: See `agent-organization-analysis.md` for deep analysis

### Secondary Questions
1. **Backup retention**: Should old backups be auto-cleaned? After how long?
2. **Gitignore**: Should `.ccflow-backups/` be auto-added to .gitignore?
3. **Team agents**: What about agents installed by `/cf:configure-team`?
4. **Specialist handling**: Should specialists be backed up separately or together?

---

## Success Criteria

### Command Completion
- [ ] All specified directories/files deleted
- [ ] Verification confirms deletion
- [ ] Clear confirmation output
- [ ] Project is in pre-init state (ready for /cf:init)

### Safety Features Working
- [ ] Git status check detects uncommitted changes
- [ ] Confirmation prompt works (unless --force)
- [ ] Backup creation works (if --backup)
- [ ] Dry run shows accurate preview

### User Experience
- [ ] Clear, professional output
- [ ] No ambiguity about what was deleted
- [ ] Helpful next steps provided
- [ ] Warnings are clear but not alarming

### Development Utility
- [ ] Enables repeated /cf:init testing
- [ ] Fast execution (< 3 seconds)
- [ ] Reliable cleanup (no orphaned files)
- [ ] Safe for framework development workflow

---

## Next Steps

1. **DECISION REQUIRED**: Resolve agent organization architecture
   - Create `agent-organization-analysis.md`
   - Deep analysis of framework vs project agents
   - Decide on final architecture

2. **Update /cf:init**: If architecture changes
   - Modify what gets copied
   - Update documentation

3. **Implement /cf:reset**: After architectural decision
   - Create `.claude/commands/cf/reset.md`
   - Follow command specification format
   - Include all safety features

4. **Testing**:
   - Test on clean project
   - Test with uncommitted changes
   - Test backup functionality
   - Test dry-run mode
   - Test force mode
   - Test error conditions

5. **Documentation**:
   - Add to command list in README
   - Update initialization docs
   - Add to troubleshooting guide
   - Mark as development tool

---

**Status**: Awaiting architectural decision on agent organization
**Blocker**: Cannot finalize what to delete until architecture is clear
**Next Action**: Create agent-organization-analysis.md
