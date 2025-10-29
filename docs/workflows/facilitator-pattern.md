# Facilitator Pattern

**Agent**: facilitator.md (`.claude/agents/workflow/`)
**Purpose**: Interactive refinement through structured questioning
**Used By**: All interactive commands (`/cf:init`, `/cf:plan --interactive`, `/cf:facilitate`)

---

## Overview

The Facilitator Pattern is a 6-step interaction protocol used across CCFlow for human-in-the-loop refinement. It ensures no user is left without clear next steps and systematically fills information gaps through structured questioning.

**Core Principle**: Facilitator outputs ONLY questions. User (and specialized agents) provide all answers, decisions, and content.

---

## The 6-Step Pattern

### 0. Detect Ambiguities (NEW - FIRST STEP)
**Purpose**: Question ambiguous requests BEFORE diving into refinement

**Example**:
```
🔄 Facilitator: Before we proceed, let me clarify your request...

Questions About Your Request:
- By "task manager" do you mean personal tasks, code tasks, or project tasks?
- When you say "integrates with IDEs" - which IDEs are you targeting?
- Is this for solo developers or teams?

Please help me understand what you're asking for.
```

**Key Points**:
- Question vague terms ("better", "improve", "fix", "manager")
- Clarify unclear scope (which components? what boundaries?)
- Identify multiple interpretations and ask which one is correct
- Resolve ambiguities BEFORE proceeding with content refinement

---

### 1. Present Current State
**Purpose**: Show what exists or has been captured WITHOUT interpretation

**Example**:
```
🔄 Facilitator: Here's what you said...

Your Description:
"A task manager for solo developers working with VS Code,
focused on code-level TODOs and technical debt tracking"

Is this accurate?
```

**Key Points**:
- Show user their input reflected back (their exact words)
- Do NOT interpret or synthesize - present what they said
- Confirm understanding before proceeding
- Ask if accurate, not assume it is

---

### 2. Identify Gaps via Questions
**Purpose**: Find what's missing, unclear, or needs refinement through questions

**Example**:
```
Questions to consider:
- What makes this different from existing task managers?
- What problem does IDE integration solve?
- Solo or team focused?
```

**Key Points**:
- Ask specific, targeted questions
- Identify assumptions that need validation
- Surface ambiguities early

---

### 3. Ask Clarifying Questions
**Purpose**: Gather needed information through structured inquiry

**Example**:
```
To refine this further:
1. Who is the primary user?
2. What's their current pain with existing tools?
3. How does IDE integration address that pain?
```

**Key Points**:
- Questions should be answerable (not too abstract)
- Build on previous responses
- Guide toward completeness

---

### 4. Present User's Answers and Validate
**Purpose**: Show user's responses organized clearly and validate accuracy

**Example**:
```
🔄 Facilitator: Here's what I captured from your answers:

Your Project:
"A task manager for solo developers who context-switch between projects,
surfacing tasks directly in their IDE to reduce app-switching and maintain focus."

Validation Questions:
1. Does this accurately reflect what you described?
2. Is anything missing or misrepresented?
3. Should we refine any aspect further?
```

**Key Points**:
- Present user's answers (their words, not your synthesis)
- Ask validation questions, don't assume accuracy
- Iterate until user explicitly approves
- No iteration limits - continue until satisfied

---

### 5. Always Recommend Next Action
**Purpose**: Never leave user without clear path forward

**Example**:
```
✓ Executive Summary captured

Next: Let's define the problem statement.

Ready to continue?
```

**Key Points**:
- Explicit next step
- Confirm user is ready
- Maintain momentum

---

## Iteration Management

### No Limits
**Principle**: Continue iterating until user is satisfied

**Pattern**:
```
Draft → Questions → Refine → "Better?"
  ↓ No
  └─→ More Questions → Refine → "Better?"
      ↓ No
      └─→ Questions → Refine → "Better?"
          ↓ Yes
          ✓ Approved
```

### When to Stop
- User explicitly approves ("Yes", "Perfect", "That's it")
- User says "move on" or similar
- User provides no further refinements

### Never Stop On
- Unclear or vague input
- Obvious gaps remaining
- User uncertainty ("I guess so")

---

## Application Across Commands

### /cf:init (Project Brief Creation)
**Usage**: 7-section guided creation

**Pattern per section**:
1. Present section (or template)
2. Identify what's needed
3. Ask domain questions
4. Refine based on responses
5. Recommend: "Section complete, next section?"

**Example Flow**:
```
[Executive Summary]
Present → Gaps → Questions → Refine → Approve → ✓

[Problem Statement]
Present → Gaps → Questions → Refine → Approve → ✓

...continues through 7 sections
```

---

### /cf:plan --interactive (Planning Refinement)
**Usage**: Iterative plan improvement

**Pattern**:
1. Present initial plan
2. Identify gaps (missing steps, unclear requirements)
3. Ask clarifying questions
4. Refine plan structure
5. Recommend: "Ready to execute?" or "Need more refinement?"

**Example Flow**:
```
Initial Plan: [3 steps]
  ↓
Gaps: "Step 2 is vague, what's the data model?"
  ↓
Questions: "What entities? What relationships?"
  ↓
Refined: [5 detailed steps with data model]
  ↓
Approve → Execute
```

---

### /cf:facilitate (General Exploration)
**Usage**: Open-ended topic exploration

**Pattern**:
1. Present topic understanding
2. Identify exploration areas
3. Ask guiding questions
4. Refine understanding
5. Recommend: Next exploration or action

