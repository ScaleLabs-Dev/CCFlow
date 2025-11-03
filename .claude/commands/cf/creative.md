---
description: "Multi-perspective creative problem-solving for high-complexity challenges"
allowed-tools: ['Read', 'Edit', 'Task', 'Write']
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

**Command Orchestration Pattern**: Coordinate Facilitator agent (Mode 4: Creative Session) to generate multi-perspective analysis, synthesize results using creative-spec-template.md, and update memory bank.

Enable structured creative exploration for complex, ambiguous challenges (Level 3-4) requiring multi-perspective problem analysis before implementation.

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

**Pattern**: Command Orchestration Pattern (systemPatterns.md:409-582)

---

## Prerequisites

**Memory bank must be initialized**. Run `/cf:init` first if needed.

**For task-id parameter**: Task must exist in tasks.md (created via `/cf:feature` or `/cf:plan`).

---

## Process

### Step 1: Verify Prerequisites

**Check memory bank exists**:
```
If NOT EXISTS:
⚠️ Memory bank not initialized. Run: /cf:init
```

**If task-id provided, check task exists in tasks.md**:
```
If NOT FOUND:
❌ Task [task-id] not found in tasks.md

Available tasks:
- TASK-001: [name]
- TASK-002: [name]

Create new task with: /cf:feature [description]
```

---

### Step 2: Load Context

**ORCHESTRATION PATTERN**: Load memory bank context to provide to Facilitator agent

**Read memory bank files** (parallel when possible):
- `memory-bank/projectbrief.md` - Project scope and constraints
- `memory-bank/activeContext.md` - Current state
- `memory-bank/systemPatterns.md` - Existing patterns
- `memory-bank/tasks.md` - Task details (if task-id provided)
- `memory-bank/productContext.md` - User needs
- `CLAUDE.md` - Tech stack reference

**Extract problem context**:

**If task-id provided**:
- Task description and complexity
- Acceptance criteria
- Existing context/notes
- Related patterns

**If description provided**:
- Use description as problem statement
- Search memory bank for related context (Grep for keywords)

**Context Summary**:
- Core problem statement
- Why this is complex/novel
- Constraints from projectbrief.md
- Success criteria
- Relevant patterns from systemPatterns.md

---

### Step 3: Invoke Facilitator Agent (Creative Session)

**ORCHESTRATION PATTERN**: Invoke facilitator agent for creative session

```markdown
## Invoke Facilitator Agent (Mode 4: Creative Session)
Task(
  subagent_type="facilitator",
  description="Multi-Perspective Creative Exploration",
  prompt=`
    Conduct creative session for complex problem exploration.

    **Mode**: Mode 4 - Creative Session (3-phase interactive process)

    **Problem Context**:
    [Pass extracted context from Step 2]

    **Task**: [task-id or description]
    **Complexity**: Level [3-4]
    **Constraints**: [from projectbrief.md]
    **Tech Stack**: [from CLAUDE.md]
    **Existing Patterns**: [relevant patterns from systemPatterns.md]

    **Creative Session Phases**:
    1. Problem Definition (5-8 min) - Clarify core problem, requirements, constraints
    2. Multi-Perspective Analysis (8-12 min) - Architect, Product, Tech Stack perspectives
    3. Synthesis & Recommendations (5-8 min) - Integrate insights, recommend approach

    **Output Required**:
    - Problem definition with requirements and constraints
    - Multi-perspective analysis (Architect, Product, Tech Stack)
    - Cross-perspective synthesis (convergent insights, productive tensions)
    - Recommended approach with rationale
    - Implementation guidance with acceptance criteria
    - Next steps and open questions
    - Session metadata (duration, perspectives, interactive rounds)

    Facilitator: Conduct full 3-phase creative session with interactive validation gates.
    Generate ONLY questions at each phase. Do NOT provide analysis or synthesis.

    Command will synthesize final output using creative-spec-template.md.
  `
)
```

**Facilitator will**:
1. **Phase 1**: Ask questions to define problem, requirements, constraints, success criteria
2. **Phase 2**: Ask questions to explore Architect, Product, and Tech Stack perspectives
3. **Phase 3**: Ask questions to synthesize insights and validate recommendations
4. Return collected user responses and session metadata

**IMPORTANT**: Facilitator generates ONLY questions. Command synthesizes responses into specification.

---

### Step 4: Collect Facilitator Output

**Facilitator returns**:
- Problem definition (from Phase 1 responses)
- Perspective insights (from Phase 2 responses)
- Synthesis notes (from Phase 3 responses)
- Session metadata (duration, interactive rounds, perspectives explored)

