# Command: /cf:plan

Create implementation plan with Architect + Product agents, breaking down complex tasks.

---

## Usage

```
/cf:plan [task-id]
/cf:plan [task-id] --interactive
```

## Parameters

- `[task-id]`: **Required** - Task ID to plan (e.g., TASK-003)

## Flags

- `--interactive`: Engage Facilitator agent for collaborative planning refinement

---

## Purpose

Create comprehensive implementation plan by:
1. Loading task details and project context
2. Engaging Architect agent for technical design
3. Engaging Product agent for user requirements
4. Breaking down into implementation steps
5. Creating sub-tasks in tasks.md
6. Updating systemPatterns.md if new patterns emerge

---

## Prerequisites

- **Memory bank initialized**: Run `/cf:init [project-name]` first
- **Task exists**: Use `/cf:feature [description]` to create task first
- **Task requires planning**: Level 2-4 complexity (Level 1 can skip directly to `/cf:code`)

---

## Process

### Step 1: Verify Prerequisites

**Check memory bank exists**:
```
If NOT EXISTS:
⚠️ Memory bank not initialized. Run: /cf:init [project-name]
```

**Check task exists in tasks.md**:
```
If NOT FOUND:
❌ Task [task-id] not found in tasks.md

Available tasks:
- TASK-001: [name]
- TASK-002: [name]

Create new task with: /cf:feature [description]
```

**Check task complexity**:
```
If Level 1:
⚠️ Task [task-id] is Level 1 (Quick Fix)

Level 1 tasks don't require planning.

Proceed directly with: /cf:code [task-id]
```

---

### Step 2: Load Context

Read required memory bank files:
- `tasks.md` - Task details, complexity, description
- `activeContext.md` - Current project state
- `systemPatterns.md` - Architectural patterns to follow
- `productContext.md` - User needs and UX requirements
- `projectbrief.md` - Project goals and constraints
- `CLAUDE.md` - Tech stack reference

Extract task information:
- Task description
- Complexity level
- Acceptance criteria
- Any existing notes or context

---

### Step 3: Engage Architect Agent

**Architect analyzes technical approach**:

1. Understand requirements from task description
2. Load architectural patterns from systemPatterns.md
3. Load tech stack from CLAUDE.md
4. Design solution approach:
   - Component architecture
   - Data flow
   - State management
   - Integration points
   - Technical decisions with trade-offs

**Architect Output**: Technical implementation plan

---

### Step 4: Engage Product Agent

**Product analyzes user requirements**:

1. Understand user need from task description
2. Load product context from productContext.md
3. Define requirements:
   - Functional requirements (must/should/could have)
   - Non-functional requirements (performance, accessibility)
   - User experience requirements
   - Success criteria
   - Edge cases

**Product Output**: User-focused requirements and UX considerations

---

### Step 5: Synthesize Plan (Standard Mode)

Combine Architect and Product perspectives into comprehensive plan:

```markdown
## 📋 IMPLEMENTATION PLAN: [Task Name]

**Task ID**: TASK-[ID]
**Complexity**: Level [2-4]
**Estimated Effort**: [X hours]

---

### 🎨 PRODUCT PERSPECTIVE

**User Need**: [What user problem this solves]
**User Value**: [Why this matters to users]

**Requirements**:

**Must Have**:
- [Core requirement 1]
- [Core requirement 2]

**Should Have**:
- [Nice-to-have 1]

**UX Considerations**:
- [Usability requirement 1]
- [Accessibility requirement 2]

**Success Criteria**:
- ✅ [Measurable outcome 1]
- ✅ [Measurable outcome 2]

---

### 🏗️ ARCHITECT PERSPECTIVE

**Technical Approach**: [High-level design strategy]

**Component Architecture**:
1. **[Component 1]**
   - Purpose: [What it does]
   - Responsibilities: [Key functions]
   - Dependencies: [What it needs]

2. **[Component 2]**
   - Purpose: [What it does]
   - Responsibilities: [Key functions]

**Data Flow**:
```
[Source] → [Processing] → [Storage/Output]
```

**Technical Decisions**:
1. **[Decision]**: [Choice made]
   - Options: [A, B, C]
   - Selected: [A]
   - Rationale: [Why]
   - Trade-offs: [Gains/losses]

**Patterns to Follow**:
- [Pattern from systemPatterns.md]

**Risks & Mitigation**:
- Risk: [Potential issue]
  Mitigation: [How to handle]

---

### 🔨 IMPLEMENTATION STEPS

**Phase 1: [Phase Name]**
1. **[Step Name]** (Sub-task 1, Level [1-2])
   - Actions: [What to do]
   - Files: [Files to modify/create]
   - Tests: [What to test]
   - Effort: [Time estimate]

2. **[Step Name]** (Sub-task 2, Level [1-2])
   - Actions: [What to do]
   - Files: [Files to modify/create]
   - Tests: [What to test]
   - Effort: [Time estimate]

**Phase 2: [Phase Name]**
3. **[Step Name]** (Sub-task 3, Level [1-2])
   ...

---

### 📊 SUMMARY

**Total Sub-tasks**: [N]
**Estimated Total Effort**: [X hours]
**Recommended Approach**: [Implementation strategy]

**Sub-tasks Created in tasks.md**:
- TASK-[ID]-1: [Sub-task name] (Level [1-2])
- TASK-[ID]-2: [Sub-task name] (Level [1-2])
- TASK-[ID]-3: [Sub-task name] (Level [1-2])

---

→ NEXT: Proceed with first sub-task

   /cf:code TASK-[ID]-1

   OR review/refine plan with:
   /cf:facilitate plan-review
```

