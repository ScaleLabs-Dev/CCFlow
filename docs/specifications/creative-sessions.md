# /cf:creative Command - Detailed Implementation Specification

## Document Purpose

This specification provides comprehensive implementation details for the `/cf:creative` command, complementing the command file (`.claude/commands/cf-creative.md`) with extended examples, dialogue flows, and integration patterns.

**Relationship to Other Documents**:
- **cf-creative.md**: Command definition and usage (operational reference)
- **Facilitator_defaults_spec.md**: Question templates and facilitation patterns
- **Workflow_spec.md**: Integration with overall CCFlow system
- **Command_and_role_spec.md**: Original creative command concept

**This Document Provides**:
- Complete dialogue flow examples for each phase
- Agent coordination patterns in detail
- Edge case handling and error recovery
- Integration examples with /cf:plan and /cf:code
- Quality validation criteria

---

## Core Philosophy

**Problem**: Some technical challenges can't be solved with standard planning because:
- Multiple viable solution paths exist with unclear trade-offs
- Novel problems without established patterns in the codebase
- High-risk decisions where wrong choice causes significant rework
- Complex interactions between components requiring deep analysis

**Solution**: Structured creative exploration through multi-agent collaboration:
1. **Deep Understanding** - Go beyond surface requirements to true problem
2. **Divergent Thinking** - Generate multiple solution approaches
3. **Systematic Analysis** - Compare approaches objectively using frameworks
4. **Convergent Design** - Detail the selected solution thoroughly
5. **Validation & Documentation** - Ensure quality and preserve knowledge

**Design Principles**:
- **Always Interactive** - Creative thinking requires human judgment
- **Multi-Perspective** - Combine Architect (technical), Product (user needs), Facilitator (process), Sequential (reasoning)
- **Evidence-Based** - Decisions backed by analysis, not assumptions
- **Pattern-Generating** - Creative sessions produce reusable knowledge
- **Time-Boxed but Thorough** - 15-30 minutes is reasonable for preventing hours of rework

---

## The Four-Phase Process

### Phase 1: Problem Deep-Dive (5-8 minutes)

**Goals**:
- Understand the problem at a deep level
- Surface hidden requirements and constraints
- Identify unknowns and assumptions
- Define clear success criteria

**Agent Roles**:
- **Facilitator**: Leads questioning, synthesizes understanding
- **Product**: Ensures user needs and requirements clarity
- **Architect**: Identifies technical constraints and implications

**Question Categories** (from Facilitator_defaults_spec.md patterns):

**Core Problem Understanding**:
- What is the actual problem vs symptom?
- Why is this challenging (what makes it non-trivial)?
- What does "success" look like concretely?

**Requirements Clarity**:
- What MUST work (functional requirements)?
- What quality attributes matter (performance, security, maintainability)?
- What edge cases or unusual scenarios must handle?

**Constraints Identification**:
- Technical constraints (technology stack, integrations, architecture)
- Resource constraints (time, complexity, team skill)
- Business constraints (UX requirements, compliance, compatibility)

**Unknowns and Assumptions**:
- What do we know for certain?
- What do we NOT know but need to find out?
- What are we assuming (and are those assumptions valid)?

**Output**:
```markdown
## Problem Understanding (Refined)

**Core Problem**: [Clear, specific problem statement]

**Why Complex**: [What makes this challenging]

**Requirements**:
**Must Have**:
- [Functional requirement 1]
- [Quality attribute 1]

**Should Have**:
- [Enhancement 1]

**Constraints**:
- **Technical**: [Constraints from architecture/stack]
- **Resource**: [Time/skill constraints]
- **Business**: [UX/compliance requirements]

**Success Criteria**:
- ✓ [Measurable criterion 1]
- ✓ [Measurable criterion 2]
- ✓ [Measurable criterion 3]

**Known Unknowns**: [Questions needing research/experimentation]
**Assumptions**: [What we're assuming to be true]
```

---

### Phase 2: Solution Exploration (8-12 minutes)

**Goals**:
- Generate 3-5 solution approaches (divergent thinking)
- Analyze each approach systematically
- Compare trade-offs objectively
- Select best approach or identify hybrid

**Agent Roles**:
- **Architect**: Generates technical approaches, analyzes feasibility
- **Product**: Validates approaches against user needs
- **Facilitator**: Guides comparison, asks probing questions
- **Sequential MCP**: Provides structured reasoning and hypothesis testing

**Approach Generation Template**:

For each approach (A, B, C, D, E):

```markdown
## Approach [X]: [Descriptive Name]

**Description**: [1-2 sentences explaining the approach]

**How It Works**:
- [Key mechanism 1]
- [Key mechanism 2]
- [Key mechanism 3]

**Implementation Overview**:
- **Component 1**: [What it does]
- **Component 2**: [What it does]
- **Data flow**: [Source] → [Processing] → [Storage/Output]

**Pros**:
✓ [Advantage 1 - with specific benefit]
✓ [Advantage 2 - with specific benefit]
✓ [Advantage 3 - with specific benefit]

**Cons**:
⚠️ [Limitation 1 - with specific impact]
⚠️ [Limitation 2 - with specific impact]

**Trade-offs**:
- Trades [X] for [Y] - [Why this might be acceptable]

**Complexity**: [Low/Medium/High] - [Justification]
**Risk**: [Low/Medium/High] - [What could go wrong]
**Effort**: [Time estimate] - [What takes time]

**Best For**: [Scenarios where this approach shines]
**Avoid If**: [Conditions where this approach fails]
```

**Sequential MCP Analysis Pattern**:

```markdown
🧠 Sequential Analysis: Systematic Comparison

**Testing Approaches Against Requirements**:

**Requirement 1**: [Core functional requirement]
- Approach A: [✓/⚠️/❌] [How it handles this]
- Approach B: [✓/⚠️/❌] [How it handles this]
- Approach C: [✓/⚠️/❌] [How it handles this]

**Requirement 2**: [Quality attribute - e.g., scalability]
- Approach A: [✓/⚠️/❌] [Assessment]
- Approach B: [✓/⚠️/❌] [Assessment]
- Approach C: [✓/⚠️/❌] [Assessment]

**Constraint 1**: [E.g., must integrate with existing auth system]
- Approach A: [✓/⚠️/❌] [Compatibility assessment]
- Approach B: [✓/⚠️/❌] [Compatibility assessment]
- Approach C: [✓/⚠️/❌] [Compatibility assessment]

**Edge Case**: [Specific edge case identified in Phase 1]
- Approach A: [✓/⚠️/❌] [How it handles]
- Approach B: [✓/⚠️/❌] [How it handles]
- Approach C: [✓/⚠️/❌] [How it handles]

**Hypothesis**: Approach [X] is best because:
1. [Reason based on requirements]
2. [Reason based on constraints]
3. [Reason based on trade-off acceptance]

**Counter-evidence**: However, Approach [Y] might be better if:
- [Condition 1 changes]
- [Assumption proves incorrect]

**Recommendation**: [Approach X] or [Hybrid of X+Y]
**Rationale**: [Synthesis of analysis]
```

**Facilitator Refinement Questions**:

```markdown
🔄 Facilitator: Narrowing to Best Approach

Based on the analysis, I have questions to help select:

1. **Trade-off Acceptance**: Approach [X] trades [A] for [B]. Is [B] more important than [A] for your use case?

2. **Risk Tolerance**: Approach [Y] has [specific risk]. Given [project context], is this risk acceptable or should we favor safer [Approach Z]?

3. **Complexity Justification**: Approach [C] is more complex but offers [benefit]. Is [benefit] worth the added complexity?

4. **Future Flexibility**: You might need [future requirement]. Does that push toward [Approach that accommodates it]?

5. **Unknown Resolution**: We identified [known unknown]. Does [Approach] handle this uncertainty better?

Your thoughts on these questions?
```

