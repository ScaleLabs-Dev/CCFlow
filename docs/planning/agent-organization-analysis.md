# Agent Organization Architecture Analysis

**Purpose**: Determine which agents are framework-level vs. project-level
**Created**: 2025-10-23
**Decision Required**: Before implementing /cf:reset and potentially refactoring /cf:init

---

## Core Question

**Which agents should be copied to project directories vs. remain in the framework?**

This affects:
- What `/cf:init` copies
- What `/cf:reset` deletes
- How agents are updated across projects
- Project customization capabilities

---

## Agent Classification

### Classification Criteria

**Framework-Level Agents** (never copied):
- ✅ No project-specific customization needed
- ✅ Consistent behavior across all projects
- ✅ Updated by framework maintainers
- ✅ Part of CCFlow's core functionality
- ✅ Should not drift from framework

**Project-Level Agents** (copied during init):
- ✅ Requires project-specific customization
- ✅ Varies by tech stack or team preferences
- ✅ Modified by project developers
- ✅ Can diverge from framework defaults
- ✅ Part of project configuration

---

## Current Agent Inventory

### 1. System Agents (`.claude/agents/system/`)

**Location**: `.claude/agents/system/`

**Agents**:
- `commandBuilder.md` - Meta-agent for command optimization
- `agentBuilder.md` - Meta-agent for agent creation/refinement
- `project-discovery.md` - Project analysis during init

**Analysis**:
- ✅ Never copied to projects
- ✅ Core framework functionality
- ✅ No customization needed
- ✅ Updated by framework maintainers only

**Customizable?**: ❌ NO

**Current Behavior**: ✅ Correct - stays in framework

**Reset Action**: ✅ Correct - never delete

---

### 2. Workflow Agents (`.claude/agents/workflow/`)

**Current Location**: `.claude/templates/agents/workflow/*.template.md` → copied to `.claude/agents/workflow/`

**Agents**:
- `assessor.md` - Complexity analysis and routing
- `architect.md` - Technical design decisions
- `product.md` - User requirements and UX
- `facilitator.md` - Interactive refinement
- `documentarian.md` - Memory bank consistency
- `reviewer.md` - Quality validation

**Analysis**:
- ❓ Currently copied, but should they be?
- ✅ Provide consistent CCFlow workflow behavior
- ❌ No project-specific customization points in current design
- ✅ Framework-defined analysis and decision patterns
- ❌ No tech stack dependencies
- ❌ No coding style preferences
- ✅ Updated by framework maintainers
- ❓ Could drift from framework if copied

**Customization Points**: NONE in current implementation

**Evidence from agent specs**:
- Assessor: Pure complexity scoring (no custom rules)
- Architect: Standard architectural patterns (no project-specific templates)
- Product: General product management practices (no domain-specific knowledge)
- Facilitator: Standard facilitation pattern (no custom conversation flows)
- Documentarian: Memory bank structure validation (fixed schema)
- Reviewer: CCFlow quality standards (framework-defined)

**Comparison to System Agents**:
- Like commandBuilder: Framework-defined behavior
- Like agentBuilder: Standard patterns applied consistently
- Unlike implementation agents: No tech stack customization needed

**Proposed Classification**: 🎯 **Framework-Level**

**Rationale**:
1. No customization points in current design
2. Consistent behavior is a FEATURE (ensures workflow predictability)
3. Copying creates maintenance burden with no benefit
4. Should be updated framework-wide, not per-project
5. Behave like system agents functionally

**Proposed Location**: `.claude/agents/system/workflow/` or `.claude/agents/workflow/` (framework-level)

**Init Behavior**: ❌ Should NOT be copied

**Reset Action**: ❌ Should NOT be deleted

**Migration Impact**:
- Existing projects would need to delete `.claude/agents/workflow/` manually
- Or `/cf:reset` could be smart during transition period
- Documentation update required

---

### 3. Generic Implementation Agents (`.claude/agents/`)

**Current Location**: `.claude/templates/generic/*.template.md` → copied to `.claude/agents/`

**Agents**:
- `codeImplementer.md` - Backend/business logic implementation
- `testEngineer.md` - TDD test writing
- `uiDeveloper.md` - UI/Frontend implementation

