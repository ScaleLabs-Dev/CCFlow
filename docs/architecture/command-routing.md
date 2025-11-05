# Command Routing Architecture

**Version**: 1.0
**Last Updated**: 2025-10-28
**Status**: Active (Phase 1 - MVP)

---

## Overview

CCFlow's command routing system intelligently directs work through the appropriate workflow based on task complexity and characteristics. This document defines how commands interact, how routing decisions are made, and where `/cf:creative` fits in the overall architecture.

**Core Principle**: Match workflow complexity to problem complexity - simple tasks get simple workflows, complex tasks get deep exploration.

---

## Routing Architecture

```mermaid
graph TD
    ENTRY[Entry Point<br/>/cf:feature] --> ASSESS[Assessor Agent<br/>Complexity Analysis]

    ASSESS --> L1{Level 1<br/>Simple}
    ASSESS --> L2{Level 2<br/>Moderate}
    ASSESS --> L3{Level 3<br/>Complex}
    ASSESS --> L4{Level 4<br/>Architectural}

    L1 --> CODE1[/cf:code<br/>Direct Implementation]

    L2 --> PLAN2[/cf:plan<br/>Standard Planning]
    PLAN2 --> CODE2[/cf:code]

    L3 --> DEC3{Ambiguity?}
    DEC3 -->|Low| PLAN3[/cf:plan<br/>Standard Planning]
    DEC3 -->|High| INT3[/cf:plan --interactive<br/>Facilitator Guided]
    PLAN3 --> CODE3[/cf:code]
    INT3 --> CODE3

    L4 --> PLAN4[/cf:plan<br/>Break Down]
    PLAN4 --> CREA4[/cf:creative<br/>Per Sub-Task]
    CREA4 --> SUB[Sub-Tasks Created]
    SUB --> L2

    style ENTRY fill:#e1f5fe
    style ASSESS fill:#fff3e0
    style CREA4 fill:#fff9c4
    style CODE1 fill:#e8f5e9
    style CODE2 fill:#e8f5e9
    style CODE3 fill:#e8f5e9
```

---

## Entry Points

### Primary Entry: `/cf:feature`

**Purpose**: Universal entry point for all new work

**Process**:
1. User provides feature description
2. Product agent creates specification
3. Assessor analyzes complexity
4. **Automatic routing** to appropriate workflow

**Example**:
```bash
/cf:feature "Add user authentication with social login"
```

**Routing Decision**: Assessor determines Level 2-3 → routes to `/cf:plan`

### Direct Entry: Manual Command Selection

**When**: User knows the appropriate workflow

**Commands**:
- `/cf:code TASK-ID` - Direct implementation (Level 1)
- `/cf:plan TASK-ID` - Standard planning (Level 2-3)
- `/cf:creative TASK-ID` - Creative exploration (Level 3-4 with ambiguity)

**Example**:
```bash
# User knows task is complex and ambiguous
/cf:creative TASK-042
```

---

## Complexity Levels

### Level 1: Quick Fix

**Criteria**:
- 1-2 files modified
- Clear scope, known pattern
- <30 minutes implementation time
- Single component affected

**Route**: Direct to `/cf:code`

**Example Tasks**:
- Fix typo in error message
- Update validation regex
- Add logging to existing function

**Rationale**: Planning overhead exceeds implementation time

---

### Level 2: Simple Enhancement

**Criteria**:
- 3-5 files modified
- Established patterns apply
- 30 minutes - 2 hours implementation
- One module affected

**Route**: `/cf:plan` → `/cf:code`

**Example Tasks**:
- Add new API endpoint following existing pattern
- Create new UI component with similar structure
- Implement standard CRUD operations

**Rationale**: Planning provides structure without heavy exploration

---

### Level 3: Intermediate Feature

**Criteria**:
- 5-10 files modified
- Some ambiguity in approach
- Cross-module changes
- 2-8 hours implementation

**Route**:
- **Low ambiguity**: `/cf:plan` → `/cf:code`
- **High ambiguity**: `/cf:plan --interactive` or `/cf:creative` → `/cf:plan` → `/cf:code`

**Example Tasks**:
- Integrate third-party API (novel to project)
- Refactor authentication flow
- Add real-time features to existing system

**Rationale**: Complexity warrants exploration when approach unclear

**Creative Session Triggers**:
- Multiple valid approaches identified
- Novel integration patterns
- Significant architectural trade-offs
- Team unfamiliar with solution domain

---

### Level 4: Complex System

**Criteria**:
- 10+ files modified
- High uncertainty in approach
- Architectural impact
- Multi-day implementation

**Route**: `/cf:plan` → Break into sub-tasks → `/cf:creative` per complex sub-task → `/cf:code`

**Example Tasks**:
- Migrate from monolith to microservices
- Implement complete real-time collaboration system
- Add multi-tenancy to existing application

**Rationale**: Too large for single creative session, requires decomposition first

**Workflow**:
1. `/cf:plan` breaks down into Level 2-3 sub-tasks
2. Each complex sub-task gets `/cf:creative` if needed
3. Sub-tasks implemented via `/cf:code`

