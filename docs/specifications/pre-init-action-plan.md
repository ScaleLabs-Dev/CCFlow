# CCFlow Pre-Init Action Plan

**Purpose**: Structured checklist of actions and decisions to address before running `/cf:init` for the first time.

**Organization**: Highest risk and most ambiguous items first, descending to low-risk optimizations.

**Status Tracking**: Use checkboxes to track completion.

---

## Phase 1: CRITICAL - Clarify Ambiguities (DO FIRST)

These items have the highest ambiguity and need design decisions before proceeding.

---

### 🔴 ACTION 1: Define Routing Disambiguation Strategy

**Risk**: HIGH - Agent routing could select wrong specialist for ambiguous tasks
**Ambiguity**: HIGH - No conflict resolution defined when multiple keywords match

**Current State**:
- Agent routing checks keywords against routing.md
- If multiple agents match (e.g., "database performance" matches both databaseSpecialist AND performanceSpecialist), selection logic is undefined

**Decision Needed**:

- [ ] **Choice A**: First match wins (keyword order determines priority)
  - **Pro**: Simple, deterministic
  - **Con**: Keyword order becomes critical (fragile)
  - **Implementation**: Document in routing.md template

- [ ] **Choice B**: Most specific match wins (count keyword matches, pick highest)
  - **Pro**: More intelligent selection
  - **Con**: Requires scoring logic, still ambiguous for ties
  - **Implementation**: Add scoring to /cf:code command

- [ ] **Choice C**: Present options to user when ambiguous
  - **Pro**: User always gets right agent
  - **Con**: Adds friction to workflow
  - **Implementation**: Interactive prompt in /cf:code

- [ ] **Choice D**: Use task complexity as tiebreaker (higher complexity → more specialized agent)
  - **Pro**: Aligns complexity with expertise
  - **Con**: Requires complexity-to-agent mapping
  - **Implementation**: Add to Assessor logic

**Recommendation**: Start with **Choice A** (simplest), monitor for issues, upgrade to **Choice D** if needed

**Action**:
- [ ] Decide which approach to use
- [ ] Document decision in routing.md template
- [ ] Update /cf:code command specification if needed
- [ ] Add example to routing.md showing keyword priority

**Test Case**:
```
Task: "Optimize database query performance for user dashboard"
Keywords: database, query, performance, optimization, user, dashboard

routing.md contains:
  - database → databaseSpecialist
  - performance → performanceSpecialist
  - user → frontendSpecialist

Which agent selected? (Document answer)
```

---

### 🔴 ACTION 2: Define Conflict Detection Logic for Checkpoint

**Risk**: HIGH - Memory bank files could drift into inconsistent state
**Ambiguity**: HIGH - No explicit conflict detection or resolution process

**Current State**:
- Multiple agents update activeContext.md and tasks.md
- Documentarian reads all files during checkpoint but doesn't validate consistency
- No defined conflict resolution strategy

**Decision Needed**:

**What conflicts to detect?**

- [ ] activeContext.md "Current Focus" task ID doesn't match tasks.md active task
- [ ] activeContext.md "Recent Changes" date is AFTER task completion date in tasks.md
- [ ] tasks.md shows task "Complete" but activeContext.md still lists it as active
- [ ] Multiple tasks marked as "Active" in tasks.md (should be 1 primary focus)
- [ ] Sub-task marked complete in tasks.md but parent task not updated
- [ ] Other: ___________________________________

**How to resolve conflicts?**

- [ ] **Choice A**: Prompt user to resolve manually
  - **Pro**: User has full control
  - **Con**: Interrupts workflow

- [ ] **Choice B**: Auto-resolve with priority rules (e.g., tasks.md is source of truth for status)
  - **Pro**: Smooth workflow
  - **Con**: Could hide real issues

- [ ] **Choice C**: Log conflict, continue, require manual resolution at next checkpoint
  - **Pro**: Non-blocking
  - **Con**: Could accumulate inconsistencies

**Recommendation**: **Choice A** for critical conflicts (task status mismatch), **Choice C** for minor conflicts (date discrepancies)