**Analysis**:
- ✅ Framework-agnostic fallbacks
- ✅ Have TODO sections for customization
- ✅ Tech stack configuration needed
- ✅ Code style preferences
- ✅ Testing framework selection
- ✅ Project-specific patterns

**Customization Points** (from templates):
```markdown
## Technology Stack (CUSTOMIZE)
<!-- TODO: Specify your stack -->
- **Language**: [Python | JavaScript | TypeScript | Ruby | Go | Java]
- **Framework**: [Express | Django | Rails | Spring Boot | None]
- **Database**: [PostgreSQL | MySQL | MongoDB | None]

## Code Style & Conventions (CUSTOMIZE)
<!-- TODO: Define your standards -->
- **Style Guide**: [Link or description]
- **Linting**: [ESLint | Pylint | RuboCop | None]
- **Formatting**: [Prettier | Black | None]

## Testing Approach (CUSTOMIZE)
<!-- TODO: Specify your testing setup -->
- **Test Framework**: [Jest | Pytest | RSpec | JUnit]
- **Coverage Target**: [e.g., 80%]
```

**Customizable?**: ✅ YES - Extensive customization required

**Proposed Classification**: 🎯 **Project-Level**

**Rationale**:
1. Must be customized for each project's tech stack
2. Coding style is project-specific
3. Testing frameworks vary by project
4. Legitimate need for divergence from defaults

**Current Behavior**: ✅ Correct - copied during init

**Reset Action**: ✅ Correct - should be deleted

---

### 4. Team-Specific Implementation Agents

**Location**: `.claude/templates/team-types/[stack]/core/`

**Examples** (React-Express team):
- `reactFrontend.md` - React-specific UI development
- `expressBackend.md` - Express-specific backend
- `jestTest.md` - Jest-specific testing

**Analysis**:
- ✅ Stack-specific specialization
- ✅ Installed via `/cf:configure-team`
- ✅ Replace or augment generic agents
- ✅ Project-specific by definition

**Customizable?**: ✅ YES - Stack configurations

**Proposed Classification**: 🎯 **Project-Level**

**Current Behavior**: ✅ Correct - copied when team configured

**Reset Action**: ✅ Correct - should be deleted

---

### 5. Specialist Agents (`.claude/agents/specialists/`)

**Location**: `.claude/agents/specialists/`

**Examples**:
- `authGuard.md` - Authentication specialist
- `dbMigration.md` - Database migration specialist
- `paymentGateway.md` - Payment processing specialist

**Analysis**:
- ✅ Created via `/cf:create-specialist`
- ✅ Domain-specific knowledge
- ✅ Project-specific requirements
- ✅ Custom business logic

**Customizable?**: ✅ YES - Entirely custom

**Proposed Classification**: 🎯 **Project-Level**

**Current Behavior**: ✅ Correct - project-created

**Reset Action**: ✅ Correct - should be deleted

---

## Recommended Architecture

### Framework-Level Agents (Never Copied, Never Deleted)

**Location**: `.claude/agents/system/` (current) or reorganized

```
.claude/agents/system/
├── commandBuilder.md          # Meta: Command optimization
├── agentBuilder.md            # Meta: Agent creation
├── project-discovery.md       # Meta: Project analysis
└── workflow/                  # NEW: Move workflow agents here
    ├── assessor.md            # Complexity routing
    ├── architect.md           # Technical decisions
    ├── product.md             # Requirements analysis
    ├── facilitator.md         # Interactive refinement
    ├── documentarian.md       # Memory consistency
    └── reviewer.md            # Quality validation
```

**Characteristics**:
- Never appear in project directories
- Referenced from framework location
- Updated framework-wide
- No project customization
- Consistent across all projects

**Alternative Organization** (if keeping workflow separate):
```
.claude/agents/
├── system/                    # Meta-agents
│   ├── commandBuilder.md
│   ├── agentBuilder.md
│   └── project-discovery.md
└── workflow/                  # Workflow agents (framework-level)
    ├── assessor.md
    ├── architect.md
    ├── product.md
    ├── facilitator.md
    ├── documentarian.md
    └── reviewer.md
```

