# Specialist Creation Guide

**Command**: `/cf:create-specialist`
**Purpose**: Create domain-specific agents for recurring patterns
**When**: Pattern repeats 3+ times in your project

---

## Overview

Specialists are custom agents that encapsulate domain-specific knowledge, patterns, and best practices for your project. They extend CCFlow's implementation agents with specialized expertise.

---

## When to Create a Specialist

### The 3-Time Rule
Create a specialist when you notice the same pattern appearing 3 or more times:

✅ **Good Reasons**:
- Authentication logic repeated across 3+ endpoints
- Payment processing pattern used in 3+ features
- Database migration pattern repeated 3+ times
- API integration pattern recurring
- Validation logic duplicated

❌ **Bad Reasons**:
- Pattern only appears once or twice
- One-off feature-specific code
- Standard CRUD operations (generic agents handle this)
- Framework boilerplate (belongs in systemPatterns.md)

---

## Specialist Types

### Development Specialists
**Type**: `--type development`

**Purpose**: Code implementation patterns

**Examples**:
- **authGuard**: Authentication middleware, token validation, permission checks
- **paymentGateway**: Payment processing, refunds, webhook handling
- **dbMigration**: Schema changes, data migrations, rollback strategies
- **apiClient**: Third-party API integration patterns
- **cacheManager**: Caching strategies, invalidation, warming

---

### Testing Specialists
**Type**: `--type testing`

**Purpose**: Test patterns and strategies

**Examples**:
- **e2eTest**: End-to-end test patterns
- **performanceTest**: Load testing, benchmarking
- **securityTest**: Penetration testing, vulnerability scanning
- **integrationTest**: Service integration testing patterns
- **mockFactory**: Test double creation patterns

---

### UI Specialists (via uiDeveloper)
**Type**: Via uiDeveloper agent

**Purpose**: UI component patterns

**Examples**:
- **formValidator**: Complex form validation patterns
- **dataTable**: Advanced table components with sorting/filtering
- **chartBuilder**: Data visualization patterns
- **modalManager**: Modal/dialog patterns
- **accessibilityAuditor**: A11y compliance patterns

---

## Creation Process

### Basic Command
```bash
/cf:create-specialist [domain] --type [development|testing] --name [agentName]
```

### Examples
```bash
# Authentication specialist
/cf:create-specialist authentication --type development --name authGuard

# Payment processing specialist
/cf:create-specialist payments --type development --name paymentGateway

# Database migration specialist
/cf:create-specialist migrations --type development --name dbMigration

# E2E testing specialist
/cf:create-specialist e2e-testing --type testing --name e2eTest
```

---

## What Gets Created

### File Location
`.claude/agents/specialists/[agentName].md`

### Generated Structure
```markdown
# [Agent Name] Specialist

**Type**: [Development|Testing]
**Domain**: [Domain description]
**Purpose**: [What this specialist does]

## Domain Expertise

[Specialist's specific knowledge area]

## Technology Stack

**Language**: [From project]
**Frameworks**: [From project]
**Tools**: [Domain-specific tools]

## Patterns & Best Practices

[Domain-specific patterns this specialist knows]

## Code Style

[Domain-specific coding standards]

## Common Operations

### Operation 1
[How to handle this pattern]

### Operation 2
[How to handle this pattern]

## Quality Standards

[Domain-specific quality criteria]

## Testing Approach

[How to test this domain]

## Tools

[Tools this specialist can use]

## Integration

[How this specialist works with other agents]
```

---

## Interactive Creation

### Step 1: Domain Analysis
agentBuilder analyzes your request:
```
🔧 Agent Builder: Analyzing domain...

Domain: Authentication
Type: Development
Name: authGuard

I'll create a specialist for authentication patterns.
```

---

### Step 2: Context Gathering
agentBuilder searches project for existing patterns:
```
Found existing authentication code:
- src/middleware/auth.ts
- src/utils/jwt.ts
- tests/auth/*.test.ts

Analyzing patterns...
```

---

### Step 3: Pattern Extraction
```
Identified patterns:
✓ JWT token validation
✓ Permission checking
✓ Role-based access control
✓ Session management

Creating specialist with these capabilities...
```

---

### Step 4: Specialist Generation
```
✓ Created: .claude/agents/specialists/authGuard.md

Specialist capabilities:
- JWT validation with refresh tokens
- Role-based permission checks
- Session lifecycle management
- Authentication middleware patterns

Integrated with:
- codeImplementer (for implementation)
- testEngineer (for auth tests)
```

---

### Step 5: Documentation Update
```
✓ Updated systemPatterns.md with authentication patterns
✓ Registered specialist in agent registry

Ready to use:
/cf:code [task] --specialist authGuard
```

---

## Using Specialists

### Explicit Invocation
```bash
# Use specific specialist for task
/cf:code TASK-042 --specialist authGuard
```

**Flow**:
1. codeImplementer detects `--specialist authGuard` flag
2. Invokes authGuard for domain-specific implementation
3. authGuard applies authentication patterns
4. Returns to codeImplementer for integration

---

### Automatic Discovery
Implementation agents automatically detect relevant specialists:

```bash
# Task involves authentication
/cf:code "Add API key authentication"

# codeImplementer automatically:
1. Checks specialists/ directory
2. Finds authGuard.md
3. Determines it's relevant
4. Invokes authGuard for implementation
```

