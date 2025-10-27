# Command: /cf:refine-agent

Optimize existing agents for token efficiency without information loss using the AgentBuilder meta-agent.

## Usage

```
/cf:refine-agent <agent-name>
/cf:refine-agent <agent-path>
```

## Parameters

- `<agent-name>`: Agent name to refine (e.g., "assessor", "codeImplementer")
- `<agent-path>`: Full path to agent file relative to `.claude/agents/`

## Flags

- `--report-only`: Analyze and report optimization opportunities without making changes
- `--aggressive`: Apply maximum optimization (may require manual review)
- `--interactive`: Prompt for approval before each change

## Purpose

The Agent Builder specification identifies that many agents can become verbose over time (>1500 tokens), reducing efficiency and increasing costs. This command applies systematic optimization to existing agents while maintaining their effectiveness and ensuring no critical information is lost.

**Key Benefits**:
- Reduce token usage by 30-90% depending on verbosity
- Maintain agent effectiveness and decision-making capability
- Enforce consistent structure across all agents
- Remove redundancy and consolidate examples
- Convert procedures to patterns for better reasoning

## Prerequisites

- CCFlow initialized (`/cf:init`)
- Target agent file exists in `.claude/agents/`

## Process

### Phase 1: Load & Analyze

1. **Locate Agent**:
   - If agent-name provided: Search `.claude/agents/` recursively
   - If agent-path provided: Load directly

2. **Engage AgentBuilder** (Load & Analyze):
   - Read agent file content
   - Verify YAML frontmatter follows [Claude Code Sub-Agents spec](docs/references/claude-code-sub-agents.md)
   - Identify agent type (workflow/core/specialist/generic)
   - Estimate current token usage (~4 chars = 1 token)
   - Detect verbosity issues:
     * Multiple framework examples
     * Tutorial-style explanations
     * Redundant information
     * Excessive lists (>10 items)
     * Verbose output templates
     * Repeated content across sections

3. **Present Current State**:
   ```
   Agent: [name]
   Type: [workflow/core/specialist/generic]
   Current Size: ~X tokens (estimated)
   Target Budget: Y-Z tokens

   Verbosity Issues Detected:
   - [List specific issues found]
   ```

### Phase 2: Optimize (if approved or not --report-only)

1. **AgentBuilder Optimization**:
   - Preserve YAML frontmatter and essential structure
   - Remove redundancy and repetitive content
   - Convert procedures → patterns (reasoning over steps)
   - Consolidate multiple examples → ONE comprehensive example
   - Convert exhaustive lists → principles (3-7 items max)
   - Replace duplication with references to CLAUDE.md/systemPatterns.md

2. **Apply Efficiency Principles**:
   - Structure Over Content
   - Patterns Over Examples
   - Reference Over Duplicate
   - Decision Over Procedure
   - ONE Good Example maximum
   - Progressive Enhancement

### Phase 3: Validate

1. **AgentBuilder Validation**:
   - Structure Check: All essential sections present? YAML follows Claude Code spec?
   - Frontmatter Check: Required fields (`name`, `description`) present and valid?
   - Token Budget Check: Within target for agent type?
   - Quality Check: Decision criteria clear and effective?
   - Completeness Check: Sufficient information for role?
   - Information Loss Check: No critical details removed?

2. **Generate Comparison**:
   ```
   Agent Refinement: [agent name]
   Before: X tokens (estimated)
   After: Y tokens (estimated)
   Reduction: Z% token savings

   Changes Made:
   - [Specific optimizations applied]
   - [Information consolidated]
   - [Structure improvements]

   Validation: [PASS/REVIEW NEEDED]
   ```

### Phase 4: Output

1. **Write Optimized Agent**:
   - Backup original to `.claude/agents/.backups/[agent-name]-[timestamp].md`
   - Write optimized version to original location
   - Update any cross-references if needed

2. **Report Results**:
   - Token savings achieved
   - Validation status
   - Any manual review items
   - Recommendation for testing

## Examples

### Example 1: Refine Single Agent
```
User: /cf:refine-agent assessor

Output:
Agent: Assessor
Type: workflow
Current Size: ~1250 tokens
Target Budget: 700-1300 tokens

Verbosity Issues Detected:
- Multiple similar examples (can consolidate to ONE)
- Some redundant explanations in Process section

Proceed with refinement? [y/n]

[After confirmation]

Agent Refinement: Assessor
Before: ~1250 tokens
After: ~950 tokens
Reduction: 24% token savings

Changes Made:
- Consolidated 3 examples into 1 comprehensive example
- Removed redundant process explanations
- Converted checklist to principles

Validation: PASS ✓

Optimized agent written to: .claude/agents/workflow/assessor.md
Backup saved to: .claude/agents/.backups/assessor-20251008.md
```

### Example 2: Report Only Mode
```
User: /cf:refine-agent generic/codeImplementer --report-only

Output:
Agent: codeImplementer
Type: generic
Current Size: ~12000 tokens (significantly over budget)
Target Budget: 600-900 tokens

Verbosity Issues Detected:
- 10+ framework examples (should be pattern + reference)
- Exhaustive procedural steps (should be decision logic)
- Multiple redundant sections
- Verbose output templates
- Tutorial-style explanations

Potential Reduction: ~93% (12000 → ~850 tokens)

Recommended Actions:
1. Consolidate framework examples → universal pattern
2. Convert procedures → decision logic
3. Remove redundant sections
4. Reference CLAUDE.md for framework details
5. Keep ONE comprehensive example

Run `/cf:refine-agent generic/codeImplementer` to apply optimizations.
```


## Error Handling

| Error | Response |
|-------|----------|
| Agent not found | "Agent '[name]' not found. Available agents in [type]: [list]" → Suggest correct name |
| Not initialized | "CCFlow not initialized. Run: /cf:init" |
| No .backups directory | Create `.claude/agents/.backups/` automatically |
| YAML syntax error in agent | "Agent file has invalid YAML frontmatter. Manual repair needed before refinement." |
| Validation fails after optimization | Restore from backup, report issue, mark for manual review |

## Memory Bank Updates

**activeContext.md**:
- Add note about agent refinement operation
- Include token savings achieved
- List any agents requiring manual review

**systemPatterns.md** (if significant changes):
- Document any new efficiency patterns discovered
- Update agent design standards if refined agents reveal better approaches

## Notes

1. **Backup Safety**: Always creates backup before modifying agent files
2. **Token Estimation**: Uses ~4 characters = 1 token heuristic (not exact but consistent)
3. **Validation Required**: Will not overwrite if validation fails post-optimization
4. **Manual Review**: Aggressive optimization may require testing refined agents
5. **Cross-References**: If agent name changes during refinement, updates references in other files
6. **Claude Code Compliance**: All refined agents must follow official [Sub-Agent specification](docs/references/claude-code-sub-agents.md)

## Related Commands

- `/cf:create-specialist` - Uses AgentBuilder to generate new specialists
- `/cf:configure-team --custom` - Uses AgentBuilder for custom core agents
- `/cf:init` - May invoke AgentBuilder for template configuration
- `/cf:checkpoint` - Good practice after batch refinement operations
