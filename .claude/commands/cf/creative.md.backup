---
description: "Multi-perspective creative problem-solving for high-complexity challenges"
allowed-tools: ['Read', 'Edit', 'Task']
argument-hint: "[task-id|description]"
---

# Command: /cf:creative

## Usage

```bash
/cf:creative [task-id|description]
```

## Parameters

- `[task-id]`: **Optional** - Existing task ID from tasks.md (e.g., TASK-001)
- `[description]`: **Optional** - Free-form problem description for exploration

**Note**: At least one parameter required.

---

## Purpose

Enable structured creative exploration for complex, ambiguous challenges (Level 3-4) requiring multi-perspective problem analysis before implementation. Use when traditional planning assumes too much clarity about the solution approach.

**When to Use**:
- Complex problems (Level 3-4) without obvious solutions
- Ambiguous or open-ended requirements needing exploration
- Multiple valid architectural approaches requiring systematic evaluation
- Novel challenges outside established patterns
- Significant trade-offs needing structured analysis
- High uncertainty in implementation approach

**When NOT to Use**:
- Well-defined problems with clear solutions → use `/cf:plan` directly
- Simple tasks (Level 1-2) with established patterns → use `/cf:code`
- Time-sensitive situations requiring immediate action
- Problems already explored in previous sessions → reference existing patterns

**Philosophy**: Some problems need exploration before planning. Creative sessions provide structured multi-perspective analysis to reduce risk and improve decision confidence.

---

## Process Overview: 3-Phase Creative Session

**Total Duration**: 18-28 minutes
**Always Interactive**: Validation gates at each phase transition

```mermaid
graph LR
    START[Input:<br/>Task or Description] --> LOAD[Load Context<br/>Memory Bank]
    LOAD --> P1[Phase 1<br/>Problem Definition<br/>5-8 min]
    P1 --> V1{Validate<br/>Complete?}
    V1 -->|Refine| P1
    V1 -->|Yes| P2[Phase 2<br/>Multi-Perspective<br/>8-12 min]
    P2 --> V2{Validate<br/>Comprehensive?}
    V2 -->|Refine| P2
    V2 -->|Yes| P3[Phase 3<br/>Synthesis<br/>5-8 min]
    P3 --> V3{Validate<br/>Actionable?}
    V3 -->|Refine| P3
    V3 -->|Yes| UPDATE[Update Memory Bank]
    UPDATE --> OUT[Specification<br/>+ Patterns]

    style P1 fill:#e1f5fe
    style P2 fill:#f3e5f5
    style P3 fill:#e8f5e9
    style OUT fill:#fff9c4
```

---

## Implementation

### Step 1: Load Context

**Load Memory Bank Files** (Read tool - parallel when possible):
```
memory-bank/projectbrief.md
memory-bank/activeContext.md
memory-bank/systemPatterns.md
memory-bank/tasks.md
memory-bank/productContext.md
```

**If task-id provided**:
- Extract task details from tasks.md (description, complexity, prerequisites, acceptance criteria)
- Use as problem statement seed for creative session

**If description provided**:
- Use description as problem statement directly
- Search memory bank for related context (Grep for keywords)

**Context Synthesis**:
- What is the core problem?
- What makes this complex/novel?
- What constraints apply from projectbrief.md?
- What success looks like?

---

### Step 2: Invoke Facilitator Agent

**Agent**: facilitator (`.claude/agents/workflow/facilitator.md`)

**Context Passed to Facilitator**:
```markdown
## Creative Session Request

**Mode**: Multi-Perspective Creative Exploration
**Process**: 3-Phase Interactive (Problem Definition → Multi-Perspective Analysis → Synthesis)

### Input
[Task ID: TASK-XXX or Description: "..."]

### Problem Statement
[Extracted from task or provided description]

### Memory Bank Context
**Project Constraints**: [From projectbrief.md]
**Existing Patterns**: [Relevant patterns from systemPatterns.md]
**Current Focus**: [From activeContext.md]

### Session Goals
1. Generate implementation-ready specification through multi-perspective analysis
2. Extract reusable patterns for systemPatterns.md
3. Document decision rationale for future reference
```

---

### Step 3: Facilitator Orchestrates 3-Phase Process

#### Phase 1: Problem Definition (5-8 minutes)