**Action**:
- [ ] Decide which conflicts to detect
- [ ] Decide resolution strategy for each conflict type
- [ ] Document in Documentarian agent specification
- [ ] Add conflict detection to checkpoint command process
- [ ] Create test scenario to verify conflict detection works

**Implementation Location**:
- File: `.claude/agents/workflow/Documentarian.md`
- Section: Add new "Conflict Detection" section after "Checkpoint Process"
- File: `.claude/commands/cf/checkpoint.md`
- Section: Add "Conflict Detection" step before "Step 5: Documentarian Output Summary"

---

### 🔴 ACTION 3: Define activeContext.md Archival Policy

**Risk**: MEDIUM - File could grow unbounded over time
**Ambiguity**: HIGH - No size limit or archival strategy defined

**Current State**:
- activeContext.md "Recent Changes" section logs every change
- Template shows 3 entries but no limit specified
- No archival mechanism documented

**Decision Needed**:

**How many recent changes to keep?**

- [ ] Keep last 5 changes (minimal history)
- [ ] Keep last 10 changes (moderate history)
- [ ] Keep last 15 changes (extensive history)
- [ ] Keep all changes from current day + last N changes
- [ ] Other: ___________________________________

**Where to archive old changes?**

- [ ] Move to progress.md checkpoint entries (integrated history)
- [ ] Create separate activeContext-archive.md file (dedicated archive)
- [ ] Delete old changes (no archive - rely on git history)
- [ ] Other: ___________________________________

**When to trigger archival?**

- [ ] Every checkpoint (automatic)
- [ ] When Recent Changes exceeds N entries (threshold-based)
- [ ] Manual command only (user control)
- [ ] Other: ___________________________________

**Recommendation**: Keep last 15 changes, archive to progress.md checkpoint entries, trigger every checkpoint

**Action**:
- [ ] Decide archival parameters (count, destination, trigger)
- [ ] Document in activeContext.md template header
- [ ] Add archival logic to Documentarian agent
- [ ] Update checkpoint command to include archival step
- [ ] Test with simulated 20+ changes

**Implementation Location**:
- File: `.claude/templates/activeContext.template.md`
- Section: Add archival policy note in header
- File: `.claude/agents/workflow/Documentarian.md`
- Section: Add "Archival Process" subsection to "Checkpoint Process"

---

### 🔴 ACTION 4: Define Facilitator Iteration Guardrails

**Risk**: CRITICAL - Could loop indefinitely consuming tokens
**Ambiguity**: HIGH - No guidance on when to stop iterating

**Current State**:
- Facilitator has NO iteration limits (Facilitator.md:246-249)
- User controls loop by saying "proceed" or "looks good"
- If user gives ambiguous feedback, could iterate many times

**Decision Needed**:

**Should there be a soft limit?**

- [ ] No limit - trust user discipline (current design)
- [ ] Soft warning after N iterations (e.g., "We've refined 5 times. Ready to proceed or continue?")
- [ ] Hard limit after N iterations (force decision)
- [ ] Other: ___________________________________

**If soft limit, what threshold?**

- [ ] 3 iterations (conservative)
- [ ] 5 iterations (moderate)
- [ ] 7 iterations (generous)
- [ ] 10 iterations (very generous)
- [ ] Other: ___________________________________

**How to guide users toward decisive responses?**

- [ ] Add "Iteration X of ~5" counter to output (sets expectation)
- [ ] After 3 iterations, ask "Are we making progress or should we proceed?"
- [ ] Provide "good enough" signal in output (e.g., "This plan is solid, though we could refine further")
- [ ] Other: ___________________________________

**Recommendation**: Soft warning after 5 iterations, add progress indicator to output

**Action**:
- [ ] Decide on iteration guardrails
- [ ] Document in Facilitator agent specification
- [ ] Update Facilitator output format to include iteration counter
- [ ] Add guidance for users on when to stop iterating
- [ ] Test with intentionally vague responses to verify guardrails work

**Implementation Location**:
- File: `.claude/agents/workflow/Facilitator.md`
- Section: Update "Refinement Cycle Management" with iteration guardrails
- Section: Update "Output Format" to include iteration counter