**Example Flow**:
```
Topic: "Improve authentication"
  ↓
Current: "What auth challenges?"
  ↓
Questions: "Security? UX? Performance?"
  ↓
Refined: "Focus on UX - slow login"
  ↓
Recommend: /cf:feature "optimize login performance"
```

---

## Multi-Agent Collaboration

When facilitator works with domain experts:

### Pattern with Product Agent
```
🔄 Facilitator: [Requests Product agent analysis from parent command]
  ↓
🎨 Product: [Provides domain-specific questions and analysis]
  ↓
🔄 Facilitator: [Presents Product's questions to user]
  ↓
User: [Responds to questions]
  ↓
🔄 Facilitator: [Presents user's answers] "Here's what you said..."
  ↓
🔄 Facilitator: [Asks validation questions] "Does this align with your objectives?"
  ↓
User: [Confirms or clarifies]
```

### Pattern with Architect Agent
```
🔄 Facilitator: [Requests Architect agent analysis from parent command]
  ↓
🏗️ Architect: [Provides technical questions and concerns]
  ↓
🔄 Facilitator: [Presents Architect's questions to user]
  ↓
User: [Provides answers and context]
  ↓
🔄 Facilitator: [Presents user's answers] "Here's what you decided..."
  ↓
🔄 Facilitator: [Asks validation questions] "Is this technically sound?"
  ↓
User: [Confirms or requests changes]
```

---

## Quality Validation

Before completing any facilitated section, facilitator checks:

### Completeness
- [ ] All required information gathered
- [ ] No obvious gaps remain
- [ ] User has approved explicitly

### Clarity
- [ ] Information is specific, not vague
- [ ] Actionable outcomes defined
- [ ] Next steps are clear

### Structure
- [ ] Information is organized logically
- [ ] Follows expected format
- [ ] Consistent with project patterns

---

## Anti-Patterns (Avoid These)

### ❌ Accepting Vague Input
```
User: "Make it better"
Facilitator: "✓ Improved!" ← WRONG
```

**Correct**:
```
User: "Make it better"
Facilitator: "What specifically needs improvement?
- Performance?
- Usability?
- Features?"
```

---

### ❌ Assuming User Intent
```
User: "Add analytics"
Facilitator: "✓ Adding Google Analytics" ← WRONG (assumption)
```

**Correct**:
```
User: "Add analytics"
Facilitator: "What kind of analytics?
- User behavior tracking?
- Business metrics?
- Performance monitoring?
- Specific tool in mind?"
```

---

### ❌ Ending Without Next Step
```
Facilitator: "✓ Section complete" ← WRONG (what now?)
```

**Correct**:
```
Facilitator: "✓ Section complete

Next: Let's define scope.
Ready to continue?"
```

---

### ❌ Too Many Questions at Once
```
Facilitator: "Tell me about your users, their pain points,
current solutions, budget, timeline, team size, and tech stack." ← OVERWHELMING
```

**Correct**:
```
Facilitator: "Let's start with users.
Who is the primary user?"

[Get response, then next question]
```

---

## Edge Case Handling

### User Wants to Skip Section
```
User: "Skip this part"
Facilitator: "Skipping [X] means we won't have [Y],
which could cause [Z] later.

This section takes ~2-3 minutes.
Would you like to:
1. Continue with section
2. Skip and note for later
3. Use --quick mode instead"
```

### User Changes Mind
```
User: "Actually, change the previous section"
Facilitator: "No problem! Let's go back to [section].

Current version:
[Shows current]

What would you like to change?"
```

### Minimal Information Provided
```
User: "Just a simple app"
Facilitator: "To help you build this effectively,
I need a bit more detail.

Let me ask specific questions:
1. What does the app do?
2. Who uses it?
3. What problem does it solve?"
```

---

## Implementation Guidelines

### For Command Designers
When creating commands that use facilitator:

1. **Define sections clearly**: What information is needed per section
2. **Provide context**: Give facilitator domain context to ask good questions
3. **Set quality gates**: Define what "complete" means for each section
4. **Enable iteration**: Don't force linear progression
5. **Plan time**: Factor realistic time for interactive refinement

### For Agent Builders
When building agents that work with facilitator:

1. **Provide expertise**: Domain-specific questions and validation
2. **Defer to facilitator**: Let facilitator manage flow and iteration
3. **Validate completeness**: Check that information is sufficient
4. **Suggest structure**: Help organize information logically

---

## Success Metrics

A successful facilitation session:
- ✅ User understands what was captured
- ✅ No obvious gaps remain
- ✅ User explicitly approved output
- ✅ Clear next action provided
- ✅ User feels heard and guided (not interrogated)

---

## Related Documentation

- **Facilitator Agent**: `.claude/agents/workflow/facilitator.md` - Agent specification
- **Interactive Commands**: Commands using facilitator pattern
  - `/cf:init` - Project brief creation
  - `/cf:plan --interactive` - Interactive planning
  - `/cf:facilitate` - General exploration
- **Product Agent**: Works with facilitator for requirements
- **Architect Agent**: Works with facilitator for technical validation

---

**Version**: 2.0
**Last Updated**: 2025-10-29
**Status**: Active - Core workflow pattern

**Changes in v2.0**:
- Added Step 0: "Detect Ambiguities" as first step before any refinement
- Updated Step 1: Emphasize presenting user's exact words without interpretation
- Updated Step 4: Changed from "Refine Based on Feedback" to "Present User's Answers and Validate"
- Clarified facilitator outputs ONLY questions, never answers or synthesis
- Updated Multi-Agent Collaboration patterns to show facilitator coordinates via parent command
- Removed all "synthesizes" language - facilitator presents and asks questions only
