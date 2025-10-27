# CCFlow Pre-Init Implementation Checklist

**Purpose**: Track implementation of all decisions from pre-init-decisions.md

**Status**: ✅ COMPLETE
**Date Created**: 2025-10-09
**Date Completed**: 2025-10-09

---

## Implementation Tasks

### ACTION 1: Routing Disambiguation Strategy
**Decision**: First match wins (keyword order determines priority)

- [ ] Update `.claude/templates/team-types/*/routing.md` templates to document keyword order matters
- [ ] Add example showing keyword priority to routing.md template
- [ ] Update `.claude/commands/cf/code.md` to note first-match routing logic
- [ ] Add comment in `/cf:configure-team` about keyword order importance

**Files to Update**:
- `.claude/templates/team-types/react-express-stack/routing.md`
- `.claude/templates/team-types/react-native-stack/routing.md`
- `.claude/templates/team-types/langchain-stack/routing.md`
- `.claude/templates/blank-agents/routing.template.md`
- `.claude/commands/cf/code.md`
- `.claude/commands/cf/configure-team.md`

---

### ACTION 2: Specialist Creation Trigger Threshold
**Decision**: No automatic suggestions - user-driven only

- [ ] Review `.claude/commands/cf/create-specialist.md` for auto-suggestion language
- [ ] Remove any "after 3+ delegations, recommend" language
- [ ] Clarify command is manual-only
- [ ] Update user guide to note specialists are optional optimization
- [ ] Update CLAUDE.md if it mentions auto-suggestions

**Files to Update**:
- `.claude/commands/cf/create-specialist.md`
- `docs/user-guide/agents.md` (if mentions auto-suggestions)
- `CLAUDE.md` (check for auto-suggestion references)

---

### ACTION 3: Memory Bank Import Logic
**Decision**: Scan first, then default to fresh start (with scan results available)

- [ ] Update `.claude/commands/cf/init.md` with scan-then-fresh flow
- [ ] Add Phase 0 (Discovery) to init process
- [ ] Document "use findings" opt-in mechanism
- [ ] Clarify `--force-fresh` flag skips scanning entirely
- [ ] Update init examples showing scan output
- [ ] Update getting-started guide with scan behavior

**Files to Update**:
- `.claude/commands/cf/init.md` (major update - add Phase 0)
- `docs/user-guide/getting-started.md`
- `README.md` (if shows init examples)

---

### ACTION 4: Facilitator Iteration Guardrails
**Decision**: No limits - trust user discipline

- [ ] Verify `.claude/agents/workflow/Facilitator.md` has no iteration limits
- [ ] Add documentation that user controls iteration count
- [ ] Update user guide to explain refinement is user-driven
- [ ] Confirm Action Recommendation Pattern always ends with recommendation

**Files to Update**:
- `.claude/agents/workflow/Facilitator.md` (verify/document)
- `docs/user-guide/workflows.md` (explain user-driven refinement)

---

### ACTION 7: Rollback Procedure
**Decision**: Manual cleanup instructions

- [ ] Add "Partial Init Failure" scenario to init.md Error Handling
- [ ] Document rollback commands: `rm -rf memory-bank/ .claude/agents/`
- [ ] Add troubleshooting section to user guide
- [ ] Include rollback in getting-started guide

**Files to Update**:
- `.claude/commands/cf/init.md` (Error Handling section)
- `docs/user-guide/getting-started.md` (troubleshooting)
- `docs/user-guide/commands.md` (init troubleshooting)

---

### ACTION 8: Test Failure Iteration Limit Policy
**Decision**: Keep 3 attempts (current design)

- [ ] Verify `.claude/commands/cf/code.md` uses 3 attempts
- [ ] Document rationale for 3-attempt limit
- [ ] Add monitoring guidance (track hit rate)
- [ ] Document monitoring targets: <10% = good, >20% = too restrictive

**Files to Update**:
- `.claude/commands/cf/code.md` (verify 3 attempts, add rationale)
- `docs/system/validation.md` (add monitoring guidance)

---

### ACTION 9: Stack-Specific vs Generic Agent Strategy
**Decision**: Recommend immediately after init, but allow anytime

- [ ] Add recommendation to init.md final output
- [ ] Update getting-started guide: "Recommended: configure team before first task"
- [ ] Clarify in configure-team.md: "Can run anytime after init"
- [ ] Update README.md workflow to show init → configure-team → feature
- [ ] Note in configure-team that skipping is fine (generic agents work)

**Files to Update**:
- `.claude/commands/cf/init.md` (final output recommendations)
- `.claude/commands/cf/configure-team.md` (timing flexibility)
- `docs/user-guide/getting-started.md` (recommended workflow)
- `README.md` (quick start workflow)

---

### ACTION 10: Memory Bank Archival Schedule
**Decision**: Defer to `/cf:archive` command (to be spec'd later)

- [ ] Add `/cf:archive` to future commands list
- [ ] Add placeholder in commands directory
- [ ] Note in progress tracking: "Archive command needed"
- [ ] Document in CLAUDE.md that archival is manual via future command

**Files to Update**:
- Create placeholder: `.claude/commands/cf/archive.md` (basic spec)
- `docs/user-guide/commands.md` (add to command list as "planned")
- `CLAUDE.md` (note archival is manual)

---

## Verification Tasks

After all implementations:

- [ ] Run structural validation: Check all command files have required sections
- [ ] Run cross-reference validation: Verify all mentioned commands/agents exist
- [ ] Check template consistency: Ensure routing.md templates match across stacks
- [ ] Review CLAUDE.md for any contradictions with decisions
- [ ] Review README.md for any outdated workflow descriptions
- [ ] Grep for "3+ delegations" or "auto-suggest" language across all files

---

## Completion Checklist

- [ ] All ACTION 1 tasks complete
- [ ] All ACTION 2 tasks complete
- [ ] All ACTION 3 tasks complete
- [ ] All ACTION 4 tasks complete
- [ ] All ACTION 7 tasks complete
- [ ] All ACTION 8 tasks complete
- [ ] All ACTION 9 tasks complete
- [ ] All ACTION 10 tasks complete
- [ ] All verification tasks complete
- [ ] pre-init-decisions.md archived as historical record
- [ ] This checklist archived after completion

---

**Next Step After Completion**: Run `/cf:init` test in throwaway directory (ACTION 6)

**Document Version**: 1.0
**Last Updated**: 2025-10-09
