---
description: "Deep exploration and creative problem-solving for high-complexity challenges"
allowed-tools: ['Read', 'Task', 'mcp__sequential-thinking__sequentialthinking']
argument-hint: "[task-id|topic]"
---

# Command: /cf:creative

## Usage

```
/cf:creative [task-id|topic]
```

## Parameters

- `[task-id|topic]`: **Required** - Task ID (e.g., TASK-003-2) or topic description

---

## Purpose

Engage in deep, structured exploration for:
- Novel technical challenges without established patterns
- High-risk architectural decisions requiring careful analysis
- Complex algorithm or data structure design
- System integration with multiple unknowns
- Problems requiring creative problem-solving and trade-off analysis
- Sub-tasks identified as "high complexity" during planning

**Philosophy**: Some problems can't be solved with standard planning. They need deep thinking, multiple solution explorations, and iterative refinement through expert collaboration.

---

## Prerequisites

**Memory bank must be initialized**: Run `/cf:init [project-name]` first if needed.

**Problem or task must exist**: Works best with:
- Task ID from tasks.md (especially complex sub-tasks)
- Clear problem statement to explore
- Architectural decision requiring analysis

---

## When to Use

**Use /cf:creative when:**
- `/cf:plan` identifies a sub-task as "high complexity, recommend /cf:creative"
- Facing novel problem without established solution pattern
- Multiple solution approaches exist, need systematic comparison
- High risk of wrong approach causing major rework
- Need to explore trade-offs deeply before committing
- Designing new architectural pattern or system component
- Problem involves significant unknowns or uncertainties

**Don't use when:**
- Problem has established pattern in systemPatterns.md (use standard `/cf:code`)
- Simple enhancement with clear approach (use `/cf:plan` → `/cf:code`)
- Time-critical bug fix (solve directly, refine later)
- Exploring "nice to have" features (use `/cf:facilitate --mode explore`)

**Decision Matrix:**
```
Problem is straightforward? → /cf:code
Problem needs planning? → /cf:plan
Plan reveals complex sub-step? → /cf:creative
Need to explore idea? → /cf:facilitate --mode explore
```

---

## Process

### Step 1: Verify Prerequisites

**Check memory bank exists**:
```
If NOT EXISTS:
⚠️ Memory bank not initialized. Run: /cf:init [project-name]
```

**Check task exists (if task-id provided)**:
```
If NOT FOUND:
❌ Task [task-id] not found in tasks.md

Create task first with: /cf:feature [description]
```

---

### Step 2: Load Context

**For task ID**, read:
- `tasks.md` - Task details, complexity, any existing plan
- `systemPatterns.md` - Existing patterns to build upon
- `productContext.md` - User needs and requirements
- `activeContext.md` - Current project state
- `projectbrief.md` - Project constraints and goals

**For topic**, search memory bank:
- Grep for related keywords
- Load relevant sections
- Identify related tasks or patterns

**Context synthesis**:
- What is the core problem?
- What makes this complex/novel?
- What constraints apply?
- What success looks like?

---

### Step 3: Creative Session Introduction

**Always interactive** (Facilitator enforced, cannot opt-out)

```markdown
💡 CREATIVE SESSION: [Task/Topic Name]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

**Problem**: [Brief problem statement]
**Complexity**: [What makes this challenging]
**Goal**: Explore solutions systematically, select best approach

**Agents Engaged**:
🔄 Facilitator - Guides exploration, asks probing questions
🏗️ Architect - Technical approaches and trade-offs
🎨 Product - User needs and requirements validation
🧠 Sequential - Structured reasoning and hypothesis testing

**Extended Thinking Enabled**:
This session uses Claude's extended thinking mode for deeper analysis:
- Phase 1 (Deep-Dive): "think" - Uncover non-obvious requirements
- Phase 2 (Exploration): "think hard" to "ultrathink" - Systematic trade-off analysis
- Phase 3 (Refinement): "think hard" - Component design and edge cases
- Phase 4 (Validation): "think" - Completeness verification

**Process** (4 phases):
1. Problem Deep-Dive - Understand thoroughly
2. Solution Exploration - Generate & analyze approaches with deep reasoning
3. Design Refinement - Detail selected solution
4. Validation & Documentation - Verify and document

Estimated time: 20-35 minutes (worth the investment for high-stakes decisions!)

Ready to begin?
```