**Selection or Hybrid Definition**:

```markdown
**Decision**: [Selected Approach] or [Hybrid: Approach A + feature from Approach B]

**Rationale**:
1. [Primary reason for selection]
2. [Secondary reason]
3. [How this addresses the most critical requirements]

**Trade-offs Accepted**:
- [Trade-off 1 with justification for acceptance]
- [Trade-off 2 with justification for acceptance]

**Risks Mitigated**:
- [Risk 1]: [How we'll handle it]
- [Risk 2]: [How we'll handle it]

**Alternative If**: [Conditions under which we'd choose different approach]
```

---

### Phase 3: Design Refinement (6-10 minutes)

**Goals**:
- Detail the selected solution with implementation specifics
- Define component architecture and interfaces
- Specify data flow and state management
- Plan for edge cases, errors, and testing

**Agent Roles**:
- **Architect**: Leads detailed design, technical specifications
- **Facilitator**: Validates completeness, asks clarifying questions
- **Product**: Ensures design meets user requirements
- **Documentarian** (consulting): Suggests documentation approach

**Design Specification Template**:

```markdown
## Detailed Design: [Solution Name]

### Component Architecture

**Component 1: [Name]**

**Purpose**: [Single, clear responsibility]

**Responsibilities**:
- [Specific responsibility 1]
- [Specific responsibility 2]
- [Specific responsibility 3]

**Public Interface**:
```[language]
// API or contract
function methodName(param: Type): ReturnType
```

**Internal State** (if stateful):
- `property1`: [type] - [purpose]
- `property2`: [type] - [purpose]

**Dependencies**:
- [Component/Service it depends on] - [What it needs from it]

**File Location**: `[path/to/file.ext]`

**Testing Approach**:
- Unit test: [Key scenarios to test]
- Mock dependencies: [What to mock]

---

**Component 2: [Name]**

[Same structure as Component 1]

---

### Data Flow Diagram

```
[Entry Point: User action / API call / Event]
  ↓
[Component 1: Validation]
  ↓ [validated data]
[Component 2: Processing]
  ↓ [processed result]
[Component 3: State Update]
  ↓ [state change event]
[Component 4: Side Effects / Notification]
  ↓
[Output: UI update / API response / Event emission]
```

**Flow Details**:
1. **Step 1**: [Entry point] → [What happens]
2. **Step 2**: [Processing] → [What happens]
3. **Step 3**: [State change] → [What happens]
4. **Step 4**: [Side effects] → [What happens]
5. **Step 5**: [Output] → [What happens]

### State Management

**State Structure**:
```[language]
{
  field1: Type,        // Purpose and when it changes
  field2: Type,        // Purpose and when it changes
  field3: {            // Nested state
    subField1: Type,   // Purpose
    subField2: Type    // Purpose
  }
}
```

**State Transitions**:
```
[Initial State]
  ↓ [Event 1]
[State A] - [What changed and why]
  ↓ [Event 2]
[State B] - [What changed and why]
  ↓ [Event 3]
[Final State]
```

**State Invariants**: [Conditions that must always be true]
- [Invariant 1]
- [Invariant 2]

### Edge Case Handling

**Edge Case 1**: [Unusual scenario identified in Phase 1]
- **Detection**: [How we detect this case]
- **Handling**: [What the system does]
- **Recovery**: [How system recovers to normal state]
- **Test**: [How to test this scenario]

**Edge Case 2**: [Another scenario]
- [Same structure]

**Edge Case 3**: [Another scenario]
- [Same structure]

### Error Handling Strategy

**Error Categories**:

**Recoverable Errors** (retry/fallback possible):
- [Error type 1]: [Recovery strategy]
- [Error type 2]: [Recovery strategy]

**Non-Recoverable Errors** (fail gracefully):
- [Error type 1]: [Graceful degradation approach]
- [Error type 2]: [User notification approach]

**Error Reporting**:
- **Logging**: [Where errors are logged, what level]
- **Monitoring**: [What triggers alerts]
- **User Feedback**: [How errors communicated to user]

**Retry Strategy** (if applicable):
- **Max retries**: [Number]
- **Backoff**: [Exponential / Fixed / Adaptive]
- **Retry conditions**: [When to retry vs fail]

### Testing Strategy

**Unit Tests**:
- **Component 1**:
  - Test: [Scenario 1]
  - Test: [Scenario 2]
  - Test: [Edge case]

- **Component 2**:
  - Test: [Scenario 1]
  - Test: [Scenario 2]
  - Test: [Edge case]

**Integration Tests**:
- Test: [Integration point 1] - [What to verify]
- Test: [Integration point 2] - [What to verify]
- Test: [End-to-end flow] - [What to verify]

**Edge Case Tests**:
- Test: [Edge case 1] - [How to trigger and verify]
- Test: [Edge case 2] - [How to trigger and verify]

**Performance Tests** (if applicable):
- Test: [Load scenario] - [Expected performance]
- Test: [Stress scenario] - [Degradation behavior]

**Test Coverage Goals**: [Percentage or criteria]

### Performance Considerations

**Expected Load**: [Estimate - requests/sec, data volume, etc.]

**Potential Bottlenecks**:
- [Bottleneck 1]: [Mitigation strategy]
- [Bottleneck 2]: [Mitigation strategy]

**Optimization Opportunities**:
- [Optimization 1]: [When to apply]
- [Optimization 2]: [When to apply]

**Performance Targets**:
- [Operation 1]: [Target time/throughput]
- [Operation 2]: [Target time/throughput]

### Security Considerations (if applicable)

**Security Requirements**:
- [Requirement 1]: [How design addresses it]
- [Requirement 2]: [How design addresses it]

**Attack Vectors Considered**:
- [Attack 1]: [Mitigation in design]
- [Attack 2]: [Mitigation in design]

**Data Protection**:
- [Sensitive data 1]: [How protected]
- [Sensitive data 2]: [How protected]

### Integration Points

**Existing System Integration**:
- **System/Component 1**: [How we integrate, what we depend on]
- **System/Component 2**: [How we integrate, what we provide]

**API Contracts**:
- [API 1]: [Contract specification]
- [API 2]: [Contract specification]

**Event Contracts** (if event-driven):
- **Event 1**: [Event structure, when emitted, who consumes]
- **Event 2**: [Event structure, when emitted, who consumes]
```

**Facilitator Validation Questions**:

```markdown
🔄 Facilitator: Design Completeness Check

Let's validate this design before finalizing:

1. **Requirement Coverage**: Does this design address all requirements from Phase 1?
   - [Requirement 1]: [✓/❌]
   - [Requirement 2]: [✓/❌]
   - [Requirement 3]: [✓/❌]

2. **Edge Cases**: Have we covered all edge cases we identified?
   - [Edge case 1]: [How handled]
   - [Edge case 2]: [How handled]

3. **Missing Details**: Are there areas needing more specificity?
   - [Aspect 1]: [Sufficient/Needs detail]
   - [Aspect 2]: [Sufficient/Needs detail]

4. **Integration Clarity**: Are integration points well-defined?
   - [Integration 1]: [Clear/Unclear]

5. **Testing Feasibility**: Can we effectively test this design?
   - Unit testing: [Feasible/Challenging because...]
   - Integration testing: [Feasible/Challenging because...]

6. **Implementation Complexity**: Is this implementable given our constraints?
   - Skill level required: [Assessment]
   - Time estimate still valid: [Yes/Adjusted to X]

Let's refine anything that needs it.
```