---

## Phase 2: HIGH RISK - Validate Before Init

These must be verified before running `/cf:init` to prevent partial failure.

---

### 🔴 ACTION 5: Verify Template Files Exist and Are Valid

**Risk**: CRITICAL - Init will fail if templates missing or malformed
**Ambiguity**: LOW - Just verification, no decisions

**Action**:
- [ ] Verify memory bank templates exist:
  ```bash
  ls -1 .claude/templates/*.template.md
  # Expected: 6 files
  # - activeContext.template.md
  # - productContext.template.md
  # - progress.template.md
  # - projectbrief.template.md
  # - systemPatterns.template.md
  # - tasks.template.md
  ```

- [ ] Verify workflow agent templates exist:
  ```bash
  ls -1 .claude/templates/agents/workflow/*.template.md
  # Expected: 6 files
  # - assessor.template.md
  # - architect.template.md
  # - documentarian.template.md
  # - facilitator.template.md
  # - product.template.md
  # - reviewer.template.md
  ```

- [ ] Verify generic implementation agent templates exist:
  ```bash
  ls -1 .claude/templates/generic/*.template.md
  # Expected: 3 files
  # - codeImplementer.template.md
  # - testEngineer.template.md
  # - uiDeveloper.template.md
  ```

- [ ] Verify YAML frontmatter in all agent templates is valid:
  ```bash
  for file in .claude/templates/agents/workflow/*.template.md; do
    head -n 10 "$file" | grep -q "^---$" || echo "Invalid YAML in $file"
  done
  ```

- [ ] Check for required sections in agent templates:
  ```bash
  grep -l "## Role" .claude/templates/agents/workflow/*.template.md | wc -l
  # Expected: 6
  ```

**If any verification fails**:
- [ ] Document missing/malformed files
- [ ] Fix issues before proceeding
- [ ] Re-run verification

---

### 🔴 ACTION 6: Test Init in Throwaway Directory

**Risk**: CRITICAL - Prevents corrupting actual project if init fails
**Ambiguity**: LOW - Standard testing procedure

**Action**:
- [ ] Create test directory:
  ```bash
  mkdir /tmp/ccflow-test
  cd /tmp/ccflow-test
  ```

- [ ] Run init with --quick flag (skip interactive):
  ```bash
  /cf:init --quick
  ```

- [ ] Verify directory structure created:
  ```bash
  ls -R memory-bank/
  # Expected: 6 .md files

  ls -R .claude/agents/
  # Expected: workflow/ (6 files), codeImplementer.md, testEngineer.md, uiDeveloper.md
  ```

- [ ] Inspect file contents for completeness:
  ```bash
  # Check memory bank files have section headers
  grep "^## " memory-bank/*.md

  # Check agent files have YAML frontmatter
  head -n 5 .claude/agents/workflow/*.md
  ```

- [ ] Verify no errors in output or partial file creation

- [ ] Clean up test directory:
  ```bash
  cd ~
  rm -rf /tmp/ccflow-test
  ```

**If test fails**:
- [ ] Document error details
- [ ] Identify which step failed (directory creation, file copy, template processing)
- [ ] Fix root cause
- [ ] Re-run test

---

### 🔴 ACTION 7: Document Rollback Procedure

**Risk**: MEDIUM - If init fails partway, need manual recovery
**Ambiguity**: MEDIUM - No rollback mechanism documented

**Decision Needed**:

**What to do if init fails partway?**

- [ ] **Choice A**: Manual cleanup instructions
  - Document: "Delete memory-bank/ and .claude/agents/, re-run init"

- [ ] **Choice B**: Add rollback logic to init command
  - On error: Delete partially created directories
  - Restore previous state if existed

- [ ] **Choice C**: Pre-init backup
  - Before init: Copy existing memory-bank/ to memory-bank.backup/
  - On failure: Restore from backup

**Recommendation**: **Choice A** (simplest) + document in init.md error handling

**Action**:
- [ ] Decide rollback approach
- [ ] Document in init.md "Error Handling" section
- [ ] Add rollback instructions to pre-init checklist
- [ ] Test rollback procedure (simulate failure, verify recovery)