---

### Step 4: Phase 1 - Problem Deep-Dive

**Facilitator + Product lead**, Architect contributes **with initial thinking**

**Goal**: Deeply understand the problem, surface hidden complexities

**Thinking Directive**: "think" (baseline exploration to uncover non-obvious requirements)

**Facilitator asks systematic questions**:

```markdown
🔄 PHASE 1: PROBLEM DEEP-DIVE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Let's ensure we fully understand the problem before exploring solutions.

## Understanding the Core Problem

**🎨 Product Questions**:
1. What is the core user need or technical requirement?
2. What happens if we solve this incorrectly?
3. Are there any non-obvious requirements we should consider?

**🏗️ Architect Questions**:
1. What makes this technically challenging?
2. What are the critical constraints (performance, scalability, etc.)?
3. Are there dependencies on other systems or components?

## Identifying Unknowns

**What do we KNOW for certain about this problem?**
**What do we NOT KNOW but need to find out?**
**What assumptions are we making?**

## Success Criteria

**How will we know we've solved this well?**
- Functional requirements: [What must work]
- Non-functional requirements: [Performance, security, maintainability]
- Edge cases: [What unusual scenarios must handle]

---

Please answer what you can. We'll refine understanding together.
```

**User provides responses**

**Facilitator synthesizes**:

```markdown
## Problem Understanding (Refined)

**Core Problem**: [Synthesized from discussion]

**Requirements**:
- Must have: [Critical requirements]
- Should have: [Important but not critical]
- Nice to have: [Enhancements]

**Constraints**:
- Technical: [Technology, architecture, integration constraints]
- Resource: [Time, complexity, skill constraints]
- Business: [User experience, performance, compliance]

**Success Criteria**:
✓ [Criterion 1 - measurable]
✓ [Criterion 2 - measurable]
✓ [Criterion 3 - measurable]

**Known Unknowns**: [What needs research/experimentation]
**Key Assumptions**: [What we're assuming]

---

Ready to explore solutions? (Type 'yes' or ask for more clarification)
```

---

### Step 5: Phase 2 - Solution Exploration

**Architect leads**, Facilitator coordinates, Sequential provides structured reasoning **with extended thinking**

**Goal**: Generate 3-5 solution approaches, analyze each systematically with deep reasoning

**Thinking Budget Levels** (applied based on complexity):
- **Standard creative session**: "think hard" (moderate depth, 2-4 approaches)
- **High-risk architectural decision**: "think harder" (comprehensive depth, 4-5 approaches)
- **Novel system design**: "ultrathink" (maximum depth, exhaustive analysis)

**Architect presents approaches**:

```markdown
🧠 PHASE 2: SOLUTION EXPLORATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Based on our problem understanding, here are potential approaches:

## Approach A: [Name - e.g., "Token-Based State Management"]

**Description**: [How this approach works]

**Implementation Overview**:
- Component 1: [What it does]
- Component 2: [What it does]
- Data flow: [How information moves]

**Pros**:
✓ [Advantage 1]
✓ [Advantage 2]
✓ [Advantage 3]

**Cons**:
⚠️ [Limitation 1]
⚠️ [Limitation 2]

**Complexity**: [Low/Medium/High]
**Risk**: [Low/Medium/High with explanation]
**Effort**: [Time estimate]

---

## Approach B: [Name - e.g., "Event-Driven Architecture"]

**Description**: [How this approach works]

**Implementation Overview**:
- Component 1: [What it does]
- Component 2: [What it does]
- Data flow: [How information moves]

**Pros**:
✓ [Advantage 1]
✓ [Advantage 2]

**Cons**:
⚠️ [Limitation 1]
⚠️ [Limitation 2]
⚠️ [Limitation 3]

**Complexity**: [Low/Medium/High]
**Risk**: [Low/Medium/High with explanation]
**Effort**: [Time estimate]

---

## Approach C: [Name - e.g., "Hybrid: Token + Event Sync"]

**Description**: [How this approach works]

**Implementation Overview**:
- Component 1: [What it does]
- Component 2: [What it does]
- Data flow: [How information moves]

**Pros**:
✓ [Advantage 1 - best of both]
✓ [Advantage 2]

**Cons**:
⚠️ [Limitation 1 - added complexity]

**Complexity**: [Low/Medium/High]
**Risk**: [Low/Medium/High with explanation]
**Effort**: [Time estimate]

---

🔄 Facilitator: Let's analyze these systematically.

Initial thoughts on these approaches? Any that clearly won't work for your context?
```