---

### Step 6: Interactive Refinement (If --interactive Flag)

If `--interactive` flag is present:

**Engage Facilitator agent**:

```markdown
🔄 INTERACTIVE PLANNING: [Task Name]

## Initial Plan Presented

[Architect + Product plan shown above]

---

## Refinement Questions

**Facilitator asks**:

1. **Scope Clarity**: The plan includes [feature X]. Is this in scope, or should we defer?

2. **Technical Approach**: Architect recommends [approach A]. Alternative [approach B] is simpler but less flexible. Your preference?

3. **User Flow**: Product outlined [flow]. Does this match your vision, or should we adjust?

4. **Phasing**: The plan has 2 phases. Would you prefer to break this into more incremental deliveries?

5. **Risks**: Main risk is [risk]. Does the proposed mitigation address your concerns?

---

[User responds]

---

## Refined Plan

[Architect + Product adjust based on feedback]

Updated approach:
- [Change 1]
- [Change 2]

---

[Facilitator asks follow-up questions if needed]

---

## Final Plan

[After iterative refinement, present finalized plan]

→ RECOMMENDATION: Plan is ready for implementation

   Proceed with: /cf:code TASK-[ID]-1

   OR make final adjustments with another refinement cycle
```

**Facilitator iterates** until user approves plan.

---

### Step 7: Update tasks.md

**Create sub-task entries** for each implementation step:

```markdown
### 🟢 TASK-[ID]: [Original Task Name] (Level [2-4])

**Status**: Active → Planning Complete
**Priority**: [P0/P1/P2]
**Complexity**: Level [2-4]
**Assigned**: Planning complete, ready for implementation
**Created**: [Original date]
**Planned**: [YYYY-MM-DD]
**Target**: [Estimated completion based on effort]

**Description**:
[Original description]

**Implementation Plan**: ✅ Complete (see below)

**Sub-tasks**:
- [ ] TASK-[ID]-1: [Sub-task name] (Level [1-2]) - Pending
  - Effort: [X hours]
  - Description: [What this subtask does]

- [ ] TASK-[ID]-2: [Sub-task name] (Level [1-2]) - Pending
  - Effort: [X hours]
  - Description: [What this subtask does]
  - Prerequisites: TASK-[ID]-1

- [ ] TASK-[ID]-3: [Sub-task name] (Level [1-2]) - Pending
  - Effort: [X hours]
  - Description: [What this subtask does]
  - Prerequisites: TASK-[ID]-2

**Total Estimated Effort**: [Sum of sub-task efforts]

**Notes**:
Implementation plan created [YYYY-MM-DD]
Plan includes [N] sub-tasks across [N] phases
```

**Mark parent task as "Planning Complete"**

---

### Step 8: Update systemPatterns.md (If New Patterns)

If Architect identifies new patterns:

Add to **Active Patterns** section:

```markdown
### [New Pattern Name]

**Category**: [Architectural/Design/etc]
**Added**: YYYY-MM-DD (from TASK-[ID] planning)

**Context**: [When/where this applies]

**Problem**: [What it solves]

**Solution**: [How the pattern works]

**Benefits**:
- ✅ [Benefit 1]
- ✅ [Benefit 2]

**Trade-offs**:
- ⚠️ [Trade-off 1]

**Examples in Codebase**: To be added during TASK-[ID] implementation

**Related Patterns**: [Similar patterns]
```

---

### Step 9: Update activeContext.md

Add entry to **Recent Changes**:

```markdown
### [YYYY-MM-DD HH:MM] - Implementation Plan Created: [Task Name]
**Agents**: Architect + Product [+ Facilitator if interactive]
**Task ID**: TASK-[ID]
**Impact**: Task broken into [N] sub-tasks, ready for implementation
**Sub-tasks**: TASK-[ID]-1 through TASK-[ID]-[N]
**Next Action**: /cf:code TASK-[ID]-1
```

Update **Immediate Next Steps** if this is high priority:

```markdown
**Immediate Next Steps**:
1. **TASK-[ID]-1: [Sub-task name]** (Priority: P0)
   - Action: [Brief description]
   - Prerequisite: None
   - Estimated Effort: [X hours]
   - Why now: [Rationale]
```

---

## Examples

### Example 1: Level 2 Task (Standard Mode)

```
User: /cf:plan TASK-005

Claude:
[Loading context...]
[Architect analyzes...]
[Product analyzes...]

## 📋 IMPLEMENTATION PLAN: Add Search Functionality to Navbar

**Task ID**: TASK-005
**Complexity**: Level 2
**Estimated Effort**: 2-3 hours

---

### 🎨 PRODUCT PERSPECTIVE

**User Need**: Users want to quickly find content without navigating through menus
**User Value**: Faster access to information, improved productivity

**Requirements**:

**Must Have**:
- Search input in navbar
- Real-time search suggestions
- Results display with keyboard navigation

**Should Have**:
- Search history (recent searches)

**UX Considerations**:
- Search should be keyboard accessible (focus with "/")
- Clear visual feedback during search
- Empty state handling

**Success Criteria**:
- ✅ Users can search from any page
- ✅ Results appear within 200ms
- ✅ Fully keyboard navigable

---

### 🏗️ ARCHITECT PERSPECTIVE

**Technical Approach**: Client-side search with debounced API calls

**Component Architecture**:
1. **SearchInput Component**
   - Purpose: Capture search input with debouncing
   - Responsibilities: Input handling, focus management
   - Dependencies: Search service

2. **SearchResults Component**
   - Purpose: Display search results
   - Responsibilities: Results rendering, keyboard navigation
   - Dependencies: Search data

3. **Search API Endpoint**
   - Purpose: Query backend for results
   - Responsibilities: Database query, result formatting

**Data Flow**:
```
User Input → Debounce (300ms) → API Call → Results → Display
```

**Technical Decisions**:
1. **Debouncing Strategy**: 300ms debounce
   - Rationale: Balance between responsiveness and API load
   - Trade-offs: Slight delay vs reduced API calls

**Patterns to Follow**:
- Component composition pattern (from systemPatterns.md)
- API service pattern

---

### 🔨 IMPLEMENTATION STEPS

**Phase 1: Backend**
1. **Create Search API Endpoint** (Sub-task 1, Level 1)
   - Actions: Create /api/search endpoint with query parameter
   - Files: routes/search.js, services/searchService.js
   - Tests: API endpoint tests (query handling, result format)
   - Effort: 45 minutes

**Phase 2: Frontend**
2. **Create SearchInput Component** (Sub-task 2, Level 1)
   - Actions: Build controlled input with debouncing
   - Files: components/SearchInput.tsx, hooks/useDebounce.ts
   - Tests: Component tests (input, debounce, keyboard)
   - Effort: 45 minutes

3. **Create SearchResults Component** (Sub-task 3, Level 1)
   - Actions: Build results display with keyboard navigation
   - Files: components/SearchResults.tsx
   - Tests: Component tests (rendering, keyboard nav)
   - Effort: 30 minutes

4. **Integrate with Navbar** (Sub-task 4, Level 1)
   - Actions: Add SearchInput to navbar, handle modal/dropdown
   - Files: components/Navbar.tsx
   - Tests: Integration tests (navbar with search)
   - Effort: 30 minutes

---

### 📊 SUMMARY

**Total Sub-tasks**: 4
**Estimated Total Effort**: 2.5 hours
**Recommended Approach**: Backend-first, then frontend components

**Sub-tasks Created in tasks.md**:
- TASK-005-1: Create Search API Endpoint (Level 1)
- TASK-005-2: Create SearchInput Component (Level 1)
- TASK-005-3: Create SearchResults Component (Level 1)
- TASK-005-4: Integrate with Navbar (Level 1)

✓ Updated tasks.md with 4 sub-tasks
✓ Updated activeContext.md

---

→ NEXT: Proceed with first sub-task

   /cf:code TASK-005-1
```

### Example 2: Level 3 Task (Interactive Mode)