---

## Specialist Refinement

### After Creation
```bash
# Optimize specialist (token efficiency)
/cf:refine-agent authGuard --target 800

# Target: 500-1500 tokens for specialists
```

---

### Manual Refinement
1. Open `.claude/agents/specialists/[name].md`
2. Add project-specific patterns
3. Update with lessons learned
4. Refine based on usage

---

## Examples by Domain

### Authentication Specialist
```bash
/cf:create-specialist authentication --type development --name authGuard
```

**Capabilities**:
- JWT token generation and validation
- OAuth flow implementation
- Session management
- Permission checks
- Multi-factor authentication

**Use Cases**:
- Login endpoints
- Protected route middleware
- Token refresh logic
- Permission guards

---

### Payment Specialist
```bash
/cf:create-specialist payments --type development --name paymentGateway
```

**Capabilities**:
- Stripe/PayPal integration
- Payment intent creation
- Webhook handling
- Refund processing
- Subscription management

**Use Cases**:
- Checkout flows
- Payment webhooks
- Refund requests
- Subscription updates

---

### Database Migration Specialist
```bash
/cf:create-specialist migrations --type development --name dbMigration
```

**Capabilities**:
- Schema changes
- Data transformations
- Rollback strategies
- Index management
- Migration testing

**Use Cases**:
- Adding/removing columns
- Table restructuring
- Data seeding
- Schema versioning

---

### API Integration Specialist
```bash
/cf:create-specialist api-integration --type development --name apiClient
```

**Capabilities**:
- REST/GraphQL clients
- Authentication handling
- Error handling & retries
- Rate limiting
- Response caching

**Use Cases**:
- Third-party service integration
- API client creation
- Webhook consumers
- Service proxies

---

## Best Practices

### DO
- ✅ Create specialists for recurring patterns (3+ times)
- ✅ Document domain-specific knowledge
- ✅ Include examples from your project
- ✅ Refine based on usage
- ✅ Keep specialists focused (single domain)
- ✅ Update systemPatterns.md with patterns

### DON'T
- ❌ Create specialists for one-off code
- ❌ Make specialists too broad (e.g., "backend specialist")
- ❌ Duplicate generic agent functionality
- ❌ Skip refining after creation
- ❌ Forget to document integration points

---

## Specialist Lifecycle

### 1. Recognition
Identify recurring pattern appearing 3+ times

### 2. Creation
```bash
/cf:create-specialist [domain] --type [type] --name [name]
```

### 3. First Use
Test specialist on existing code:
```bash
/cf:code [task] --specialist [name]
```

### 4. Refinement
After 2-3 uses, refine based on learnings:
```bash
/cf:refine-agent [name]
```

### 5. Documentation
Update specialist with project-specific patterns

### 6. Maintenance
Keep specialist updated as patterns evolve

---

## Integration with Other Agents

### codeImplementer
```
codeImplementer detects domain
  ↓
Checks specialists/ directory
  ↓
Finds relevant specialist
  ↓
Invokes specialist for domain logic
  ↓
Integrates specialist output
```

### testEngineer
```
testEngineer writing tests
  ↓
Checks for testing specialists
  ↓
Invokes specialist for domain tests
  ↓
Applies domain-specific test patterns
```

### uiDeveloper
```
uiDeveloper building UI
  ↓
Checks for UI specialists
  ↓
Invokes for complex UI patterns
  ↓
Applies component patterns
```

---

## Troubleshooting

### Specialist Not Being Used
**Problem**: Created specialist but agents aren't using it

**Solutions**:
1. Check naming convention (lowercase-with-hyphens)
2. Verify file location: `.claude/agents/specialists/[name].md`
3. Explicitly invoke: `--specialist [name]`
4. Check specialist's domain matches task

---

### Specialist Too Verbose
**Problem**: Specialist agent spec is too long

**Solution**:
```bash
/cf:refine-agent [name] --target 800
```

Target: 500-1500 tokens for specialists

---

### Wrong Patterns Extracted
**Problem**: agentBuilder extracted incorrect patterns

**Solution**:
1. Manually edit `.claude/agents/specialists/[name].md`
2. Replace with correct patterns from your code
3. Add examples from actual project files

---

## Advanced Usage

### Multiple Specialists
Projects can have many specialists:
```
.claude/agents/specialists/
├── authGuard.md
├── paymentGateway.md
├── dbMigration.md
├── cacheManager.md
└── apiClient.md
```

---

### Specialist Chains
Specialists can reference each other:
```
paymentGateway uses authGuard:
  ↓
Validates user authentication
  ↓
Processes payment
  ↓
Logs via auditLogger specialist
```

---

### Team-Specific Specialists
Different teams can have different specialists:
```
Frontend team:
- formValidator
- chartBuilder
- accessibilityAuditor

Backend team:
- authGuard
- paymentGateway
- dbMigration
```

---

## Related Documentation

- **Agent Organization**: `docs/architecture/agent-organization.md` - Specialist classification
- **Command Spec**: `.claude/commands/cf/create-specialist.md` - Complete command specification
- **Agent Builder**: `.claude/agents/system/agentBuilder.md` - Meta-agent that creates specialists
- **System Patterns**: `memory-bank/systemPatterns.md` - Where patterns are documented

---

**Version**: 1.0
**Last Updated**: 2025-10-23
**Status**: Active - Core workflow pattern
