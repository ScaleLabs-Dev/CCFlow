# Pattern Management Workflow

**Version**: 2.0 (Pattern Catalog Structure)
**Last Updated**: 2025-11-06
**Related**: TASK-005 (systemPatterns.md maintainability refactor)

---

## Overview

Pattern management in CCFlow follows a **two-tier structure**: a master index for navigation and individual pattern files for detailed documentation. This workflow guides developers through discovering, creating, and maintaining patterns in the pattern catalog.

**Core Principle**: Patterns emerge from implementation, not speculation. Extract patterns only when proven reusable (3+ use cases).

---

## Pattern Catalog Structure

```
memory-bank/
├── systemPatterns.md              # Master index (navigation)
└── patterns/                      # Pattern catalog (details)
    ├── README.md                 # Navigation guide
    ├── [pattern-name].md         # Individual patterns (9 active)
    └── ...
```

**Two-Tier Benefits**:
- **Quick Navigation**: Master index provides <30s pattern discovery
- **Detailed Documentation**: Pattern files contain full implementation details
- **Scalability**: Supports 20+ patterns without degradation
- **Flexibility**: Flat structure works for any project type

---

## Pattern Discovery Workflow

### Step 1: Check Existing Patterns

**Before creating new patterns**, check if existing patterns solve the problem:

1. **Open master index**: `memory-bank/systemPatterns.md`
2. **Scan categorized TOC**:
   - Workflow Patterns (task orchestration, session management)
   - Architectural Patterns (system design, agent coordination)
   - Technical Patterns (implementation specifics)
3. **Click pattern link** to view details
4. **Review pattern sections**: Context, Problem, Solution, Examples

**Quick Search**:
```bash
# Search pattern names in master index
grep -i "keyword" memory-bank/systemPatterns.md

# Search pattern content in catalog
grep -ri "keyword" memory-bank/patterns/
```

---

### Step 2: Identify Pattern Candidates

Patterns emerge when you notice:
- **Recurring solutions**: Same approach used 3+ times
- **Proven effectiveness**: Solution works reliably
- **Broad applicability**: Useful across multiple contexts
- **Clear boundaries**: Well-defined problem and solution

**Pattern Candidate Examples**:
✅ **Good Candidates**:
- "We keep using this agent coordination approach for multi-step analysis"
- "This file organization pattern solved scalability issues 3 times"
- "This testing strategy works consistently across features"

❌ **Poor Candidates**:
- "This might be useful someday" (speculative)
- "Used once, worked well" (not proven reusable)
- "Works for this specific feature" (too narrow)

---

## Pattern Creation Workflow

### Prerequisites

- Pattern used successfully 3+ times
- Clear problem statement
- Documented solution
- Examples in codebase

---

### Step 1: Create Pattern File

**Location**: `memory-bank/patterns/[pattern-name].md`

**Naming Convention**: lowercase-with-hyphens
- ✅ Good: `command-orchestration.md`, `working-memory.md`
- ❌ Bad: `CommandOrchestration.md`, `working_memory.md`, `new-pattern.md`

**Create from template**:
```bash
cp .claude/templates/pattern-template.md memory-bank/patterns/[pattern-name].md
```

---

### Step 2: Fill Pattern Template

**Required Sections**:

#### 1. Pattern Metadata
```markdown
# [Pattern Name]

**Category**: [Workflow/Architectural/Technical]
**Added**: YYYY-MM-DD (from TASK-[ID])
**Status**: Active
**Reusability**: [3+ scenarios described]
```

#### 2. Context
**What to include**:
- When/where this pattern applies
- Project phase or scope
- Preconditions required

**Example**:
```markdown
## Context

**When**: Multi-agent analysis requiring domain-specific expertise
**Where**: /cf:feature command for Level 2+ tasks
**Precondition**: Complexity assessment complete, domain boundaries defined
```

#### 3. Problem
**What to include**:
- What problem this solves
- Why existing approaches fail
- Impact of not solving

**Example**:
```markdown
## Problem

Features reveal hidden complexity during implementation (integration, data, algorithm), forcing "stop and spec" pauses mid-coding. Specifications appear complete during planning but lack technical depth, leading to:
- Context switching overhead
- Implementation delays
- Incomplete architectural analysis
```

#### 4. Solution
**What to include**:
- How the pattern works (step-by-step)
- Key components and relationships
- Decision points and variations

