# System Patterns: [Project Name]

<!-- IMPORT NOTE: This file may be pre-populated from existing project documentation -->
<!-- Tech stack information is often imported from CLAUDE.md and package.json -->
<!-- Code patterns may be detected from code structure analysis -->

**Version**: 1.0
**Created**: [YYYY-MM-DD]
**Last Updated**: [YYYY-MM-DD]

---

## Architecture Overview
<!-- IMPORT SOURCE: CLAUDE.md, code structure analysis, or manual entry -->

### System Architecture

**Architecture Style**: [Monolith/Microservices/Serverless/etc]

**High-Level Components**:
```
[Simple diagram or description of main components]

Example:
Frontend (React) → API Gateway → Backend Services → Database
                                      ↓
                              External APIs / Services
```

**Key Technologies**:
<!-- IMPORT SOURCE: CLAUDE.md, package.json -->
- **Frontend**: [Framework/library and version]
- **Backend**: [Framework/language and version]
- **Database**: [Database and version]
- **Infrastructure**: [Hosting/deployment platform]

**Communication Patterns**:
- **Client ↔ Server**: [REST/GraphQL/WebSocket/etc]
- **Service ↔ Service**: [HTTP/Message Queue/gRPC/etc]
- **Data Access**: [ORM/Raw SQL/ODM/etc]

---

## Active Patterns

### [Pattern Name 1]

**Category**: [Architectural/Design/Code/Testing/etc]

**Context**: When/where this pattern applies
- [Situation 1]
- [Situation 2]

**Problem**: What problem this solves
- [Challenge it addresses]

**Solution**: How the pattern works
```[language]
// Example code or pseudocode
[Show the pattern in action]
```

**Benefits**:
- ✅ [Benefit 1]
- ✅ [Benefit 2]

**Trade-offs**:
- ⚠️ [What you lose or accept]
- ⚠️ [Complexity added]

**Examples in Codebase**:
- [file.js:42] - [Brief description]
- [module/component.ts] - [Brief description]

**Related Patterns**: [Other patterns that complement or conflict]

---

### [Pattern Name 2]

**Category**: [Category]

**Context**: [When to use]

**Problem**: [What it solves]

**Solution**:
```[language]
[Example code]
```

**Benefits**: [What you gain]

**Trade-offs**: [What you accept]