**Facilitator Goal**: Deeply understand the problem before exploring solutions

**Interactive Questions**:
```markdown
🔍 PHASE 1: PROBLEM DEFINITION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Let's ensure we fully understand the problem.

## Core Problem
- What is the fundamental challenge or need?
- What happens if we solve this incorrectly?
- Are there non-obvious requirements to consider?

## Constraints
- **Technical**: Technology, architecture, integration limits?
- **Business**: User experience, performance, compliance requirements?
- **Resource**: Time, complexity, skill constraints?

## Success Criteria
- How will we know we've solved this well?
- What are the must-have vs nice-to-have outcomes?
- What edge cases must we handle?

---
Please share your thoughts. We'll refine together.
```

**User Provides Responses**

**Facilitator Synthesizes**:
```markdown
## Problem Understanding (Refined)

**Core Problem**: [Synthesized statement]

**Requirements**:
- Must have: [Critical requirements]
- Should have: [Important requirements]
- Nice to have: [Enhancements]

**Constraints**:
- Technical: [Technology/architecture/integration constraints]
- Business: [UX/performance/compliance needs]
- Resource: [Time/complexity/skill limits]

**Success Criteria**:
✓ [Measurable criterion 1]
✓ [Measurable criterion 2]
✓ [Measurable criterion 3]

**Known Unknowns**: [What needs research]
**Key Assumptions**: [What we're assuming]

---
**Validation**: Does this capture the problem accurately? (yes/refine)
```

**User Validates** → Proceed to Phase 2 or refine

---

#### Phase 2: Multi-Perspective Analysis (8-12 minutes)

**Facilitator Goal**: Generate 3 distinct perspectives, identify convergences and tensions

**Perspectives Generated**:

1. **Architect Perspective**
   - Technical approach and component design
   - Integration patterns and architecture considerations
   - Implementation complexity and risks

2. **Product Perspective**
   - User needs and experience requirements
   - Feature priorities and acceptance criteria
   - Edge cases from user journey

3. **Tech Stack Perspective** (if team configured, otherwise generic patterns)
   - Stack-specific patterns and optimizations
   - Framework best practices
   - Performance characteristics

**Output Format**:
```markdown
🎨 PHASE 2: MULTI-PERSPECTIVE ANALYSIS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## ARCHITECT Perspective

**Technical Approach**:
[How to solve this technically]

**Components Needed**:
- Component 1: [Purpose and responsibility]
- Component 2: [Purpose and responsibility]

**Integration Points**:
[How this connects to existing system]

**Trade-offs**:
✓ Pros: [Advantages of this approach]
⚠️ Cons: [Limitations to consider]

**Risk Assessment**: [Low/Medium/High with explanation]

---

## PRODUCT Perspective

**User Needs Addressed**:
[What user problems this solves]

**UX Flow**:
[How users interact with this]

**Acceptance Criteria**:
- [Criterion 1]
- [Criterion 2]

**Edge Cases**:
- [Edge case 1 and handling]
- [Edge case 2 and handling]

**Trade-offs**:
✓ Pros: [User benefits]
⚠️ Cons: [User experience limitations]

---

## TECH STACK Perspective

**Stack-Specific Patterns**:
[Recommended patterns for current tech stack]

**Framework Integration**:
[How to leverage framework capabilities]

**Performance Characteristics**:
[Expected performance profile]

**Trade-offs**:
✓ Pros: [Stack advantages]
⚠️ Cons: [Stack limitations]

---

## Cross-Perspective Analysis

**Convergent Insights** (where perspectives agree):
- [Agreement 1]
- [Agreement 2]

**Productive Tensions** (where perspectives disagree):
- [Tension 1]: Architect suggests X, Product needs Y
- [Tension 2]: Performance vs simplicity trade-off

**Critical Questions**:
- [Question raised by multiple perspectives]

---
**Validation**: Do these perspectives address your concerns? (yes/refine)
```

**User Validates** → Proceed to Phase 3 or refine

---

#### Phase 3: Synthesis (5-8 minutes)

**Facilitator Goal**: Integrate insights, resolve tensions, produce actionable specification