**Command receives**:
- User responses to all facilitator questions
- Problem context and requirements
- Multi-perspective insights
- Trade-offs and decisions discussed

---

### Step 5: Synthesize Using Template

**ORCHESTRATION PATTERN**: Command synthesizes facilitator output using creative-spec-template.md

**Read template**:
```
.claude/templates/workflow/creative-spec-template.md
```

**Apply synthesis logic**:

**Section 1: Problem Definition**
- Context: [From Phase 1 - background and situation]
- Core Problem: [From Phase 1 - synthesized problem statement]
- Why This Matters: [User impact and business value]
- Requirements: [Must/Should/Nice to have from Phase 1]
- Constraints: [Technical/Business/Resource from Phase 1]
- Success Criteria: [Measurable criteria from Phase 1]

**Section 2: Multi-Perspective Analysis**

**ARCHITECT Perspective**:
- [Technical Analysis from Phase 2 Architect questions/responses]
- Component impact
- Data flow considerations
- Technical approaches (with pros/cons/complexity/risk)
- Architectural patterns to consider
- Technical risks and mitigation

**PRODUCT Perspective**:
- [User Impact from Phase 2 Product questions/responses]
- User needs analysis
- UX considerations
- Feature trade-offs
- Non-functional requirements
- Success metrics

**TECH STACK Perspective**:
- [Stack Compatibility from Phase 2 Tech Stack questions/responses]
- Technology options with maturity/community/learning curve
- Dependencies and versions
- Development environment impact
- Deployment considerations

**Section 3: Cross-Perspective Synthesis**

**Convergent Insights** (where perspectives agree):
- [Synthesize agreements from Phase 3]

**Productive Tensions** (where perspectives disagree):
- [Synthesize conflicts from Phase 3]

**Resolution Strategy**:
- [How to reconcile conflicts from Phase 3]

**Exploration Dimensions**:
- Feasibility: [Technical/Resource/Integration viability]
- Risk-Benefit: [Trade-off analysis]
- Alternative Angles: [What if we approached differently?]

**Section 4: Synthesis & Recommended Approach**

**Solution Name**: [From Phase 3]
**Rationale**: [Why this approach, with supporting evidence from perspectives]
**How It Resolves Tensions**: [From Phase 3]
**Why This Over Alternatives**: [Comparison from Phase 3]

**Section 5: Implementation Specification**

**Component Breakdown**: [From synthesis]
**Implementation Phases**: [From synthesis]
**Data Flow**: [From architectural perspective]
**Testing Strategy**: [Unit/Integration/E2E tests]

**Section 6: Patterns Extracted**

[Any new patterns to add to systemPatterns.md]

**Section 7: Decision Record**

**Decision**: [What was decided]
**Alternatives Considered**: [What else was considered, why rejected]
**Key Trade-offs Accepted**: [Trade-offs and rationale]
**Assumptions to Validate**: [What to test during implementation]

**Section 8: Next Steps**

**Immediate Actions**: [From Phase 3]
**Recommended Command Sequence**: [/cf:plan, /cf:code, /cf:review]
**Open Questions**: [Remaining unknowns]

**Section 9: Session Metadata**

**Facilitator**: facilitator (Mode 4: Creative Session)
**Perspectives Explored**: Architect, Product, Tech Stack
**Session Duration**: [From facilitator]
**Interactive Rounds**: [From facilitator]
**Pattern**: Creative Session Pattern (systemPatterns.md)

---

### Step 6: Create Specification Document

**ORCHESTRATION PATTERN**: Create specification document in memory-bank/specs/

**For Level 3-4 tasks**, create dedicated specification document:

**File path**: `memory-bank/specs/TASK-[ID]-[slug]-spec.md`

**Slug generation**:
- Extract key words from task name
- Convert to lowercase-with-hyphens
- Example: "Deferred Issues Workflow" → "deferred-issues-workflow"

**Write specification document** using synthesized content from Step 5:

```markdown
# Creative Session Specification: [Task Name]

**Task ID**: TASK-[ID]
**Complexity**: Level [3-4]
**Session Date**: [YYYY-MM-DD]
**Status**: Implementation Ready
**Facilitator**: facilitator (Mode 4: Creative Session)

[Full synthesized specification from Step 5]

---

**Template Version**: 1.1 (Command Orchestration Pattern)
**Template Purpose**: Multi-perspective creative session synthesis output
**Used By**: /cf:creative command for Level 3-4 complexity exploration
**Last Updated**: [YYYY-MM-DD]
```

---

### Step 7: Update Memory Bank

**ORCHESTRATION PATTERN**: Update memory bank files systematically

**Update tasks.md** (if task-id provided):