**Example**:
```markdown
## Solution

Conditional multi-agent orchestration: invoke domain experts (Architect, Product) based on complexity level, then synthesize outputs at command layer.

### Flow
1. Assessor determines complexity level
2. **IF Level 2+**: Invoke Architect for technical pre-analysis (6-8 min)
3. Invoke Product for user requirements (2-3 min)
4. **IF Level 2+**: Command synthesizes Architect + Product outputs
5. **ELSE**: Use Product output directly

### Domain Separation
- Architect: Pure technical focus (integration/data/algorithm/constraints)
- Product: Pure user focus (who/why/what users need)
- Command: Cross-domain synthesis
```

#### 5. Benefits
**What to include**:
- Concrete advantages
- Measurable improvements
- Use cases enabled

**Example**:
```markdown
## Benefits

- ✅ Early complexity detection (before implementation)
- ✅ Specification completeness (technical + user requirements)
- ✅ Domain separation (clean agent responsibilities)
- ✅ Conditional efficiency (no overhead for simple tasks)
```

#### 6. Trade-offs
**What to include**:
- Limitations and constraints
- When NOT to use
- Costs and complexity

**Example**:
```markdown
## Trade-offs

- ⚠️ Additional 6-8 min for Level 2+ features (acceptable for completeness)
- ⚠️ Command orchestration complexity (requires synthesis logic)
- ⚠️ Not suitable for Level 1 (unnecessary overhead)
```

#### 7. Examples in Codebase
**What to include**:
- File:line references
- Code snippets
- Usage patterns

**Example**:
```markdown
## Examples in Codebase

**Implementation**: `.claude/commands/cf/feature.md`
- Conditional invocation: Lines 84-110 (orchestration flow)
- Architect prompt: Lines 200-250
- Product prompt: Lines 356-446
- Synthesis logic: Lines 516-634

**Pattern Documentation**: `memory-bank/systemPatterns.md:719-938`
```

#### 8. Reusability
**What to include**:
- 3+ specific scenarios
- Adaptation guidelines
- Generalization strategy

**Example**:
```markdown
## Reusability

**Scenarios**:
1. `/cf:plan`: Conditional facilitator engagement (L3+ interactive)
2. `/cf:creative`: Conditional perspective selection (domain-specific)
3. `/cf:review`: Conditional specialist routing (complexity-based)

**Adaptation**:
- Define complexity threshold (Level 1/2/3/4)
- Identify domain experts to invoke
- Design synthesis strategy for command layer
```

#### 9. Related Patterns
**What to include**:
- Similar patterns
- Complementary patterns
- Pattern combinations

**Example**:
```markdown
## Related Patterns

- **Command Orchestration Pattern**: Foundation for multi-agent coordination
- **Conditional Expert Pre-Analysis**: Specific application of conditional orchestration
- **Domain Separation Pattern**: Ensures clean agent responsibilities
```

#### 10. Testing Approach (Optional but Recommended)
**What to include**:
- How to validate pattern works
- Test scenarios
- Success criteria

---

### Step 3: Add to Master Index

**Open**: `memory-bank/systemPatterns.md`

**Find appropriate category table**:
- Workflow Patterns
- Architectural Patterns
- Technical Patterns

**Add pattern entry**:
```markdown
| [Pattern Name](./patterns/pattern-name.md) | [Purpose description] | Active |
```

**Example**:
```markdown
## Architectural Patterns

| Pattern | Purpose | Status |
|---------|---------|--------|
| [Command Orchestration](./patterns/command-orchestration.md) | Commands coordinate agents, synthesize outputs | Active |
| [Conditional Multi-Agent Orchestration](./patterns/conditional-multi-agent-orchestration.md) | Conditional domain expert invocation with synthesis | Active |
| ... | ... | ... |
```

**Ensure**:
- ✅ Relative link path correct (`./patterns/pattern-name.md`)
- ✅ Purpose description is concise (1 line)
- ✅ Status is "Active" (not "Planned" or "Deprecated")

---

### Step 4: Cross-Reference Pattern

**Update related patterns** to reference new pattern:

1. **Identify related patterns** (from Related Patterns section)
2. **Edit each related pattern file**
3. **Add cross-reference** in Related Patterns section