**Output Format**:
```markdown
🧩 PHASE 3: SYNTHESIS
━━━━━━━━━━━━━━━━━━━

## Recommended Approach

**Solution Name**: [Descriptive name for the approach]

**Rationale**:
[Why this approach addresses the problem best, integrating insights from all perspectives]

**How It Resolves Tensions**:
- [Tension 1]: Resolved by [solution aspect]
- [Tension 2]: Resolved by [solution aspect]

---

## Implementation Specification

### Component Breakdown
1. **Component A**: [Purpose and responsibilities]
2. **Component B**: [Purpose and responsibilities]
3. **Component C**: [Purpose and responsibilities]

### Implementation Phases
**Phase 1**: [What to build first]
**Phase 2**: [What to build second]
**Phase 3**: [What to build third]

### Data Flow
```
[Entry Point] → [Processing] → [State Change] → [Output]
```

### Testing Strategy
- **Unit Tests**: [Component-level tests]
- **Integration Tests**: [Cross-component tests]
- **Edge Case Tests**: [Specific edge case validation]

---

## Patterns Extracted

### Pattern: [Pattern Name]

**Context**: When [situation where pattern applies]

**Problem**: [What problem it solves]

**Solution**: [How the pattern works]

**Benefits**: [What you gain]

**Trade-offs**: [What you accept]

**Reusability**: [Where else this could apply - must be 3+ scenarios]

---

[Additional patterns if identified]

---

## Decision Record

**Decision**: Use [selected approach]

**Alternatives Considered**:
1. [Alternative A]: Rejected because [reason]
2. [Alternative B]: Rejected because [reason]

**Key Trade-offs Accepted**:
- [Trade-off 1 and why it's acceptable]
- [Trade-off 2 and why it's acceptable]

**Assumptions to Validate**:
- [Assumption 1 to test during implementation]
- [Assumption 2 to test during implementation]

---
**Validation**: Is this specification actionable for implementation? (yes/refine)
```

**User Validates** → Update memory bank and complete

---

### Step 4: Update Memory Bank

**Step 4a: Create Specification Document (for Level 3-4 tasks)**

**If task complexity is Level 3-4**, create comprehensive specification document:

1. **Read template**: `.claude/templates/workflow/creative-spec-template.md`
2. **Create spec document**: `memory-bank/specs/TASK-[ID]-[slug]-spec.md` (Write tool)
3. **Fill template** with Phase 1-3 outputs:
   - Problem Definition (from Phase 1 synthesis)
   - Multi-Perspective Analysis (from Phase 2 full output)
   - Recommended Approach & Implementation Spec (from Phase 3 synthesis)
   - Patterns Extracted (from Phase 3)
   - Decision Record (from Phase 3)

**File naming convention**:
- Format: `TASK-[ID]-[slug]-spec.md`
- Slug: lowercase, hyphens, max 4-5 words from task name
- Example: `TASK-002-mode-loading-spec.md`

**When to create**:
- ✅ Task complexity is Level 3 or Level 4
- ✅ Creative session completed all 3 phases
- ❌ Skip for Level 1-2 tasks (summary in activeContext.md sufficient)

**Directory structure**:
- Ensure `memory-bank/specs/` directory exists (create if needed)
- Spec documents are part of project memory, version-controlled

---

**Step 4b: Update activeContext.md** (Edit tool):
```markdown
### [YYYY-MM-DD HH:MM] - Creative Session Complete: [Task/Topic]

**Session Type**: Multi-perspective creative exploration
**Duration**: [X] minutes
**Perspectives**: Architect, Product, Tech Stack

**Problem Explored**: [One-line problem statement]

**Solution Designed**: [Selected approach name]

**Key Decisions**:
1. [Decision 1] - [Rationale]
2. [Decision 2] - [Rationale]

**Patterns Created**: [N] new patterns added to systemPatterns.md
- [Pattern 1 name]
- [Pattern 2 name]

**Specification**: memory-bank/specs/TASK-[ID]-[slug]-spec.md (for Level 3-4 tasks)

**Next Action**: [/cf:plan TASK-ID or /cf:code TASK-ID]

**Files Updated**:
- systemPatterns.md: [N] patterns added
- tasks.md: Task notes updated
- memory-bank/specs/TASK-[ID]-spec.md: Full specification created (if Level 3-4)
```

