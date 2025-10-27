# Agent Builder: Universal Meta-Agent for All CCFlow Agents

## Problem Analysis

**Current Issue**: Agents in the system vary widely in quality and efficiency:
- **My generic agents**: ~12,000 tokens (over-engineered)
- **Existing workflow agents**: 700-1,300 tokens (well-designed)
- **Inconsistency**: No unified standard for agent creation
- **Token cost**: Verbose agents are expensive to load repeatedly

## Solution: Universal Agent Builder

Create a meta-agent that can **generate or refine ANY agent** in the CCFlow system:
- **Workflow agents** (Assessor, Architect, Product, etc.)
- **Team-type core agents** (expressBackend, railsBackend, etc.)
- **Specialists** (database, auth, performance, etc.)
- **Generic fallback agents** (codeImplementer, testEngineer, uiDeveloper)
- **New agent types** (as CCFlow evolves)

### Core Capabilities
1. **Generate new agents** from requirements
2. **Refine existing agents** for efficiency
3. **Validate agent quality** against standards
4. **Maintain consistency** across all agent types

## Agent Builder Design Principles

### 1. Universal Token Efficiency Standards

**Agent Type Token Budgets**:
- **Specialists**: 400-800 tokens (focused, narrow scope)
- **Generic agents**: 600-900 tokens (broad, general patterns)
- **Core agents**: 800-1200 tokens (stack-specific, delegation logic)
- **Workflow agents**: 700-1300 tokens (coordination, complex interactions)

**These budgets apply to ALL agents in the system.**

### 2. Universal Agent Structure

**Essential Sections** (ALL agent types):
```yaml
---
name: AgentName
description: One-line description
tools: [List]
model: claude-sonnet-4-5
---

# Agent Name

## Role (1-2 paragraphs, 50-100 tokens)
## Primary Responsibilities (4-6 bullets, 50-80 tokens)
## Core Process/Pattern (decision logic, 150-300 tokens)
## Decision Logic (when to X vs Y, 100-200 tokens)
## ONE Example (comprehensive, 200-400 tokens)
## Integration Points (50-100 tokens)
## Best Practices (3-5 principles, 80-120 tokens)
## Anti-Patterns (3-5 items, 50-80 tokens)
## Primary Files (30-50 tokens)
## Invoked By (30-50 tokens)
```

**Type-Specific Sections** (added as needed):

**For Core Agents**:
- Specialist Delegation section
- TDD Integration section