```markdown
### 🟢 TASK-[ID]: [Task Name] (Level [3-4])

**Status**: Active → Creative Session Complete
**Priority**: [P0/P1/P2]
**Complexity**: Level [3-4]
**Created**: [Original date]
**Creative Session**: [YYYY-MM-DD]

**Description**:
[Original description]

**Creative Exploration**: ✅ Complete (see spec document)
- **Specification**: memory-bank/specs/TASK-[ID]-[slug]-spec.md
- **Recommended Approach**: [Solution name from synthesis]
- **Session Duration**: [Duration]
- **Perspectives**: Architect, Product, Tech Stack

**Next Action**:
Use specification for detailed planning:
/cf:plan TASK-[ID] --interactive

OR proceed directly to implementation:
/cf:code TASK-[ID]

**Notes**:
Creative session complete [YYYY-MM-DD]
Specification document contains multi-perspective analysis and recommended approach
[Any additional context]
```

**Update activeContext.md**:

Add to **Recent Changes**:
```markdown
### [YYYY-MM-DD HH:MM] - Creative Session Complete: [Task Name]
**Facilitator**: facilitator (Mode 4: Creative Session)
**Task ID**: TASK-[ID]
**Specification**: memory-bank/specs/TASK-[ID]-[slug]-spec.md
**Duration**: [Duration]
**Perspectives**: Architect, Product, Tech Stack
**Recommended Approach**: [Solution name]
**Pattern Used**: Creative Session Pattern
**Next Action**: /cf:plan TASK-[ID] --interactive (or /cf:code TASK-[ID])
```

**Update systemPatterns.md** (if new patterns identified):

Add to **Active Patterns** section:
```markdown
### [New Pattern Name]

**Category**: [Type]
**Added**: YYYY-MM-DD (from TASK-[ID] creative session)

**Context**: [When this pattern applies]

**Problem**: [What it solves]

**Solution**: [How the pattern works]

[Example code or reference]

**Benefits**:
- ✅ [Benefit 1]

**Trade-offs**:
- ⚠️ [Trade-off 1]

**Source**: Creative session TASK-[ID] - see memory-bank/specs/TASK-[ID]-[slug]-spec.md

**Related Patterns**: [Connections to other patterns]
```

---

### Step 8: Output Summary

**Present specification summary to user**:

```markdown
🎨 CREATIVE SESSION COMPLETE

## Specification: [Task Name]

**Task**: TASK-[ID]
**Complexity**: Level [3-4]
**Duration**: [Duration]

---

### 🎯 PROBLEM DEFINITION

**Core Problem**: [Brief problem statement]

**Why This Matters**: [User impact and value]

**Constraints**:
- Technical: [Key technical constraints]
- Business: [Key business constraints]
- Resource: [Key resource constraints]

---

### 🏗️ MULTI-PERSPECTIVE ANALYSIS

**ARCHITECT**: [Key technical insights]

**PRODUCT**: [Key user/UX insights]

**TECH STACK**: [Key technology insights]

**Convergent Insights**: [Where perspectives agree]

**Productive Tensions**: [Where perspectives disagree - trade-offs revealed]

---

### 💡 RECOMMENDED APPROACH

**Solution**: [Solution name]

**Rationale**:
1. [Reason 1 with perspective support]
2. [Reason 2 with perspective support]
3. [Reason 3 with perspective support]

**Why This Over Alternatives**: [Brief comparison]

---

### 📋 IMPLEMENTATION GUIDANCE

**Acceptance Criteria**:
- Must Have: [Critical requirements]
- Should Have: [Important requirements]

**Implementation Phases**:
1. [Phase 1]: [What to build first]
2. [Phase 2]: [What to build second]
3. [Phase 3]: [What to build third]

**Testing Strategy**: [Unit/Integration/E2E approach]

---

### 🎯 DECISION RECORD

**Decision**: [What was decided]

**Alternatives Considered**:
1. [Alternative A]: [Why not chosen]
2. [Alternative B]: [Why not chosen]

**Key Trade-offs Accepted**: [Trade-offs and rationale]

---

### 📚 SPECIFICATION DOCUMENT

✓ **Created**: memory-bank/specs/TASK-[ID]-[slug]-spec.md

Full specification includes:
- Detailed multi-perspective analysis
- Cross-perspective synthesis
- Implementation specification
- Patterns extracted
- Session metadata

---

### 📊 MEMORY BANK UPDATES

✓ tasks.md updated (creative session complete, spec reference added)
✓ activeContext.md updated (recent changes logged)
[✓] systemPatterns.md updated (if new patterns added)
✓ Specification document created in memory-bank/specs/

---

### ⏭️ NEXT STEPS

**Recommended Command Sequence**:

**Option 1: Detailed Planning**
```bash
/cf:plan TASK-[ID] --interactive
```
Use specification for detailed sub-task breakdown

**Option 2: Direct Implementation**
```bash
/cf:code TASK-[ID]
```
Proceed with implementation using specification as guide

**Option 3: Review Specification**
```bash
Read memory-bank/specs/TASK-[ID]-[slug]-spec.md
```
Review full specification before deciding next steps

**Open Questions** (requiring answers before proceeding):
- [Question 1]
- [Question 2]

---

**Pattern**: Creative Session Pattern (systemPatterns.md)
**Session Metadata**: See specification document for full details
```