**Update systemPatterns.md** (Edit tool - if patterns extracted):
```markdown
### [Pattern Name]

**Category**: [Architectural/Design/Code/Testing/etc]
**Added**: [YYYY-MM-DD]
**Source**: Creative session for [task/topic]
**Status**: Active (in development)

**Context**: When to use this pattern
- [Situation 1]
- [Situation 2]

**Problem**: What problem this solves
[Description of the challenge]

**Solution**: How the pattern works
[Pattern implementation details]

**Benefits**:
- ✅ [Benefit 1]
- ✅ [Benefit 2]

**Trade-offs**:
- ⚠️ [Trade-off 1]
- ⚠️ [Trade-off 2]

**Examples in Codebase**: Will be added in [TASK-ID] implementation

**Related Patterns**: [Connection to existing patterns]

**Testing Approach**: [How to test this pattern]

**When NOT to Use**:
- ❌ [Scenario 1]
- ❌ [Scenario 2]
```

**Step 4c: Update tasks.md** (Edit tool - if task exists):
```markdown
**Creative Session**: ✅ Complete [YYYY-MM-DD]
- Multi-perspective exploration conducted
- Implementation approach validated
- Patterns extracted: [pattern names]
- Ready for: /cf:plan [task-id] or /cf:code [task-id]

**Specification**: memory-bank/specs/TASK-[ID]-[slug]-spec.md (for Level 3-4 tasks)

**Implementation Notes**:
- [Note 1 from synthesis]
- [Note 2 from synthesis]

**Edge Cases to Handle**:
- [Edge case 1]
- [Edge case 2]

**Patterns to Apply**: [Pattern names from systemPatterns.md]
```

---

### Step 5: Output Summary

```markdown
✅ CREATIVE SESSION COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

**Topic**: [Task/Problem name]
**Duration**: [X] minutes

## Outcomes

✅ **Problem Understood**: [One-line summary]

✅ **Perspectives Explored**: 3 (Architect, Product, Tech Stack)
- Convergent insights: [N]
- Productive tensions: [N] (all resolved)

✅ **Solution Designed**: [Approach name]
- **Rationale**: [Top 3 reasons for selection]
- **Components**: [N] components identified
- **Testing**: Strategy defined

✅ **Patterns Documented**: [N] new patterns added to systemPatterns.md
- [Pattern 1 name]
- [Pattern 2 name]

✅ **Implementation Ready**: Specification is actionable

## Memory Bank Updates

✓ activeContext.md - Creative session documented
✓ systemPatterns.md - [N] patterns added
✓ tasks.md - Task notes updated with approach
✓ memory-bank/specs/TASK-[ID]-spec.md - Full specification created (Level 3-4 only)

## Next Steps

**Recommended**: /cf:plan [task-id] → Create detailed implementation plan
**Alternative**: /cf:code [task-id] → Implement directly if simple enough

Review specification in:
- memory-bank/specs/TASK-[ID]-[slug]-spec.md (full specification for Level 3-4)
- memory-bank/activeContext.md (session summary)
- memory-bank/systemPatterns.md (new patterns)
- memory-bank/tasks.md (task notes)
```

---

## Error Handling

### Memory Bank Not Initialized
```
❌ Memory bank not found

The memory-bank/ directory does not exist.

Initialize CCFlow project: /cf:init

This creates the required memory bank structure for creative sessions.
```

### Missing Task ID
```
❌ Task [task-id] not found in tasks.md

Checked: memory-bank/tasks.md

Create task first: /cf:feature [description]

Or provide a description directly: /cf:creative "your problem description"
```

### No Input Provided
```
❌ No input provided

Usage: /cf:creative [task-id|description]

Examples:
  /cf:creative TASK-003
  /cf:creative "design real-time collaboration system"
```

### Low Complexity Task Warning
```
⚠️ Task [task-id] is Level [1-2]

Creative sessions are designed for complex problems (Level 3-4).

For Level 1-2 tasks, consider:
  /cf:plan [task-id] → Standard planning
  /cf:code [task-id] → Direct implementation

Continue with creative session anyway? [yes/no]
```

### Memory Bank File Missing
```
⚠️ Cannot read memory-bank/[file]

File is missing or unreadable.

Fix: Ensure file exists or run /cf:checkpoint to regenerate memory bank structure.

Continuing with available context...
```