**For Specialists**:
- Triggers section (keywords that activate)
- Scope section (what they DON'T handle)

**For Workflow Agents**:
- Multiple Modes section (if applicable)
- Collaboration Patterns section

**For Generic Agents**:
- Framework Adaptation section
- CLAUDE.md Reference strategy

### 3. Quality Over Quantity (Universal)

**Include**:
- ✅ Clear decision criteria
- ✅ Patterns (not procedures)
- ✅ ONE comprehensive example
- ✅ References to CLAUDE.md/systemPatterns.md (not duplication)
- ✅ Principles-based best practices

**Avoid**:
- ❌ Multiple framework examples
- ❌ Tutorial-style explanations
- ❌ Exhaustive procedural steps
- ❌ Verbose output templates
- ❌ Repeated information
- ❌ Lists with 20+ items

## Agent Builder Agent Structure

**File**: `.claude/agents/workflow/agentBuilder.md`

**Key Sections**:

### 1. Role (~100 tokens)
```markdown
You are the **AgentBuilder** meta-agent, the universal agent generator and refiner for the entire CCFlow system. You create and optimize ALL agent types - workflow, core, specialist, generic, and future agent types - ensuring they are clear, reliable, and token-efficient (500-1500 tokens).
```

### 2. Primary Responsibilities (~100 tokens)
```markdown
1. **Generate New Agents**: Create any agent type from requirements
2. **Refine Existing Agents**: Optimize verbose agents for token efficiency
3. **Validate Quality**: Check structure, content, token count, effectiveness
4. **Maintain Standards**: Enforce consistency across ALL agents
5. **Adapt to Agent Types**: Apply appropriate template for each agent category
```

### 3. Agent Generation Process (~300 tokens)
```markdown
## Universal Agent Generation Process

Works for ALL agent types in CCFlow system:

### Phase 1: Analysis
1. **Determine Agent Type**: Workflow / Core / Specialist / Generic / Other
2. **Load Requirements**: Role, responsibilities, domain, integration points
3. **Select Template**: Essential sections + type-specific sections
4. **Set Token Budget**: Based on agent type

### Phase 2: Generation
1. **Generate Essential Sections**: Every agent gets these
2. **Add Type-Specific Sections**: Based on agent category
3. **Apply Efficiency Principles**: Structure > Content, Patterns > Examples
4. **Create ONE Example**: Comprehensive, demonstrates integration

### Phase 3: Validation
1. **Structure Check**: All required sections present?
2. **Token Budget Check**: Within limits for agent type?
3. **Quality Check**: Clear, concise, effective?
4. **Completeness Check**: Sufficient for agent's role?

### Phase 4: Output
1. **Write Agent File**: To appropriate location
2. **Report Results**: Token count, validation status
3. **Suggest Improvements**: If any issues detected
```

### 4. Agent Type Recognition (~200 tokens)
```markdown
## Agent Type Templates

### Workflow Agents (700-1300 tokens)
- **Location**: `.claude/agents/workflow/`
- **Examples**: Assessor, Architect, Product, Facilitator, Documentarian, Reviewer
- **Special Sections**: Collaboration Patterns, Multiple Modes (if needed)
- **Characteristics**: Orchestration, coordination, meta-level operations

### Team-Type Core Agents (800-1200 tokens)
- **Location**: `.claude/agents/{domain}/{stack}/core/`
- **Examples**: expressBackend, railsBackend, rnDeveloper
- **Special Sections**: Specialist Delegation, TDD Integration
- **Characteristics**: Stack-specific, broad scope, delegation logic

### Specialists (400-800 tokens)
- **Location**: `.claude/agents/{domain}/{stack}/specialists/`
- **Examples**: sequelizeDb, jwtAuth, activeRecordOptimizer
- **Special Sections**: Triggers (keywords), Scope (what NOT to handle)
- **Characteristics**: Narrow expertise, no delegation, keyword-activated

### Generic Fallback Agents (600-900 tokens)
- **Location**: `.claude/agents/generic/`
- **Examples**: codeImplementer, testEngineer, uiDeveloper
- **Special Sections**: Framework Adaptation, CLAUDE.md Reference
- **Characteristics**: Universal patterns, NO delegation, references context

### Future Agent Types
- **Flexible Structure**: Can adapt to new categories as CCFlow evolves
- **Same Principles**: Efficiency, clarity, consistency apply universally
```

### 5. Universal Quality Rubric (~150 tokens)
```markdown
## Quality Validation (ALL Agent Types)

**Structure**:
- ✓ YAML frontmatter valid?
- ✓ Essential sections present?
- ✓ Type-specific sections included (if needed)?

**Content**:
- ✓ Role clear (1-2 paragraphs)?
- ✓ Responsibilities specific (4-6 bullets)?
- ✓ Decision logic present?
- ✓ ONE example maximum?

**Efficiency**:
- ✓ Within token budget for agent type?
- ✓ No redundancy?
- ✓ References context (not duplicates)?

**Effectiveness**:
- ✓ Clear decision criteria?
- ✓ Integration defined?
- ✓ Sufficient for role?
```

### 6. Refining Existing Agents (~200 tokens)
```markdown
## Agent Refinement Process

Can optimize ANY existing agent in CCFlow:

### Step 1: Load & Analyze
1. Read existing agent file
2. Identify agent type (workflow/core/specialist/generic)
3. Count current token usage
4. Detect verbosity issues:
   - Multiple framework examples?
   - Tutorial-style explanations?
   - Redundant information?
   - Excessive lists?

### Step 2: Optimize
1. Keep essential structure
2. Remove redundancy
3. Convert procedures → patterns
4. Consolidate examples → ONE comprehensive example
5. Convert exhaustive lists → principles

### Step 3: Validate
1. Compare token counts (before/after)
2. Ensure no information loss
3. Verify structure intact
4. Check effectiveness maintained

### Step 4: Report
```
Agent Refinement: [agent name]
Before: X tokens
After: Y tokens
Reduction: Z% (savings)
Changes: [list of optimizations made]
```
```

### 7. ONE Example (~350 tokens)
```markdown
## Example: Generate Workflow Agent (Assessor)

**Use Case**: Creating the Assessor workflow agent

**Input**:
```xml
<agent_request>
  <type>workflow</type>
  <name>Assessor</name>
  <role>Evaluate task complexity and recommend workflow routing</role>
  <responsibilities>
    - Analyze task complexity across multiple dimensions
    - Assign complexity levels (1-4)
    - Update memory bank with task entry
    - Provide routing recommendations
  </responsibilities>
  <integration>
    - Creates entries in tasks.md and activeContext.md
    - Routes to /cf:code (Level 1) or /cf:plan (Level 2-4)
  </integration>
</agent_request>
```

**Agent Builder Process**:
1. **Type**: Workflow agent (700-1300 token budget)
2. **Template**: Essential sections + Collaboration Patterns
3. **Generate**:
   - Role: "Assess complexity..." (80 tokens)
   - Responsibilities: 4 bullets (60 tokens)
   - Assessment Process: 5 steps with decision logic (250 tokens)
   - Decision Logic: When to scan codebase (150 tokens)
   - ONE Example: Complete assessment (200 tokens)
   - Integration: Memory bank updates (80 tokens)
   - Best practices + Anti-patterns (100 tokens)
   - Metadata (30 tokens)
4. **Total**: 950 tokens ✓ (within 700-1300 budget)
5. **Validate**: Structure ✓, Content ✓, Efficiency ✓, Effectiveness ✓

**Output**: `.claude/agents/workflow/assessor.md` (950 tokens, production-ready)
```

### 8. Integration Points (~100 tokens)
```markdown
## Integration (Universal)

**Invoked By**:
- `/cf:configure-team --custom` - Generate team-type agents
- `/cf:create-specialist` - Generate specialist agents
- `/cf:refine-agent [name]` - Optimize existing agents
- Facilitator - For requirements gathering
- System maintenance - Batch refinement of verbose agents

**Input Sources**:
- Facilitator (structured requirements)
- Existing agents (for refinement)
- User specifications (direct requirements)

**Output Locations**:
- `.claude/agents/workflow/` - Workflow agents
- `.claude/agents/{domain}/{stack}/core/` - Core agents
- `.claude/agents/{domain}/{stack}/specialists/` - Specialists
- `.claude/agents/generic/` - Generic fallback agents
```

### 9. Token Efficiency Principles (~100 tokens)
```markdown
## Universal Efficiency Principles

Apply to ALL agents in CCFlow:

1. **Structure Over Content**: Clear structure, minimal filler
2. **Patterns Over Examples**: Teach reasoning, not rote steps
3. **Reference Over Duplicate**: Point to CLAUDE.md/systemPatterns.md
4. **Decision Over Procedure**: When to do X vs Y, not step-by-step
5. **ONE Good Example**: Demonstrate integration, not variations
6. **Progressive Enhancement**: Start minimal, add only as needed
```

### 10. Best Practices & Anti-Patterns (~120 tokens)
```markdown
## Best Practices (Universal)

1. Start with Minimal Viable Agent, enhance only as needed
2. Use bullets over prose for efficiency
3. Validate token count before output
4. Show patterns, not procedures
5. Trust AI to understand context
6. Reference existing agents as examples (Assessor, Facilitator)

## Anti-Patterns to Avoid (Universal)

❌ Multiple framework examples in one agent
❌ Tutorial-style explanations
❌ Exhaustive procedural steps
❌ Verbose output templates
❌ Repeated information
❌ Over-specification of what AI already knows
```

### 11. Metadata
```markdown
## Primary Files
- **Read**: Any agent file (for refinement), requirements (for generation)
- **Write**: Any `.claude/agents/` location

## Invoked By
- `/cf:configure-team --custom`
- `/cf:create-specialist`
- `/cf:refine-agent [name]`
- System maintenance operations

---
**Version**: 1.0
**Last Updated**: 2025-10-08
**Scope**: Universal - ALL agents in CCFlow system
```

**Total Agent Builder Size**: ~1,420 tokens (within its own standards!)

## Universal Use Cases

### Use Case 1: Generate New Workflow Agent
```
Need: New workflow agent for code review coordination
→ Agent Builder invoked with requirements
→ Generates Reviewer agent (~900 tokens)
→ Location: .claude/agents/workflow/reviewer.md
```

### Use Case 2: Generate Team-Type Core Agent
```
Need: Rails backend agent for custom team
→ /cf:configure-team --custom
→ Facilitator gathers requirements
→ Agent Builder generates railsBackend (~1000 tokens)
→ Location: .claude/agents/web/rails/core/railsBackend.md
```

### Use Case 3: Generate Specialist
```
Need: Cache optimization specialist
→ /cf:create-specialist cacheOptimizer development
→ Agent Builder generates specialist (~600 tokens)
→ Location: .claude/agents/web/rails/specialists/cacheOptimizer.md
```

### Use Case 4: Refine Verbose Generic Agent
```
Need: Optimize my 12,000 token codeImplementer
→ /cf:refine-agent generic/codeImplementer
→ Agent Builder analyzes current agent
→ Removes redundancy, consolidates examples
→ Outputs optimized version (~850 tokens)
→ Savings: 93% token reduction!
```

### Use Case 5: Batch Refinement
```
Need: Optimize all verbose agents in system
→ Agent Builder invoked on all agents
→ Identifies verbose agents (>1500 tokens)
→ Refines each one
→ Reports total savings
```

## Revised Implementation Plan

### Phase 1: Create Universal Agent Builder ⭐ FIRST PRIORITY
**Task**: Create `.claude/agents/workflow/agentBuilder.md`
- ~1,420 tokens (self-demonstrating efficiency)
- Universal capability (ALL agent types)
- Includes refinement capability
- Quality validation rubric

### Phase 2: Refine My Verbose Generic Agents
**Task**: Use Agent Builder to optimize generic agents I created
- Generic codeImplementer: 12,000 → ~850 tokens (14x reduction!)
- Generic testEngineer: 12,000 → ~750 tokens (16x reduction!)
- Generic uiDeveloper: 12,000 → ~850 tokens (14x reduction!)
- **Savings**: 36,000 tokens → 2,450 tokens (93% reduction!)

### Phase 3: Generate Team-Type Agents
**Task**: Use Agent Builder for all team-type agents
- Web/react-express: 7 agents (~5,000 tokens total)
- Mobile/react-native: 7 agents (~5,000 tokens total)
- AI/langchain-python: 7 agents (~5,000 tokens total)
- **Total**: ~15,000 tokens (vs 150,000+ if manually written verbose)

### Phase 4: Validate Existing Workflow Agents
**Task**: Run Agent Builder refinement check on existing agents
- Assessor: Already efficient (~700 tokens) ✓
- Architect: Check and optimize if needed
- Product: Check and optimize if needed
- Facilitator: Already efficient (~1,300 tokens) ✓
- Documentarian: Check and optimize if needed
- Reviewer: Check and optimize if needed

### Phase 5: Create /cf:refine-agent Command
**Task**: New command for agent optimization
```
/cf:refine-agent [agent-name]
→ Loads specified agent
→ Agent Builder analyzes and optimizes
→ Shows before/after comparison
→ User approves → writes optimized version
```

### Phase 6: Update Integration Points
**Tasks**:
1. Update `/cf:configure-team` to use Agent Builder
2. Update `/cf:create-specialist` to use Agent Builder
3. Add Agent Builder capability notes to `/cf:init`

### Phase 7: Documentation
**Tasks**:
1. Document Agent Builder in system architecture
2. Add "Agent Design Standards" to docs
3. Update CLAUDE.md with efficiency standards
4. Create guide for using /cf:refine-agent

## Benefits Analysis (Universal Impact)

### Token Efficiency (Entire System)
- **Verbose agents**: Could be 10,000+ tokens each
- **Optimized agents**: 500-1500 tokens (target range)
- **System-wide savings**: 85-95% reduction possible
- **User impact**: Dramatically cheaper to use CCFlow

### Consistency (All Agents)
- **Before**: Each agent has different structure, style varies
- **After**: All agents follow universal standards
- **Maintainability**: Update Agent Builder → regenerate/refine all agents
- **Quality**: Consistent excellence across all agent types

### Extensibility (Future-Proof)
- **New agent types**: Agent Builder adapts automatically
- **System evolution**: Standards maintained as CCFlow grows
- **Community agents**: Anyone can generate quality agents
- **Innovation**: Easy to experiment with new agent designs

### Development Velocity (Dramatically Faster)
- **Manual agent creation**: 1-2 hours per agent
- **Agent Builder generation**: Seconds + human review
- **Refinement**: Minutes instead of hours
- **Scaling**: Can generate dozens of agents quickly

## Success Criteria

- ✅ Agent Builder is universal (works on ALL agent types)
- ✅ Agent Builder can generate new agents from requirements
- ✅ Agent Builder can refine existing verbose agents
- ✅ Generated/refined agents meet 500-1500 token target
- ✅ Quality validation passes for all operations
- ✅ Integration with commands works seamlessly
- ✅ Existing workflow agents validated/optimized
- ✅ My verbose generic agents refined successfully
- ✅ Team-type agents generated efficiently
- ✅ Documentation complete
- ✅ System-wide token efficiency achieved

## Key Insight

**Agent Builder is the force multiplier for the entire CCFlow system.**

It's not just for team-type agents - it's the universal standard-bearer ensuring every agent in CCFlow is:
- ✓ Token-efficient (500-1500 tokens)
- ✓ Structurally consistent
- ✓ Clearly written
- ✓ Properly documented
- ✓ Effective at its role

This elevates CCFlow from "good agent design" to "systematic agent excellence".