**Example**:
```markdown
## Related Patterns

- [Command Orchestration Pattern](./command-orchestration.md): Foundation for agent coordination
- **[NEW] [Conditional Multi-Agent Orchestration](./conditional-multi-agent-orchestration.md)**: Advanced conditional coordination
```

---

### Step 5: Update Relevant Documentation

**If pattern affects workflows**, update:
- Command documentation (`docs/commands/`)
- Agent specifications (`.claude/agents/workflow/`)
- Architecture documentation (`docs/architecture/`)

**Example** (TASK-005):
- Updated architect.md: Pattern catalog workflow
- Updated documentarian.md: Pattern creation process
- Updated reviewer.md: Pattern recommendation approach
- Updated facilitator.md: Creative session pattern extraction

---

### Step 6: Git Commit

**Create atomic commit** documenting pattern addition:

```bash
git add memory-bank/patterns/[pattern-name].md \
        memory-bank/systemPatterns.md

git commit -m "docs(patterns): add [Pattern Name] pattern (TASK-[ID])

- Add [pattern-name].md to pattern catalog
- Update master index with new pattern entry
- Cross-reference with [related patterns]

[Brief description of what pattern solves]

Related: TASK-[ID]"
```

---

## Pattern Maintenance Workflow

### Updating Existing Patterns

**When to update**:
- Pattern evolved during implementation
- New examples added to codebase
- Trade-offs discovered
- Related patterns added

**Process**:
1. Edit pattern file: `memory-bank/patterns/[pattern-name].md`
2. Update relevant sections (Solution, Examples, Trade-offs, Related Patterns)
3. Add changelog entry at bottom of file:
   ```markdown
   ---
   ## Changelog

   **v1.1** (YYYY-MM-DD):
   - Added [what changed]
   - Updated [section] based on [reason]
   ```
4. Git commit with clear change description

---

### Deprecating Patterns

**When to deprecate**:
- Better pattern supersedes it
- No longer applicable to project
- Proven ineffective

**Process**:
1. **Update pattern file**:
   ```markdown
   # [Pattern Name]

   **Status**: ⚠️ Deprecated (YYYY-MM-DD)
   **Superseded By**: [New Pattern Name](./new-pattern.md)
   **Reason**: [Why deprecated]

   [Keep original content for reference]
   ```

2. **Update master index**:
   ```markdown
   | ~~[Pattern Name]~~ | Deprecated - see [New Pattern] | Deprecated |
   ```

3. **Update cross-references** in related patterns

4. **Git commit** documenting deprecation

**Do NOT delete deprecated patterns** - preserve for historical reference

---

### Refactoring Pattern Catalog

**When to refactor**:
- Pattern catalog exceeds 20 patterns
- Categories need reorganization
- Related patterns should be merged

**Approach**:
1. **Plan refactor** via `/cf:plan` (treat as Level 2 task)
2. **Preserve git history** using `git mv` for file moves
3. **Update all cross-references** systematically
4. **Test all links** in master index
5. **Create comprehensive changelog** in systemPatterns.md

**Example** (TASK-005):
- Refactored from: 1623-line monolithic file
- Refactored to: 257-line master index + 9 pattern files
- Preserved: All pattern content and cross-references
- Benefits: 84% size reduction, <30s discovery time

---

## Pattern Quality Checklist

### Before Adding Pattern

- [ ] Pattern used successfully 3+ times
- [ ] Clear problem statement (what it solves)
- [ ] Well-defined solution (how it works)
- [ ] Benefits documented (why use it)
- [ ] Trade-offs identified (when NOT to use)
- [ ] Examples in codebase (file:line references)
- [ ] Reusability scenarios (3+ specific cases)
- [ ] Related patterns cross-referenced

### After Adding Pattern

- [ ] Pattern file created from template
- [ ] All template sections filled (no TODOs)
- [ ] Master index updated with entry
- [ ] Category correct (Workflow/Architectural/Technical)
- [ ] Related patterns cross-referenced bidirectionally
- [ ] Git commit created with atomic changes
- [ ] Pattern discoverable via master index (<30s)

---

## Pattern Anti-Patterns

### ❌ Don't: Speculative Patterns
**Problem**: Create patterns "we might need someday"
**Instead**: Extract patterns after 3+ successful uses

### ❌ Don't: Incomplete Pattern Documentation
**Problem**: Skip sections, leave TODOs, minimal examples
**Instead**: Fill all template sections completely