---

### Phase 4: Validation & Documentation (3-5 minutes)

**Goals**:
- Validate design completeness and quality
- Extract reusable patterns for systemPatterns.md
- Document design decisions and rationale
- Prepare memory bank updates
- Confirm implementation readiness

**Agent Roles**:
- **Facilitator**: Leads validation checklist
- **All Agents**: Validate from their perspectives
- **Documentarian**: Prepares memory bank updates

**Validation Checklist**:

```markdown
✅ VALIDATION CHECKLIST

### Requirements Coverage
- [✓/❌] All functional requirements addressed in design
- [✓/❌] All quality attributes (performance, security, etc.) considered
- [✓/❌] All edge cases have explicit handling
- [✓/❌] Error scenarios are covered
- [✓/❌] Success criteria from Phase 1 can be met

### Design Quality
- [✓/❌] Components have single, clear responsibilities (SRP)
- [✓/❌] Interfaces are well-defined and stable
- [✓/❌] Dependencies are explicit and manageable
- [✓/❌] State management is clear and predictable
- [✓/❌] Data flow is unidirectional or well-documented
- [✓/❌] Error handling is comprehensive

### Testing Readiness
- [✓/❌] Unit tests can be written for each component
- [✓/❌] Integration tests can verify key flows
- [✓/❌] Edge cases are testable
- [✓/❌] Test doubles/mocks are feasible
- [✓/❌] Testing strategy is comprehensive

### Integration
- [✓/❌] Aligns with existing systemPatterns.md patterns
- [✓/❌] Follows project architectural conventions
- [✓/❌] Compatible with existing components
- [✓/❌] No conflicts with other system parts
- [✓/❌] Integration points are well-defined

### Implementation Readiness
- [✓/❌] Design is detailed enough to implement
- [✓/❌] All unknowns have been addressed or documented
- [✓/❌] Risk mitigation strategies are in place
- [✓/❌] File/component locations are specified
- [✓/❌] Implementation path is clear

### Documentation
- [✓/❌] Design rationale is documented
- [✓/❌] Trade-offs are explicit
- [✓/❌] Decision record is complete
- [✓/❌] Pattern can be extracted for reuse
- [✓/❌] Future maintainers will understand approach
```

**Pattern Extraction Template**:

```markdown
## Pattern Extraction

### Pattern: [Descriptive Name]

**Category**: [Architectural / Design / Implementation]

**Problem**: [What problem does this pattern solve]

**Context**: [When should this pattern be used]
- [Condition 1]
- [Condition 2]

**Solution**: [How the pattern works - reference design components]

**Structure**:
```[language or diagram]
[Code structure, class diagram, or component diagram]
```

**Participants** (components in the pattern):
- [Component 1]: [Role in pattern]
- [Component 2]: [Role in pattern]

**Collaborations**: [How components interact]

**Benefits**:
- ✓ [Benefit 1]
- ✓ [Benefit 2]
- ✓ [Benefit 3]

**Trade-offs**:
- ⚠️ [Trade-off 1]
- ⚠️ [Trade-off 2]

**Related Patterns**:
- [Existing pattern 1]: [Relationship - builds on, alternative to, etc.]
- [Existing pattern 2]: [Relationship]

**Example Usage**: [Reference to TASK-ID where first implemented]

**Variations**:
- [Variation 1]: [When to use this variation]

**Antipatterns to Avoid**:
- [Antipattern 1]: [Why to avoid]
```

**Decision Record Template**:

```markdown
## Architectural Decision Record

**Decision**: [What was decided]

**Date**: [YYYY-MM-DD]

**Context**: [Problem and constraints that led to this decision]

**Alternatives Considered**:

**Option A**: [Approach A name]
- Pros: [Key advantages]
- Cons: [Key disadvantages]
- Rejected because: [Reason]

**Option B**: [Approach B name]
- Pros: [Key advantages]
- Cons: [Key disadvantages]
- Rejected because: [Reason]

**Option C**: [Approach C name] ← **SELECTED**
- Pros: [Key advantages]
- Cons: [Accepted disadvantages]
- Selected because: [Rationale]

**Consequences**:

**Positive**:
- [Benefit 1]
- [Benefit 2]

**Negative** (accepted):
- [Cost 1]
- [Mitigation strategy]

**Risks and Mitigations**:
- **Risk 1**: [Description]
  - Mitigation: [How we address it]
  - Monitoring: [How we track it]

**Revisit Triggers**: [Conditions that would cause us to reconsider]
- If [condition 1 changes]
- If [assumption proves incorrect]
- After [time period or milestone]

**Related Decisions**: [Links to other decisions this affects or depends on]
```

---

## Memory Bank Update Patterns

### systemPatterns.md Update

**Adding New Pattern**:

```markdown
---

## [Pattern Name]

**Added**: [YYYY-MM-DD]
**Source**: Creative session for TASK-[ID]
**Status**: Active

**Category**: [Architectural / Design / Implementation]

**Problem**: [What this pattern solves]

**Context**: [When to use this pattern]

**Solution**:
[Pattern description referencing components and flow]

**Implementation**:
```[language]
// Code structure or example
```

**Benefits**:
- ✓ [Benefit 1 with explanation]
- ✓ [Benefit 2 with explanation]

**Trade-offs**:
- ⚠️ [Trade-off 1 with mitigation]

**Examples**:
- `TASK-[ID]`: [Brief description of usage]
- (More examples will be added as pattern is reused)

**Related Patterns**:
- [Pattern A]: [Relationship]
- [Pattern B]: [Relationship]

**Antipatterns**:
- [What NOT to do]

**Testing Approach**:
- [How to test implementations of this pattern]

**Revision History**:
- [YYYY-MM-DD]: Pattern defined
- (Future revisions as pattern evolves)
```

### tasks.md Update

**Updating Task with Creative Session Results**:

```markdown
### 🟡 TASK-[ID]: [Task Name]

[Existing task fields...]

**Creative Session**: ✅ Complete
**Session Date**: [YYYY-MM-DD]
**Duration**: [Estimate]

**Problem Explored**:
[Brief problem statement]

**Approaches Considered**: [N]
1. [Approach A] - Rejected: [Reason]
2. [Approach B] - Rejected: [Reason]
3. [Approach C] - Selected: [Reason]

**Selected Solution**: [Solution name]

**Design Summary**:
- Components: [Component 1], [Component 2], [Component 3]
- Pattern: [Pattern name] (see systemPatterns.md)
- Complexity: [Reassessed complexity if changed]

**Implementation Notes**:
- [Critical note 1 for implementer]
- [Critical note 2 for implementer]
- [File structure suggested]

**Edge Cases to Handle**:
1. [Edge case 1] - [Handling approach]
2. [Edge case 2] - [Handling approach]
3. [Edge case 3] - [Handling approach]

**Testing Requirements**:
- Unit tests: [Key scenarios]
- Integration tests: [Key flows]
- Edge case tests: [Specific tests]

**Dependencies**:
- [Prerequisite 1 if any]

**Estimated Effort**: [Updated estimate based on detailed design]

**Ready for Implementation**: ✅ Yes - Design is detailed and validated

**Patterns to Apply**:
- [Pattern 1] from systemPatterns.md
- [Pattern 2] from systemPatterns.md

**Decision Rationale**: [Why this approach - link to ADR if complex]
```

