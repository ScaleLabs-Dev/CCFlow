---
description: "Create focused git commits with intelligent message generation and memory bank integration"
allowed-tools: ['Bash', 'Read', 'Edit']
argument-hint: "[--message \"text\"] [--all] [--staged] [--no-update]"
---

# Command: /cf:git

## Usage

```bash
/cf:git
/cf:git --message "implement user authentication"
/cf:git -m "fix login bug"
/cf:git --all
/cf:git --staged
/cf:git --no-update
```

## Parameters

- `--message "text"` or `-m "text"`: **Optional** - Custom commit message
- `--all`: **Optional** - Stage all modified files before committing
- `--staged`: **Optional** - Commit only currently staged files (no additional staging)
- `--no-update`: **Optional** - Skip memory bank update

---

## Purpose

Create focused git commits that:
1. Analyze changes and suggest intelligent commit messages
2. Follow project commit message conventions
3. Prevent common mistakes (committing secrets, working on main branch)
4. Update memory bank activeContext.md with commit details
5. Provide clear visibility into what's being committed

**Scope**: This command ONLY handles committing changes. It does NOT:
- Push to remote (user does this manually)
- Create or manage branches
- Handle merges or rebases
- Perform complex git operations

---

## Prerequisites

**Git repository required**. Command will error if not in a git repository.

**Memory bank optional**. Command works without memory bank but won't update activeContext.md.

---

## Process

### Step 1: Validate Environment

**Check git repository**:
```bash
git rev-parse --git-dir
```

**If NOT a git repository**:
```
❌ Not a Git Repository

This directory is not a git repository.

To initialize git:
git init

Or navigate to a git repository directory.
```

**Stop execution.**

---

**Check current branch**:
```bash
git branch --show-current
```

**If on main or master branch**:
```
⚠️ WARNING: On Main/Master Branch

You are currently on branch: [main|master]

Committing directly to main/master is not recommended.

Best practice: Create a feature branch
git checkout -b feature/[feature-name]

Continue anyway? (y/n)
```

**If user says no**: Stop execution.
**If user says yes**: Proceed with warning logged.

---

### Step 2: Check for Changes

**Run git status**:
```bash
git status --porcelain
```

**If no changes**:
```
ℹ️ No Changes to Commit

Working tree is clean. Nothing to commit.

Tip: Make some changes first, then run /cf:git
```

**Stop execution.**

---

### Step 3: Gather Change Context

**Run in parallel** (all bash commands):

1. **Staged files**:
```bash
git diff --staged --name-only
```

2. **Unstaged files**:
```bash
git diff --name-only
```

3. **Untracked files**:
```bash
git ls-files --others --exclude-standard
```

4. **Staged diff** (for analysis):
```bash
git diff --staged
```

5. **Recent commits** (for style analysis):
```bash
git log -5 --pretty=format:"%h %s"
```

---

### Step 4: Analyze Changes and Detect Issues

**Check for sensitive files** in staged + unstaged + untracked:

**Sensitive patterns to detect**:
- `.env`, `.env.*`
- `credentials.json`, `secrets.json`, `config.secret.*`
- `*.key`, `*.pem`, `*.p12`, `*.pfx`
- `id_rsa`, `id_ed25519`
- Files containing "secret", "password", "token" in name

**If sensitive files detected**:
```
🚨 SENSITIVE FILES DETECTED

The following files contain potential secrets and should NOT be committed:
- .env.local
- config/credentials.json
- keys/api.key

These files are likely sensitive. Add them to .gitignore instead:
echo ".env.local" >> .gitignore
echo "config/credentials.json" >> .gitignore
echo "keys/*.key" >> .gitignore

Commit blocked for safety.
```

**Stop execution.**

---

**Analyze change type** (from diff):

**Keywords detection**:
- New files (`A` status) → "add"
- Deleted files (`D` status) → "remove"
- Modified files (`M` status) + file contains "test" → "test"
- Modified files + file contains "README", ".md" → "docs"
- Modified files + keywords "fix", "bug" in diff → "fix"
- Modified files + keywords "refactor", "cleanup" → "refactor"
- Default → "update"