### ❌ Don't: Pattern Proliferation
**Problem**: Create pattern for every solution
**Instead**: Only extract when broadly reusable (3+ scenarios)

### ❌ Don't: Ignore Master Index
**Problem**: Create pattern files without index entry
**Instead**: Always update systemPatterns.md master index

### ❌ Don't: Broken Cross-References
**Problem**: Pattern links don't work, references outdated
**Instead**: Test links, maintain bidirectional references

### ❌ Don't: Forget Git History
**Problem**: Direct file edits, no commits
**Instead**: Atomic commits for all pattern changes

---

## Common Workflows

### Quick Pattern Lookup

```bash
# 1. Open master index
open memory-bank/systemPatterns.md

# 2. Scan category TOC (Workflow/Architectural/Technical)

# 3. Click pattern link → opens detailed pattern file

# Time: <30 seconds from need to reading
```

---

### Adding Pattern During Implementation

```bash
# During /cf:code TASK-042

# 1. Recognize recurring pattern (3rd use)
# 2. Note pattern candidate in task notes
# 3. Complete task implementation
# 4. Extract pattern to catalog:
cp .claude/templates/pattern-template.md memory-bank/patterns/api-caching.md
# 5. Fill template sections
# 6. Add to master index
# 7. Git commit

git add memory-bank/patterns/api-caching.md \
        memory-bank/systemPatterns.md

git commit -m "docs(patterns): add API Caching Pattern (TASK-042)

- Add api-caching.md to pattern catalog
- Update master index with pattern entry
- Cross-reference with command-orchestration pattern

Solves: Repeated API calls causing performance degradation

Related: TASK-042"
```

---

### Pattern Discovered During Code Review

```bash
# During /cf:review

# Reviewer identifies recurring pattern in code
# Suggests pattern extraction

# 1. Create feature to extract pattern
/cf:feature "Extract [pattern-name] to pattern catalog"

# 2. Plan pattern extraction
/cf:plan TASK-[ID]

# 3. Implement pattern documentation
/cf:code TASK-[ID]

# Pattern now documented for future use
```

---

## Pattern Catalog Evolution

### Current State (v2.0)

**Statistics**:
- 9 active patterns
- 3 categories (Workflow, Architectural, Technical)
- 257-line master index
- <30s average discovery time
- Flat directory structure

**Categories**:
- **Workflow Patterns** (3): Creative Session, Mode-Specific Agent Loading, Working Memory
- **Architectural Patterns** (5): Atomic Migration, Command Orchestration, Conditional Expert Pre-Analysis, Conditional Multi-Agent Orchestration, Subagent Type Encoding
- **Technical Patterns** (1): Documentation Organization

---

### Future Enhancements

**Planned**:
- Pattern search tool (keyword → relevant patterns)
- Pattern usage analytics (which patterns used most)
- Pattern templates for specific domains (testing, UI, backend)
- Pattern validation checklist automation
- Pattern cross-reference graph visualization

**Scalability Target**: Support 20+ patterns without degradation

---

## Related Documentation

- **Memory Bank Architecture**: `docs/architecture/memory-bank.md`
- **Session Management**: `docs/workflows/session-management.md`
- **Pattern Template**: `.claude/templates/pattern-template.md`
- **Pattern Catalog Index**: `memory-bank/systemPatterns.md`
- **Pattern Catalog**: `memory-bank/patterns/`

---

## Quick Reference

### Pattern Naming
- ✅ lowercase-with-hyphens.md
- ❌ CamelCase.md, snake_case.md

### Pattern Categories
- **Workflow**: Task orchestration, session management
- **Architectural**: System design, agent coordination
- **Technical**: Implementation specifics, tooling

### Minimum Pattern Content
1. Context (when/where)
2. Problem (what solves)
3. Solution (how works)
4. Benefits (why use)
5. Trade-offs (when NOT)
6. Examples (file:line)
7. Reusability (3+ scenarios)

### Pattern Lifecycle
1. Recognize (3+ uses)
2. Create (from template)
3. Document (fill sections)
4. Index (add to master)
5. Cross-reference (related patterns)
6. Commit (atomic git commit)

---

**Version**: 2.0 (Pattern Catalog Structure)
**Last Updated**: 2025-11-06
**Status**: Active (Pattern Management Workflow Complete)
