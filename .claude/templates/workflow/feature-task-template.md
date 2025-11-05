# Feature Task Entry: [Task Name]

**Task ID**: TASK-[NNN]
**Complexity**: Level [1-4] ([Category Name])
**Status**: [Pending/Active]
**Priority**: P[0-2]
**Created**: [YYYY-MM-DD]
**Estimated Effort**: [From assessor]

---

## Description

[User's original task description]

---

## User Value

**Why This Matters**: [From product agent - user impact and business value]

[Detailed explanation of what problem this solves, who benefits, and strategic importance]

---

## Acceptance Criteria

[From product agent - 3-5 specific, testable criteria]

- [ ] [Criterion 1 - specific and measurable]
- [ ] [Criterion 2 - specific and measurable]
- [ ] [Criterion 3 - specific and measurable]
- [ ] [Criterion 4 - if applicable]
- [ ] [Criterion 5 - if applicable]
- [ ] All tests passing (unit, integration, E2E as applicable)
- [ ] Code reviewed and meets quality standards

---

## Complexity Assessment

**From Assessor Agent**:

**Scope**: ~[N] files ([component types: UI components, API endpoints, database models, etc.])

**Risk Level**: [Low/Medium/High]
- [Risk factor 1]
- [Risk factor 2]
- [Risk factor 3 if applicable]

**Effort Estimate**: [Time estimate with rationale]

**Complexity Indicators**: [Keywords and patterns identified by assessor]

---

## Technical Pre-Analysis

*This section is populated by Architect agent for **Level 2+ features only**. Provides rapid technical assessment to identify hidden complexity before implementation.*

**From Architect Agent** (when invoked for L2+ complexity):

### Integration Concerns
**Affected Components**: [List components this feature touches]
**Integration Points**: [External/internal systems that need coordination]
**Pattern Impact**: [Existing architectural patterns that will be affected]

### Data Modeling Needs
**Entities**: [Data structures or models required]
**Relationships**: [How data entities connect and relate]
**Schema Changes**: [Database schema or state structure changes needed]

### Algorithmic Complexity
**Computational Concerns**: [Performance considerations, complexity analysis (e.g., O(n²))]
**Business Logic**: [Complex calculations, decision logic, or algorithm areas]

### Technical Constraints
**Platform Limits**: [Technical boundaries or constraints to work within]
**Security/Compliance**: [Security requirements or compliance needs]
**External Dependencies**: [Third-party APIs, services, libraries required]

### Hidden Complexity Signals
**🔴 HIGH Priority** (must specify before implementation):
- [Signal 1]: [Why this complexity needs detailed specification]

**🟡 MEDIUM Priority** (should specify):
- [Signal 1]: [Why this should be specified upfront]

**🟢 LOW Priority** (optional specification):
- [Signal 1]: [Nice to have but not critical to specify]

### Assumptions & Uncertainties
[Any assumptions made due to limited context or areas requiring clarification]

**Note**: If this section is empty, the feature was assessed as Level 1 (Simple) and does not require technical pre-analysis.

---

## Edge Cases

**From Product Agent**:

- [Edge case 1]: [How to handle]
- [Edge case 2]: [How to handle]
- [Edge case 3]: [How to handle]
- [Additional edge cases as identified]

---

## Non-Functional Requirements

**From Product Agent** (if applicable):

**Performance**:
- [Performance requirement 1 if any]

**Security**:
- [Security requirement 1 if any]

**Accessibility**:
- [Accessibility requirement 1 if any]

**Usability**:
- [Usability requirement 1 if any]

**Compliance**:
- [Compliance requirement 1 if any]

[If none: "None identified - standard project quality gates apply"]

---

## Prerequisites

**Dependencies**:
- [TASK-ID if dependent on another task]
- [External dependency if any]
- [Technical prerequisite if any]

[If none: "None - ready to start"]

---

## Testing Strategy

**Status**: Not started

**Test Types Required**:
- [ ] Unit tests: [Component/function level tests needed]
- [ ] Integration tests: [Cross-component tests needed]
- [ ] E2E tests: [User flow tests needed]
- [ ] Edge case tests: [Specific edge case validation]

**Test Coverage Target**: [From assessor based on complexity]

---

## Implementation Approach

**For Level 1 (Quick Fix)**:
- Direct implementation via /cf:code

**For Level 2+ (Requires Planning)**:
- Planning via /cf:plan to break down into sub-tasks
- Sub-tasks will be created during planning phase

**Sub-tasks**: [Will be populated by /cf:plan for Level 2+]

---

## Blockers

**Current Blockers**: None

[To be updated if blockers arise during implementation]

---

## Notes

**Created By**: /cf:feature command (Command Orchestration Pattern)

**Assessor Routing Recommendation**: [Next command recommendation from assessor]

**Agent Coordination**:
- Complexity analysis: assessor agent
- Technical pre-analysis: architect agent (Level 2+ only)
- Requirements validation: product agent
- Task synthesis: /cf:feature command using feature-task-template.md

**Pattern Reference**:
- Command Orchestration Pattern (systemPatterns.md:409-582)
- Conditional Expert Pre-Analysis Pattern (systemPatterns.md:585-716)

**Technical Pre-Analysis Logic**:
- **Level 1 features**: Technical Pre-Analysis section remains empty (simple features don't need pre-analysis)
- **Level 2+ features**: Architect agent populates Technical Pre-Analysis section during `/cf:feature` execution
- **Purpose**: Identify hidden complexity (integration, data, algorithm, constraints) before implementation

**Implementation Notes**: [Additional context or considerations]

---

## Task Lifecycle

**Created**: [YYYY-MM-DD] via /cf:feature
**Planned**: [YYYY-MM-DD] via /cf:plan (for Level 2+)
**Started**: [YYYY-MM-DD] via /cf:code
**Completed**: [YYYY-MM-DD]
**Reviewed**: [YYYY-MM-DD] via /cf:review

---

**Template Version**: 1.1 (Conditional Expert Pre-Analysis)
**Template Purpose**: Feature task entry synthesis from assessor + architect (L2+) + product agent outputs
**Used By**: /cf:feature command for structured task creation
**Created**: 2025-11-03 (TASK-003-8)
**Updated**: 2025-11-04 (TASK-004-3, TASK-004-4) - Added Technical Pre-Analysis section for Level 2+ features