---

### Project-Level Agents (Copied During Init, Deleted During Reset)

**After /cf:init (minimal)**:
```
.claude/agents/
├── codeImplementer.md         # Generic (needs TODO completion)
├── testEngineer.md            # Generic (needs TODO completion)
├── uiDeveloper.md             # Generic (needs TODO completion)
└── specialists/               # Empty initially
    └── (created by /cf:create-specialist)
```

**After /cf:configure-team [team-type]**:
```
.claude/agents/
├── codeImplementer.md         # Generic (kept as fallback)
├── testEngineer.md            # Generic (kept as fallback)
├── uiDeveloper.md             # Generic (kept as fallback)
├── react-express/             # NEW: Team-specific agents
│   ├── reactFrontend.md       # Stack-specific
│   ├── expressBackend.md      # Stack-specific
│   └── jestTest.md            # Stack-specific
└── specialists/
    └── (custom specialists)
```

**Characteristics**:
- Copied from templates during init
- Require customization (generic agents have TODOs)
- Tech stack specific
- Can diverge from framework
- Deleted during reset

---

## Comparison: Current vs. Proposed

### Current Architecture

```
Framework (.claude/):
├── agents/
│   └── system/                # Never copied ✅
│       ├── commandBuilder.md
│       ├── agentBuilder.md
│       └── project-discovery.md
└── templates/
    ├── agents/
    │   └── workflow/          # COPIED to project ❌ (should not be)
    │       ├── assessor.template.md
    │       ├── architect.template.md
    │       ├── product.template.md
    │       ├── facilitator.template.md
    │       ├── documentarian.template.md
    │       └── reviewer.template.md
    └── generic/               # COPIED to project ✅ (correct)
        ├── codeImplementer.template.md
        ├── testEngineer.template.md
        └── uiDeveloper.template.md

Project (.claude/agents/):
├── workflow/                  # Copied from templates (❌ unnecessary)
│   ├── assessor.md
│   ├── architect.md
│   ├── product.md
│   ├── facilitator.md
│   ├── documentarian.md
│   └── reviewer.md
├── codeImplementer.md         # Copied (✅ correct - needs customization)
├── testEngineer.md            # Copied (✅ correct - needs customization)
├── uiDeveloper.md             # Copied (✅ correct - needs customization)
└── specialists/               # Created as needed (✅ correct)
```

**Issues**:
1. Workflow agents copied unnecessarily (no customization points)
2. Creates maintenance burden (6 extra files per project)
3. Risk of drift from framework (bugs fixed in framework but not in projects)
4. Confusing for users (which agents can be customized?)

---

### Proposed Architecture

```
Framework (.claude/):
├── agents/
│   ├── system/                # Never copied
│   │   ├── commandBuilder.md
│   │   ├── agentBuilder.md
│   │   └── project-discovery.md
│   └── workflow/              # Never copied (NEW: moved from templates)
│       ├── assessor.md
│       ├── architect.md
│       ├── product.md
│       ├── facilitator.md
│       ├── documentarian.md
│       └── reviewer.md
└── templates/
    ├── generic/               # Copied to project
    │   ├── codeImplementer.template.md
    │   ├── testEngineer.template.md
    │   └── uiDeveloper.template.md
    └── team-types/            # Copied when team configured
        └── [stack]/

Project (.claude/agents/):
├── codeImplementer.md         # Copied from generic templates
├── testEngineer.md            # Copied from generic templates
├── uiDeveloper.md             # Copied from generic templates
├── [team-type]/               # Optional: if team configured
│   └── [stack-specific agents]
└── specialists/               # Optional: if specialists created
    └── [custom specialists]
```

**Benefits**:
1. Clear separation: Framework vs. Project agents
2. No unnecessary file duplication
3. Framework updates automatically apply
4. Obvious which agents can be customized (only those in project)
5. Cleaner project directories (3 files instead of 9)
6. Easier onboarding (less confusion)

---

## Impact Analysis

### Impact on /cf:init

**Current behavior**:
```bash
# Copies 9 agents to project
cp .claude/templates/agents/workflow/*.template.md .claude/agents/workflow/
cp .claude/templates/generic/*.template.md .claude/agents/
```