**Examples in Codebase**: [Where it's used]

---

## Coding Conventions

### Code Style

| Aspect | Convention | Example |
|--------|------------|---------|
| File naming | [kebab-case/snake_case/PascalCase] | `user-service.js` |
| Variable naming | [camelCase/snake_case] | `userData` |
| Function naming | [camelCase/snake_case] | `getUserData()` |
| Class naming | [PascalCase] | `UserService` |
| Constant naming | [UPPER_SNAKE_CASE] | `MAX_RETRIES` |
| Private members | [_prefix/convention] | `_internalMethod()` |

### Code Organization

**File Structure**:
```
src/
├── [directory 1]/    # [Purpose]
├── [directory 2]/    # [Purpose]
└── [directory 3]/    # [Purpose]
```

**Import Order**:
1. [External dependencies]
2. [Internal modules]
3. [Relative imports]
4. [Types/interfaces]

**Function Organization**:
- [Public functions first/last]
- [Group by feature/alphabetical]
- [Helper functions at bottom]

### Error Handling

**Standard Pattern**:
```[language]
// Example error handling pattern
try {
  // Operation
} catch (error) {
  // Standard error handling
}
```

**Error Types**:
- **Validation Errors**: [How to handle]
- **Not Found Errors**: [How to handle]
- **Server Errors**: [How to handle]
- **External Service Errors**: [How to handle]

**Logging Pattern**:
```[language]
// How to log errors and events
logger.error('[context]', { error, metadata })
```

### Comments & Documentation

**When to Comment**:
- ✅ Complex algorithms or business logic
- ✅ Non-obvious decisions or trade-offs
- ✅ TODOs with context (rare, prefer tickets)
- ❌ Obvious code (let code be self-documenting)
- ❌ Commented-out code (use version control)

**Comment Style**:
```[language]
/**
 * [Function purpose]
 *
 * @param {Type} paramName - Description
 * @returns {Type} Description
 */
```

---

## Testing Patterns

### Test Organization

**Test File Location**: [Co-located/__tests__/test/etc]

**Test File Naming**: [*.test.js/test_*.py/etc]

**Test Structure**:
```[language]
describe('[Feature/Component]', () => {
  describe('[Specific behavior]', () => {
    it('should [expected outcome] when [condition]', () => {
      // Arrange
      // Act
      // Assert
    })
  })
})
```

### Test Categories

**Unit Tests**:
- **Scope**: Individual functions/methods
- **Dependencies**: Mocked
- **Speed**: Fast (< 1 second)
- **Coverage**: [Target %]

**Integration Tests**:
- **Scope**: Component interactions
- **Dependencies**: Real where possible
- **Speed**: Medium (1-10 seconds)
- **Coverage**: [Target %]

**E2E Tests**:
- **Scope**: Full user workflows
- **Dependencies**: Real
- **Speed**: Slow (10+ seconds)
- **Coverage**: [Critical paths only]

### Mocking Strategy

**When to Mock**:
- External APIs
- Database calls (in unit tests)
- Time-dependent operations
- File system operations

**When NOT to Mock**:
- Internal pure functions
- Simple utilities
- In integration tests (use real dependencies)

**Mocking Pattern**:
```[language]
// Example mock setup
[Show how to mock in your framework]
```

---

## Data Patterns

### Database Schema Conventions

**Table Naming**: [snake_case/PascalCase/etc]

**Column Naming**: [snake_case/camelCase/etc]

**Primary Keys**: [id/uuid/composite]

**Timestamps**: [created_at/createdAt, updated_at/updatedAt]

**Soft Deletes**: [deleted_at/is_deleted]

### Query Patterns

**Standard Query Structure**:
```[language]
// Example query pattern
[Show typical query structure]
```

**Pagination Pattern**:
```[language]
// How to paginate results
[Show pagination approach]
```

**Transaction Pattern**:
```[language]
// How to handle transactions
[Show transaction handling]
```

---

## API Patterns

### REST API Conventions

**Endpoint Naming**:
- Resources: [Plural nouns, lowercase]
- Actions: [HTTP verbs, not in URL]
- Nesting: [Max 2 levels deep]

**Standard Endpoints**:
```
GET    /api/resources          # List
GET    /api/resources/:id      # Get one
POST   /api/resources          # Create
PUT    /api/resources/:id      # Update (full)
PATCH  /api/resources/:id      # Update (partial)
DELETE /api/resources/:id      # Delete
```

**Response Format**:
```json
{
  "data": {},
  "meta": {},
  "errors": []
}
```

**Status Codes**:
- `200`: Success
- `201`: Created
- `400`: Bad Request (validation)
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `500`: Server Error

### Request Validation

**Validation Pattern**:
```[language]
// How to validate requests
[Show validation approach]
```

**Error Response**:
```json
{
  "errors": [
    {
      "field": "email",
      "message": "Invalid email format",
      "code": "VALIDATION_ERROR"
    }
  ]
}
```

---

## Security Patterns

### Authentication

**Pattern**: [JWT/Session/OAuth/etc]

**Implementation**:
```[language]
// Auth pattern implementation
[Show auth middleware or pattern]
```

**Token Storage**: [Where and how tokens are stored]

**Token Expiration**: [Duration and refresh strategy]

### Authorization

**Pattern**: [RBAC/ABAC/Simple roles/etc]

**Permission Check**:
```[language]
// How to check permissions
[Show permission checking pattern]
```

### Input Sanitization

**Sanitization Pattern**:
```[language]
// How to sanitize user input
[Show sanitization approach]
```

**XSS Prevention**: [Strategy and tools]

**SQL Injection Prevention**: [Parameterized queries, ORM usage]

---

## Performance Patterns

### Caching Strategy

**What to Cache**:
- [Type of data 1]: [Duration]
- [Type of data 2]: [Duration]

**Cache Invalidation**:
- [Trigger 1]: [How to invalidate]
- [Trigger 2]: [How to invalidate]

**Caching Pattern**:
```[language]
// Cache usage pattern
[Show caching implementation]
```

### Optimization Patterns

**Database Optimization**:
- Indexes on: [Columns]
- Query optimization: [Patterns]
- Connection pooling: [Configuration]

**Frontend Optimization**:
- Code splitting: [Strategy]
- Lazy loading: [What and when]
- Image optimization: [Approach]

---

## Critical Paths

### [Critical Path 1]

**Importance**: [Why this path is critical]

**Flow**:
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Performance Requirements**:
- [Metric 1]: [Target]
- [Metric 2]: [Target]

**Failure Handling**:
- [Scenario]: [How to handle]

**Monitoring**:
- [What to monitor]
- [Alert thresholds]

### [Critical Path 2]

[Same structure as above]

---

## Architecture Decision Records (ADR)

### ADR Index

| ADR # | Date | Decision | Status |
|-------|------|----------|--------|
| ADR-001 | YYYY-MM-DD | [Decision title] | [Accepted/Superseded] |
| ADR-002 | YYYY-MM-DD | [Decision title] | [Accepted] |

### ADR Template

See `docs/adr/` for detailed ADRs. Each ADR follows this structure:

```markdown
# ADR-[number]: [Title]

**Status**: [Proposed/Accepted/Deprecated/Superseded]
**Date**: YYYY-MM-DD
**Deciders**: [Who was involved]

## Context
[What is the issue we're facing]

## Decision
[What we decided to do]

## Consequences
- **Positive**: [Benefits]
- **Negative**: [Drawbacks]
- **Neutral**: [Trade-offs]

## Alternatives Considered
1. [Alternative 1]: [Why rejected]
2. [Alternative 2]: [Why rejected]
```

---

## Anti-Patterns

### Avoid These Patterns

❌ **[Anti-Pattern 1]**: [What not to do]
- **Why it's bad**: [Problems it causes]
- **Instead do**: [Correct pattern]

❌ **[Anti-Pattern 2]**: [What not to do]
- **Why it's bad**: [Problems it causes]
- **Instead do**: [Correct pattern]

---

## Pattern Evolution

### Deprecated Patterns

| Pattern | Deprecated Date | Reason | Replacement |
|---------|----------------|--------|-------------|
| [Old pattern] | YYYY-MM-DD | [Why deprecated] | [New pattern] |

### Emerging Patterns

**Patterns under evaluation**:
- **[Pattern name]**: [Being tried in [location], evaluate by [date]]

---

## Revision History

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | YYYY-MM-DD | Initial creation | [Name/System] |

---

**Template Version**: 1.0
**Template Last Updated**: 2025-10-05
