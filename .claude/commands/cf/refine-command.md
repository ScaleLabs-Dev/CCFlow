---
description: "Optimize existing commands for clarity, completeness, and token efficiency using the CommandBuilder meta-agent"
allowed-tools: ['Read', 'Write', 'Bash(mkdir:*)', 'Task']
argument-hint: "<command-name> [--report-only] [--interactive]"
---

# Command: /cf:refine-command

Optimize existing CCFlow commands for clarity, completeness, and token efficiency without information loss using the CommandBuilder meta-agent.

## Usage

```
/cf:refine-command <command-name>
/cf:refine-command <command-path>
```

## Parameters

- `<command-name>`: Command name to refine (e.g., "sync", "code", "init")
- `<command-path>`: Full path to command file relative to `.claude/commands/cf/`

## Flags

- `--report-only`: Analyze and report optimization opportunities without making changes
- `--aggressive`: Apply maximum optimization (may require manual review)
- `--interactive`: Prompt for approval before each change

---

## Purpose

The CommandBuilder specification identifies that commands can become unclear, incomplete, or inefficient over time. This command applies systematic optimization to existing commands while maintaining their effectiveness and ensuring no critical information is lost.

**Key Benefits**:
- Improve clarity with clearer decision trees and process steps
- Add missing examples to reach 2-3 minimum scenarios
- Enhance error handling with actionable recovery steps
- Remove redundant Prerequisites sections (saves 200-400 tokens per command)
- Ensure all essential sections present
- Maintain token budgets (simple 800-1500, moderate 1500-3000, complex 3000-5000)

---

## Process

### Phase 1: Load & Analyze

1. **Locate Command**:
   - If command-name provided: Search `.claude/commands/cf/` for matching file
   - If command-path provided: Load directly

2. **Engage CommandBuilder** (Load & Analyze):
   - Read command file content
   - Identify complexity level (simple/moderate/complex)
   - Estimate current token usage (~4 chars = 1 token)
   - Detect issues:
     * Missing essential sections (Usage, Purpose, Process, Examples, Error Handling)
     * Unclear process or decision logic
     * Insufficient examples (<2 scenarios)
     * Incomplete error handling (no recovery guidance)
     * Redundant Prerequisites section (only mentions memory bank)
     * No action recommendations
     * Verbosity (>20% over token budget)

3. **Present Current State**:
   ```
   Command: /cf:[name]
   Complexity: [simple/moderate/complex]
   Current Size: ~X tokens (estimated)
   Target Budget: Y-Z tokens

   Issues Detected:
   - [List specific issues found]
   ```

---

### Phase 2: Optimize (if approved or not --report-only)

1. **CommandBuilder Optimization**:
   - Preserve YAML frontmatter and essential structure
   - Remove redundant Prerequisites sections (if only "memory bank initialized")
   - Clarify decision trees with clear If/Then/Else logic
   - Add missing examples to reach 2-3 minimum
   - Enhance error handling table with actionable recovery
   - Add action recommendations if missing
   - Consolidate verbose sections

2. **Apply Efficiency Principles**:
   - Essential + Conditional (only include sections with meaningful content)
   - Clear Decision Trees (not verbose explanations)
   - Comprehensive Examples (2-3 scenarios minimum)
   - Actionable Errors (recovery steps for each)
   - Remove Redundancy (DRY principle)
   - Action Recommendations (always recommend next step)

---

### Phase 3: Validate

1. **CommandBuilder Validation**:
   - Structure Check: All essential sections present? YAML valid? Conditional sections only when needed?
   - Token Budget Check: Within target for complexity level?
   - Quality Check: Clear process, comprehensive errors, action recommendations?
   - Completeness Check: Sufficient information for execution?
   - Information Loss Check: No critical details removed?

2. **Generate Comparison**:
   ```
   Command Refinement: /cf:[name]
   Before: X tokens (estimated)
   After: Y tokens (estimated)
   Reduction: Z% token savings

   Changes Made:
   - [Specific optimizations applied]
   - [Information consolidated]
   - [Structure improvements]

   Validation: [PASS/REVIEW NEEDED]
   ```

---

### Phase 4: Output

1. **Create Backup**:
   - Check if `.claude/commands/.backups/` exists, create if needed
   - Backup original to `.claude/commands/.backups/[name]-[timestamp].md`

2. **Write Optimized Command**:
   - Write refined version to original location
   - Update any cross-references if needed

3. **Report Results**:
   - Token savings achieved
   - Validation status
   - Any manual review items
   - Recommendation for testing

---

## Examples

### Example 1: Refine Single Command

```
User: /cf:refine-command sync

CommandBuilder Output:
Command: /cf:sync
Complexity: simple
Current Size: ~1650 tokens
Target Budget: 800-1500 tokens

Issues Detected:
- Redundant Prerequisites section (only mentions memory bank)
- Verbose process steps could be streamlined
- Missing action recommendations at end

Proceed with refinement? [y/n]

[After confirmation]

Command Refinement: /cf:sync
Before: ~1650 tokens
After: ~1350 tokens
Reduction: 18% token savings (300 tokens)

Changes Made:
- Removed redundant Prerequisites section
- Streamlined process steps with clearer decision points
- Added action recommendations section

Validation: PASS ✓

Optimized command written to: .claude/commands/cf/sync.md
Backup saved to: .claude/commands/.backups/sync-20251009.md
```

---

### Example 2: Report Only

```
User: /cf:refine-command code --report-only

CommandBuilder Output:
Command: /cf:code
Complexity: moderate
Current Size: ~2800 tokens
Target Budget: 1500-3000 tokens

Issues Detected:
- Examples section only has 1 scenario (need 2-3 minimum)
- Error handling missing recovery guidance for 2 errors
- Could add more explicit decision tree for agent selection

Potential Improvements:
1. Add 2 additional examples (edge cases, different scenarios)
2. Enhance error handling table with actionable recovery
3. Add explicit If/Then/Else for agent selection logic

Estimated Reduction: Minimal (within budget, improvements for clarity)

Run `/cf:refine-command code` to apply optimizations.
```

---

## Error Handling

| Error | Response |
|-------|----------|
| Command not found | "Command '[name]' not found in .claude/commands/cf/. Available: [list]" → Suggest correct name |
| No .backups directory | Create `.claude/commands/.backups/` automatically |
| YAML syntax error | "Command has invalid YAML frontmatter. Manual repair needed before refinement." |
| Validation fails after optimization | Restore from backup, report issue, mark for manual review |
| File write permission error | "Cannot write to .claude/commands/cf/. Check permissions." → Stop execution |

---

## Memory Bank Updates

**activeContext.md**:
- Add note about command refinement operation
- Include token savings achieved
- List any commands requiring manual review

**systemPatterns.md** (if significant changes):
- Document any new command patterns discovered
- Update command design standards if refined commands reveal better approaches

---

## Notes

1. **Backup Safety**: Always creates backup before modifying command files
2. **Token Estimation**: Uses ~4 characters = 1 token heuristic (not exact but consistent)
3. **Validation Required**: Will not overwrite if validation fails post-optimization
4. **Manual Review**: Aggressive optimization may require testing refined commands
5. **Cross-References**: If command integrations change during refinement, updates references
6. **Redundancy Removal**: Automatically removes Prerequisites sections that only mention "memory bank initialized"

---

## Related Commands

- `/cf:refine-agent [name]` - Parallel command for agent refinement
- `/cf:checkpoint` - Good practice after refinement operations
- `/cf:sync` - Verify memory bank state after refinements

---

**Command Version**: 1.0
**Last Updated**: 2025-10-09