**Proposed behavior**:
```bash
# Copies only 3 generic agents to project
cp .claude/templates/generic/*.template.md .claude/agents/
# Workflow agents stay in framework - not copied
```

**Changes needed**:
- Remove workflow agent copying from init
- Update init documentation
- Update agent customization instructions

---

### Impact on /cf:reset

**Current plan**:
```bash
# Deletes 9 agents + specialists
rm -rf .claude/agents/workflow/
rm -rf .claude/agents/codeImplementer.md
rm -rf .claude/agents/testEngineer.md
rm -rf .claude/agents/uiDeveloper.md
rm -rf .claude/agents/specialists/
rm -rf memory-bank/
```

**Proposed behavior**:
```bash
# Deletes only 3 generic agents + specialists + team agents
rm -rf .claude/agents/codeImplementer.md
rm -rf .claude/agents/testEngineer.md
rm -rf .claude/agents/uiDeveloper.md
rm -rf .claude/agents/[team-type]/      # If exists
rm -rf .claude/agents/specialists/
rm -rf memory-bank/
# Workflow agents not touched - they're in framework
```

**Simpler logic**:
- No need to check for workflow agents
- Clear project vs framework boundary
- Less code, less complexity

---

### Impact on Agent Invocation

**Current**: Commands look in `.claude/agents/workflow/`
**Proposed**: Commands look in `.claude/agents/workflow/` (framework location)

**No changes needed** if Claude Code's Task tool searches both:
- `.claude/agents/system/`
- `.claude/agents/workflow/`
- `.claude/agents/` (project agents)

Alternatively, commands could explicitly specify paths:
```
Invoke facilitator subagent (at .claude/agents/workflow/facilitator.md)
```

**Testing needed**: Verify Task tool finds agents in framework locations

---

### Impact on Agent Updates

**Current architecture**:
- Framework update: Must update template, users must re-run init or manually copy
- Project divergence: Easy to get out of sync

**Proposed architecture**:
- Framework update: Edit framework file, all projects get it immediately
- No divergence possible for workflow agents
- Cleaner update story

**Example**:
- Bug fix in assessor.md
- **Current**: Update template, notify users, users manually update or reinit
- **Proposed**: Update `.claude/agents/workflow/assessor.md`, done

---

### Impact on Documentation

**Files to update**:
1. `/cf:init` command spec
2. `/cf:reset` command spec
3. Agent customization guide
4. Architecture documentation
5. Contribution guidelines

**New clarity**:
```markdown
## Which Agents Can I Customize?

**Framework Agents** (DO NOT MODIFY):
- System agents (.claude/agents/system/)
- Workflow agents (.claude/agents/workflow/)

**Project Agents** (CUSTOMIZE THESE):
- Generic implementation agents (.claude/agents/*.md)
- Team-specific agents (.claude/agents/[team-type]/)
- Specialists (.claude/agents/specialists/)

To customize: Edit the TODO sections in your project agents.
```

---

## Migration Strategy

### For New Projects
- Just implement proposed architecture
- New inits create correct structure

### For Existing Projects
**Option A: Manual migration**
```bash
# Remove workflow agents from project
rm -rf .claude/agents/workflow/

# Framework workflow agents will be used automatically
```

**Option B: Reset + reinit**
```bash
/cf:reset --backup    # Save project config
/cf:init              # Reinitialize with new architecture
# Restore customizations from backup
```

**Option C: Smart /cf:reset during transition**
```bash
# /cf:reset detects old structure and cleans it
if [ -d ".claude/agents/workflow/" ]; then
  echo "⚠️  Detected old architecture - cleaning up workflow agents"
  rm -rf .claude/agents/workflow/
fi
```

**Recommendation**: Option C (smart cleanup) for best UX

---

## Decision Matrix

| Aspect | Current (Copy Workflow) | Proposed (Framework Workflow) |
|--------|------------------------|-------------------------------|
| **File count** | 9 agents copied | 3 agents copied |
| **Customizability** | Possible but discouraged | Clear: 3 customizable, 6 not |
| **Maintenance** | Manual sync needed | Automatic |
| **Updates** | Per-project | Framework-wide |
| **Clarity** | Ambiguous | Explicit |
| **Reset complexity** | More files to track | Simpler logic |
| **Disk usage** | ~180 KB per project | ~80 KB per project |
| **Drift risk** | High | None |
| **Onboarding** | "Don't modify these 6" | "These 3 are yours" |