### activeContext.md Update

**Adding Creative Session Entry**:

```markdown
### [YYYY-MM-DD HH:MM] - Creative Session Completed

**Task**: TASK-[ID] - [Task name]
**Topic**: [Problem explored]
**Agents**: Facilitator + Architect + Product + Sequential
**Duration**: [Actual time spent]

**Problem**: [One-line problem statement]

**Solution Designed**: [Selected approach name]

**Key Decisions**:
1. [Decision 1] - [Brief rationale]
2. [Decision 2] - [Brief rationale]

**Patterns Created**:
- [Pattern name 1] added to systemPatterns.md
- [Pattern name 2] added to systemPatterns.md

**Trade-offs Accepted**:
- [Trade-off 1]
- [Trade-off 2]

**Implementation Complexity**: [Level] - [Justification]

**Next Action**: Ready for /cf:code TASK-[ID]

**Memory Bank Updates**:
✓ systemPatterns.md - [N] patterns added
✓ tasks.md - Task updated with design
[✓ projectbrief.md - Decision log updated if architectural]
```

### projectbrief.md Decision Log (When Architectural)

**Adding to Decision Log**:

```markdown
| Date | Decision | Rationale | Alternatives | Review |
|------|----------|-----------|--------------|--------|
| [YYYY-MM-DD] | [Architectural decision from creative session] | [Why - concise] | [A, B, C considered] | [When to revisit] |
```

**With Expanded ADR** (for complex decisions):

Create separate ADR file or section referencing creative session output.

---

## Complete Dialogue Flow Example

### Example: Real-Time Collaboration Mechanism