**Determine commit type prefix**:
- Add new feature → `feat:`
- Fix bug → `fix:`
- Refactor code → `refactor:`
- Update documentation → `docs:`
- Add/update tests → `test:`
- General update → `chore:` or no prefix (match project style)

---

**Extract recent commit message style**:

From `git log` output, identify patterns:
- Uses conventional commits (feat:, fix:, etc.)? → Follow that
- Uses imperative mood ("add", "fix", "update")? → Follow that
- Uses past tense ("added", "fixed")? → Follow that
- Length patterns (short vs detailed)?

**Default style if unclear**: Conventional commits with imperative mood

---

### Step 5: Stage Files (if needed)

**If `--staged` flag provided**:
- Skip staging, use currently staged files only

**If `--all` flag provided**:
```bash
git add --all
```

**If neither flag provided**:

Show user what needs to be staged:

```
📋 CHANGES DETECTED
─────────────────────────────

**Modified (not staged)**:
- src/auth/login.ts
- src/auth/session.ts

**Untracked**:
- src/auth/utils.ts

**Already staged**:
(none)

Which files should be committed?

Options:
1. All files (--all)
2. Only modified files (exclude untracked)
3. Manually select files
4. Use already staged files (none currently)

Enter choice (1-4):
```

**Based on user choice**:
- Choice 1: `git add --all`
- Choice 2: `git add --update`
- Choice 3: Prompt for file selection → `git add [files]`
- Choice 4: Use staged files (error if none staged)

---

### Step 6: Generate Commit Message

**If `--message` or `-m` flag provided**:
- Use user's custom message
- Skip generation

**Otherwise, generate message**:

**Template**:
```
[type]: [concise description]

[optional body if needed]
```

**Generation logic**:

1. **Determine type** (from Step 4 analysis)
2. **Generate description**:
   - Focus on WHAT changed and WHY
   - Use imperative mood: "add", "fix", "update"
   - Keep under 50 characters for summary
   - Be specific: "add user authentication" not "add feature"

3. **Example generations**:
   - Files: `src/auth/login.ts`, `src/auth/session.ts` modified
   - Diff shows: JWT token handling, session management
   - Generated: `feat: implement JWT authentication with session management`

   - Files: `README.md` modified
   - Diff shows: installation instructions added
   - Generated: `docs: add installation instructions to README`

   - Files: `src/utils/validate.ts` modified
   - Diff shows: bug fix for email validation
   - Generated: `fix: correct email validation regex pattern`

**Fallback if analysis unclear**:
```
chore: update [file names or component]
```

---

### Step 7: Present Commit Preview

**Show user what will be committed**:

```
📝 COMMIT PREVIEW
─────────────────────────────

**Files to be committed** ([N] files):
M  src/auth/login.ts
M  src/auth/session.ts
A  src/auth/utils.ts

**Changes summary**:
3 files changed, 125 insertions(+), 12 deletions(-)

**Suggested commit message**:
─────────────────────────────
feat: implement JWT authentication with session management

Adds JWT token handling and session management for user authentication.
Includes utility functions for token validation and refresh.
─────────────────────────────

Options:
1. Commit with this message
2. Edit message
3. Cancel

Enter choice (1-3):
```

**Based on user choice**:
- Choice 1: Proceed with suggested message
- Choice 2: Prompt for edited message → use edited version
- Choice 3: Stop execution

---

### Step 8: Create Commit

**Execute commit** using heredoc for proper formatting:

```bash
git commit -m "$(cat <<'EOF'
feat: implement JWT authentication with session management

Adds JWT token handling and session management for user authentication.
Includes utility functions for token validation and refresh.
EOF
)"
```

**Verify commit succeeded**:
```bash
git log -1 --oneline
git status
```

**If commit failed**:
```
❌ Commit Failed

Git commit command failed with error:
[error message from git]

Common causes:
- Empty commit (use --allow-empty if intentional)
- Pre-commit hooks failed
- Git configuration issues

Check git output above for details.
```

**Stop execution.**

---

### Step 9: Update Memory Bank (Optional)

**Check if memory bank exists**:
```bash
test -f memory-bank/activeContext.md
```

