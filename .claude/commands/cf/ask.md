---
description: "Semantic query interface for memory bank knowledge retrieval"
allowed-tools: ['Read', 'Glob', 'Grep']
argument-hint: "[question]"
---

# Command: /cf:ask

## Usage

```
/cf:ask [question]
```

## Parameters

- `[question]`: **Required** - Natural language question about project context, decisions, patterns, or history

---

## Purpose

Provide intelligent query interface to memory bank for:
1. Quick knowledge retrieval without manual file reading
2. Cross-file semantic search and synthesis
3. Historical context and decision rationale lookup
4. Pattern and convention discovery
5. Project understanding for new team members or resumed sessions

---

## Prerequisites

**Memory bank must be initialized**. Run `/cf:init [project-name]` first if needed.

**Some memory bank content**. Works best after project has checkpoints and documentation.

---

## Process

### Step 1: Verify Memory Bank Exists

Check if `memory-bank/` directory exists:

**If NOT EXISTS**:
```
⚠️ Memory Bank Not Initialized

Run: /cf:init [project-name]
```

**Stop execution.**

---

### Step 2: Parse Query Intent

**Analyze question to determine**:
- **Query type**: What, Why, When, Where, How, Who
- **Subject domain**: Architecture, decisions, patterns, tasks, features, progress
- **Scope**: Specific item, general knowledge, historical context
- **Relevant files**: Which memory bank files likely contain answer

**Query classification examples**:

| Question | Type | Domain | Files |
|----------|------|--------|-------|
| "Why did we choose microservices?" | Why | Decision | projectbrief.md, progress.md |
| "What's our error handling pattern?" | What | Pattern | systemPatterns.md |
| "When did we complete the auth feature?" | When | History | progress.md, tasks.md |
| "How do we structure API responses?" | How | Pattern | systemPatterns.md, productContext.md |
| "Where is the user authentication logic?" | Where | Code location | systemPatterns.md, activeContext.md |
| "What tasks are blocked?" | What | Status | tasks.md |

---

### Step 3: Load Relevant Memory Bank Files

**Based on query classification, load targeted files**:

**For decision questions** (Why did we...):
- `projectbrief.md` - Decision log
- `progress.md` - Checkpoint entries with decision rationale
- `systemPatterns.md` - Pattern decisions

**For pattern/convention questions** (How do we...):
- `systemPatterns.md` - Active patterns and conventions
- `productContext.md` - Non-functional requirements

**For feature/requirement questions** (What features...):
- `productContext.md` - Feature tables and requirements
- `tasks.md` - Task breakdown and acceptance criteria

