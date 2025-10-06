# Common Workflow Patterns

Proven patterns for different development scenarios with CCFlow.

## Quick Task (Level 1)

**Scenario:** Simple fixes, styling changes, minor updates

**Pattern:**
```bash
/cf:feature "fix login button alignment"
# → Assessor: Level 1 (Quick Task)
# → Recommendation: Proceed with /cf:code TASK-001

/cf:code TASK-001
# → testEngineer: Write tests
# → uiDeveloper: Fix alignment
# → GREEN gate: Tests pass
# → Memory bank updated
```

**Duration:** < 2 hours

**Key points:**
- Skip planning, go straight to implementation
- TDD still enforced
- Fast iteration

---

## Simple Feature (Level 2)

**Scenario:** Small features, straightforward additions

**Pattern:**
```bash
/cf:feature "add search functionality to navbar"
# → Assessor: Level 2 (Simple Enhancement)
# → Recommendation: Use /cf:plan TASK-002

/cf:plan TASK-002
# → Architect: Design approach
# → Product: Define requirements
# → Creates 4 sub-tasks in tasks.md

/cf:code TASK-002-1  # Backend API
/cf:code TASK-002-2  # Search component
/cf:code TASK-002-3  # Integration
/cf:code TASK-002-4  # Polish

/cf:checkpoint "Search feature complete"
```

**Duration:** 2-6 hours

**Key points:**
- Planning breaks work into manageable pieces
- Implement sub-tasks sequentially
- Checkpoint after completion

---

## Complex Feature (Level 3)

**Scenario:** Multi-component features, moderate complexity

**Pattern:**
```bash
/cf:feature "implement order management system"
# → Assessor: Level 3 (Intermediate Feature)
# → Recommendation: Use /cf:plan TASK-003

/cf:plan TASK-003
# → Auto-enables --interactive (Level 3)
# → Facilitator + Architect + Product
# → Creates 8 sub-tasks, flags 2 as high-complexity

/cf:creative TASK-003-4  # Complex sub-task (payment processing)
# → 4-phase deep exploration
# → Documents solution in systemPatterns.md

/cf:code TASK-003-1  # Simple sub-task
/cf:checkpoint       # Regular saves

/cf:code TASK-003-4  # Complex sub-task (uses creative design)
/cf:review TASK-003-4

# Continue with remaining sub-tasks
/cf:checkpoint "Order management Phase 1 complete"
```

**Duration:** 1-3 days

**Key points:**
- Facilitator automatically engaged
- Creative sessions for high-complexity sub-tasks
- Regular checkpoints (every 30-60 min)
- Review before completion

---

## System-Level Change (Level 4)

**Scenario:** Architecture changes, migrations, major refactors

**Pattern:**
```bash
/cf:feature "migrate authentication to OAuth 2.0"
# → Assessor: Level 4 (Complex System)
# → Recommendation: Use /cf:plan TASK-004

/cf:plan TASK-004
# → Auto-enables --interactive (Level 4)
# → Facilitator guides through:
#    - Migration strategy
#    - Risk assessment
#    - Rollback plans
# → Creates 12 sub-tasks, flags 3 for /cf:creative

/cf:creative TASK-004-3  # Token refresh mechanism
# → Extended thinking ("think harder")
# → Compares 4 approaches
# → Documents pattern

/cf:creative TASK-004-7  # Account linking strategy
# → Extended thinking ("think hard")
# → Edge case analysis

# Implement with careful progression
/cf:code TASK-004-1  # Setup OAuth config
/cf:checkpoint "OAuth setup complete"

/cf:code TASK-004-3  # Token refresh (creative-designed)
/cf:review TASK-004-3
/cf:checkpoint "Token management complete"

# Continue methodically
/cf:checkpoint "OAuth migration Phase 1"
/cf:review all
```

**Duration:** 3+ days

**Key points:**
- Multiple creative sessions for complex decisions
- Frequent checkpoints and reviews
- Phased approach with validation
- Comprehensive documentation

---

## Daily Development Routine

**Morning:**
```bash
/cf:context           # Load yesterday's work
/cf:status            # See active tasks
# Review progress.md and activeContext.md
```

**During work:**
```bash
/cf:feature "..." or /cf:code TASK-XXX
/cf:checkpoint        # Every 30-60 minutes
```

**Before breaks:**
```bash
/cf:checkpoint "Before lunch break"
```

**End of day:**
```bash
/cf:review all
/cf:checkpoint "End of day - completed TASK-042, TASK-043 in progress"
```

---

## Quality Management Workflow

**Weekly review:**
```bash
/cf:review all
# → Reviewer assesses:
#    - Technical debt accumulation
#    - Pattern consistency
#    - Quality trends

# Address high-priority items
/cf:feature "Refactor authentication to use new pattern"
/cf:plan refactor-auth
/cf:code [refactor tasks]

/cf:checkpoint "Quality improvements - tech debt reduced"
```

**Before major releases:**
```bash
/cf:review all
/cf:facilitate "pre-release validation" --mode validate
/cf:checkpoint "Release 1.0 ready"
```

---

## Interrupted Work Pattern

**When interrupted:**
```bash
/cf:checkpoint "Pausing work on TASK-052, auth tests passing"
```

**When resuming:**
```bash
/cf:context
/cf:status
# Read activeContext.md for exact state
# Continue where you left off
```

---

## Exploration and Discovery

**Exploring new ideas:**
```bash
/cf:facilitate "notification preferences system" --mode explore
# → Facilitator asks discovery questions
# → Helps crystallize requirements
# → Results in task or feature description

/cf:feature "implement notification preferences"
# Continue with standard workflow
```

**Validating before implementation:**
```bash
/cf:plan TASK-065
/cf:facilitate TASK-065 --mode validate
# → Facilitator checks for:
#    - Missed edge cases
#    - Unclear requirements
#    - Hidden assumptions

# After validation
/cf:code TASK-065-1
```

---

## Specialist Creation Pattern

**When patterns emerge:**
```bash
# After 3+ database-related delegations
/cf:create-specialist database --type development --name databaseSpecialist

# Edit .claude/agents/development/specialists/databaseSpecialist.md
# Configure: ORM, migration tools, query patterns

# Future database work automatically uses specialist
/cf:code TASK-075  # Database task
# → codeImplementer → databaseSpecialist (automatic)
```

---

## Error Recovery Patterns

**Tests failing:**
```bash
/cf:code TASK-042
# → Tests fail after 3 attempts
# → Blocker reported

# Investigate
/cf:ask "What tests failed for TASK-042?"
/cf:review TASK-042

# Fix approach
/cf:facilitate TASK-042 --mode validate
/cf:code TASK-042  # Retry with corrected approach
```

**Missing context:**
```bash
/cf:sync  # Full memory bank summary
/cf:context --full  # Load all files
/cf:ask "What was the decision about API versioning?"
```

---

## Tips for Effective Workflows

**1. Trust the routing:**
- Don't skip planning for Level 2-4
- Use creative sessions when recommended
- Facilitator guidance improves outcomes

**2. Checkpoint frequently:**
- Every 30-60 minutes minimum
- Before risky operations
- After significant milestones

**3. Review regularly:**
- After completing tasks
- Weekly for overall quality
- Before releases

**4. Leverage agents:**
- Facilitator for ambiguous requirements
- Creative for complex decisions
- Specialists for repeated domains

**5. Maintain memory bank:**
- Keep activeContext.md current (automatic)
- Update systemPatterns.md as patterns emerge
- Document decisions and rationale

---

For detailed command usage, see [Command Reference](commands.md).