---

## Examples

### Example 1: Creative Session for Complex Task

```
User: /cf:creative TASK-012

Claude:
📋 LOADING CONTEXT
- Task: TASK-012 - Design real-time collaboration system
- Complexity: Level 3
- Problem: Multiple users editing shared documents simultaneously

---

🎨 CREATIVE SESSION: Starting

Invoking facilitator (Mode 4: Creative Session)...

---

**FACILITATOR** (Phase 1 - Problem Definition):

Let me help clarify the problem through some questions:

1. **Scope**: What types of documents need collaboration support?
   - Text documents only
   - Spreadsheets
   - Code files
   - All of the above

2. **Scale**: How many simultaneous users per document?
   - 2-5 users (small team)
   - 5-20 users (medium team)
   - 20+ users (large scale)

3. **Conflict Resolution**: When two users edit the same content, what should happen?
   - Last write wins
   - Operational transformation (merge edits)
   - CRDTs (conflict-free replicated data types)
   - Block concurrent edits (locking)

[User provides answers...]

---

**FACILITATOR** (Phase 2 - Multi-Perspective Analysis):

Now let's explore from different angles:

**Architect Perspective Questions**:
- What's your current tech stack for real-time communication?
- Have you worked with WebSockets, Server-Sent Events, or polling before?
- How do you handle state management currently?

**Product Perspective Questions**:
- What's the expected latency users will tolerate?
- Should users see cursors/selections of other users?
- How should conflicts be communicated to users?

**Tech Stack Perspective Questions**:
- What's your deployment environment (serverless, traditional servers)?
- Any existing real-time infrastructure to leverage?
- What's your comfort level with operational transformation libraries?

[User provides answers...]

---

**FACILITATOR** (Phase 3 - Synthesis):

Based on your responses, let me validate the emerging recommendation:

- Approach: WebSocket-based with Operational Transformation
- Rationale: Your Node.js stack + need for <100ms latency
- Trade-off: More complex than last-write-wins, but better UX

Does this align with your thinking? Any concerns?

[User validates or provides adjustments...]

---

🎨 SYNTHESIS COMPLETE

Creating specification document...

✓ Specification created: memory-bank/specs/TASK-012-realtime-collaboration-spec.md

---

🎨 CREATIVE SESSION COMPLETE

## Specification: Design real-time collaboration system

**Task**: TASK-012
**Complexity**: Level 3
**Duration**: 23 minutes

### 🎯 PROBLEM DEFINITION

**Core Problem**: Enable multiple users to edit shared documents simultaneously with <100ms latency

**Why This Matters**: Core differentiator for collaborative product, significant UX impact

**Constraints**:
- Technical: WebSocket support required, state consistency critical
- Business: <100ms latency for professional UX
- Resource: 2-week implementation timeline

### 🏗️ MULTI-PERSPECTIVE ANALYSIS

**ARCHITECT**: WebSocket architecture with operational transformation middleware, state synchronization layer, conflict resolution engine

**PRODUCT**: Real-time cursor/selection visibility, smooth merge experience, clear conflict communication when they occur

**TECH STACK**: Node.js + ShareDB (OT library), Redis for pub/sub, existing WebSocket infrastructure

**Convergent Insights**: All perspectives agree WebSockets are necessary, operational transformation provides best UX

**Productive Tensions**: Architect prefers CRDT for simplicity, Product needs OT for richer collaboration features

### 💡 RECOMMENDED APPROACH

**Solution**: WebSocket-Based Operational Transformation with ShareDB

**Rationale**:
1. ShareDB provides battle-tested OT implementation (Architect: reduces implementation risk)
2. OT enables rich collaboration UX features Product needs (Product: cursor sharing, merge visualization)
3. Integrates with existing Node.js stack (Tech Stack: minimal new infrastructure)

**Why This Over Alternatives**:
- vs CRDT: Better support for rich text editing and UX features Product requires
- vs Last-write-wins: Unacceptable UX for collaborative editing
- vs Locking: Defeats purpose of real-time collaboration

### 📋 IMPLEMENTATION GUIDANCE

**Acceptance Criteria**:
- Must Have: <100ms latency, no data loss on conflicts, cursor visibility
- Should Have: Selection highlighting, presence indicators

**Implementation Phases**:
1. WebSocket infrastructure + ShareDB integration
2. Document model with OT support
3. UI with real-time updates and collaboration indicators

**Testing Strategy**: Unit (OT operations), Integration (WebSocket flow), E2E (multi-user scenarios)

### 🎯 DECISION RECORD

**Decision**: Use ShareDB for operational transformation

**Alternatives Considered**:
1. CRDT (Automerge): Rejected - less mature for rich text, more complex state model
2. Locking model: Rejected - poor UX for collaboration
3. Custom OT: Rejected - high risk, ShareDB is proven

**Key Trade-offs Accepted**:
- ShareDB adds dependency but significantly reduces implementation risk
- OT more complex than last-write-wins but provides acceptable UX

### 📚 SPECIFICATION DOCUMENT

✓ Created: memory-bank/specs/TASK-012-realtime-collaboration-spec.md

### 📊 MEMORY BANK UPDATES

✓ tasks.md updated
✓ activeContext.md updated
✓ Specification document created

### ⏭️ NEXT STEPS

**Recommended**: Proceed with detailed planning
```bash
/cf:plan TASK-012 --interactive
```

Use specification to break down into implementable sub-tasks

**Open Questions**:
- How to handle offline users rejoining? (Address in planning)
- Scaling: How many documents can one WebSocket server handle? (Performance testing in Phase 2)
```