**User provides initial reactions**

**Sequential MCP engaged for deep structured comparison**:

```markdown
🧠 Extended Thinking Analysis: Deep Approach Comparison
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

**Thinking Directive**: [think hard | think harder | ultrathink]

> Engaging extended thinking mode to thoroughly evaluate solution alternatives,
> test hypotheses against requirements, and identify subtle trade-offs that
> might not be immediately apparent.

Let me reason through these approaches against your requirements:

**Hypothesis 1**: Approach A (Token-Based) is simplest and meets core requirements.

Testing against criteria:
- ✓ Meets functional requirement: state persistence
- ✓ Low complexity (easier to maintain)
- ⚠️ May not scale well with requirement: [specific scaling need]
- ❌ Doesn't address edge case: [specific edge case]

**Hypothesis 2**: Approach B (Event-Driven) handles edge cases better but adds complexity.

Testing against criteria:
- ✓ Handles edge case: [specific edge case]
- ✓ Scales better for requirement: [specific need]
- ⚠️ Higher complexity (learning curve, debugging)
- ❌ May be over-engineering for current scope

**Hypothesis 3**: Approach C (Hybrid) balances trade-offs.

Testing against criteria:
- ✓ Core simplicity of A with edge case handling of B
- ✓ Gradual complexity (start simple, add events where needed)
- ⚠️ Risk of "worst of both worlds" if not careful
- ✓ Most flexible for future evolution

**Deep Trade-off Analysis** (extended thinking):
[Systematic exploration of second-order effects, maintenance implications,
team capability requirements, migration complexity, future extensibility,
performance characteristics under edge conditions]

**Preliminary Recommendation**: Approach [X] because:
1. [Reason 1 based on requirements]
2. [Reason 2 based on constraints]
3. [Reason 3 based on risk tolerance]
4. [Reason 4 from deep analysis - non-obvious factor]

**Alternative**: Approach [Y] if [condition changes]

**Critical Assumptions Identified**:
- [Assumption 1 that recommendation depends on]
- [Assumption 2 to validate during implementation]

**Risk Mitigation Strategies**:
- [Strategy 1 for primary risk]
- [Strategy 2 for secondary risk]
```

**Facilitator asks refining questions**:

```markdown
🔄 Facilitator: Narrowing the Field

Based on Sequential's analysis and your requirements:

1. **Approach A** is simplest but may have [specific limitation]. Is [limitation] acceptable for your use case, or is it a deal-breaker?

2. **Approach C** (hybrid) offers flexibility but adds some complexity. Is the added complexity justified by [specific benefit]?

3. **Risk Tolerance**: You mentioned [time/quality constraint]. Does that push us toward simpler (A) or more robust (B/C)?

4. **Future Evolution**: Do you foresee [potential future requirement]? If yes, that favors [approach that handles it].

Your thoughts?
```

**Iterative refinement** until approach selected or hybrid defined

---

### Step 6: Phase 3 - Design Refinement

**Architect + Facilitator**, informed by selected approach **with detailed thinking**

**Goal**: Detail the selected solution with implementation specifics

**Thinking Directive**: "think hard" (systematic component design, edge case identification)