**For status/progress questions** (What's the status...):
- `tasks.md` - Task statuses and blockers
- `progress.md` - Completed work and milestones
- `activeContext.md` - Current focus and next steps

**For historical questions** (When did we...):
- `progress.md` - Checkpoint entries with timestamps
- `tasks.md` - Task completion dates
- `activeContext.md` - Recent changes log

**For current work questions** (What am I working on...):
- `activeContext.md` - Current focus and recent changes
- `tasks.md` - Active tasks

**For comprehensive questions** (Tell me about the project):
- Load ALL files for full context synthesis

---

### Step 4: Search and Extract

**Use native Claude tools** for semantic search:

1. **Read** relevant memory bank files
2. **Grep** for specific keywords or patterns if question is narrow
3. **Semantic extraction**: Understand content and synthesize answer
4. **Cross-reference**: Connect information across multiple files if needed

**Search strategies by question type**:

**Specific item lookup**:
- Grep for exact terms (task ID, feature name, pattern name)
- Read section directly
- Return concise answer

**Conceptual understanding**:
- Read full relevant files
- Synthesize understanding
- Provide comprehensive explanation

**Historical timeline**:
- Grep for dates or task IDs
- Construct chronological sequence
- Return timeline

**Decision rationale**:
- Search decision logs
- Find checkpoint entries mentioning decision
- Extract rationale and alternatives considered
- Return full decision context

---

### Step 5: Synthesize Answer

**Answer format based on query type**:

#### "Why" Questions (Decision Rationale)

```markdown
🎯 DECISION RATIONALE

**Question**: [User's question]

**Decision**: [What was decided]

**When**: [YYYY-MM-DD] (from [source file])

**Rationale**:
[Why this decision was made - from decision log or checkpoint]

**Alternatives Considered**:
- [Alternative 1] - [Why not chosen]
- [Alternative 2] - [Why not chosen]

**Trade-offs**:
✅ **Gains**: [What we got from this decision]
⚠️ **Costs**: [What we gave up]

**Source**: [Memory bank file(s) and section(s)]
```

#### "What" Questions (Factual Information)

```markdown
📋 ANSWER

**Question**: [User's question]

**Answer**:
[Direct answer to question]

**Context**:
[Additional relevant context if helpful]

**Related Information**:
- [Related fact 1]
- [Related fact 2]

**Source**: [Memory bank file(s) and section(s)]
```

#### "How" Questions (Patterns and Procedures)

```markdown
🔧 PATTERN/PROCEDURE

**Question**: [User's question]

**Approach**:
[How we do this - pattern description or procedure]

**Example**:
```[language]
[Code example or concrete illustration if available]
```

**Rationale**: [Why we do it this way]

**Related Patterns**: [Connected patterns if any]

**Source**: [Memory bank file(s) and section(s)]
```

#### "When" Questions (Historical Timeline)

```markdown
📅 TIMELINE

**Question**: [User's question]

**Answer**: [Date or timeframe]

**Timeline**:
- **[YYYY-MM-DD]**: [Event 1]
- **[YYYY-MM-DD]**: [Event 2]
- **[YYYY-MM-DD]**: [Event 3]

**Current Status**: [Where things stand now]

**Source**: [Memory bank file(s) and section(s)]
```

#### "Where" Questions (Location Information)

```markdown
📍 LOCATION

**Question**: [User's question]

**Location**:
[File path, component, or section where thing exists]

**Context**:
[Why it's there, pattern it follows]

**Related Locations**: [Other relevant files or components]

**Source**: [Memory bank file(s) and section(s)]
```

#### Comprehensive Questions

```markdown
📚 COMPREHENSIVE ANSWER

**Question**: [User's question]

**Overview**:
[High-level summary answer]

**Details**:

### [Aspect 1]
[Information about aspect 1]

### [Aspect 2]
[Information about aspect 2]

### [Aspect 3]
[Information about aspect 3]

**Current Status**: [Where things stand]

**Next Steps**: [What's coming - if relevant]

**Sources**: [All memory bank files consulted]
```

---

### Step 6: Handle Special Cases

#### Question Not Answerable from Memory Bank

```markdown
❓ INFORMATION NOT FOUND

**Question**: [User's question]

**Status**: This information is not currently in the memory bank.

**Possible reasons**:
- Decision not yet made or documented
- Feature not yet planned
- Pattern not yet established
- Outside current project scope

**Suggestions**:
- If this is a decision that should be made, consider /cf:plan or /cf:facilitate
- If this is a pattern that should be documented, update systemPatterns.md
- If this is about current code, try asking about the codebase directly (not /cf:ask)

**Related information found**:
[Any tangentially related content that might help]
```

#### Ambiguous Question

```markdown
🤔 CLARIFICATION NEEDED

**Question**: [User's question]

**Ambiguity**: [What's unclear about the question]

**Did you mean**:
1. [Interpretation 1] - [What would be answered]
2. [Interpretation 2] - [What would be answered]
3. [Interpretation 3] - [What would be answered]

Please clarify and ask again, or I can answer all interpretations.
```

#### Multiple Answers Found

```markdown
📚 MULTIPLE ANSWERS FOUND

**Question**: [User's question]

**Several relevant answers found**:

### Answer 1: [Context]
[Answer from perspective 1]
**Source**: [File and section]

### Answer 2: [Context]
[Answer from perspective 2]
**Source**: [File and section]

### Answer 3: [Context]
[Answer from perspective 3]
**Source**: [File and section]

**Synthesis**: [How these answers relate or which is most current]
```

---

## Examples

### Example 1: Decision Rationale Question

```
User: /cf:ask Why did we choose PostgreSQL over MongoDB?

Claude:
[Loads projectbrief.md and progress.md, searches for database decision...]

🎯 DECISION RATIONALE

**Question**: Why did we choose PostgreSQL over MongoDB?

**Decision**: Use PostgreSQL as primary database

**When**: 2025-09-15 (from projectbrief.md decision log)

**Rationale**:
Strong ACID guarantees required for financial transaction data. Team has
PostgreSQL expertise. Complex relational queries needed for reporting features.

**Alternatives Considered**:
- MongoDB - Rejected: No ACID transactions, eventual consistency not acceptable for financial data
- MySQL - Rejected: PostgreSQL has better JSON support needed for flexible user preferences

**Trade-offs**:
✅ **Gains**:
- Data integrity guarantees (critical for finance)
- Rich query capabilities (complex reports)
- JSON support (flexible schemas where needed)

⚠️ **Costs**:
- Potentially higher learning curve for junior devs
- Less flexible schema evolution than NoSQL

**Source**: projectbrief.md (Decision Log, entry 3), progress.md (Checkpoint 2025-09-15)
```

### Example 2: Pattern Question

```
User: /cf:ask How do we handle errors in API responses?

Claude:
[Loads systemPatterns.md, searches for error handling pattern...]

🔧 PATTERN/PROCEDURE

**Question**: How do we handle errors in API responses?

**Approach**:
All API errors follow RFC 7807 Problem Details format with consistent structure.

**Example**:
```json
{
  "type": "https://api.example.com/errors/validation-failed",
  "title": "Validation Failed",
  "status": 400,
  "detail": "Email field is required",
  "instance": "/api/users/create",
  "errors": {
    "email": ["Required field missing"]
  }
}
```

**Rationale**:
Standardized format provides consistent developer experience, enables client-side
error handling without special cases, follows industry best practice (RFC 7807).

**Related Patterns**:
- Logging pattern: All errors logged with correlation ID
- Client error handling: Frontend uses typed error parser

**Source**: systemPatterns.md (Active Patterns → Error Handling Pattern)
```

### Example 3: Status Question

```
User: /cf:ask What tasks are currently blocked?

Claude:
[Loads tasks.md, searches for blocked status...]

📋 ANSWER

**Question**: What tasks are currently blocked?

**Answer**:
2 tasks currently blocked:

1. **TASK-027: Payment Gateway Integration**
   - Blocker: Waiting for production API credentials from vendor
   - Since: 2025-10-01
   - Owner: Sarah

2. **TASK-033: Performance Testing**
   - Blocker: Staging environment configuration incomplete (depends on TASK-032)
   - Since: 2025-10-03
   - Owner: Mike

**Context**:
Both blockers are external dependencies. TASK-027 has vendor ticket #12345
open. TASK-032 (staging setup) is 80% complete, expected resolution tomorrow.

**Related Information**:
- 8 other tasks are in progress without blockers
- 12 tasks are pending (not started)

**Source**: tasks.md (Active Tasks section, Pending Tasks section)
```

### Example 4: Historical Question

```
User: /cf:ask When did we complete the authentication feature?

Claude:
[Loads progress.md and tasks.md, searches for auth completion...]

📅 TIMELINE

**Question**: When did we complete the authentication feature?

**Answer**: 2025-09-22

**Timeline**:
- **2025-09-12**: TASK-008 (Auth planning) completed - architecture decided
- **2025-09-18**: TASK-009 (JWT implementation) completed - backend auth working
- **2025-09-20**: TASK-010 (Login UI) completed - frontend components done
- **2025-09-22**: TASK-011 (Auth integration tests) completed - feature complete ✅

**Current Status**:
Authentication feature fully deployed to production (2025-09-25).
No open issues. 487 users registered to date.

**Source**: progress.md (Checkpoints 9/12, 9/18, 9/20, 9/22), tasks.md (TASK-008 through TASK-011)
```

### Example 5: Location Question

```
User: /cf:ask Where is the user validation logic?

Claude:
[Loads systemPatterns.md and activeContext.md...]

📍 LOCATION

**Question**: Where is the user validation logic?

**Location**:
`src/validators/userValidator.ts` - Centralized validation using Joi schema

**Context**:
Follows "centralized validation" pattern from systemPatterns.md. All validation
logic extracted from controllers to dedicated validator modules for reusability
and testability.

**Related Locations**:
- Schema definitions: `src/schemas/userSchema.ts`
- Used in: `src/controllers/userController.ts` (line 23)
- Tests: `tests/validators/userValidator.test.ts`

**Source**: systemPatterns.md (Validation Pattern), activeContext.md (Recent Changes 2025-09-14)
```

### Example 6: Comprehensive Question

```
User: /cf:ask Tell me about the project scope and progress

Claude:
[Loads ALL memory bank files for comprehensive synthesis...]

📚 COMPREHENSIVE ANSWER

**Question**: Tell me about the project scope and progress

**Overview**:
E-Commerce Platform - B2C marketplace for handmade goods. Currently 73% complete,
on track for Q4 2025 launch. 6-person team, 12 weeks into 16-week timeline.

**Details**:

### Scope
**Core Features** (Must Have):
- ✅ User authentication (complete)
- ✅ Product catalog (complete)
- ✅ Shopping cart (complete)
- 🔄 Payment processing (in progress - 60%)
- ⏳ Order management (not started)

**Nice-to-Have Features** (Deferred to Phase 2):
- Seller analytics dashboard
- Advanced search with filters
- Wishlist functionality

### Technical Approach
- **Architecture**: Microservices (3 services: Auth, Catalog, Orders)
- **Stack**: Node.js/Express backend, React frontend, PostgreSQL database
- **Patterns**: 12 established patterns documented (REST API, error handling, validation, etc.)

### Progress
- **Completed**: 18 tasks across 4 major features
- **In Progress**: 5 tasks (payment integration, order workflows)
- **Pending**: 12 tasks (primarily Phase 2 features)

### Current Focus
Working on TASK-032 (Payment Gateway Integration). Tests written (GREEN ✅),
implementation 60% complete. Expected completion: 2025-10-08.

**Next Steps**:
1. Complete payment integration (TASK-032)
2. Begin order management system (TASK-035)
3. Integration testing across services (TASK-040)

**Sources**: projectbrief.md, productContext.md, systemPatterns.md, activeContext.md,
progress.md, tasks.md
```

### Example 7: Not Found

```
User: /cf:ask What's our mobile app strategy?

Claude:
[Loads memory bank files, searches for mobile references...]

❓ INFORMATION NOT FOUND

**Question**: What's our mobile app strategy?

**Status**: This information is not currently in the memory bank.

**Possible reasons**:
- Mobile app not in current project scope (web-only project)
- Decision not yet made or documented
- Future phase planning not yet started

**Suggestions**:
- Check projectbrief.md scope to confirm if mobile is planned
- If mobile should be considered, use /cf:facilitate to explore options
- If this is a future phase, document decision in projectbrief.md

**Related information found**:
- productContext.md mentions "responsive web design" for mobile browsers
- No mobile-specific requirements in current scope
- Progressive Web App (PWA) listed as Phase 3 consideration
```

---

## Error Handling

### Memory Bank Not Initialized

```
⚠️ Memory Bank Not Initialized

Memory bank not found at: memory-bank/

To initialize, run: /cf:init [project-name]

Example: /cf:init MyProject
```

### Empty Memory Bank

```
⚠️ Memory Bank Empty

Memory bank exists but contains no meaningful content.

Have you completed any work yet?

Steps to populate memory bank:
1. /cf:feature [description] - Create and work on tasks
2. /cf:checkpoint - Document progress and decisions
3. /cf:ask [question] - Query preserved knowledge

Currently, memory bank has no answers to provide.
```

### Missing Question

```
❌ Error: Question required

Usage: /cf:ask [question]

Examples:
- /cf:ask Why did we choose React?
- /cf:ask What's our error handling pattern?
- /cf:ask What tasks are blocked?
- /cf:ask When did we complete authentication?
```

---

## Integration with Other Commands

**Typical usage patterns**:

```
# Understanding project before starting work
/cf:ask Tell me about the project
/cf:ask What am I working on?
/cf:status → See current tasks

# Looking up patterns before implementation
/cf:ask How do we structure API responses?
/cf:code TASK-023 → Follow pattern

# Understanding past decisions
/cf:ask Why did we choose microservices?
[Understand rationale before proposing changes]

# Checking status
/cf:ask What tasks are blocked?
/cf:ask What's completed this week?

# New team member onboarding
/cf:ask Tell me about the project
/cf:ask What are our coding conventions?
/cf:ask What's the architecture?
[Get up to speed quickly]
```

**When to use /cf:ask vs other commands**:
- `/cf:ask` - **Query existing knowledge** in memory bank (read-only)
- `/cf:sync` - **Full status report** with structure (read-only)
- `/cf:status` - **Quick task list** (read-only)
- `/cf:checkpoint` - **Create new knowledge** (write operation)
- `/cf:review` - **Quality assessment** (analysis + write)

---

## Notes

- **Read-only operation**: Never modifies memory bank, only queries
- **Semantic search**: Understands question intent, not just keyword matching
- **Cross-file synthesis**: Can combine information from multiple memory bank files
- **Natural language**: Ask questions naturally, no special syntax required
- **Fast knowledge retrieval**: Faster than manually reading memory bank files
- **Onboarding tool**: Great for new team members to understand project quickly
- **Session resume aid**: Quick way to remember context after time away
- **Decision archaeology**: Understand why past decisions were made
- **Pattern discovery**: Find established conventions without manual searching

**Best practices**:
- Ask specific questions for concise answers
- Ask broad questions for comprehensive overviews
- Reference task IDs, feature names, or pattern names for precise lookup
- Use for "why" questions to understand decision rationale
- Use for "how" questions to find patterns and procedures
- Great for answering "I forgot..." or "What was..." questions

---

## Related Commands

- `/cf:sync` - Full memory bank status report
- `/cf:status` - Quick task status overview
- `/cf:checkpoint` - Create checkpoint (write operation)
- `/cf:context` - Load active context for work
- `/cf:review` - Quality and progress assessment

---

**Command Version**: 1.0
**Last Updated**: 2025-10-05