**If `--no-update` flag provided**: Skip update.

**If memory bank exists**:

**Read** `memory-bank/activeContext.md`

**Add entry to "Recent Changes" section**:

```markdown
### [YYYY-MM-DD HH:MM] - Git Commit
**Commit**: [commit_hash]
**Message**: [commit_message_first_line]
**Files**: [N] files changed
**Author**: Git (/cf:git command)
```

**Update activeContext.md** with new entry.

**If memory bank doesn't exist**:
```
ℹ️ Note: Memory bank not found, skipping activeContext.md update

To enable memory bank integration, run: /cf:init [project-name]
```

---

### Step 10: Output Success Confirmation

```
✅ COMMIT SUCCESSFUL
─────────────────────────────

**Commit**: [commit_hash]
**Branch**: [branch_name]
**Message**: [commit_message]

**Changes committed**:
- [N] files changed
- [X] insertions(+), [Y] deletions(-)

[✓ Memory bank updated: activeContext.md]

**Next steps**:
- Review commit: git show [commit_hash]
- Push to remote: git push origin [branch_name]
- Create pull request (if ready)
- Continue work on next task
```

---

## Examples

### Example 1: Guided Commit (Default Behavior)

```
User: /cf:git

Claude:
[Checks git status...]

📋 CHANGES DETECTED
─────────────────────────────

**Modified (not staged)**:
- src/components/LoginForm.tsx
- src/hooks/useAuth.ts
- tests/auth.test.ts

**Untracked**:
- src/types/auth.ts

Which files should be committed?

1. All files (--all)
2. Only modified files (exclude untracked)
3. Manually select files

Enter choice (1-3):

User: 1

[Stages all files, analyzes changes...]

📝 COMMIT PREVIEW
─────────────────────────────

**Files to be committed** (4 files):
M  src/components/LoginForm.tsx
M  src/hooks/useAuth.ts
M  tests/auth.test.ts
A  src/types/auth.ts

**Suggested commit message**:
─────────────────────────────
feat: add login form with authentication hook

Implements LoginForm component using useAuth hook for state management.
Adds TypeScript types for auth state and unit tests.
─────────────────────────────

Options:
1. Commit with this message
2. Edit message
3. Cancel

User: 1

[Creates commit...]

✅ COMMIT SUCCESSFUL
─────────────────────────────

**Commit**: 7a3f2b1
**Branch**: feature/auth
**Message**: feat: add login form with authentication hook

**Changes committed**:
- 4 files changed
- 156 insertions(+), 0 deletions(-)

✓ Memory bank updated: activeContext.md

**Next steps**:
- Review commit: git show 7a3f2b1
- Push to remote: git push origin feature/auth
```

---

### Example 2: Quick Commit with Custom Message

```
User: /cf:git -m "fix: resolve login redirect bug"

Claude:
[Checks git status, detects unstaged files...]

📋 CHANGES DETECTED
─────────────────────────────

**Modified (not staged)**:
- src/components/LoginForm.tsx

**Already staged**:
(none)

Stage modified files and commit with message:
"fix: resolve login redirect bug"

Proceed? (y/n):

User: y

[Stages files and creates commit...]

✅ COMMIT SUCCESSFUL
─────────────────────────────

**Commit**: 8b4c3d2
**Branch**: feature/auth
**Message**: fix: resolve login redirect bug

**Changes committed**:
- 1 file changed
- 3 insertions(+), 2 deletions(-)

✓ Memory bank updated: activeContext.md
```

---

### Example 3: Commit Already Staged Files

```
User: /cf:git --staged

Claude:
[Checks git status...]

📋 STAGED CHANGES
─────────────────────────────

**Already staged** (2 files):
M  src/auth/session.ts
M  tests/session.test.ts

**Suggested commit message**:
─────────────────────────────
test: add session management unit tests

Adds comprehensive test coverage for session creation, validation,
and expiration handling.
─────────────────────────────

Commit with this message? (y/n/edit):

User: y

[Creates commit...]

✅ COMMIT SUCCESSFUL
─────────────────────────────

**Commit**: 9c5d4e3
**Branch**: feature/auth
**Message**: test: add session management unit tests

**Changes committed**:
- 2 files changed
- 87 insertions(+), 0 deletions(-)

✓ Memory bank updated: activeContext.md
```