```
User: /cf:creative realtime-collaboration

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Claude:
[Loads context: TASK-078 "Add real-time collaboration to code editor"]
[Reads tasks.md, systemPatterns.md, productContext.md]

💡 CREATIVE SESSION: Real-Time Collaboration Mechanism
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

**Problem**: Enable multiple users to edit same code file simultaneously
**Complexity**: High - Conflict resolution, synchronization, user presence
**Goal**: Explore solutions systematically, select best approach

**Agents Engaged**:
🔄 Facilitator - Guides exploration, asks probing questions
🏗️ Architect - Technical approaches and trade-offs
🎨 Product - User needs and requirements validation
🧠 Sequential - Structured reasoning and hypothesis testing

**Process** (4 phases):
1. Problem Deep-Dive - Understand thoroughly
2. Solution Exploration - Generate & analyze approaches
3. Design Refinement - Detail selected solution
4. Validation & Documentation - Verify and document

Estimated time: 20-30 minutes

Ready to begin?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

User: Yes

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔄 PHASE 1: PROBLEM DEEP-DIVE
━━━━━━━━━━━━━━━━━━━━━━━━━━

Let's ensure we fully understand the problem.

## Understanding the Core Problem

**🎨 Product Questions**:
1. What is the core user need? (Pair programming, classroom, code review?)
2. How many simultaneous users do we expect? (2-3 or larger teams?)
3. What happens if users make conflicting changes?
4. Should users see each other's cursors/selections in real-time?

**🏗️ Architect Questions**:
1. What file sizes are we dealing with? (Small scripts or large files?)
2. Network latency tolerance? (LAN, WAN, global?)
3. Must changes persist during collaboration or only after session?
4. Can we rely on server authority or need peer-to-peer?

## Identifying Unknowns

**What do we KNOW for certain?**
**What do we NOT KNOW but need to find out?**
**What assumptions are we making?**

## Success Criteria

**How will we know we've solved this well?**

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

User: Primary use case is pair programming (2-3 users max). File sizes under 10MB. Internet latency (not LAN). Changes should be auto-saved. Server can be authority. Must see cursors/selections. Conflicts should be resolved automatically without losing work.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔄 Facilitator: Let me clarify a few points:

1. **Conflict Resolution**: When two users type in same location, auto-resolve means:
   A) Last write wins (simpler but can lose work)
   B) Merge both changes intelligently (more complex)
   C) Highlight conflict for users to resolve (manual)

   Which aligns with "without losing work"?

2. **Network Resilience**: If user loses connection briefly, should they:
   A) Auto-reconnect and sync
   B) Enter read-only mode
   C) Continue offline and sync when back

3. **Cursor Performance**: Seeing cursors requires frequent updates. Acceptable if cursor updates lag by 100-500ms?

4. **File Locking**: Should we prevent editing certain sections (like imports) while someone edits them, or allow all simultaneous edits?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

User: 1B - merge intelligently. 1C as fallback for complex conflicts. 2A - auto-reconnect and sync. 3 - yes, 100-500ms cursor lag is fine. 4 - allow all simultaneous, rely on merge algorithm.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔄 Facilitator: Excellent. Let me synthesize our understanding.

## Problem Understanding (Refined)

**Core Problem**: Enable 2-3 users to collaboratively edit code files in real-time with automatic conflict resolution that preserves all work.

**Why Complex**:
- Automatic merge requires sophisticated algorithm (character-level merging)
- Network latency + potential disconnections require resilient sync
- Cursor/selection broadcasting at high frequency
- Must maintain file consistency despite concurrent edits

**Requirements**:

**Must Have**:
- Real-time text synchronization (character-level)
- Automatic conflict resolution (merge both changes)
- User presence indicators (cursors, selections)
- Auto-reconnect and sync after disconnect
- Auto-save during collaboration

**Should Have**:
- Manual conflict resolution UI for complex conflicts
- User typing indicators
- Change attribution (who made what change)

**Nice to Have**:
- Undo/redo with collaborative awareness
- Comment/annotation system

**Constraints**:
- **Technical**: Internet latency (100-500ms), file size < 10MB, server-authoritative
- **User Experience**: No lost work, smooth editing feel, clear presence
- **Resource**: 2-3 users typical, scales to maybe 10

**Success Criteria**:
✓ Two users can type simultaneously without conflicts or lost characters
✓ Cursor positions visible with < 500ms lag
✓ Disconnection doesn't lose unsaved work
✓ Merge handles 95%+ of conflicts automatically
✓ Users feel editing is "smooth" (not laggy or jarring)

**Known Unknowns**:
- Best algorithm for character-level merging (OT vs CRDT)
- WebSocket vs polling for updates
- Cursor broadcast frequency vs performance

**Assumptions**:
- Users have stable internet (occasional drops OK, not constant)
- Users editing code (text), not binary files
- Server has authority (not P2P)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Ready to explore solutions? (Type 'yes' or ask for more clarification)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

User: Yes

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🧠 PHASE 2: SOLUTION EXPLORATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Based on our problem understanding, here are potential approaches:

## Approach A: Operational Transformation (OT)

**Description**: Transform operations based on concurrent changes to maintain consistency

**How It Works**:
- Client sends operations (insert/delete at position)
- Server transforms operations to account for concurrent ops
- Transformed ops broadcast to other clients
- Each client applies transformed ops

**Implementation Overview**:
- **OT Engine**: Transforms operations (complex algorithm)
- **Operation Queue**: Queues client ops, applies server-transformed ops
- **WebSocket Channel**: Bidirectional real-time communication
- **State Sync**: Periodic full state sync for recovery

**Pros**:
✓ Well-established algorithm (Google Docs uses OT)
✓ Deterministic convergence (all clients reach same state)
✓ Works well with server authority model
✓ Handles complex merge scenarios

**Cons**:
⚠️ Complex transformation algorithm (hard to implement correctly)
⚠️ Performance degrades with many concurrent ops
⚠️ Requires careful state management
⚠️ Bug in transformation logic = data corruption

**Complexity**: High
**Risk**: Medium-High (implementation complexity)
**Effort**: 3-4 days (implementing OT correctly is hard)

**Best For**: When need proven algorithm, can invest in correct implementation
**Avoid If**: Team lacks experience with OT, tight timeline

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Approach B: Conflict-Free Replicated Data Type (CRDT)

**Description**: Use data structure that automatically converges without transformation

**How It Works**:
- Document represented as CRDT (e.g., Yjs, Automerge)
- Each character has unique ID + metadata
- Changes merge automatically based on CRDT properties
- No transformation needed, eventual consistency guaranteed

**Implementation Overview**:
- **CRDT Library**: Use existing library (Yjs or Automerge)
- **Sync Protocol**: CRDT-specific sync (often more efficient than OT)
- **WebSocket Channel**: Bidirectional for changes and awareness
- **Persistence Layer**: Store CRDT state

**Pros**:
✓ Simpler than OT (leverage existing libraries)
✓ Automatic merging without transformation logic
✓ Proven libraries available (Yjs very mature)
✓ Good performance even with many users
✓ Offline-first friendly (eventual consistency)

**Cons**:
⚠️ Larger payload size (character metadata)
⚠️ Learning curve for CRDT concepts
⚠️ Some edge cases can be unintuitive (cursor jumping)
⚠️ Dependency on external library

**Complexity**: Medium
**Risk**: Low-Medium (mature libraries available)
**Effort**: 1-2 days (library does heavy lifting)

**Best For**: When want proven solution without implementing algorithm
**Avoid If**: Can't accept dependency, need full control over merge logic

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Approach C: Last Write Wins (LWW) with Diff/Patch

**Description**: Simple approach - last edit wins, use diff/patch for sync

**How It Works**:
- Each edit creates diff from previous state
- Server maintains canonical state (last write)
- Clients send diffs, server applies and broadcasts
- Conflicts resolved by timestamp (last write wins)

**Implementation Overview**:
- **Diff Engine**: Generate and apply diffs (use library)
- **Timestamp Coordination**: Server assigns authoritative timestamps
- **WebSocket Channel**: For diffs and sync
- **Conflict Strategy**: Last write wins, notify user if overwritten

**Pros**:
✓ Very simple to implement
✓ Low server complexity
✓ Easy to reason about
✓ Fast for small changes

**Cons**:
⚠️ Can lose work (last write wins means earlier edits overwritten)
⚠️ Poor user experience when conflicts occur
⚠️ Doesn't meet "no lost work" requirement
⚠️ User frustration when changes disappear

**Complexity**: Low
**Risk**: High (doesn't meet requirements)
**Effort**: 1 day

**Best For**: Simple scenarios, single user with optimistic UI
**Avoid If**: Need real conflict resolution (our case)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Approach D: Hybrid - CRDT for Text + Manual Conflict UI

**Description**: Use CRDT for automatic merging, add UI for edge cases

**How It Works**:
- CRDT (Yjs) handles most merges automatically
- Track "suspicious" merges (rapid concurrent edits in same location)
- UI highlights suspicious merges for user review
- User can accept, reject, or manually resolve

**Implementation Overview**:
- **Yjs CRDT**: Core text merging
- **Conflict Detector**: Heuristics for suspicious merges
- **Conflict UI**: Show diffs, allow resolution
- **Resolution Sync**: Broadcast manual resolutions

**Pros**:
✓ Best of both: automatic + human oversight
✓ Meets "no lost work" requirement
✓ Better UX for complex conflicts
✓ CRDT handles 95%+ automatically

**Cons**:
⚠️ Additional UI complexity
⚠️ Requires conflict detection heuristics
⚠️ Slightly more complex than pure CRDT

**Complexity**: Medium-High
**Risk**: Low (CRDT proven, UI is additive)
**Effort**: 2-3 days

**Best For**: When want safety net for edge cases
**Avoid If**: Want purely automatic (but we said manual fallback OK)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🧠 Sequential Analysis: Approach Comparison

**Testing Against Requirements**:

**Requirement**: Auto-merge without losing work
- Approach A (OT): ✓ Yes, with correct implementation
- Approach B (CRDT): ✓ Yes, guaranteed by CRDT properties
- Approach C (LWW): ❌ No, last write wins loses earlier work
- Approach D (Hybrid): ✓ Yes, plus manual fallback

**Requirement**: Real-time cursor/selection visibility
- Approach A (OT): ✓ Can add awareness layer
- Approach B (CRDT): ✓ Yjs has built-in awareness API
- Approach C (LWW): ✓ Can add separately
- Approach D (Hybrid): ✓ Yjs awareness included

**Requirement**: Handle disconnection/reconnection
- Approach A (OT): ⚠️ Requires careful queue management
- Approach B (CRDT): ✓ Designed for offline-first, handles well
- Approach C (LWW): ⚠️ Need full state resync
- Approach D (Hybrid): ✓ Same as CRDT

**Constraint**: Implementation effort (2-4 days acceptable)
- Approach A (OT): ❌ 3-4 days minimum, risky if bugs
- Approach B (CRDT): ✓ 1-2 days with library
- Approach C (LWW): ✓ 1 day but doesn't meet requirements
- Approach D (Hybrid): ⚠️ 2-3 days, within range

**Constraint**: Internet latency resilience
- Approach A (OT): ✓ Handles but complex
- Approach B (CRDT): ✓ Excellent (eventual consistency)
- Approach C (LWW): ⚠️ Poor (full sync on reconnect)
- Approach D (Hybrid): ✓ Same as CRDT

**Hypothesis**: Approach B (CRDT) or D (Hybrid) are best.

**Reasoning**:
1. Approach C (LWW) eliminated - doesn't meet "no lost work" requirement
2. Approach A (OT) viable but high risk/effort
3. Approach B (CRDT) meets all requirements, low risk, good effort
4. Approach D (Hybrid) adds safety net, slightly more effort

**Counter-evidence**: If team has OT experience, Approach A could work.

**Recommendation**: Approach B (pure CRDT with Yjs)
**Rationale**:
- Meets all requirements
- Lowest risk (mature library)
- Reasonable effort (1-2 days)
- User said manual fallback "nice" but auto-merge is primary goal

**Alternative**: Approach D if manual conflict UI is high priority

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔄 Facilitator: Narrowing to Best Approach

Based on Sequential's analysis:

1. **Approach C (LWW)** is eliminated - doesn't meet "no lost work" requirement. Agree?

2. **Approach A (OT) vs B (CRDT)**:
   - OT is proven (Google Docs) but complex to implement correctly
   - CRDT (Yjs) is also proven and simpler (library does work)
   - Does your team have OT experience, or would CRDT be better fit?

3. **Pure CRDT (B) vs Hybrid (D)**:
   - You mentioned manual conflict resolution as fallback
   - Pure CRDT (B) relies on automatic merging (95%+ success)
   - Hybrid (D) adds UI for edge cases but more effort
   - Is the manual UI worth the extra day of effort, or trust CRDT?

4. **Risk Tolerance**:
   - CRDT is lower risk (library handles complexity)
   - OT is higher risk (implementation bugs = data corruption)
   - Given this is real-time collab (high user expectations), favor lower risk?

Your thoughts?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

User: Agree C is eliminated. No OT experience, so CRDT better. I think pure CRDT (B) is fine - the 95%+ auto-merge should be enough, and we can add manual UI later if needed. Lower risk is important.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔄 Facilitator: Decision Made

**Selected Approach**: B - CRDT with Yjs Library

**Rationale**:
1. Meets all requirements (auto-merge, no lost work, real-time sync)
2. Lowest risk (proven library vs custom algorithm)
3. Reasonable effort (1-2 days with library)
4. No OT experience = CRDT is better technical fit
5. Can add manual conflict UI later if 95%+ isn't enough (defer complexity)

**Trade-offs Accepted**:
- Dependency on Yjs library (acceptable - it's mature and maintained)
- Larger payload vs simple approaches (acceptable for 2-3 users, <10MB files)
- Some edge case merge behaviors may be unintuitive (acceptable - can document)

**Risks Mitigated**:
- Implementation complexity: Using library vs building from scratch
- Data corruption: Yjs is battle-tested
- Performance: Yjs optimized for real-time collaboration

Ready to detail the design?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

User: Yes

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🏗️ PHASE 3: DESIGN REFINEMENT
━━━━━━━━━━━━━━━━━━━━━━━━━━

**Selected Solution**: CRDT-Based Real-Time Collaboration with Yjs

## Component Architecture

### Component 1: CollaborationManager

**Purpose**: Orchestrates real-time collaboration for a document session

**Responsibilities**:
- Initialize Yjs document and sync provider
- Manage WebSocket connection lifecycle
- Handle user join/leave events
- Coordinate between CRDT and UI

**Public Interface**:
```typescript
class CollaborationManager {
  constructor(documentId: string, userId: string)