```markdown
🏗️ PHASE 3: DESIGN REFINEMENT
━━━━━━━━━━━━━━━━━━━━━━━━━━

**Selected Approach**: [Chosen solution name]

## Detailed Design

### Component Architecture

**Component 1: [Name]**
- **Purpose**: [What it does]
- **Responsibilities**:
  - [Responsibility 1]
  - [Responsibility 2]
- **Interface**: [Public API or contract]
- **Dependencies**: [What it needs]
- **File location**: [Suggested path]

**Component 2: [Name]**
- **Purpose**: [What it does]
- **Responsibilities**:
  - [Responsibility 1]
  - [Responsibility 2]
- **Interface**: [Public API or contract]
- **Dependencies**: [What it needs]
- **File location**: [Suggested path]

### Data Flow

```
[Step 1: Entry point]
  ↓
[Step 2: Processing]
  ↓
[Step 3: State change]
  ↓
[Step 4: Side effects]
  ↓
[Step 5: Output/response]
```

### State Management

**State Structure**:
```
{
  field1: [type] - [purpose],
  field2: [type] - [purpose]
}
```

**State Transitions**:
- [Event 1] → [New state]
- [Event 2] → [New state]

### Edge Cases Handled

1. **[Edge case 1]**: [How design handles it]
2. **[Edge case 2]**: [How design handles it]
3. **[Edge case 3]**: [How design handles it]

### Error Handling Strategy

- **Recoverable errors**: [Approach - retry, fallback, etc.]
- **Non-recoverable errors**: [Approach - fail gracefully, alert, etc.]
- **Error reporting**: [Where errors go]

### Testing Strategy

**Unit Tests**:
- Test [component 1]: [Key test cases]
- Test [component 2]: [Key test cases]

**Integration Tests**:
- Test [integration point 1]: [Scenario]
- Test [integration point 2]: [Scenario]

**Edge Case Tests**:
- Test [edge case 1]: [How to test]
- Test [edge case 2]: [How to test]

### Performance Considerations

- **Expected load**: [Estimate]
- **Bottleneck risk**: [Potential issue and mitigation]
- **Optimization opportunities**: [Where to optimize if needed]

---

🔄 Facilitator: Review Questions

1. Does this design address all requirements we identified?
2. Are there any gaps or areas needing more detail?
3. Any concerns about implementation complexity?
4. Does this align with existing patterns in systemPatterns.md?

Let's refine anything that needs it.
```

**Iterative refinement** until design is solid

---

### Step 7: Phase 4 - Validation & Documentation

**Facilitator + Documentarian**, all agents validate **with comprehensive thinking**

**Goal**: Verify completeness, document decisions, prepare for implementation

**Thinking Directive**: "think" (systematic validation against requirements, gap identification)

```markdown
✅ PHASE 4: VALIDATION & DOCUMENTATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Validation Checklist

### Requirements Coverage
- [✓/❌] All functional requirements addressed
- [✓/❌] All non-functional requirements considered
- [✓/❌] All edge cases have handling strategy
- [✓/❌] Error scenarios covered

### Design Quality
- [✓/❌] Components have single, clear responsibilities
- [✓/❌] Interfaces are well-defined
- [✓/❌] State management is explicit
- [✓/❌] Testing strategy is comprehensive

### Integration
- [✓/❌] Aligns with existing systemPatterns.md patterns
- [✓/❌] Follows project architectural conventions
- [✓/❌] Dependencies are manageable
- [✓/❌] No conflicts with other components

### Implementation Readiness
- [✓/❌] Design is detailed enough to implement
- [✓/❌] Unknowns have been identified and addressed
- [✓/❌] Risk mitigation strategies in place
- [✓/❌] Clear testing approach defined

---

## Patterns Identified

### New Pattern: [Pattern Name]

**Context**: When [situation where this applies]

**Problem**: [What problem it solves]

**Solution**: [How the pattern works - reference the design above]

**Benefits**:
- ✓ [Benefit 1]
- ✓ [Benefit 2]

**Trade-offs**:
- ⚠️ [Trade-off 1]

**Related Patterns**: [Existing patterns this builds on or relates to]

**Example**: See TASK-[ID] implementation

---

[Additional patterns if identified]

---

## Decision Record

**Decision**: Use [selected approach]

**Context**: [Problem we were solving]

**Alternatives Considered**:
1. [Approach A]: Rejected because [reason]
2. [Approach B]: Rejected because [reason]
3. [Approach C]: Selected because [reason]

**Consequences**:
- **Positive**: [Benefits gained]
- **Negative**: [Costs accepted]
- **Risks**: [Risks and mitigations]

**Revisit Trigger**: [What would cause us to reconsider - e.g., "if scale exceeds X"]

---

🔄 Facilitator: Final Confirmation

We've thoroughly explored this problem and designed a solution.

Summary:
✓ Problem understood deeply
✓ [N] approaches explored
✓ Best approach selected with rationale
✓ Design detailed and validated
✓ [N] new patterns identified
✓ All requirements covered

Are you confident in this approach and ready to implement?
```