---

### Example 4: Warning - On Main Branch

```
User: /cf:git

Claude:
⚠️ WARNING: On Main/Master Branch

You are currently on branch: main

Committing directly to main/master is not recommended.

Best practice: Create a feature branch
git checkout -b feature/my-feature

Continue anyway? (y/n):

User: n

Claude:
Commit cancelled.

Create a feature branch first:
git checkout -b feature/[name]

Then run /cf:git again.
```

---

### Example 5: Error - Sensitive Files Detected

```
User: /cf:git --all

Claude:
[Scans files...]

🚨 SENSITIVE FILES DETECTED

The following files contain potential secrets and should NOT be committed:
- .env.local
- config/api-keys.json

These files are likely sensitive. Add them to .gitignore instead:
echo ".env.local" >> .gitignore
echo "config/api-keys.json" >> .gitignore

Then stage and commit safe files only:
git reset .env.local config/api-keys.json
/cf:git

Commit blocked for safety.
```

---

### Example 6: Commit All Changes

```
User: /cf:git --all -m "refactor: simplify authentication logic"

Claude:
[Checks for sensitive files... none found]
[Stages all files...]

📝 COMMIT PREVIEW
─────────────────────────────

**Files to be committed** (5 files):
M  src/auth/login.ts
M  src/auth/session.ts
D  src/auth/legacy.ts
M  src/hooks/useAuth.ts
M  tests/auth.test.ts

**Commit message**:
refactor: simplify authentication logic

Proceed? (y/n):

User: y

[Creates commit...]

✅ COMMIT SUCCESSFUL
─────────────────────────────

**Commit**: a1b2c3d
**Branch**: feature/auth-refactor
**Message**: refactor: simplify authentication logic

**Changes committed**:
- 5 files changed
- 78 insertions(+), 145 deletions(-)

✓ Memory bank updated: activeContext.md
```

---

## Error Handling

### Not a Git Repository

```
❌ Not a Git Repository

This directory is not a git repository.

To initialize git:
git init

Or navigate to a git repository directory.
```

---

### No Changes to Commit

```
ℹ️ No Changes to Commit

Working tree is clean. Nothing to commit.

Tip: Make some changes first, then run /cf:git
```

---

### On Main/Master Branch (Warning)

```
⚠️ WARNING: On Main/Master Branch

You are currently on branch: [main|master]

Committing directly to main/master is not recommended.

Best practice: Create a feature branch
git checkout -b feature/[feature-name]

Continue anyway? (y/n):
```

**User can proceed or cancel.**

---

### Sensitive Files Detected (Blocker)

```
🚨 SENSITIVE FILES DETECTED

The following files contain potential secrets and should NOT be committed:
- .env.local
- credentials.json
- api-keys.json

These files are likely sensitive. Add them to .gitignore:
echo ".env.local" >> .gitignore
echo "credentials.json" >> .gitignore
echo "api-keys.json" >> .gitignore

Commit blocked for safety.
```

**Execution stops. User must fix before retrying.**

---

### No Files Staged (with --staged flag)

```
❌ No Files Staged

You used --staged flag but no files are currently staged.

Either:
1. Stage files first: git add [files]
2. Use /cf:git --all to stage and commit all changes
3. Use /cf:git without flags for guided staging
```

---

### Commit Failed

```
❌ Commit Failed

Git commit command failed with error:
[error message from git]

Common causes:
- Empty commit (use --allow-empty if intentional)
- Pre-commit hooks failed
- Git configuration issues (name/email not set)

Git configuration check:
git config user.name
git config user.email

If not set:
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

---

### Memory Bank Not Found (Informational)

```
ℹ️ Note: Memory bank not found, skipping activeContext.md update

To enable memory bank integration, run: /cf:init [project-name]