```
User: /cf:plan TASK-006 --interactive

Claude:
[Loading context...]
[Architect analyzes...]
[Product analyzes...]

## 📋 IMPLEMENTATION PLAN: Migrate Authentication to OAuth 2.0

[Initial plan presented with Architect + Product perspectives]

---

🔄 INTERACTIVE PLANNING

Facilitator: I've reviewed the initial plan. Let me ask some clarifying questions:

**Q1: OAuth Provider**
The plan assumes a single OAuth provider (Google). Do you want to support multiple providers (Google, GitHub, etc.) from the start, or add that later?

User: Start with Google only, add others later

Facilitator: Good, that simplifies Phase 1. I'll update the plan.

**Q2: Migration Strategy**
Two options for existing users:
A) Parallel auth (support both old and OAuth simultaneously, migrate gradually)
B) Hard cutover (force all users to re-authenticate)

Option A is safer but more complex. Your preference?

User: Option A - parallel auth, don't want to disrupt users

Facilitator: Understood. This adds complexity but is the right choice for UX.

**Q3: Data Migration**
Should we migrate existing user emails to OAuth automatically, or require users to manually link accounts?

User: Automatic migration where emails match

Facilitator: Got it. This requires careful handling of edge cases.

[Architect updates plan based on responses...]

---

## 🔄 REFINED PLAN

**Updated Approach**:
- Single OAuth provider (Google) for Phase 1
- Parallel authentication (both systems running)
- Automatic email-based account linking
- Gradual user migration strategy

**Sub-tasks Adjusted**:
- Added: Parallel auth middleware (routes to correct auth system)
- Added: Account linking logic (email matching)
- Added: Migration tracking (dashboard to monitor progress)

[Updated implementation steps shown...]

---

Facilitator: Does this refined approach address your needs, or should we adjust further?

User: Looks good

Facilitator: Excellent. One final consideration:

**Testing Strategy for Migration**
Given the risk, I recommend:
1. Unit tests for all auth paths
2. Integration tests for account linking
3. Manual testing with test accounts before production

Should I add a sub-task for comprehensive testing?

User: Yes, add that

---

## ✅ FINAL PLAN

[Complete refined plan with testing sub-task added]

**Total Sub-tasks**: 8 (was 5, added migration and testing tasks)
**Estimated Total Effort**: 14 hours (was 10, adjusted for added complexity)

✓ Updated tasks.md with 8 sub-tasks
✓ Updated activeContext.md

---

→ RECOMMENDATION: Plan is comprehensive and ready

   Begin with: /cf:code TASK-006-1

   Consider running /cf:checkpoint before starting to save this planning work.
```

---

## Error Handling

### Task Not Found

```
❌ Task TASK-099 not found in tasks.md

Available tasks:
- TASK-001: Fix header typo
- TASK-002: Add navbar search
- TASK-003: User authentication

Create new task with: /cf:feature [description]
```

### Task Already Planned

```
⚠️ Task TASK-005 already has implementation plan

Sub-tasks exist:
- TASK-005-1: Create API endpoint
- TASK-005-2: Create search component

To update plan:
1. Review existing sub-tasks in tasks.md
2. Use /cf:facilitate to refine if needed
3. Or proceed with: /cf:code TASK-005-1
```

### Level 1 Task (Doesn't Need Planning)

```
⚠️ Task TASK-004 is Level 1 (Quick Fix)

Level 1 tasks are straightforward and don't require planning.

Proceed directly with: /cf:code TASK-004

Planning is only needed for Level 2-4 tasks.
```

---

## Memory Bank Updates

### tasks.md
- Parent task marked as "Planning Complete"
- Sub-tasks created with IDs TASK-[ID]-1, TASK-[ID]-2, etc.
- Effort estimates added
- Dependencies noted

### activeContext.md
- Recent change entry added
- Immediate next steps updated if high priority

### systemPatterns.md (if applicable)
- New patterns documented
- ADR reference added if architectural decision made

---

## Notes

- Planning is **required** for Level 2-4 tasks before implementation
- Sub-tasks are always Level 1 or 2 (never Level 3-4)
- If sub-task seems Level 3+, it should be broken down further
- Interactive mode (`--interactive`) highly recommended for Level 3-4
- Architect and Product work together, providing complementary perspectives
- Plan can be refined later with `/cf:facilitate` if needed

---

## Related Commands

- `/cf:feature` - Create task before planning
- `/cf:code` - Implement sub-tasks after planning
- `/cf:facilitate` - Refine plan interactively
- `/cf:checkpoint` - Save planning work before implementation

---

**Command Version**: 1.0
**Last Updated**: 2025-10-05
