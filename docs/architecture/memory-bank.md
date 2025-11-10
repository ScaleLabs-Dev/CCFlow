# Memory Bank Architecture

**Version**: 2.0 (Pattern Catalog Structure)
**Last Updated**: 2025-11-06
**Related**: TASK-005 (systemPatterns.md maintainability refactor)

---

## Overview

The memory bank is CCFlow's persistent context system that maintains project state, patterns, and progress across development sessions. It uses a structured file organization to separate concerns and enable efficient context loading.

**Core Principle**: Living documentation that evolves with the project, not static reference material.

---

## Directory Structure

```
memory-bank/
├── projectbrief.md              # Immutable project scope (NEVER roadmap)
├── productContext.md            # Living roadmap (Features & Priorities) + requirements
├── systemPatterns.md            # Pattern catalog master index
├── activeContext.md             # Current work focus (working memory)
├── progress.md                  # Completed milestones
├── tasks.md                     # Task tracking and management
├── patterns/                    # Pattern catalog (v2.0)
│   ├── README.md               # Navigation guide
│   ├── atomic-migration.md
│   ├── command-orchestration.md
│   ├── conditional-expert-pre-analysis.md
│   ├── conditional-multi-agent-orchestration.md
│   ├── creative-session.md
│   ├── documentation-organization.md
│   ├── mode-specific-agent-loading.md
│   ├── subagent-type-encoding.md
│   └── working-memory.md
└── specs/                       # Feature specifications (Level 3-4)
    └── TASK-[ID]-[slug]-spec.md
```

---

## File Purposes

### Core Files

#### projectbrief.md
**Status**: Immutable (set during `/cf:init`)
**Purpose**: Defines project scope, objectives, and constraints
**Updated By**: Manual only (Decision Log can be appended)
**Read By**: All workflow agents during analysis

**Contains**:
- Project name and description
- Core objectives
- Scope boundaries (in/out of scope)
- Technical constraints
- Success criteria (immutable targets)
- Decision Log (append-only)

**⚠️ NEVER Contains**: Features & Priorities (roadmap) - that's in productContext.md

#### productContext.md
**Status**: Living document
**Purpose**: Tracks living roadmap, features, and user needs
**Updated By**: `/cf:feature`, `/cf:plan`, `/cf:checkpoint`, Documentarian
**Read By**: Product agent, Architect agent, planning commands

**Contains**:
- **Features & Priorities** (roadmap table - status, priority, complexity)
- **Success Metrics** (project goal tracking)
- **Feature Details** (specifications from /cf:feature)
- User personas and needs
- UX requirements
- Product decisions and rationale

**Architecture Decision** (TASK-154): productContext.md is the single source of truth for the living roadmap. Commands and agents ALWAYS read/write roadmap data here, not in projectbrief.md.

#### systemPatterns.md
**Status**: Master index (v2.0 - flat catalog structure)
**Purpose**: Navigable index of architecture patterns
**Updated By**: `/cf:code`, `/cf:creative`, `/cf:checkpoint`, Documentarian
**Read By**: All agents during implementation