This doesn't affect the commit - it succeeded.
```

---

## Memory Bank Updates

### activeContext.md Changes

**If memory bank exists**, add entry to "Recent Changes" section:

```markdown
### [YYYY-MM-DD HH:MM] - Git Commit
**Commit**: [short_hash]
**Message**: [commit_message_first_line]
**Files**: [N] files changed ([X] insertions, [Y] deletions)
**Branch**: [branch_name]
**Author**: Git (/cf:git command)
```

**Example entry**:
```markdown
### [2025-10-08 14:32] - Git Commit
**Commit**: 7a3f2b1
**Message**: feat: add login form with authentication hook
**Files**: 4 files changed (156 insertions, 0 deletions)
**Branch**: feature/auth
**Author**: Git (/cf:git command)
```

**If memory bank doesn't exist**: Informational message only, commit proceeds.

---

## Integration with Other Commands

### Relationship to /cf:checkpoint

**Different purposes**:
- `/cf:git` - Commits code changes to version control
- `/cf:checkpoint` - Updates ALL memory bank files with session summary

**Typical workflow**:
```bash
# Make code changes
[code changes...]

# Commit changes
/cf:git -m "feat: implement feature"

# After multiple commits or significant work
/cf:checkpoint --message "End of session: completed auth feature"
```

**Key distinction**: `/cf:git` is for version control, `/cf:checkpoint` is for project state documentation.

---

### After /cf:code

**Common pattern**:
```bash
# Implement task
/cf:code TASK-005

# Tests pass, implementation complete
# Commit the work
/cf:git --all -m "feat: implement search functionality"

# Document progress
/cf:checkpoint
```

---

### In Feature Development Flow

**Full workflow**:
```bash
# 1. Create task
/cf:feature "implement user profile"

# 2. Plan task
/cf:plan TASK-010 --interactive

# 3. Implement sub-tasks
/cf:code TASK-010-1
/cf:git -m "feat: add profile data model"

/cf:code TASK-010-2
/cf:git -m "feat: add profile UI component"

/cf:code TASK-010-3
/cf:git -m "test: add profile integration tests"

# 4. Review and checkpoint
/cf:review TASK-010
/cf:checkpoint
```

---

## Notes

- **Scope**: This command ONLY handles commits, not push/pull/merge operations
- **Safety-first**: Blocks commits with sensitive files, warns about main/master branch
- **Smart suggestions**: Analyzes changes to suggest appropriate commit messages
- **Flexible staging**: Supports guided, automatic (--all), or pre-staged (--staged) workflows
- **Memory bank integration**: Optional but helpful for tracking commit history in activeContext.md
- **Non-destructive**: Never forces operations or rewrites history
- **Style-aware**: Matches project's existing commit message conventions when detected
- **Git config required**: User must have git configured (name/email) for commits to work

---

## Best Practices

### Commit Message Quality

**Good messages** (specific, imperative mood):
```
feat: add JWT authentication with session management
fix: resolve race condition in token refresh
refactor: extract validation logic to utils module
docs: add API documentation for auth endpoints
test: add comprehensive auth integration tests
```

**Poor messages** (vague, not helpful):
```
fix: fix bug
update: updates
changes: changed some stuff
wip: work in progress
```

**The command will suggest good messages, but user can always override.**

---

### When to Commit

**Commit often**:
- After implementing a discrete unit of functionality
- When tests pass (GREEN state in TDD)
- Before risky operations (creates restore point)
- At logical stopping points

**Don't commit**:
- Broken code (tests failing)
- Work-in-progress that doesn't work
- Multiple unrelated changes together (split into separate commits)
- Sensitive information (passwords, keys, tokens)

---

### Branch Strategy

**Always work on feature branches**:
```bash
git checkout -b feature/my-feature
/cf:git -m "feat: implement feature"
git push origin feature/my-feature
# Create PR
```

**Avoid committing to main/master** (command will warn).

---

## Related Commands

- `/cf:checkpoint` - Document project state across memory bank (different from version control)
- `/cf:code` - Implement tasks (often followed by /cf:git to commit work)
- `/cf:review` - Quality check (confirm quality before committing)
- `/cf:init` - Initialize memory bank (enables activeContext.md updates)

---

**Command Version**: 1.0
**Last Updated**: 2025-10-08