---

## Error Handling

### Memory Bank Not Initialized

```
⚠️ Memory Bank Not Initialized

Run: /cf:init
```

### Task Not Found (if task-id provided)

```
❌ Task TASK-099 not found in tasks.md

Available tasks:
- TASK-001: [name]
- TASK-002: [name]

Create new task with: /cf:feature [description]
```

### No Parameter Provided

```
❌ Missing Parameter

Usage: /cf:creative [task-id|description]

Examples:
/cf:creative TASK-005
/cf:creative "Design microservices architecture for payment processing"
```

### Task Complexity Too Low (Level 1-2)

```
⚠️ Task Complexity May Not Require Creative Session

Task TASK-007 is Level 1 (Quick Fix)

Creative sessions are designed for Level 3-4 complexity with:
- Ambiguous requirements
- Multiple valid approaches
- Significant trade-offs

For Level 1-2 tasks, consider:
/cf:plan TASK-007 (standard planning)
/cf:code TASK-007 (direct implementation)

Proceed with creative session anyway? (y/n)
```

---

## Memory Bank Updates

### tasks.md
- Creative session status updated
- Specification document reference added
- Recommended approach documented
- Next action suggested

### activeContext.md
- Recent change entry added
- Specification created
- Pattern used documented

### systemPatterns.md (if applicable)
- New patterns documented
- Source reference (creative session task ID)

### memory-bank/specs/
- Specification document created
- Full multi-perspective analysis preserved

---

## Orchestration Notes

**Pattern Compliance**:
- ✅ **Facilitator Invocation**: Command invokes facilitator (Mode 4) for creative session
- ✅ **Question-Only Facilitator**: Facilitator generates questions, command synthesizes responses
- ✅ **Template-Driven Synthesis**: Command uses creative-spec-template.md for consistent output
- ✅ **Memory Bank Updates**: Systematic updates to tasks.md, activeContext.md, systemPatterns.md, specs/
- ✅ **Specification Document**: Creates dedicated spec document for Level 3-4 complexity

**Command Responsibilities**:
- Context loading from memory bank
- Facilitator invocation (Mode 4: Creative Session)
- Response collection from interactive session
- Synthesis using creative-spec-template.md
- Specification document creation
- Memory bank updates

**Facilitator Responsibilities**:
- Generate questions for 3-phase creative session (Problem Definition, Multi-Perspective, Synthesis)
- Validate responses at phase transitions
- Collect user responses and session metadata
- Return structured output to command
- NO analysis, NO synthesis (command handles this)

---

## Related Commands

- `/cf:feature` - Create task before creative exploration
- `/cf:plan` - Plan task after creative session (using specification)
- `/cf:code` - Implement after creative session (using specification)
- `/cf:checkpoint` - Save creative session work

---

**Command Version**: 2.0 (Command Orchestration Pattern)
**Last Updated**: 2025-11-03 (TASK-003-6)
**Pattern**: Command Orchestration Pattern (systemPatterns.md:409-582)