---

## Recommendation

### 🎯 Proposed Decision

**Workflow agents should be framework-level, NOT project-level**

**Rationale**:
1. **No customization points**: They don't need to be customized
2. **Consistency is a feature**: Predictable workflow behavior across projects
3. **Simpler updates**: Bug fixes apply immediately to all projects
4. **Clearer UX**: Obvious which agents are customizable
5. **Less maintenance**: No sync burden between framework and projects
6. **Smaller reset surface**: /cf:reset has less to delete
7. **Matches system agents**: Similar purpose and behavior

**Classification**:
- **Framework-Level** (never copied, never deleted):
  - System agents (commandBuilder, agentBuilder, project-discovery)
  - Workflow agents (assessor, architect, product, facilitator, documentarian, reviewer)

- **Project-Level** (copied, customized, deleted on reset):
  - Generic implementation agents (codeImplementer, testEngineer, uiDeveloper)
  - Team-specific agents (configured via /cf:configure-team)
  - Specialists (created via /cf:create-specialist)

**Organization**:
```
.claude/agents/
├── system/           # Framework meta-agents
│   ├── commandBuilder.md
│   ├── agentBuilder.md
│   └── project-discovery.md
└── workflow/         # Framework workflow agents
    ├── assessor.md
    ├── architect.md
    ├── product.md
    ├── facilitator.md
    ├── documentarian.md
    └── reviewer.md
```

---

## Implementation Checklist

### Phase 1: Architecture Refactor
- [ ] Move workflow agents from templates to framework
  - [ ] `.claude/templates/agents/workflow/` → `.claude/agents/workflow/`
  - [ ] Remove .template extension
- [ ] Update /cf:init to NOT copy workflow agents
- [ ] Test agent invocation from framework location
- [ ] Update documentation

### Phase 2: /cf:reset Implementation
- [ ] Implement reset command with correct deletion logic
- [ ] Add smart cleanup for old architecture (transition period)
- [ ] Test on both old and new project structures
- [ ] Document reset behavior

### Phase 3: Documentation Update
- [ ] Update /cf:init documentation
- [ ] Create agent customization guide
- [ ] Update architecture documentation
- [ ] Add migration guide for existing projects

### Phase 4: Testing
- [ ] Test new init on fresh project
- [ ] Test reset on new architecture
- [ ] Test reset on old architecture (transition)
- [ ] Verify agent invocation works
- [ ] Test configure-team compatibility

---

## Open Questions

1. **Agent invocation**: Does Task tool automatically search `.claude/agents/workflow/` in framework?
   - Test needed: Create agent in framework location, try to invoke
   - May need explicit path in command specs

2. **Backward compatibility**: Support projects with old structure?
   - Smart /cf:reset can detect and clean
   - Document migration path
   - Time-limited or permanent support?

3. **Template cleanup**: Remove workflow templates after moving?
   - Yes: Clean break, no confusion
   - No: Keep for reference/compatibility
   - Recommendation: Remove after migration period

4. **Documentation location**: Should workflow agents have README?
   - Like system agents have documentation
   - Clarify their purpose and usage
   - Recommendation: Yes, add .claude/agents/workflow/README.md

---

## Conclusion

**Recommendation**: Reclassify workflow agents as framework-level

**Confidence**: High - Based on:
- No customization points in current design
- Behavioral similarity to system agents
- Reduced complexity and maintenance
- Clearer user mental model
- Easier framework updates

**Next Steps**:
1. Get user confirmation on recommendation
2. Implement Phase 1 (architecture refactor)
3. Update /cf:init accordingly
4. Then implement /cf:reset with correct logic

**Blocker Resolved**: Once approved, /cf:reset can be implemented with clear deletion logic

---

**Status**: Awaiting user decision
**Recommendation**: ✅ Move workflow agents to framework level
**Impact**: /cf:init changes, /cf:reset simplified, better UX