**Implementation Location**:
- File: `.claude/commands/cf/init.md`
- Section: "Error Handling" - add "Partial Init Failure" scenario

---

## Phase 3: MEDIUM RISK - Design Decisions

These affect system behavior but can be adjusted post-init.

---

### 🟡 ACTION 8: Define Test Failure Iteration Limit Policy

**Risk**: MEDIUM - Affects development flow when tests fail
**Ambiguity**: MEDIUM - Current 3-attempt limit may need adjustment

**Current State**:
- /cf:code stops after 3 failed test attempts
- Task marked as BLOCKED
- User must use /cf:plan or /cf:facilitate to proceed

**Decision Needed**:

**Is 3 attempts the right limit?**

- [ ] Keep 3 attempts (current design)
- [ ] Increase to 5 attempts (more generous)
- [ ] Make configurable per project (user preference)
- [ ] Make adaptive (increase limit for complex tasks)
- [ ] Other: ___________________________________

**Recommendation**: Keep 3 attempts initially, monitor hit rate, adjust after 5-10 tasks if needed

**Action**:
- [ ] Decide on iteration limit
- [ ] Document rationale in code.md
- [ ] Add monitoring guidance (track how often limit is hit)
- [ ] Define escalation path (what to do when limit reached)
- [ ] Plan review after 5-10 tasks to adjust if needed

**Monitoring Metrics**:
- [ ] Track: % of tasks that hit 3-attempt limit
- [ ] Target: < 10% hit limit (indicates limit is appropriate)
- [ ] Alert: > 20% hit limit (indicates limit too restrictive OR test quality issues)

**Implementation Location**:
- File: `.claude/commands/cf/code.md`
- Section: "Step 5: Verify GREEN Phase" - document rationale for 3-attempt limit
- Add monitoring guidance to "Notes" section

---

### 🟡 ACTION 9: Define Stack-Specific vs Generic Agent Strategy

**Risk**: MEDIUM - Affects token usage and quality significantly
**Ambiguity**: LOW - Decision point is clear

**Current State**:
- /cf:init installs generic agents (codeImplementer, testEngineer, uiDeveloper)
- /cf:configure-team installs stack-specific agents (optional)
- Generic agents work with any stack but are verbose

**Decision Needed**:

**When to configure stack-specific team?**

- [ ] **Immediately after init** (before first task)
  - **Pro**: Better from day one
  - **Con**: Requires knowing tech stack upfront

- [ ] **After 1-2 tasks** (learn system with generic agents first)
  - **Pro**: Understand workflow before optimizing
  - **Con**: Higher token usage initially

- [ ] **When token usage becomes issue** (reactive)
  - **Pro**: Optimize only when needed
  - **Con**: Could waste tokens unnecessarily

**Recommendation**: **After 1-2 tasks** (learn then optimize)

**Action**:
- [ ] Decide when to run /cf:configure-team
- [ ] Document recommendation in getting-started guide
- [ ] Add reminder to init output
- [ ] Measure token savings after team configuration

**Implementation Location**:
- File: `docs/user-guide/getting-started.md`
- Section: "Next Steps After Init" - add guidance on when to configure team
- File: `.claude/commands/cf/init.md`
- Section: Final output - add reminder about /cf:configure-team

---

### 🟡 ACTION 10: Define Memory Bank Archival Schedule

**Risk**: LOW - Affects long-term file size but not critical
**Ambiguity**: MEDIUM - Multiple archival strategies possible

**Current State**:
- tasks.md will accumulate completed tasks
- progress.md will accumulate checkpoint entries
- No archival schedule defined

**Decision Needed**:

**When to archive completed tasks?**

- [ ] After 7 days of completion (aggressive)
- [ ] After 30 days of completion (moderate)
- [ ] After 90 days of completion (conservative)
- [ ] When "Recently Completed" section exceeds N entries
- [ ] Never (rely on git history)
- [ ] Other: ___________________________________

**When to archive old checkpoint entries?**