  // Lifecycle
  connect(): Promise<void>
  disconnect(): void

  // Document access
  getYDoc(): Y.Doc
  getText(): Y.Text

  // Awareness (cursors, selections)
  getAwareness(): Awareness
  setLocalCursor(position: number): void
  setLocalSelection(start: number, end: number): void

  // Events
  on(event: 'sync' | 'connection-change' | 'user-joined' | 'user-left', handler: Function): void
  off(event: string, handler: Function): void
}
```

**Internal State**:
- `ydoc`: Y.Doc - Yjs document instance
- `provider`: WebsocketProvider - Sync provider
- `awareness`: Awareness - User presence state
- `connected`: boolean - Connection status

**Dependencies**:
- Yjs library (Y.Doc, Y.Text)
- y-websocket (WebsocketProvider)
- WebSocket connection to server

**File Location**: `src/collaboration/CollaborationManager.ts`

**Testing Approach**:
- Unit test: Mock WebSocket, test lifecycle
- Integration test: Two managers syncing via test WebSocket server

---

### Component 2: SyncServer (Backend)

**Purpose**: WebSocket server for Yjs synchronization

**Responsibilities**:
- Handle WebSocket connections
- Persist Yjs documents to database
- Broadcast updates to connected clients
- Manage document rooms

**Public Interface**:
```typescript
class SyncServer {
  constructor(wss: WebSocketServer, persistence: PersistenceAdapter)

  // Lifecycle
  start(): void
  stop(): void

  // Document management
  getDocument(docId: string): Promise<Y.Doc>
  saveDocument(docId: string): Promise<void>
}
```

**Internal State**:
- `rooms`: Map<string, Set<WebSocket>> - Active document rooms
- `docs`: Map<string, Y.Doc> - Loaded documents
- `persistence`: PersistenceAdapter - Database persistence

**Dependencies**:
- y-websocket (setupWSConnection)
- Database adapter for persistence

**File Location**: `src/server/SyncServer.ts`

**Testing Approach**:
- Unit test: Mock WebSocket and persistence
- Integration test: Multiple clients syncing same document

---

### Component 3: EditorBinding

**Purpose**: Binds Yjs text to code editor (e.g., CodeMirror, Monaco)

**Responsibilities**:
- Sync editor content with Y.Text
- Apply remote changes to editor
- Send local changes to Y.Text
- Render remote cursors/selections

**Public Interface**:
```typescript
class EditorBinding {
  constructor(ytext: Y.Text, editor: Editor, awareness: Awareness)

  // Lifecycle
  attach(): void
  detach(): void

  // Cursor rendering
  renderRemoteCursors(): void
  updateLocalCursor(): void
}
```

**Internal State**:
- `ytext`: Y.Text - Shared text
- `editor`: Editor - Code editor instance
- `awareness`: Awareness - For cursors
- `remoteChanging`: boolean - Flag to prevent update loops

**Dependencies**:
- Yjs (Y.Text)
- Editor instance (CodeMirror/Monaco)
- Awareness provider

**File Location**: `src/collaboration/EditorBinding.ts`

**Testing Approach**:
- Unit test: Mock editor, test sync logic
- Integration test: Two editors syncing via shared Y.Text

---

### Component 4: AwarenessUI

**Purpose**: Renders user presence (cursors, selections, typing indicators)

**Responsibilities**:
- Render remote user cursors in editor
- Show remote selections with color coding
- Display user list with connection status
- Show typing indicators

**Public Interface**:
```typescript
class AwarenessUI {
  constructor(awareness: Awareness, editor: Editor, container: HTMLElement)

  // Lifecycle
  attach(): void
  detach(): void

  // Rendering
  renderCursors(users: Map<number, UserState>): void
  renderUserList(users: Map<number, UserState>): void
}
```

**Internal State**:
- `awareness`: Awareness - User presence state
- `editor`: Editor - For rendering cursors
- `container`: HTMLElement - For user list
- `cursorWidgets`: Map - Editor widgets for cursors

**Dependencies**:
- Awareness provider
- Editor for cursor rendering

**File Location**: `src/collaboration/AwarenessUI.ts`

**Testing Approach**:
- Unit test: Mock awareness events, verify rendering
- Visual test: Manual verification of cursor display

---

## Data Flow Diagram

```
[User types in Editor A]
  ↓
[EditorBinding captures change]
  ↓ [Applies to Y.Text]
[Y.Text generates update]
  ↓ [Sends via WebSocket]
[SyncServer receives update]
  ↓ [Broadcasts to other clients]
[WebSocket delivers to Editor B]
  ↓ [Provider applies to Y.Text]
[EditorBinding detects Y.Text change]
  ↓ [Applies to Editor B]
[User B sees change in editor]

[Parallel: Awareness updates for cursors follow similar flow]
```

**Flow Details**:
1. **Local Edit**: User types → EditorBinding → Y.Text.insert(pos, char)
2. **Update Generation**: Y.Text generates Yjs update (binary)
3. **Network Send**: WebsocketProvider sends update to server
4. **Server Broadcast**: SyncServer broadcasts to all connected clients in room
5. **Remote Receive**: Other clients' providers receive update
6. **Remote Apply**: Y.Text applies update → EditorBinding updates editor

## State Management

**Yjs Document State**:
```typescript
{
  // Shared text content (CRDT)
  text: Y.Text,  // Entire document content with position metadata

  // Awareness (user presence)
  awareness: {
    states: Map<clientId, {
      user: { name: string, color: string },
      cursor: { position: number },
      selection: { start: number, end: number }
    }>
  }
}
```

**State Transitions**:
```
[New Document]
  ↓ [User connects]
[Document with Users]
  ↓ [User edits]
[Document with Edits] + [Pending Sync]
  ↓ [Sync complete]
[Document Synced Across Clients]
  ↓ [User disconnects]