---

### Step 8: Update Memory Bank

**Documentarian performs updates**:

#### systemPatterns.md - Add New Patterns

```markdown
### [Pattern Name] - [YYYY-MM-DD]

**Category**: [Architectural/Design/Implementation]
**Source**: Creative session for TASK-[ID]

**Context**: [When this pattern applies]

**Problem**: [What it solves]

**Solution**:
[Pattern implementation - reference design components]

**Structure**:
```[language]
[Code structure or component diagram]
```

**Benefits**:
- ✓ [Benefit 1]
- ✓ [Benefit 2]

**Trade-offs**:
- ⚠️ [Trade-off 1]

**Examples in Codebase**: Will be added in TASK-[ID] implementation

**Related Patterns**: [Connection to existing patterns]

**Revision History**:
- [YYYY-MM-DD]: Defined during creative session
```

#### tasks.md - Update Task with Refined Approach

```markdown
**Creative Session**: ✅ Complete ([YYYY-MM-DD])

**Approach Selected**: [Solution name]

**Implementation Notes**:
- [Note 1 from design]
- [Note 2 from design]

**Edge Cases to Handle**:
- [Edge case 1]
- [Edge case 2]

**Testing Requirements**:
- [Test requirement 1]
- [Test requirement 2]

**Patterns to Apply**: [Pattern name] (see systemPatterns.md)

**Decision Rationale**: [Brief summary of why this approach]
```

#### activeContext.md - Add Creative Session Entry

```markdown
### [YYYY-MM-DD HH:MM] - Creative Session: [Topic]

**Task**: TASK-[ID]
**Agents**: Facilitator + Architect + Product + Sequential
**Duration**: [Estimate based on session]

**Problem Explored**: [One-line problem statement]

**Solution Designed**: [Selected approach]

**Key Decisions**:
1. [Decision 1] - [Rationale]
2. [Decision 2] - [Rationale]

**Patterns Created**: [N] new patterns added to systemPatterns.md

**Next Action**: Ready for /cf:code TASK-[ID]
```

#### projectbrief.md - Decision Log (if architectural)

If decision has project-wide implications:

```markdown
| Date | Decision | Rationale | Alternatives |
|------|----------|-----------|--------------|
| [YYYY-MM-DD] | [Architectural decision] | [Why - from creative session] | [Approaches rejected] |
```

---

### Step 9: Creative Session Summary

**Output to user**:

```markdown
💡 CREATIVE SESSION COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

**Topic**: [Task/Problem name]
**Duration**: [Actual time]

## What We Accomplished

✅ **Deep Problem Analysis**: [Summary of problem understanding]

✅ **Approaches Explored**: [N] solution approaches analyzed
- [Approach A]: [Brief description]
- [Approach B]: [Brief description]
- [Approach C]: [Brief description]

✅ **Solution Selected**: [Chosen approach]
- **Why**: [Top 3 reasons for selection]
- **Trade-offs accepted**: [Key trade-offs]

✅ **Design Detailed**:
- [N] components designed
- [N] edge cases handled
- Testing strategy defined
- Error handling approach specified

✅ **Patterns Documented**: [N] new patterns added to systemPatterns.md
- [Pattern 1 name]
- [Pattern 2 name]

✅ **Implementation Readiness**: All unknowns addressed, design is actionable

## Memory Bank Updates

✓ systemPatterns.md - [N] patterns added
✓ tasks.md - Task updated with refined approach
✓ activeContext.md - Creative session documented
[✓ projectbrief.md - Decision log updated]

## Next Action

→ **Ready to implement**: /cf:code TASK-[ID]

With this thorough exploration, implementation should be straightforward following the detailed design.

**Alternative**: If you want to review the design before implementing:
- Review: memory-bank/systemPatterns.md (new patterns)
- Review: memory-bank/tasks.md (task notes)
- Refine further: /cf:facilitate TASK-[ID] --mode validate

---

**Confidence Level**: [High/Medium] - [Brief explanation]
```

