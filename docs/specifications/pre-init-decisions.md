# CCFlow Pre-Init Decisions Log

**Purpose**: Record all design decisions made during pre-init action plan execution

**Document Version**: 1.0
**Date Started**: 2025-10-09
**Status**: In Progress

---

## Decision Record

### 🔴 ACTION 1: Routing Disambiguation Strategy

**Question**: When a task matches multiple agent keywords, how should the system select which agent to use?

**Decision**: **Choice A - First match wins (keyword order determines priority)**

**Rationale**: Simplest implementation, deterministic behavior, can upgrade later if needed

**Implementation Required**:
- Document in routing.md template that keyword order matters
- Add example showing keyword priority
- Note in /cf:code command specification

**Date Decided**: 2025-10-09

---

### 🔴 ACTION 2: Specialist Creation Trigger Threshold

**Question**: When should the system suggest creating a new specialist agent?

**Decision**: **No automatic suggestions - user-driven only**

**Rationale**:
- User will recognize need for specialization themselves
- Avoids tracking overhead and complexity
- Removes "after 3+ delegations, recommend specialist creation" language from docs

**Implementation Required**:
- Remove auto-suggestion language from `/cf:create-specialist` documentation
- Keep command available for manual use
- Document in user guide that specialists are optional optimization

**Date Decided**: 2025-10-09

---

### 🟡 ACTION 3: Memory Bank Import vs Fresh Creation Logic

**Question**: When running `/cf:init`, should the system scan existing docs and use them to pre-populate Facilitator questions?

**Decision**: **Scan first, then default to fresh start (with scan results available)**

**Rationale**:
- Existing docs are **source material** for Facilitator, not directly imported
- Scan shows user what was found, sets context
- Default to fresh avoids assuming scanned info is accurate/current
- User can request "use findings" if they want pre-population

**Implementation Flow**:
1. Scan for: README.md, CLAUDE.md, package.json, code structure
2. Present findings: "Found: [list of docs and key info extracted]"
3. Default: "Starting fresh guided creation. (Type 'use findings' to pre-populate)"
4. Facilitator proceeds with empty templates (unless user opts in to pre-population)

**Implementation Required**:
- Add scanning logic to `/cf:init` command (inline, not in agents)
- Update init.md with scan-then-fresh flow
- Document "use findings" opt-in mechanism
- Keep `--force-fresh` flag to skip scanning entirely

**Date Decided**: 2025-10-09

---

### 🔴 ACTION 4: Facilitator Iteration Guardrails

**Question**: Should Facilitator have iteration limits to prevent runaway token usage?

**Decision**: **No limits - trust user discipline**

**Rationale**:
- User controls refinement loop completely
- Adding limits/warnings adds complexity without clear benefit
- User can always say "proceed" or "looks good" to exit loop
- If runaway usage becomes problem, can add soft warnings later

**Implementation Required**:
- No changes needed (current design already has no limits)
- Document in Facilitator.md that user controls iteration count
- Note in user guide that refinement is user-driven

**Date Decided**: 2025-10-09

---

### 🔴 ACTION 7: Rollback Procedure

**Question**: If `/cf:init` fails partway through, how should the user recover?

**Decision**: **Manual cleanup instructions**

**Rationale**:
- Simple, no automation needed
- Clear instructions in error handling documentation
- Users can verify what was created before deleting

**Rollback Instructions**:
```
If /cf:init fails partway:
1. Delete memory-bank/ directory: rm -rf memory-bank/
2. Delete .claude/agents/ directory: rm -rf .claude/agents/
3. Re-run: /cf:init
```

**Implementation Required**:
- Add rollback instructions to init.md "Error Handling" section
- Add "Partial Init Failure" scenario with cleanup commands
- Document in user guide troubleshooting section

**Date Decided**: 2025-10-09

---

### 🟡 ACTION 8: Test Failure Iteration Limit Policy

**Question**: Is 3 test failure attempts the right limit before marking task as BLOCKED?

**Decision**: **Keep 3 attempts** (current design)

**Rationale**:
- Reasonable balance between persistence and stopping on real blockers
- Can monitor hit rate during first 5 tasks and adjust if needed
- Clear escalation path: BLOCKED → user must use /cf:plan or /cf:facilitate

**Implementation Required**:
- No changes needed (current design already uses 3)
- Document rationale in code.md
- Add monitoring guidance to track hit rate

**Monitoring Target**:
- < 10% of tasks hit limit = appropriate
- \> 20% of tasks hit limit = too restrictive, consider increasing

**Date Decided**: 2025-10-09

---

### 🟡 ACTION 9: Stack-Specific vs Generic Agent Strategy

**Question**: When should users run `/cf:configure-team` to install stack-specific agents?

**Decision**: **Recommend immediately after init, but allow anytime**

**Rationale**:
- Ideally configure right after `/cf:init` for best token efficiency from day one
- Technically can run anytime after init (flexible for users who want to learn system first)
- Generic agents work fine, just more verbose

**Implementation Required**:
- Add recommendation to init.md final output: "Next: Run `/cf:configure-team` for stack-specific optimization"
- Document in getting-started guide: "Recommended: configure team before first task"
- Clarify in configure-team.md: "Can run anytime after init, replaces generic agents"
- Note: User can skip if they prefer generic agents or don't know stack yet

**Date Decided**: 2025-10-09

---

### 🟡 ACTION 10: Memory Bank Archival Schedule

**Question**: When should completed tasks and old checkpoints be archived?

**Decision**: **Defer to dedicated `/cf:archive` command (to be spec'd)**

**Rationale**:
- Archival is complex enough to warrant its own command
- Different users may have different archival needs
- Command can offer options: by date, by count, by file size
- Manual trigger gives user control over when to archive

**Implementation Required**:
- Create `/cf:archive` command specification
- Support archival targets: tasks, checkpoints, or both
- Support destinations: appendix sections, separate files, or deletion
- Support criteria: by age (days), by count (entries), or by size (lines)
- Document in commands list and user guide

**Next Step**: Spec out `/cf:archive` command after core system is validated

**Date Decided**: 2025-10-09

---

## Next Actions

- [ ] After all Phase 1 decisions: Update affected command/agent files
- [ ] After all Phase 1 decisions: Run Phase 2 verification
- [ ] After Phase 2 complete: Proceed to Phase 3
- [ ] After all decisions: Archive this log with final implementations

---

**Note**: This decision log will be used to update the actual command and agent files. After implementation, archive this file as historical record.