[Document with Remaining Users]
```

**State Invariants**:
- Y.Text always converges to same state on all clients
- Each client has unique clientId in awareness
- Cursor positions always valid for current document length

## Edge Cases Handled

**Edge Case 1**: Concurrent edits at same position
- **Detection**: Two insert operations at same offset, close in time
- **Handling**: Yjs CRDT automatically merges (both inserts preserved, order determined by client IDs)
- **Recovery**: No recovery needed, automatic
- **Test**: Two clients type at same position simultaneously

**Edge Case 2**: User disconnects mid-edit
- **Detection**: WebSocket close event
- **Handling**:
  - Server removes user from awareness
  - Client auto-reconnects (y-websocket built-in)
  - On reconnect, Yjs syncs any missed updates
- **Recovery**: Automatic reconnection and sync
- **Test**: Disconnect network, make edits, reconnect

**Edge Case 3**: Conflicting delete operations
- **Detection**: Two delete operations overlap
- **Handling**: Yjs CRDT resolves (both deletes applied, overlaps handled correctly)
- **Recovery**: Automatic
- **Test**: Two clients delete overlapping text ranges

**Edge Case 4**: Large file (approaching 10MB)
- **Detection**: File size check on load
- **Handling**: Initial sync may be slow (one-time), incremental updates are fast
- **Recovery**: Progress indicator during initial sync
- **Test**: Load 9MB file, verify sync time < 5 seconds

**Edge Case 5**: Cursor position after remote edit
- **Detection**: Remote edit before local cursor
- **Handling**: EditorBinding adjusts cursor position based on edit
- **Recovery**: Cursor position recalculated
- **Test**: Verify cursor doesn't jump incorrectly

**Edge Case 6**: Network latency spikes (>1s)
- **Detection**: WebSocket message delay
- **Handling**: Updates queue, apply when received (eventual consistency)
- **Recovery**: UI shows "syncing" indicator if delay > 2s
- **Test**: Inject artificial latency, verify sync recovers

## Error Handling Strategy

**Recoverable Errors**:
- **WebSocket disconnect**: Auto-reconnect with exponential backoff (1s, 2s, 4s, max 30s)
- **Sync conflict**: Yjs handles automatically
- **Persistence failure**: Retry save 3 times, alert admin if fails

**Non-Recoverable Errors**:
- **Document too large** (>10MB): Reject, show error to user
- **Invalid document format**: Can't load, show error

**Error Reporting**:
- **Logging**: Winston logger (server), console (client dev mode)
- **Monitoring**: Track WebSocket disconnects, sync failures
- **User Feedback**: Toast notifications for connection issues

**Retry Strategy**:
- **Max retries**: 3 for persistence, infinite for WebSocket (with backoff)
- **Backoff**: Exponential (1s, 2s, 4s, 8s, max 30s)
- **Retry conditions**: Network errors (retry), malformed data (don't retry)

## Testing Strategy

**Unit Tests**:
- **CollaborationManager**:
  - Test connect/disconnect lifecycle
  - Test event emission
  - Mock WebSocket and Yjs

- **EditorBinding**:
  - Test local edit → Y.Text update
  - Test Y.Text update → editor change
  - Test cursor position adjustments

- **SyncServer**:
  - Test document loading
  - Test persistence
  - Mock WebSocket connections

**Integration Tests**:
- Test two CollaborationManagers syncing via test WebSocket server
- Test concurrent edits merge correctly
- Test disconnection/reconnection recovery
- Test cursor synchronization

**End-to-End Tests**:
- Full flow: User A types → User B sees change
- Multiple users editing simultaneously
- User disconnect/reconnect scenario
- Large file sync

**Performance Tests**:
- Load test: 10 concurrent users editing
- Stress test: Rapid edits from multiple users
- Latency test: Verify updates arrive < 500ms

**Test Coverage Goals**: 80% for collaboration components

## Performance Considerations

**Expected Load**: 2-3 users typically, up to 10 users max

**Potential Bottlenecks**:
- **Initial sync for large files**: Mitigate with loading indicator, background sync
- **Cursor update frequency**: Mitigate with throttling (update max every 50ms)
- **WebSocket message volume**: Mitigate with Yjs's efficient binary protocol

**Optimization Opportunities**:
- **Lazy load awareness**: Only load when users present
- **Cursor throttling**: Batch cursor updates
- **Persistence debouncing**: Save to DB every 5s, not every change

**Performance Targets**:
- **Edit to visible**: < 200ms on good connection, < 500ms on slow
- **Cursor update**: < 100ms lag typical
- **Initial sync**: < 2s for typical files, < 5s for large files

## Security Considerations

**Security Requirements**:
- Authenticate users before allowing document access
- Authorize users for specific documents
- Prevent unauthorized document viewing/editing

**Implementation**:
- **Authentication**: JWT tokens in WebSocket handshake
- **Authorization**: Server checks user permissions for document ID
- **Data Protection**: HTTPS for WebSocket (WSS)

**Attack Vectors Considered**:
- **Unauthorized access**: Mitigated by auth/authz on WebSocket connect
- **Document injection**: Yjs validates update format
- **DoS via large documents**: Size limit enforcement

**Data Protection**:
- **In-transit**: WSS (WebSocket Secure)
- **At-rest**: Database encryption (handled by DB layer)

## Integration Points

**Existing System Integration**:
- **Auth System**: Provide user ID and token for WebSocket auth
- **Document Storage**: Load/save documents from existing database
- **Editor Component**: Integrate EditorBinding with current code editor

**API Contracts**:
- **WebSocket Endpoint**: `wss://server/collaboration/:docId`
- **Auth Header**: `Authorization: Bearer <JWT>`

**Event Contracts**:
- **user-joined**: `{ userId, userName, color }`
- **user-left**: `{ userId }`
- **connection-change**: `{ connected: boolean }`

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔄 Facilitator: Design Completeness Check

Let's validate this design:

1. **Requirements Coverage**:
   - ✓ Real-time sync: Yjs + WebSocket
   - ✓ Auto-merge: CRDT built-in
   - ✓ Cursors/selections: Awareness API
   - ✓ Disconnection handling: Auto-reconnect
   - ✓ Auto-save: Server persistence layer

   All covered?

2. **Edge Cases**:
   - ✓ Concurrent edits: Handled by CRDT
   - ✓ Disconnection: Auto-reconnect
   - ✓ Large files: Progress indicator
   - ✓ Cursor positioning: EditorBinding logic

   Any others you're concerned about?

3. **Implementation Clarity**:
   - Component responsibilities clear?
   - Yjs integration approach make sense?
   - Any areas needing more detail?

4. **Testing**: Can we effectively test this?

5. **Timeline**: Still 1-2 days with this design?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

User: Looks comprehensive. One question: how do we handle user A editing while user B is offline, then B comes back online?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔄 Facilitator: Great question, let me clarify that edge case.

**Edge Case 7**: User B offline while User A edits

**Scenario**:
1. User A and B both online, editing document
2. User B loses connection (offline)
3. User A makes edits while B offline
4. User B reconnects