---

## Routing Decision Factors

### Assessor Analysis Inputs

When routing, Assessor considers:

1. **Scope Metrics**:
   - Files affected (from grep/glob analysis)
   - Modules impacted (directory breadth)
   - Integration points (external dependencies)

2. **Clarity Indicators**:
   - Keywords: "unsure", "maybe", "which approach", "unclear"
   - Pattern matches: Similar to existing implementations?
   - Novelty: First time for this type of work?

3. **Risk Signals**:
   - Architectural changes (CLAUDE.md modifications)
   - Breaking changes (API contracts)
   - Data migrations (schema changes)

4. **Context Patterns**:
   - Similar tasks in tasks.md
   - Existing patterns in systemPatterns.md
   - Recent similar work in activeContext.md

### Ambiguity Detection

**Low Ambiguity** (Standard Planning):
- Clear technical approach
- Existing patterns apply
- Minimal trade-offs
- Proven solutions available

**High Ambiguity** (Creative Exploration):
- Multiple valid approaches
- Novel challenges
- Significant trade-offs
- Pattern extraction potential

**Indicators**:
```yaml
low_ambiguity:
  keywords: ["like existing", "follow pattern", "similar to"]
  patterns_found: true
  single_approach: true

high_ambiguity:
  keywords: ["unsure", "explore", "which approach", "trade-offs"]
  patterns_found: false
  multiple_approaches: true
  novel_integration: true
```

---

## Creative Session Integration

### When Creative Sessions Are Invoked

#### Automatic Routing (Future Phase 2)

Assessor will automatically suggest creative sessions when:

1. **Ambiguity Score High**:
   - Multiple approach keywords detected
   - No matching patterns in systemPatterns.md
   - Novel integration or architecture

2. **Complexity + Uncertainty**:
   - Level 3-4 complexity
   - High uncertainty in description
   - Significant trade-offs implied

3. **User Indication**:
   - Explicit exploration keywords
   - Questions in description
   - Alternative approaches mentioned

**Example**:
```bash
/cf:feature "Add real-time collaboration but unsure if WebSocket, polling, or SSE is best"

# Assessor detects: Level 3, high ambiguity, multiple approaches
# Routes to: /cf:creative → /cf:plan → /cf:code
```

#### Manual Invocation (Current Phase 1)

User decides when creative exploration needed:

```bash
# After receiving task from /cf:feature
/cf:creative TASK-042

# Or directly with description
/cf:creative "design conflict resolution for distributed system"
```

### Creative Session Output Routing

After creative session completes:

```mermaid
graph LR
    CREA[Creative Session<br/>Complete] --> SPEC[Specification<br/>Generated]
    SPEC --> DEC{Specification<br/>Complexity?}
    DEC -->|Simple| CODE[/cf:code<br/>Direct Impl]
    DEC -->|Complex| PLAN[/cf:plan<br/>Breakdown]
    PLAN --> CODE2[/cf:code]

    style CREA fill:#fff9c4
    style SPEC fill:#f3e5f5
    style CODE fill:#e8f5e9
    style CODE2 fill:#e8f5e9
```

**Decision Factors**:
- Specification detail level
- Component count
- Implementation phases defined
- Sub-task potential

**Examples**:

1. **Simple Spec** → Direct to code:
```markdown
Creative Session Output:
- Single component approach
- Clear implementation steps
- Minimal dependencies

Next: /cf:code TASK-042
```

2. **Complex Spec** → Plan first:
```markdown
Creative Session Output:
- 5 components identified
- 3 implementation phases
- Cross-cutting concerns

Next: /cf:plan TASK-042 → Creates TASK-042-1 through TASK-042-5
```

---

## Command Interaction Patterns

### Sequential Flow (Most Common)

```
/cf:feature → /cf:plan → /cf:code → /cf:review → /cf:checkpoint → /cf:git
```

**When**: Standard Level 2-3 tasks with clear approach

### Creative Flow (High Ambiguity)

```
/cf:feature → /cf:creative → /cf:plan → /cf:code → /cf:review → /cf:checkpoint → /cf:git
```

**When**: Level 3-4 with multiple approaches or novel challenges

### Direct Flow (Simple Tasks)

```
/cf:feature → /cf:code → /cf:review → /cf:checkpoint → /cf:git
```

**When**: Level 1 tasks with obvious solutions

### Hierarchical Flow (Complex Systems)

```
/cf:feature → /cf:plan → [TASK-1, TASK-2, TASK-3]
                               ↓
                         /cf:creative TASK-2 → /cf:plan TASK-2 → [TASK-2-1, TASK-2-2]
                                                                            ↓
                                                                      /cf:code TASK-2-1
```

**When**: Level 4 requiring decomposition before exploration

---

## Routing Rules

### Rule 1: Scope-Based Routing

```yaml
scope_routing:
  files_1_2: /cf:code
  files_3_5: /cf:plan
  files_5_10: /cf:plan [--interactive if ambiguous]
  files_10_plus: /cf:plan → decompose → [/cf:creative per complex sub-task]
```