**Contains** (v2.0):
- Quick navigation to pattern catalog
- Categorized table of contents (Workflow/Architectural/Technical)
- Pattern summary table with links to patterns/*.md
- Coding conventions
- Pattern addition guide

**Changed in v2.0** (TASK-005):
- From: 1623-line monolithic file with embedded patterns
- To: 257-line master index + patterns/ directory
- Benefits: <30s pattern discovery (vs 60-90s), scalable to 20+ patterns

**See**: `docs/workflows/pattern-management.md` for pattern addition workflow

#### activeContext.md
**Status**: Working memory (ephemeral)
**Purpose**: Current work focus and recent changes
**Updated By**: All commands, `/cf:checkpoint`
**Read By**: `/cf:context`, all workflow agents

**Contains**:
- Current Focus: Active task/feature being worked on
- Recently Completed: Last 3-5 completed tasks
- Recent Changes: Last 5 entries chronologically
- Next Steps: Immediate actions
- Active Decisions: Pending choices
- Key Learnings: Session insights
- Session Notes: Context for resumption

**Working Memory Pattern** (TASK-006):
- Completion clears Current Focus (not archived)
- New feature overwrites Current Focus (not append)
- Manual archival via `/cf:checkpoint` → progress.md
- Target: 200-300 lines for quick readability

#### progress.md
**Status**: Append-only historical record
**Purpose**: Completed milestones and project history
**Updated By**: `/cf:checkpoint` (explicit), `/cf:git` (automatic)
**Read By**: `/cf:status`, `/cf:review`, `/cf:sync`

**Contains**:
- Completed task summaries
- Feature launch records
- Architectural decisions (ADRs)
- Project milestones
- Session summaries
- Key learnings and retrospectives

#### tasks.md
**Status**: Task management system
**Purpose**: Track all project tasks and their lifecycle
**Updated By**: `/cf:feature`, `/cf:plan`, `/cf:code`, `/cf:review`
**Read By**: All workflow agents, status commands

**Contains**:
- Active tasks (🟢 in progress)
- Pending tasks (⏳ ready to start)
- Blocked tasks (🔄 dependency issues)
- Completed tasks (✅ verified)
- Cancelled tasks (❌ out of scope)
- Task metadata: complexity, effort, acceptance criteria, tests

---

### Pattern Catalog (v2.0)

#### patterns/ Directory
**Status**: Living catalog (added in TASK-005)
**Purpose**: Detailed pattern documentation
**Structure**: Flat directory (no subdirectories)
**Updated By**: `/cf:code`, `/cf:creative`, Documentarian
**Read By**: All agents during implementation

**Pattern File Structure**:
```markdown
# [Pattern Name]

## Context
[When/where this applies]

## Problem
[What it solves]

## Solution
[How the pattern works]

## Benefits
- ✅ [Advantage 1]

## Trade-offs
- ⚠️ [Limitation 1]

## Examples in Codebase
[File:line references]

## Reusability
[3+ scenarios where applicable]

## Related Patterns
[Cross-references]
```

**Current Patterns** (9 active):
1. Atomic Migration Pattern
2. Command Orchestration Pattern
3. Conditional Expert Pre-Analysis Pattern
4. Conditional Multi-Agent Orchestration Pattern
5. Creative Session Pattern
6. Documentation Organization Pattern
7. Mode-Specific Agent Loading Pattern
8. Subagent Type Encoding Pattern
9. Working Memory Pattern

**See**: `docs/workflows/pattern-management.md` for adding patterns

#### patterns/README.md
**Status**: Navigation guide
**Purpose**: Help developers navigate pattern catalog
**Updated By**: Manual (when catalog structure changes)

**Contains**:
- How to browse patterns
- Pattern addition workflow
- Cross-references to systemPatterns.md

---

### Specification Documents

#### specs/ Directory
**Status**: Optional (created by `/cf:creative` for Level 3-4)
**Purpose**: Detailed specifications for complex features
**Naming**: `TASK-[ID]-[slug]-spec.md`
**Updated By**: `/cf:creative` only
**Read By**: `/cf:plan`, implementation agents

**Specification Structure**:
```markdown
# [Feature Name] - Specification

## Context
[Why this matters]

## Problem Definition
[What we're solving]

## Multi-Perspective Analysis
### Architect Perspective
### Product Perspective
### Tech Stack Perspective

## Cross-Perspective Synthesis
[Convergent insights and tensions]

## Recommended Approach
[Selected solution with rationale]

## Implementation Plan
[Component breakdown and phases]

## Testing Strategy
[How to verify success]

## Pattern Extraction
[Reusable patterns identified]

## Decision Record
[Alternatives considered and trade-offs]
```

**When Created**: Level 3-4 tasks requiring deep analysis
**When Skipped**: Level 1-2 tasks (specification in tasks.md sufficient)

---

## Memory Bank Lifecycle

### Initialization (`/cf:init`)
1. Creates memory-bank/ directory
2. Creates all core files from templates
3. Prompts for projectbrief.md content
4. Sets up patterns/ directory (v2.0)
5. Copies pattern template to .claude/templates/

### Session Start (`/cf:context`)
1. Loads activeContext.md (current focus)
2. Loads tasks.md (active tasks)
3. Loads systemPatterns.md index (quick pattern reference)
4. Optional: Loads productContext.md if needed

### During Work
**Commands update memory bank automatically**:
- `/cf:feature` → tasks.md + activeContext.md
- `/cf:plan` → tasks.md + activeContext.md + (optional) productContext.md
- `/cf:code` → tasks.md + activeContext.md + systemPatterns.md + patterns/*.md
- `/cf:review` → activeContext.md + progress.md (if issues found)

### Checkpointing (`/cf:checkpoint`)
1. Documentarian agent analyzes all memory bank files
2. Creates comprehensive summary
3. Updates progress.md with milestone
4. Validates cross-file consistency
5. Suggests cleanup if files growing too large

### Session End
1. Run `/cf:checkpoint` (create savepoint)
2. Run `/cf:git` (commit changes with memory bank updates)
3. activeContext.md preserves Current Focus for next session

---

## Memory Bank Patterns

### Working Memory Pattern (TASK-006)
**Pattern**: activeContext.md as ephemeral working memory
**Lifecycle**:
- Task start: Overwrite Current Focus with new task
- Task complete: Clear Current Focus
- Manual archive: `/cf:checkpoint` moves to progress.md

**Benefits**:
- Always fresh context (200-300 lines)
- No manual maintenance
- Zero bloat accumulation

### Pattern Catalog Pattern (TASK-005)
**Pattern**: Master index + detailed pattern files
**Structure**:
- systemPatterns.md: Quick navigation (categorized TOC)
- patterns/*.md: Detailed pattern documentation
- Flat directory: No subdirectories (flexible for any project)

**Benefits**:
- <30s pattern discovery (vs 60-90s monolithic)
- Scalable to 20+ patterns
- Easy pattern addition workflow

### Specification Document Pattern (TASK-001-5)
**Pattern**: Separate spec documents for complex features
**Trigger**: Level 3-4 tasks from `/cf:creative`
**Location**: memory-bank/specs/

**Benefits**:
- Preserves full multi-perspective analysis
- Enables /cf:plan to reference detailed design
- Maintains specification versioning

---

## File Size Guidelines

| File | Target Size | Warning Threshold | Action if Exceeded |
|------|-------------|-------------------|-------------------|
| projectbrief.md | 200-400 lines | N/A | Immutable, should stay small |
| productContext.md | 300-600 lines | 800 lines | Archive old features to progress.md |
| systemPatterns.md | 200-300 lines | 400 lines | Extract more patterns to patterns/ |
| activeContext.md | 200-300 lines | 400 lines | Archive to progress.md via /cf:checkpoint |
| progress.md | Unlimited | N/A | Append-only, searchable |
| tasks.md | 500-1000 lines | 1500 lines | Archive completed to progress.md |
| patterns/*.md | 100-300 lines/file | 400 lines | Split into multiple patterns |

**Documentarian Monitoring**: Warns during `/cf:checkpoint` if files exceed thresholds

---

## Memory Bank Anti-Patterns

### ❌ Don't: Manual Edits Without Commands
**Problem**: Breaks consistency, bypasses validation
**Instead**: Use commands (they update memory bank correctly)

### ❌ Don't: Accumulate Stale Content
**Problem**: Files grow unwieldy, context loading slows
**Instead**: Regular `/cf:checkpoint` archives old content

### ❌ Don't: Duplicate Information Across Files
**Problem**: Maintenance burden, synchronization issues
**Instead**: Single source of truth, cross-references

### ❌ Don't: Skip Memory Bank Updates
**Problem**: Lost context, breaks session resumption
**Instead**: Commands auto-update, trust the system

### ❌ Don't: Mix Concerns in Files
**Problem**: activeContext.md becomes catch-all
**Instead**: Respect file purposes, use specs/ for detail

---

## Migration Guide

### Upgrading to v2.0 (Pattern Catalog)

**From**: Monolithic systemPatterns.md (1623 lines)
**To**: Master index + patterns/ directory (257 lines + 9 files)

**Steps**:
1. Create memory-bank/patterns/ directory
2. Create .claude/templates/pattern-template.md
3. Extract patterns from systemPatterns.md to patterns/*.md
4. Rewrite systemPatterns.md as master index with categorized TOC
5. Update agent references (architect, documentarian, reviewer, facilitator)
6. Update command documentation (cf-creative, cf-feature, README)
7. Create git commits preserving history

**Benefits**:
- 84% size reduction (1623 → 257 lines)
- Pattern discovery: 60-90s → <30s
- Scalability: 9 patterns → 20+ patterns without degradation

**Reference**: TASK-005 implementation (7 sub-tasks, 2h 50min)

---

## Best Practices

### For Developers

1. **Trust the System**: Let commands handle memory bank updates
2. **Regular Checkpoints**: Run `/cf:checkpoint` after major milestones
3. **Review Context**: Start sessions with `/cf:context` to load fresh state
4. **Pattern First**: Check systemPatterns.md before implementing new patterns
5. **Specs for Complexity**: Use `/cf:creative` for Level 3-4 to create specs/

### For Commands

1. **Atomic Updates**: Update all related files in single operation
2. **Validation**: Check file sizes and warn if exceeding thresholds
3. **Consistency**: Cross-reference validation (no broken links)
4. **Timestamps**: Always include timestamps in Recent Changes
5. **Working Memory**: Respect activeContext.md lifecycle (overwrite, not append)

### For Agents

1. **Read-Only**: Workflow agents read memory bank, never write
2. **Context Loading**: Load relevant files based on agent responsibility
3. **Pattern Application**: Reference systemPatterns.md + patterns/ during analysis
4. **Recommendation**: Suggest patterns when recurring problems identified

---

## Related Documentation

- **Pattern Management**: `docs/workflows/pattern-management.md`
- **Session Management**: `docs/workflows/session-management.md`
- **Command Reference**: `docs/commands/README.md`
- **Agent Organization**: `docs/architecture/agent-organization.md`

---

**Version**: 2.0 (Pattern Catalog Structure)
**Last Updated**: 2025-11-06
**Changes**: Added pattern catalog architecture, working memory pattern, file size guidelines