**Handling**:
1. **Server Side**: Continues accepting User A's edits, persists to database
2. **User B Offline**: Yjs document on B's client frozen at last sync state
3. **User B Reconnects**:
   - WebSocket reconnects automatically
   - Yjs sync protocol kicks in:
     - B sends its last known state vector to server
     - Server calculates diff (missing updates B didn't see)
     - Server sends only missing updates to B
     - B applies updates, catching up to current state
4. **Conflict Resolution**: If B made edits while offline (local-only), those merge with A's edits via CRDT when syncing

**Result**: B catches up to current state seamlessly, any offline edits B made are merged

**Implementation**: This is built into Yjs sync protocol, no extra code needed

**Test**: Disconnect B, have A edit, reconnect B, verify B sees A's changes

Does that address your concern?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

User: Perfect. Design looks ready.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ PHASE 4: VALIDATION & DOCUMENTATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Validation Checklist

### Requirements Coverage
- ✓ All functional requirements addressed
- ✓ All quality attributes considered
- ✓ All edge cases have handling
- ✓ Error scenarios covered
- ✓ Success criteria can be met

### Design Quality
- ✓ Components have single, clear responsibilities
- ✓ Interfaces are well-defined
- ✓ Dependencies are manageable (Yjs library)
- ✓ State management is clear (CRDT)
- ✓ Data flow is well-documented

### Testing Readiness
- ✓ Unit tests feasible for each component
- ✓ Integration tests can verify sync
- ✓ Edge cases are testable
- ✓ Mocking strategy clear
- ✓ Performance testing approach defined

### Integration
- ✓ Aligns with existing patterns (WebSocket, component architecture)
- ✓ Follows project conventions
- ✓ Compatible with existing editor
- ✓ No conflicts
- ✓ Integration points defined

### Implementation Readiness
- ✓ Design detailed enough to implement
- ✓ Unknowns addressed (offline/online sync)
- ✓ Risk mitigation in place (using proven library)
- ✓ File locations specified
- ✓ Implementation path clear

All checks pass! ✅

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Pattern Extracted

### Pattern: CRDT-Based Real-Time Collaboration

**Category**: Architectural

**Problem**: Enable multiple users to edit shared document simultaneously without conflicts or lost data

**Context**: When you need:
- Real-time collaborative editing
- Automatic conflict resolution
- Offline/online resilience
- 2-10 concurrent users

**Solution**: Use CRDT library (Yjs) with WebSocket sync

**Structure**:
```typescript
CollaborationManager ←→ Y.Doc (CRDT)
                      ←→ WebsocketProvider
                      ←→ Awareness (cursors)
                           ↓
EditorBinding ←→ Editor UI
                           ↓
AwarenessUI ←→ Cursor/User rendering
```

**Components**:
- **CollaborationManager**: Orchestrates collaboration session
- **SyncServer**: WebSocket server for sync
- **EditorBinding**: Binds CRDT to editor UI
- **AwarenessUI**: Renders user presence

**Benefits**:
✓ Automatic conflict resolution (CRDT guarantees)
✓ Proven library vs custom algorithm
✓ Offline-first friendly
✓ Good performance (efficient binary protocol)

**Trade-offs**:
⚠️ Dependency on Yjs library
⚠️ Larger payload than simple text sync

**Related Patterns**:
- WebSocket pattern (for real-time communication)
- Component binding pattern (editor integration)

**Example Usage**: TASK-078 - Real-time code editor collaboration

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Decision Record

**Decision**: Use Yjs CRDT library for real-time collaboration

**Date**: [YYYY-MM-DD]

**Context**: Need to enable 2-3 users to collaboratively edit code files in real-time with automatic conflict resolution that preserves all work

**Alternatives Considered**:

**Option A**: Operational Transformation (OT)
- Pros: Proven (Google Docs), deterministic
- Cons: Complex to implement correctly
- Rejected because: High implementation risk, team lacks OT experience

**Option B**: Last Write Wins with Diff/Patch
- Pros: Simple to implement
- Cons: Can lose work (doesn't meet requirements)
- Rejected because: Violates "no lost work" requirement

**Option C**: Yjs CRDT ← **SELECTED**
- Pros: Proven library, automatic merging, lower risk, reasonable effort
- Cons: External dependency, larger payload
- Selected because: Best fit for requirements, lowest risk, no CRDT/OT expertise needed

**Consequences**:

**Positive**:
- Fast implementation (library does heavy lifting)
- Low risk of data corruption (battle-tested library)
- Built-in offline support (eventual consistency)
- Awareness API for cursors included

**Negative** (accepted):
- Dependency on external library (mitigated: Yjs is mature, maintained)
- Larger message size (acceptable for 2-3 users, small files)

**Risks and Mitigations**:
- **Risk**: Library abandonment
  - Mitigation: Yjs is widely used, active maintenance
- **Risk**: Edge case merge behaviors unintuitive
  - Mitigation: Can add manual resolution UI later
- **Risk**: Performance with many users
  - Monitoring: Track sync latency

**Revisit Triggers**:
- If scale exceeds 10 concurrent users
- If Yjs library becomes unmaintained
- If payload size becomes performance issue

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Memory bank updates performed...]

✓ systemPatterns.md - CRDT Collaboration pattern added
✓ tasks.md - TASK-078 updated with design
✓ activeContext.md - Creative session documented

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 CREATIVE SESSION COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

**Topic**: Real-Time Collaboration Mechanism
**Duration**: ~28 minutes

## What We Accomplished

✅ **Deep Problem Analysis**: Understood collaborative editing requirements, constraints, and success criteria

✅ **Approaches Explored**: 4 solution approaches
- Operational Transformation (OT): Rejected (high complexity)
- Last Write Wins: Rejected (loses work)
- Pure CRDT (Yjs): **Selected**
- Hybrid CRDT + Manual UI: Deferred (can add later)

✅ **Solution Selected**: Yjs CRDT Library
- **Why**: Proven library, automatic merging, lowest risk, meets all requirements
- **Trade-offs accepted**: External dependency, larger payload (both acceptable)

✅ **Design Detailed**:
- 4 components designed (CollaborationManager, SyncServer, EditorBinding, AwarenessUI)
- 7 edge cases handled (including offline/online sync)
- Testing strategy defined (unit, integration, e2e, performance)
- Error handling specified (auto-reconnect, retries)

✅ **Patterns Documented**: 1 new pattern
- CRDT-Based Real-Time Collaboration pattern added to systemPatterns.md

✅ **Implementation Readiness**: ✅ High confidence
- All unknowns addressed
- Design is detailed and actionable
- Library selection reduces implementation risk

## Memory Bank Updates

✓ systemPatterns.md - CRDT Collaboration pattern added
✓ tasks.md - TASK-078 updated with detailed design
✓ activeContext.md - Creative session documented
✓ projectbrief.md - Decision log updated (architectural choice)

## Next Action

→ **Ready to implement**: /cf:code TASK-078-1 (Setup Yjs and WebSocket server)

With this thorough exploration, implementation should be straightforward:
1. Install Yjs and y-websocket
2. Implement SyncServer (backend)
3. Implement CollaborationManager (frontend)
4. Implement EditorBinding
5. Implement AwarenessUI
6. Test and validate

Estimated effort: 1-2 days as planned

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

**Confidence Level**: High

Design is comprehensive, backed by proven library, all edge cases considered. Implementation path is clear.
```

---

## Key Takeaways from Example

1. **Thorough Problem Understanding**: Phase 1 dug deep to understand the true requirements
2. **Multiple Solution Paths**: Explored 4 distinct approaches, not just one
3. **Systematic Comparison**: Used Sequential MCP for structured reasoning
4. **User Collaboration**: Facilitator asked targeted questions, not generic "thoughts?"
5. **Detailed Design**: Phase 3 specified components, data flow, edge cases, testing
6. **Pattern Extraction**: Documented reusable CRDT collaboration pattern
7. **Decision Record**: Captured "why" with rationale and alternatives
8. **Implementation Ready**: Developer can implement confidently from this design

---

**Version**: 1.0
**Last Updated**: 2025-10-05