---

## Examples

### Example 1: OAuth Token Refresh Mechanism (Complex Sub-Task)

```
User: /cf:creative TASK-042-3

Claude:
[Loads TASK-042-3 from tasks.md: "OAuth token refresh mechanism"]

💡 CREATIVE SESSION: OAuth Token Refresh Mechanism
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

**Problem**: Design secure, reliable token refresh mechanism
**Complexity**: High - Security implications, race conditions, edge cases
**Goal**: Explore solutions systematically, select best approach

[Agents engaged message]

Ready to begin?

User: Yes

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔄 PHASE 1: PROBLEM DEEP-DIVE

**🎨 Product Questions**:
1. What is the user experience we want? Silent refresh or prompt?
2. What happens if refresh fails - force re-login immediately or retry?

**🏗️ Architect Questions**:
1. Access token lifetime? Refresh token lifetime?
2. How do we handle concurrent requests during refresh?
3. Storage security for refresh tokens?

User: Silent refresh preferred. If refresh fails, retry once then force re-login. Access token 15min, refresh 7 days. Must handle concurrent requests gracefully. Refresh tokens in httpOnly cookie.

[Facilitator synthesizes understanding...]
[Ready for solution exploration...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🧠 PHASE 2: SOLUTION EXPLORATION

**Approach A: Request Interceptor with Queue**
- Intercept 401 responses
- Queue pending requests during refresh
- Single refresh attempt for concurrent requests
- Pros: Clean separation, handles concurrency well
- Cons: Complex state management, testing complexity
- Complexity: Medium-High

**Approach B: Proactive Refresh with Timer**
- Refresh before expiry (e.g., at 12min for 15min token)
- Background timer triggers refresh
- No 401 handling needed
- Pros: Simpler, better UX (no delay on request)
- Cons: Timer management, may refresh unnecessarily
- Complexity: Medium

**Approach C: Hybrid - Proactive + Interceptor Fallback**
- Primary: Timer-based proactive refresh
- Fallback: Interceptor handles edge cases (page wake, clock skew)
- Pros: Best UX, handles all cases
- Cons: Most complex
- Complexity: High

[Sequential analysis...]
[User provides thoughts...]
[Facilitator refines...]

Selected: Approach C (Hybrid)
Rationale: Best UX (proactive) with safety net (interceptor) justifies added complexity

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🏗️ PHASE 3: DESIGN REFINEMENT

**Component 1: TokenManager**
- Manages access/refresh tokens
- Exposes: getValidToken(), forceRefresh()
- Handles: Storage, expiry tracking, refresh coordination

**Component 2: RefreshTimer**
- Schedules proactive refresh
- Calculates refresh timing (80% of token lifetime)
- Handles: Page visibility, sleep/wake events

**Component 3: RequestInterceptor**
- Catches 401 errors
- Queues requests during refresh
- Replays after fresh token obtained

[Detailed data flow...]
[Edge cases: concurrent refresh, network failure, clock skew...]
[Error handling: exponential backoff, max retries...]
[Testing strategy...]

[User validates design...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ PHASE 4: VALIDATION & DOCUMENTATION

[Validation checklist all ✓]

**New Pattern**: Token Refresh with Proactive Timer + Interceptor Fallback

**Decision**: Use hybrid approach (proactive + fallback)
- Rejected: Request interceptor only (worse UX)
- Rejected: Timer only (edge case failures)

[Pattern documented in systemPatterns.md]
[Task updated with approach]
[Active context updated]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 CREATIVE SESSION COMPLETE

**Topic**: OAuth Token Refresh Mechanism
**Duration**: ~25 minutes

**Approaches Explored**: 3
**Solution Selected**: Hybrid (Proactive Timer + Interceptor Fallback)
**Patterns Documented**: 1 (Token Refresh pattern)
**Implementation Readiness**: ✅ High confidence

→ **Next**: /cf:code TASK-042-3

The design is detailed and tested against edge cases. Implementation should be straightforward.
```