---

## Examples

### Example 1: Task-Based Creative Session

```bash
/cf:creative TASK-005
```

**Scenario**: TASK-005 is "Implement real-time collaboration" (Level 3)

**Output**:
```
[Loads TASK-005 context from tasks.md]

🔍 PHASE 1: PROBLEM DEFINITION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Problem: Enable multiple users to edit shared documents simultaneously
...
[Interactive questions, user responds]
...
✓ Problem understanding validated

🎨 PHASE 2: MULTI-PERSPECTIVE ANALYSIS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ARCHITECT: WebSocket layer + operational transformation
PRODUCT: User presence indicators, conflict highlighting
TECH STACK: Socket.io + Yjs CRDT library
...
[Convergences: WebSocket necessary, conflict resolution critical]
[Tensions: OT vs CRDT approach]
...
✓ Perspectives validated

🧩 PHASE 3: SYNTHESIS
━━━━━━━━━━━━━━━━━━━

Recommended: Hybrid CRDT (Yjs) + custom conflict UI
Rationale: Reduces implementation complexity while addressing UX needs
...
[Detailed specification]
...
Pattern: "Real-Time Collaboration Pattern" extracted
✓ Specification validated

✅ CREATIVE SESSION COMPLETE
Duration: 23 minutes
Patterns: 1 added to systemPatterns.md
Next: /cf:plan TASK-005
```

### Example 2: Description-Based Creative Session

```bash
/cf:creative "We need to handle file uploads but unsure if S3, local storage, or CDN is best"
```

**Output**:
```
[No task ID, uses description as problem seed]

🔍 PHASE 1: PROBLEM DEFINITION
...
[Explores requirements: scale, security, budget, performance]
...

🎨 PHASE 2: MULTI-PERSPECTIVE ANALYSIS
...
ARCHITECT: S3 + CloudFront hybrid minimizes server load
PRODUCT: Direct upload avoids timeout issues
TECH STACK: Presigned URLs for security
...

🧩 PHASE 3: SYNTHESIS
...
Recommended: S3 direct upload + CloudFront for frequently accessed
Pattern: "Hybrid Storage Pattern" extracted
...

Next: Create task via /cf:feature, then /cf:plan for implementation
```

---

## Integration with CCFlow Workflow

**Typical Flow**:
```mermaid
graph LR
    F[/cf:feature] --> A[Assessor]
    A -->|Level 3-4<br/>High Ambiguity| CR[/cf:creative]
    CR --> SP[Specification<br/>+ Patterns]
    SP --> P[/cf:plan]
    P --> C[/cf:code]

    A -->|Level 2-3<br/>Clear Scope| P

    style CR fill:#fff3e0
    style SP fill:#fff9c4
    style P fill:#f3e5f5
    style C fill:#e8f5e9
```

**When Assessor Might Recommend** (Future Enhancement):
- Ambiguity indicators in task description
- Multiple valid approaches detected
- Novel challenges identified
- User explicitly requests exploration

---

## Notes

- **Always Interactive**: Validation gates require user participation - cannot be automated
- **Time Investment**: 18-28 minutes upfront reduces hours of implementation rework
- **Single Facilitator**: One agent maintains conversational flow across all 3 phases
- **Pattern Accumulation**: Each session can contribute reusable patterns to systemPatterns.md
- **Decision Documentation**: Records why approach chosen (prevents future confusion)
- **MVP Scope**: Phase 1 implementation - simplified from full 4-phase specification
- **Manual Invocation Only**: Auto-routing by assessor deferred to Phase 2

**Deferred to Future Phases**:
- Assessor auto-routing based on ambiguity detection
- 4th phase for detailed design refinement
- Additional perspectives beyond core 3
- Output format flags (report mode vs spec mode)
- Sequential MCP integration for structured reasoning

---

## Related Commands

- `/cf:feature` - Create tasks that may need creative exploration
- `/cf:plan` - Standard planning, follows creative sessions
- `/cf:facilitate` - Interactive refinement and validation
- `/cf:code` - Implementation after creative design complete
- `/cf:checkpoint` - Save creative session outputs

---

**Version**: 1.0 (MVP - 3 Phase)
**Last Updated**: 2025-10-28