- [ ] After 30 days (aggressive)
- [ ] After 60 days (moderate)
- [ ] After 90 days (conservative)
- [ ] When progress.md exceeds N lines
- [ ] Never (checkpoints are permanent history)
- [ ] Other: ___________________________________

**Where to archive?**

- [ ] Separate archive file (e.g., tasks-archive.md, progress-archive.md)
- [ ] Git history (delete from active file, rely on version control)
- [ ] Compressed format (move to appendix section within same file)
- [ ] Other: ___________________________________

**Recommendation**: Archive tasks after 30 days, archive checkpoints after 60 days, to appendix sections within same files

**Action**:
- [ ] Decide archival schedule for tasks
- [ ] Decide archival schedule for checkpoints
- [ ] Decide archival destination
- [ ] Document in task.md and progress.md templates
- [ ] Add archival process to Documentarian agent
- [ ] Set reminder to review archival after 30 days of use

**Implementation Location**:
- File: `.claude/templates/tasks.template.md`
- Section: "Archive Policy" - define schedule
- File: `.claude/templates/progress.template.md`
- Section: Add "Archive Policy" section
- File: `.claude/agents/workflow/Documentarian.md`
- Section: Add "Archival Process" to responsibilities

---

## Phase 4: OPTIMIZATION - Post-Init Improvements

These are optimizations to do after init but before heavy usage.

---

### 🟢 ACTION 11: Agent Refinement Priority List

**Risk**: LOW - Optimization, not critical functionality
**Ambiguity**: LOW - Clear targets identified

**Target Agents** (in priority order):

1. [ ] **testEngineer.md** (463 lines → target 200-250)
   - **Why**: Invoked on EVERY /cf:code (highest frequency)
   - **Method**: Remove verbose examples, consolidate TODO sections
   - **Expected savings**: 8,000-10,000 tokens per Level 3 task
   - **Command**: `/cf:refine-agent testEngineer`

2. [ ] **codeImplementer.md** (548 lines → target 200-250)
   - **Why**: Invoked on EVERY /cf:code (highest frequency)
   - **Method**: Remove template sections, consolidate patterns
   - **Expected savings**: 6,000-8,000 tokens per Level 3 task
   - **Command**: `/cf:refine-agent codeImplementer`

3. [ ] **uiDeveloper.md** (similar size, similar frequency for UI tasks)
   - **Why**: Invoked for all UI tasks
   - **Method**: Same as codeImplementer
   - **Expected savings**: 6,000-8,000 tokens per UI-heavy Level 3 task
   - **Command**: `/cf:refine-agent uiDeveloper`

4. [ ] **Documentarian.md** (374 lines → target 200-250)
   - **Why**: Invoked on every checkpoint
   - **Method**: Consolidate checkpoint examples
   - **Expected savings**: 3,000-5,000 tokens per checkpoint
   - **Command**: `/cf:refine-agent Documentarian`

**Schedule**:
- [ ] After first init, before first task: Refine testEngineer + codeImplementer
- [ ] After first task complete: Refine uiDeveloper (if UI-heavy project)
- [ ] After first checkpoint: Refine Documentarian

**Measurement**:
- [ ] Before refinement: Run first task, measure token usage
- [ ] After refinement: Run similar task, measure token usage
- [ ] Calculate savings: (Before - After) / Before × 100%
- [ ] Target: 25-30% reduction

---

### 🟢 ACTION 12: Command Refinement Priority List

**Risk**: LOW - Optimization, not critical functionality
**Ambiguity**: LOW - Clear targets identified

**Target Commands** (in priority order):

1. [ ] **code.md** (929 lines → target 600-700)
   - **Why**: Most complex command, high frequency
   - **Method**: Consolidate examples, remove redundancy
   - **Expected savings**: 3,000-4,000 tokens per invocation
   - **Command**: `/cf:refine-command code`

2. [ ] **plan.md** (788 lines → target 500-600)
   - **Why**: Used for all Level 2-4 tasks
   - **Method**: Consolidate examples, reference patterns
   - **Expected savings**: 2,000-3,000 tokens per invocation
   - **Command**: `/cf:refine-command plan`