### Rule 2: Ambiguity-Based Routing

```yaml
ambiguity_routing:
  clear_approach: /cf:plan
  some_uncertainty: /cf:plan --interactive
  high_uncertainty: /cf:creative
  multiple_approaches: /cf:creative
```

### Rule 3: Novelty-Based Routing

```yaml
novelty_routing:
  established_pattern: /cf:plan
  first_time_similar: /cf:plan --interactive
  truly_novel: /cf:creative
  architectural_impact: /cf:creative
```

### Rule 4: Pattern Availability

```yaml
pattern_routing:
  pattern_exists: /cf:plan (reference systemPatterns.md)
  no_pattern: /cf:creative (extract new patterns)
  pattern_variant: /cf:plan --interactive
```

---

## Anti-Patterns and Corrections

### Anti-Pattern 1: Over-Planning Simple Tasks

**Problem**: Using `/cf:creative` for Level 1-2 tasks

**Detection**:
```bash
/cf:creative "Fix typo in error message"

# Warning: Task is Level 1
# Creative sessions designed for Level 3-4
# Suggestion: /cf:code directly
```

**Correction**: Route to `/cf:code` with warning

### Anti-Pattern 2: Under-Planning Complex Tasks

**Problem**: Using `/cf:code` directly for Level 3-4 tasks

**Detection**:
```bash
/cf:code TASK-042

# Assessor: Task is Level 3 with high ambiguity
# Recommendation: /cf:creative or /cf:plan --interactive first
```

**Correction**: Suggest appropriate planning workflow

### Anti-Pattern 3: Creative Session for Established Patterns

**Problem**: Exploring solutions that exist in systemPatterns.md

**Detection**:
```bash
/cf:creative "Add authentication"

# Found pattern: "OAuth Authentication Pattern" in systemPatterns.md
# Recommendation: /cf:plan (reference existing pattern)
```

**Correction**: Point to existing pattern, skip creative session

### Anti-Pattern 4: Planning Before Feature Creation

**Problem**: Running `/cf:plan` or `/cf:creative` without task in tasks.md

**Detection**:
```bash
/cf:plan "some description"

# Error: No task found
# Fix: /cf:feature "some description" first
```

**Correction**: Require `/cf:feature` to create task before planning

---

## Future Enhancements (Phase 2+)

### Intelligent Auto-Routing

**Planned**: Assessor automatically invokes creative sessions

**Criteria**:
```yaml
auto_creative_triggers:
  ambiguity_score: > 0.7
  novel_integration: true
  multiple_approaches: >= 2
  no_matching_pattern: true
  user_keywords: ["unsure", "explore", "which", "trade-off"]
```

**Flow**:
```
/cf:feature "Add feature X but unsure about approach Y vs Z"
    ↓
Assessor detects: Level 3, ambiguity 0.8, 2 approaches, no pattern
    ↓
Auto-route: /cf:creative TASK-XXX
    ↓
User participates in creative session
    ↓
Continue to /cf:plan or /cf:code
```

### Context-Aware Routing

**Planned**: Use memory bank context for routing decisions

**Enhancements**:
- Recent similar tasks influence routing
- Learning from past creative sessions
- Pattern reuse recommendations
- Team skill level consideration

### Dynamic Complexity Adjustment

**Planned**: Adjust routing based on outcomes

**Learning Loop**:
```
Task estimated Level 2 → Routed to /cf:plan
    ↓
Implementation reveals Level 3 complexity
    ↓
Update: Adjust complexity assessment for similar tasks
    ↓
Future similar tasks: Route to /cf:creative or /cf:plan --interactive
```

---

## Routing Metrics

### Success Indicators

**Proper Routing**:
- Tasks complete without significant rework
- Planning overhead proportional to complexity
- Patterns extracted from appropriate tasks
- No under-planning (missing analysis)
- No over-planning (excessive overhead)

**Routing Efficiency**:
```yaml
metrics:
  level_1_direct_to_code: > 90%
  level_2_plan_then_code: > 80%
  level_3_creative_when_novel: > 70%
  level_4_decomposed: > 95%
```

### Failure Indicators

**Poor Routing**:
- Implementation blocked due to insufficient planning
- Creative sessions for simple tasks (wasted time)
- Missing creative sessions for novel challenges (poor decisions)
- Rework due to wrong approach selected

**Correction Actions**:
- Review routing decision factors
- Update complexity assessment criteria
- Improve ambiguity detection
- Document learned patterns

---

## Related Documentation

- **Command Reference**: `docs/commands/README.md`
- **Creative Sessions**: `docs/workflows/creative-sessions.md`
- **Agent Organization**: `docs/architecture/agent-organization.md`
- **Assessor Agent**: `.claude/agents/workflow/assessor.md`
- **Facilitator Agent**: `.claude/agents/workflow/facilitator.md`

---

**Version**: 1.0 (MVP - Manual Routing)
**Last Updated**: 2025-10-28
**Status**: Active (Phase 1 implementation)
