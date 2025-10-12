---
domain: [domain-name]
stack: [stack-name]
version: 1.0
custom: true
---

# Team Routing Configuration: [Team Name]

This file defines which implementation agents handle which tasks and when to delegate to specialists.

## Core Agents

### [Core Agent 1 Name]
**Agent Path**: `.claude/agents/[agentName].md`
**Fallback Path**: `.claude/agents/[genericAgentName].md`
**Scope**: [What this agent handles - e.g., backend logic, frontend UI, database operations]
**Keywords**: [keyword1, keyword2, keyword3, keyword4]

**Delegation Rules**:
- [Work type] ([keywords]) → [specialistName] specialist
- [Work type] ([keywords]) → Handle directly (no delegation)

### [Core Agent 2 Name]
**Agent Path**: `.claude/agents/[agentName].md`
**Fallback Path**: `.claude/agents/[genericAgentName].md`
**Scope**: [What this agent handles]
**Keywords**: [keyword1, keyword2, keyword3, keyword4]

**Delegation Rules**:
- [Work type] ([keywords]) → [specialistName] specialist
- [Work type] ([keywords]) → Handle directly

### [Core Agent 3 Name] (Testing)
**Agent Path**: `.claude/agents/[testAgentName].md`
**Fallback Path**: `.claude/agents/testEngineer.md`
**Scope**: [Testing framework and types]
**Keywords**: test, spec, testing, [testing-framework-name]

**Delegation Rules**:
- No delegation (testing agents handle all test types directly)

## Specialist Routing Rules

### [Core Agent 1] Specialists

**[Specialist1Name]** → `.claude/agents/specialists/[specialist1Name].md`
- **Triggers**: [keyword1, keyword2, keyword3]
- **Fallback**: [CoreAgent1] handles with general patterns
- **Returns To**: [CoreAgent1] for integration

**[Specialist2Name]** → `.claude/agents/specialists/[specialist2Name].md`
- **Triggers**: [keyword1, keyword2, keyword3]
- **Fallback**: [CoreAgent1] handles with general patterns
- **Returns To**: [CoreAgent1] for integration

### [Core Agent 2] Specialists

**[Specialist3Name]** → `.claude/agents/specialists/[specialist3Name].md`
- **Triggers**: [keyword1, keyword2, keyword3]
- **Fallback**: [CoreAgent2] handles with general patterns
- **Returns To**: [CoreAgent2] for integration

## Fallback Behavior

### When Specialist Missing
If a specialist is not available:
1. Core agent handles task directly with general [framework/technology] patterns
2. Logs: "Using general patterns - specialist [name] recommended"
3. Documents pattern in activeContext.md for potential specialist creation

### When Core Agent Missing
If a core agent is not available:
1. Falls back to generic agent ([genericAgentName])
2. Logs: "Using generic agent - stack-specific agent missing"
3. Generic agent handles with framework-agnostic best practices

### When All Agents Missing
If both core and generic agents missing:
1. ERROR: System misconfiguration
2. User must run: /cf:init to restore agents
3. /cf:code command should detect and report this

## Task Routing Logic (for /cf:code)

### Step 1: Keyword Analysis
Extract keywords from task description:
- [Domain 1] keywords → [CoreAgent1] (or [GenericFallback1])
- [Domain 2] keywords → [CoreAgent2] (or [GenericFallback2])
- Testing keywords → [TestAgent] (or testEngineer fallback)

**IMPORTANT - Disambiguation Strategy**: If task matches multiple agents' keywords, **first match wins**. Order agents by priority (most specific first). Example:
```
Task: "Optimize database query performance"
Keywords match: database (CoreAgent1), performance (CoreAgent2)
Result: CoreAgent1 selected (listed first)
```

### Step 2: Agent Selection
1. Check if stack-specific agent exists ([coreAgentName].md)
2. If yes → Use stack-specific agent
3. If no → Use generic fallback ([genericAgentName].md)
4. If neither → ERROR and guide user to run /cf:init

### Step 3: Specialist Delegation (within agent)
Agent determines if task requires specialist:
- [CoreAgent1] checks for [domain] keywords → delegates to specialist
- [CoreAgent2] checks for [domain] keywords → delegates to specialist
- [TestAgent] never delegates (handles all test types)

## Usage in /cf:code Command

```markdown
## Process (in /cf:code command)

1. Read `routing.md` to understand team configuration
2. Analyze task keywords
3. Select appropriate agent:
   - [Domain1] task → [CoreAgent1] (or [GenericFallback1])
   - [Domain2] task → [CoreAgent2] (or [GenericFallback2])
   - Testing task → [TestAgent] (or testEngineer fallback)
4. Invoke selected agent
5. Agent handles delegation to specialists if needed
6. Agent returns implementation
7. Update memory bank with results
```

## Team Type Information

**Domain**: [Domain name - e.g., Web, Mobile, AI, Desktop]
**Stack**: [Technology stack description]
**Primary Technologies**:
- [Technology 1]: [Purpose]
- [Technology 2]: [Purpose]
- [Technology 3]: [Purpose]

**When to Use This Team**:
- [Use case 1]
- [Use case 2]
- [Use case 3]

**When NOT to Use**:
- [Scenario where different team needed]
- [Scenario where different team needed]
- [Scenario where different team needed]

## Keyword-to-Agent Mapping

### [CoreAgent1] Keywords
Primary: [keyword1, keyword2, keyword3]
Secondary: [keyword4, keyword5, keyword6]
Delegation triggers: [specialist1-keywords], [specialist2-keywords]

### [CoreAgent2] Keywords
Primary: [keyword1, keyword2, keyword3]
Secondary: [keyword4, keyword5, keyword6]
Delegation triggers: [specialist3-keywords], [specialist4-keywords]

### [TestAgent] Keywords
Primary: test, spec, testing, [testing-framework]
Secondary: coverage, unit, integration, e2e
No delegation (handles all directly)

## Configuration Notes

**Created By**: /cf:configure-team command
**Custom**: true (custom team type created with Facilitator)
**Version**: 1.0
**Created Date**: [YYYY-MM-DD]

**Modification**:
- To add specialists: Create new agent in `specialists/` directory, add to routing rules above
- To change delegation rules: Update "Delegation Rules" sections for each core agent
- To add core agents: Create agent file, add section above with keywords and delegation rules
- To switch teams: Run /cf:configure-team again with different configuration

## Team Architecture Diagram

```
User Request
    ↓
/cf:code (reads routing.md)
    ↓
[Keyword Analysis]
    ↓
    ├─→ [CoreAgent1] (keywords: [list])
    │       ├─→ [Specialist1] (keywords: [list])
    │       └─→ [Specialist2] (keywords: [list])
    │
    ├─→ [CoreAgent2] (keywords: [list])
    │       └─→ [Specialist3] (keywords: [list])
    │
    └─→ [TestAgent] (keywords: [list])
            └─→ No delegation (handles directly)

Fallback Chain:
[CoreAgent] → [GenericAgent] → ERROR (must run /cf:init)
[Specialist] → [CoreAgent handles directly] → Continue
```

## Notes

- Core agents coordinate and can delegate to specialists
- Specialists focus on narrow expertise and return to core agents
- Testing agents handle all test types directly (no specialists)
- Generic agents are always available as fallback
- Routing.md is read by /cf:code to determine agent selection
- Specialists are NEVER invoked directly by /cf:code