3. [ ] **init.md** (630 lines → target 400-500)
   - **Why**: One-time use but very verbose
   - **Method**: Move examples to documentation
   - **Expected savings**: Only for future inits (minimal)
   - **Command**: `/cf:refine-command init`

**Schedule**:
- [ ] After 2-3 tasks: Refine code.md (once you understand workflow)
- [ ] After 2-3 tasks: Refine plan.md
- [ ] Optional: Refine init.md (low priority, one-time use)

---

### 🟢 ACTION 13: Create First-Task Test Scenario

**Risk**: LOW - Quality assurance, not critical
**Ambiguity**: LOW - Standard testing procedure

**Purpose**: Verify end-to-end workflow with minimal complexity

**Test Scenario**:
```
Task: "Add a health check endpoint to the API"
- Level: 1 (Quick Fix)
- Complexity: Low
- Tech: Backend (Express/Flask/etc.)
- Expected Duration: 15-20 minutes
```

**Test Plan**:

- [ ] Run `/cf:feature "Add health check endpoint"`
  - Verify: Assessor assigns Level 1
  - Verify: tasks.md updated with TASK-001
  - Verify: activeContext.md updated

- [ ] Run `/cf:code TASK-001`
  - Verify: testEngineer writes tests (RED phase)
  - Verify: codeImplementer implements endpoint
  - Verify: Tests pass (GREEN phase)
  - Verify: tasks.md marked complete
  - Verify: activeContext.md updated

- [ ] Run `/cf:checkpoint`
  - Verify: progress.md has checkpoint entry
  - Verify: All 6 memory bank files updated
  - Verify: No inconsistencies

**Success Criteria**:
- [ ] All commands execute without errors
- [ ] Memory bank files are consistent
- [ ] Task marked complete with GREEN tests
- [ ] Token usage within expected range (7,000-9,000)

**If test fails**:
- [ ] Document failure point
- [ ] Check memory bank for inconsistencies
- [ ] Verify agents are working correctly
- [ ] Fix issues before proceeding to real tasks

---

## Phase 5: MONITORING - Track During First 5 Tasks

These are ongoing measurements to inform future optimizations.

---

### 🟢 ACTION 14: Token Usage Tracking

**Purpose**: Measure actual vs expected token consumption

**Metrics to Track**:

| Task | Level | Token Usage | Expected Range | Variance |
|------|-------|-------------|----------------|----------|
| TASK-001 | 1 | _______ | 7,000-9,000 | _______ |
| TASK-002 | 2 | _______ | 25,000-30,000 | _______ |
| TASK-003 | 1 | _______ | 7,000-9,000 | _______ |
| TASK-004 | 3 | _______ | 53,000-68,000 | _______ |
| TASK-005 | 2 | _______ | 25,000-30,000 | _______ |

**Action**:
- [ ] After each task, record token usage
- [ ] Calculate variance from expected
- [ ] If variance >20%, investigate root cause
- [ ] After 5 tasks, calculate average token per complexity level
- [ ] Adjust expectations based on actual usage

**Analysis Questions**:
- [ ] Are token costs higher or lower than expected?
- [ ] Which phases consume most tokens? (Planning, Implementation, Checkpoint)
- [ ] Which agents are most expensive?
- [ ] After refinement, what's the actual savings?

---

### 🟢 ACTION 15: Memory Bank Consistency Audit

**Purpose**: Verify no drift or contradictions across files

**Audit Schedule**: After tasks 1, 3, and 5

**Checklist**:

- [ ] **activeContext.md vs tasks.md**:
  - Current Focus task matches active task in tasks.md
  - Recent Changes dates align with task completion dates
  - No tasks listed as both active and complete

- [ ] **tasks.md internal consistency**:
  - Only one task marked as primary Active
  - Parent tasks updated when sub-tasks complete
  - Blockers documented for all Blocked tasks

- [ ] **progress.md vs activeContext.md**:
  - Checkpoint summaries match Recent Changes
  - Project progress % is consistent with tasks complete
  - Next priorities align with Immediate Next Steps

- [ ] **systemPatterns.md vs code**:
  - Patterns documented match actual code patterns
  - Pattern examples reference actual files
  - No outdated patterns listed