---

## Error Handling

### Task Not Found

```
❌ Task TASK-099-3 not found in tasks.md

Checked: tasks.md

Ensure task exists before creative session.

Create task with: /cf:feature [description]
```

### Memory Bank Not Initialized

```
⚠️ Memory Bank Not Initialized

Run: /cf:init [project-name]
```

### Topic Too Vague

```
⚠️ Topic Needs Clarity

Topic provided: "improve performance"

This is too broad for deep exploration. Please be more specific:
- Which component or feature?
- What performance issue specifically?
- What's the current behavior vs desired?

Example: "improve dashboard load time (currently 3s, target <1s)"

Or create a task first with /cf:feature for complexity assessment.
```

### No Complexity Justification

```
ℹ️ Consider Simpler Approach

Topic: [Simple topic that doesn't need /cf:creative]

This seems straightforward enough for standard planning.

Suggested workflow:
1. /cf:plan [topic] - Create plan with Architect + Product
2. /cf:code [task] - Implement directly

/cf:creative is for high-complexity, novel problems without established patterns.

Continue with creative session anyway? (not recommended)
```

---

## Integration with Other Commands

**Typical workflows**:

```
# Complex task discovered during planning
/cf:plan TASK-050 (Level 3)
→ Creates 6 sub-tasks
→ "Sub-task 4 (distributed cache sync) is high complexity"
→ "Recommend /cf:creative TASK-050-4 before implementation"

/cf:creative TASK-050-4
→ Deep exploration
→ Solution designed and documented

/cf:code TASK-050-4
→ Implementation follows refined design

# Novel architectural challenge
User identifies: "Need real-time collaboration, no established pattern"

/cf:feature "add real-time collaboration to editor"
→ Assessor: Level 4 (Complex System)

/cf:plan realtime-collab
→ Creates plan
→ Entire feature is novel, recommend /cf:creative upfront

/cf:creative realtime-collab
→ Comprehensive exploration of real-time approaches
→ WebSocket vs CRDT vs OT comparison
→ Design selected and validated

/cf:code [sub-tasks from refined plan]

# Validating complex design before implementation
/cf:plan TASK-080 --interactive
→ Plan created and refined with Facilitator

/cf:creative TASK-080 (optional validation)
→ Deep analysis confirms approach
→ Identifies edge cases plan didn't cover
→ Refined design ready for implementation

/cf:code TASK-080
→ Confident implementation
```

---

## Notes

- **Always interactive**: Cannot opt-out of Facilitator, deep thinking requires human input
- **Time investment**: 20-35 minutes average (longer with ultrathink), but prevents hours/days of rework
- **Use sparingly**: For genuinely complex problems, not routine tasks
- **Complements /cf:plan**: Plan breaks down work, creative explores complex pieces
- **Complements /cf:facilitate**: Facilitate refines existing content, creative explores new solutions
- **Extended thinking integration**: Uses Claude's thinking modes for deeper analysis
  - **"think"**: Default for problem understanding and validation phases
  - **"think hard"**: Default for solution comparison and design refinement
  - **"think harder"**: High-risk architectural decisions with 4-5 solution approaches
  - **"ultrathink"**: Novel system designs requiring exhaustive analysis and edge case exploration
- **MCP Sequential**: Used for structured reasoning when comparing approaches with extended thinking
- **Patterns emerge**: Creative sessions often produce reusable patterns for systemPatterns.md
- **Decision documentation**: Records why specific approach chosen (prevents future confusion)
- **Can revisit**: If implementation reveals issues, run creative session again with new insights
- **Thinking budget adapts**: Complexity assessment determines which thinking level to use in Phase 2

---

## Related Commands

- `/cf:plan` - Standard planning, identifies when creative needed
- `/cf:facilitate` - Interactive refinement of existing plans
- `/cf:code` - Implementation after creative design is complete
- `/cf:checkpoint` - Save creative session outputs

---

**Command Version**: 1.0
**Last Updated**: 2025-10-05