**If inconsistencies found**:
- [ ] Document the inconsistency
- [ ] Identify which agent caused it
- [ ] Determine if it's a system issue or user error
- [ ] Add check to Documentarian if systematic

---

### 🟢 ACTION 16: Test Failure Rate Tracking

**Purpose**: Determine if 3-attempt limit is appropriate

**Metrics to Track**:

| Task | Level | Test Iterations | Limit Hit? | Reason |
|------|-------|-----------------|------------|--------|
| TASK-001 | 1 | _______ | Yes/No | _______ |
| TASK-002 | 2 | _______ | Yes/No | _______ |
| TASK-003 | 1 | _______ | Yes/No | _______ |
| TASK-004 | 3 | _______ | Yes/No | _______ |
| TASK-005 | 2 | _______ | Yes/No | _______ |

**Analysis**:
- [ ] Calculate: % of tasks that hit 3-attempt limit = _______ %
- [ ] If <10%: Limit is appropriate
- [ ] If 10-20%: Monitor, may need adjustment
- [ ] If >20%: Increase limit to 5 attempts

**Common Reasons for Limit Hit**:
- [ ] Flaky tests (intermittent failures)
- [ ] Misunderstood requirements
- [ ] Complex integration issues
- [ ] Agent implementation errors
- [ ] Other: _______

---

### 🟢 ACTION 17: Facilitator Iteration Tracking

**Purpose**: Measure typical iteration counts in interactive modes

**Metrics to Track**:

| Command | Task | Iterations | Productive? | Notes |
|---------|------|------------|-------------|-------|
| /cf:plan --interactive | TASK-002 | _______ | Yes/No | _______ |
| /cf:plan --interactive | TASK-004 | _______ | Yes/No | _______ |
| /cf:checkpoint --interactive | After TASK-002 | _______ | Yes/No | _______ |

**Analysis**:
- [ ] Calculate: Average iterations per interactive session = _______
- [ ] If <3: Users are decisive, no issues
- [ ] If 3-5: Normal range, system working well
- [ ] If 5-7: High but acceptable
- [ ] If >7: May indicate unclear questions or indecisive responses

**If >7 iterations common**:
- [ ] Add soft warning after 5 iterations
- [ ] Improve Facilitator question clarity
- [ ] Add "good enough" signals to output

---

## Summary Checklist

### Pre-Init (Must Complete Before /cf:init)

- [ ] Phase 1 - Action 1: Define routing disambiguation strategy
- [ ] Phase 1 - Action 2: Define conflict detection logic
- [ ] Phase 1 - Action 3: Define activeContext archival policy
- [ ] Phase 1 - Action 4: Define Facilitator iteration guardrails
- [ ] Phase 2 - Action 5: Verify template files exist
- [ ] Phase 2 - Action 6: Test init in throwaway directory
- [ ] Phase 2 - Action 7: Document rollback procedure

### Post-Init, Pre-First-Task (Optimize Before Heavy Use)

- [ ] Phase 3 - Action 8: Define test failure iteration policy
- [ ] Phase 3 - Action 9: Define team configuration timing
- [ ] Phase 3 - Action 10: Define archival schedule
- [ ] Phase 4 - Action 11: Refine testEngineer and codeImplementer
- [ ] Phase 4 - Action 13: Run first-task test scenario

### During First 5 Tasks (Monitor and Measure)

- [ ] Phase 4 - Action 12: Refine commands after understanding workflow
- [ ] Phase 5 - Action 14: Track token usage
- [ ] Phase 5 - Action 15: Audit memory bank consistency
- [ ] Phase 5 - Action 16: Track test failure rate
- [ ] Phase 5 - Action 17: Track Facilitator iterations

### After 5 Tasks (Review and Adjust)

- [ ] Review all metrics
- [ ] Adjust limits based on actual usage
- [ ] Refine remaining verbose agents/commands
- [ ] Document lessons learned
- [ ] Update pre-init-analysis.md with actual findings

---

**Document Version**: 1.0
**Created**: 2025-10-09
**Status**: Ready for execution
**Next Review**: After completing Phase 1 actions
