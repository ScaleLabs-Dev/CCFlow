# /cf:init Command Specification - CCFlow

## Overview

The `/cf:init` command initializes the CCFlow workflow system for a new project. It creates the memory bank structure, generates agent templates, and most importantly, **guides the user through an iterative, comprehensive project brief creation process** using the Facilitator and Product agents working in tandem.

**Command Location**: `.claude/commands/cf/init.md`

**Default Behavior**: Always interactive (cannot be overridden)

---

## Command Signature

```
/cf:init [project-name] [flags]
```

**Parameters:**
- `project-name`: Name of the project (required)

**Flags:**
- `--interactive` (default, implicit): Full guided creation
- `--quick`: Minimal setup, skip guided brief creation (creates stub files only)

---

## Core Philosophy

Project initialization is **not** a form-filling exercise. It's a **collaborative discovery process** where:

1. **Facilitator** guides the conversation and refinement
2. **Product** agent provides expertise on requirements and user needs
3. **Architect** agent weighs in on technical feasibility
4. **User** provides domain knowledge and vision
5. **Iteration** continues until the brief is comprehensive and clear

The goal: A project brief that genuinely captures what needs to be built and why, serving as a reliable foundation for all future work.

---

## Command Workflow

### Phase 1: Structure Creation (Non-Interactive)

**Duration**: ~10 seconds

**Actions:**
1. Create directory structure
2. Generate template files
3. Create stub agent files
4. Initialize git tracking (if applicable)

**Output:**
```
🚀 Initializing CCFlow for: [project-name]

Creating directory structure...
✓ Created memory-bank/
✓ Created memory-bank/templates/
✓ Created .claude/agents/testing/
✓ Created .claude/agents/development/
✓ Created .claude/agents/ui/
✓ Created .claude/commands/cf/

Generating template files...
✓ Created memory-bank/templates/projectbrief.template.md
✓ Created memory-bank/templates/productContext.template.md
✓ Created memory-bank/templates/systemPatterns.template.md
✓ Created memory-bank/templates/activeContext.template.md
✓ Created memory-bank/templates/progress.template.md
✓ Created memory-bank/templates/tasks.template.md

Creating agent templates...
✓ Created .claude/agents/testing/testEngineer.md (template)
✓ Created .claude/agents/development/codeImplementer.md (template)
✓ Created .claude/agents/ui/uiDeveloper.md (template)

Structure created successfully!
```

---

### Phase 2: Guided Project Brief Creation (Interactive)

**Duration**: ~10-20 minutes (depending on project complexity)

**Agents Engaged:**
- **Facilitator** (primary): Guides conversation, identifies gaps, manages iteration
- **Product** (expert): Provides structure, asks domain questions, suggests best practices
- **Architect** (advisor): Raises technical considerations, feasibility questions

#### Step 1: Introduction & Context Setting

**Facilitator presents:**
```
📋 PROJECT BRIEF CREATION

We'll now create your project brief through a guided conversation. This brief becomes the foundation for all future work, so we'll take time to get it right.

The process:
1. I'll ask questions to understand your vision
2. We'll draft each section together
3. You'll review and refine
4. We'll iterate until it's comprehensive

This typically takes 10-20 minutes. Ready to begin?
```

**User confirms readiness**

---

#### Step 2: Executive Summary (Product-Led, Facilitator-Guided)

**Product agent asks:**
```
🎨 Product Agent: Let's start with the core vision.

In 1-2 sentences, what are you building and why does it matter?

Don't worry about perfection - we'll refine this together.
```

**User provides initial response**

**Facilitator reviews:**
```
🔄 Facilitator: Let me capture that...

Draft Executive Summary:
"[User's response, lightly cleaned up]"

Questions to refine:
- Is this the right scope, or should it be broader/narrower?
- Does this capture the "why" or just the "what"?
- Would someone unfamiliar with the project understand this?

What would you adjust?
```

**User provides feedback**

**Facilitator iterates:**
```
🔄 Facilitator: Updated version:

"[Refined based on feedback]"

Better? Or should we refine further?
```

**Repeat until user approves**

**Facilitator marks complete:**
```
✓ Executive Summary captured
```

---

#### Step 3: Problem Statement (Product-Led with Depth)

**Product agent asks:**
```
🎨 Product Agent: Now let's clarify the problem you're solving.

What problem or pain point does this project address?
Who experiences this problem?
```

**User provides response**

**Facilitator identifies gaps:**
```
🔄 Facilitator: Draft Problem Statement:

"[User's description]"

I notice some areas we should clarify:
- You mentioned [X problem], but who specifically feels this pain?
- How do people currently handle this? What's the workaround?
- What makes the current situation unsatisfactory?

Let's dig into these...
```

**Product agent provides structure:**
```
🎨 Product Agent: A strong problem statement typically includes:
- The specific user/persona affected
- The current situation and its limitations
- The impact of the problem (time, money, frustration, etc.)
- Why existing solutions don't work

Based on what you've shared, here's a structured version:

**Who**: [persona]
**Current Pain**: [specific problem]
**Impact**: [consequences]
**Existing Solutions**: [current approaches] → **Limitations**: [why they fail]

Does this capture it, or should we adjust?
```

**User refines**

**Facilitator synthesizes:**
```
🔄 Facilitator: Refined Problem Statement:

[Synthesized version incorporating feedback]

Does this accurately represent the problem? Any gaps?
```

**Iteration continues until approved**

```
✓ Problem Statement captured
```

---

#### Step 4: Objectives (Product-Led, Facilitator Validates)

**Product agent asks:**
```
🎨 Product Agent: What are the key objectives for this project?

What does success look like? What outcomes do you want to achieve?

Try to think in terms of measurable goals.
```

**User provides objectives**

**Facilitator reviews:**
```
🔄 Facilitator: Initial objectives list:

1. [Objective from user]
2. [Objective from user]
3. [Objective from user]

Let me check these against best practices...

Observations:
- Objective 1 is clear and measurable ✓
- Objective 2 seems vague - how would we know if we achieved it?
- Are these prioritized? Which is most critical?

Let's refine...
```

**Product agent suggests structure:**
```
🎨 Product Agent: Strong objectives are:
- Specific (not vague)
- Measurable (with a clear success metric)
- Prioritized (ranked by importance)

Here's a refined version:

1. **[Objective 1]** - Success metric: [how to measure]
2. **[Objective 2]** - Success metric: [how to measure]  
3. **[Objective 3]** - Success metric: [how to measure]

Ranked by priority. Does this work?
```

**User validates and refines**

```
✓ Objectives captured and prioritized
```

---

#### Step 5: Scope Definition (Product + Architect Collaboration)

**Product agent asks:**
```
🎨 Product Agent: Let's define what's in and out of scope.

What features or capabilities MUST be included? (Core scope)
What SHOULD be included if time allows? (Nice to have)
What is explicitly OUT of scope? (To avoid scope creep)
```

**User provides scope items**

**Architect agent weighs in:**
```
🏗️ Architect Agent: Looking at your must-have features...

Quick feasibility check:
- Feature 1: Straightforward, doable
- Feature 2: This might require [technical dependency] - aware of that?
- Feature 3: High complexity, might want to start with simplified version

Any technical constraints I should know about?
```

**User addresses technical questions**

**Facilitator structures:**
```
🔄 Facilitator: Draft Scope Definition:

**Must Have (P0):**
| Feature | Priority | Complexity | Notes |
|---------|----------|------------|-------|
| [Feature 1] | P0 | Level 2 | [Note] |
| [Feature 2] | P0 | Level 3 | [Constraint noted] |

**Should Have (P1):**
| Feature | Priority | Complexity | Notes |
|---------|----------|------------|-------|
| [Feature 3] | P1 | Level 2 | [Can defer] |

**Out of Scope:**
- ❌ [Excluded feature] - [Reason]
- ❌ [Excluded feature] - [Reason]

Does this accurately capture the scope? Anything missing?
```

**User validates**

**Product agent validates:**
```
🎨 Product Agent: Scope looks solid. One more check:

Have we forgotten anything critical?
- User authentication/authorization?
- Data persistence?
- Error handling?
- Mobile/desktop?

Just making sure we haven't missed obvious requirements...
```

**User confirms or adds**

```
✓ Scope defined (Must Have, Should Have, Out of Scope)
```

---

#### Step 6: Constraints (Architect-Led, Facilitator Captures)

**Architect agent asks:**
```
🏗️ Architect Agent: Let's identify any constraints.

**Technical constraints:**
- Must use specific technologies? (languages, frameworks, platforms)
- Integration requirements? (existing systems, APIs)
- Performance requirements? (speed, scale)
- Security/compliance needs?

**Resource constraints:**
- Timeline? (hard deadlines, target dates)
- Team size? (solo, team of X)
- Budget? (if relevant)

**Business constraints:**
- Must launch by date X?
- Must work with legacy system Y?
- Regulatory requirements?
```

**User provides constraints**

**Facilitator organizes:**
```
🔄 Facilitator: Identified Constraints:

**Technical:**
- [Constraint 1] → Impact: [how this affects approach]
- [Constraint 2] → Impact: [how this affects approach]

**Resource:**
- Timeline: [duration/deadline] → [why/impact]
- Team: [composition]

**Business:**
- [Constraint 1] → [implication]

Are these accurate? Any I missed?
```

**User validates**

**Architect validates:**
```
🏗️ Architect Agent: These constraints are workable. 

One thing to note: [constraint X] means we'll need to [approach/consideration].

Aware of that trade-off?
```

**User confirms understanding**

```
✓ Constraints documented
```

---

#### Step 7: Success Criteria (Product-Led Validation)

**Product agent asks:**
```
🎨 Product Agent: How will we know this project succeeded?

Beyond the objectives, what are the concrete success criteria?
- User adoption metrics?
- Performance benchmarks?
- Business outcomes?
- Quality measures?
```

**User provides criteria**

**Facilitator structures:**
```
🔄 Facilitator: Success Criteria:

- [ ] [Criterion 1 - measurable outcome]
- [ ] [Criterion 2 - measurable outcome]
- [ ] [Criterion 3 - measurable outcome]

These are checkboxes we'll validate when the project is complete.

Are these the right measures of success?
```

**User validates**

```
✓ Success criteria defined
```

---

#### Step 8: Complete Brief Review (Facilitator-Led)

**Facilitator presents complete draft:**
```
🔄 Facilitator: Here's the complete project brief draft:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Project Brief: [Project Name]

## Executive Summary
[Captured summary]

## Problem Statement
**Who**: [personas]
**Current Pain**: [problem description]
**Impact**: [consequences]
**Existing Solutions**: [current approaches] → **Limitations**: [gaps]

## Objectives (Ranked)
1. **[Objective 1]** - [Success metric]
2. **[Objective 2]** - [Success metric]
3. **[Objective 3]** - [Success metric]

## Scope Definition

### Must Have (P0)
[Table of core features]

### Should Have (P1)
[Table of nice-to-have features]

### Out of Scope
[Explicit exclusions]

## Constraints

### Technical
[Documented technical constraints]

### Resource
[Timeline, team, budget]

### Business
[Business constraints]

## Success Criteria
[Checklist of success measures]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

This brief will serve as the foundation for all future work.

Review questions:
1. Does this accurately capture your vision?
2. Is anything missing or unclear?
3. Would this guide someone else working on the project?
4. Are you confident this is the right scope?

What would you change?
```

**User provides final feedback**

**Facilitator refines:**
```
🔄 Facilitator: Updated based on your feedback...

[Shows updated sections]

Better? Ready to finalize?
```

**Iteration continues until user approves**

---

#### Step 9: Finalization & Next Steps

**Facilitator finalizes:**
```
✓ Project Brief Complete!

Writing to: memory-bank/projectbrief.md
✓ Written successfully

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 PROJECT BRIEF FINALIZED

Your project brief is now the source of truth for:
- Project scope and goals
- Success criteria
- Constraints and limitations

This brief will guide all future planning and implementation.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 RECOMMENDED NEXT STEPS:

1. **Customize agents** for your tech stack:
   - Edit .claude/agents/development/codeImplementer.md
   - Edit .claude/agents/testing/testEngineer.md
   - Edit .claude/agents/ui/uiDeveloper.md
   
   Replace TODO sections with your:
   - Programming languages and frameworks
   - Testing approach and tools
   - Code style preferences
   - Project-specific patterns

2. **Create productContext.md** (optional but recommended):
   Use: /cf:create-product-context
   
   This expands on the brief with:
   - Detailed feature descriptions
   - User flows
   - UX requirements

3. **Start first task**:
   Use: /cf:feature [description]
   
   The system will assess complexity and guide next steps.

Ready to customize agents, or want to jump right into development?
```

---

## Phase 3: Post-Brief Creation (Optional)

### Option A: Agent Customization Guidance

If user chooses to customize agents:

```
📝 AGENT CUSTOMIZATION

I'll help you customize each agent for your tech stack.

Let's start with the Code Implementer agent...

[Facilitator guides through each agent file, helping fill in TODOs]
```

### Option B: Product Context Creation

If user wants to create detailed product context:

```
Creating productContext.md...

[Facilitator + Product agent guide through expanded requirements]
```

### Option C: Jump to Development

If user wants to start immediately:

```
Great! You're ready to begin development.

Recommended first command:
/cf:sync

This will load your project brief and show current status.

Then use:
/cf:feature [your first feature]

Good luck building [project-name]! 🚀
```

---

## Facilitator's Role Throughout

The Facilitator orchestrates the entire process with specific responsibilities:

### 1. **Conversation Management**
- Introduces each section clearly
- Transitions smoothly between topics
- Maintains focus and momentum
- Prevents tangents while allowing necessary exploration

### 2. **Gap Identification**
```
After each user response, Facilitator:
1. Captures what was said
2. Identifies what's missing or unclear
3. Asks targeted follow-up questions
4. Doesn't move forward until gaps are filled
```

### 3. **Quality Validation**
```
Before accepting any section, Facilitator checks:
- Is it specific enough?
- Is it measurable (where applicable)?
- Does it align with best practices?
- Will it be useful for future work?
```

### 4. **Synthesis & Structuring**
```
Facilitator transforms user input into structured content:
- Converts narrative into tables where appropriate
- Organizes information logically
- Adds structure that user might not think of
- Ensures consistency across sections
```

### 5. **Iteration Management**
```
Facilitator uses Action Recommendation Pattern:
1. Present current state
2. Identify gaps/concerns
3. Ask clarifying questions
4. Refine based on feedback
5. Recommend: "Ready to proceed?" or "Let's refine X"

NO iteration limits - continues until user is satisfied
```

---

## Product Agent's Role Throughout

The Product agent provides domain expertise:

### 1. **Question Design**
- Asks insightful questions that surface requirements
- Probes for user needs beyond stated features
- Identifies edge cases and scenarios
- Ensures nothing critical is forgotten

### 2. **Structure & Best Practices**
```
Product agent suggests:
- Standard formats for problem statements
- How to make objectives measurable
- Scope categorization (Must/Should/Won't)
- Success criteria frameworks
```

### 3. **Validation**
```
Product agent validates:
- Are objectives aligned with problem?
- Is scope realistic for stated constraints?
- Do success criteria actually measure objectives?
- Are we solving the right problem?
```

### 4. **Experience Injection**
```
Product agent shares:
- "Strong objectives typically include..."
- "I've seen similar projects forget about [X]..."
- "This scope might need [Y] to be complete..."
- Best practices from product management
```

---

## Architect Agent's Role Throughout

The Architect agent provides technical reality checks:

### 1. **Feasibility Assessment**
- Flags technically complex features early
- Identifies dependencies and integration challenges
- Raises performance/scale considerations
- Points out potential technical risks

### 2. **Constraint Identification**
```
Architect agent asks about:
- Technology stack requirements
- Integration with existing systems
- Performance/scale needs
- Security/compliance requirements
```

### 3. **Technical Validation**
```
Architect agent validates:
- Is the proposed scope technically achievable?
- Are there hidden technical dependencies?
- Will stated constraints work together?
- Any architectural decisions needed upfront?
```

---

## Quality Gates

Before finalizing the project brief, all agents validate:

### Facilitator Checks:
- [ ] All sections complete (no TODOs)
- [ ] Information is structured and organized
- [ ] Gaps have been identified and filled
- [ ] User has reviewed and approved final draft

### Product Checks:
- [ ] Problem statement is clear and specific
- [ ] Objectives are measurable
- [ ] Scope is well-defined (must/should/won't)
- [ ] Success criteria align with objectives
- [ ] Nothing critical has been forgotten

### Architect Checks:
- [ ] Technical constraints are documented
- [ ] Scope is technically feasible
- [ ] Dependencies are identified
- [ ] No show-stopping technical issues

**Only when all checks pass**: Write projectbrief.md

---

## Command File Implementation

**File**: `.claude/commands/cf/init.md`

```markdown
# Initialize CCFlow Workflow System

Initialize CCFlow for project: $ARGUMENTS

## Phase 1: Create Structure

Create the following directories and files:

**Directories:**
- memory-bank/
- memory-bank/templates/
- .claude/agents/testing/
- .claude/agents/development/
- .claude/agents/ui/
- .claude/commands/cf/

**Template Files:**
Create all template files in memory-bank/templates/ using the structures defined in the Custom Claude Workflow Specification.

**Agent Files:**
Create template agent files with TODO sections:
- .claude/agents/testing/testEngineer.md
- .claude/agents/development/codeImplementer.md
- .claude/agents/ui/uiDeveloper.md

Report structure creation completion.

## Phase 2: Guided Project Brief Creation

**CRITICAL**: This phase uses Facilitator + Product + Architect agents in an iterative process.

Announce:
"📋 PROJECT BRIEF CREATION

We'll create your project brief through a guided conversation. This typically takes 10-20 minutes.

The process:
1. Facilitator will guide the conversation
2. Product agent will ask domain questions
3. Architect will raise technical considerations
4. We'll iterate until comprehensive

Ready to begin?"

### Brief Creation Process

For each section, follow this pattern:

1. **Product agent asks initial questions**
2. **User responds**
3. **Facilitator captures and identifies gaps**
4. **Product/Architect provide structure and validation**
5. **User refines**
6. **Facilitator synthesizes**
7. **Iterate until user approves**
8. **Mark section complete**

**Sections to create (in order):**

#### 1. Executive Summary
- Product asks: "In 1-2 sentences, what are you building and why?"
- Facilitator iterates until clear and compelling
- Validate: Does this capture both WHAT and WHY?

#### 2. Problem Statement
- Product asks about the problem, who has it, current solutions
- Facilitator structures into: Who, Pain, Impact, Existing Solutions, Limitations
- Validate: Is the problem clear and specific?

#### 3. Objectives
- Product asks for measurable goals
- Facilitator ensures objectives are specific, measurable, prioritized
- Validate: Can we measure success for each objective?

#### 4. Scope Definition
- Product asks: Must have? Should have? Out of scope?
- Architect checks technical feasibility
- Facilitator structures into tables with complexity estimates
- Validate: Is scope clear and realistic?

#### 5. Constraints
- Architect asks about technical, resource, and business constraints
- Facilitator documents with impact notes
- Validate: Are all constraints captured?

#### 6. Success Criteria
- Product asks how we'll know if project succeeded
- Facilitator creates measurable checklist
- Validate: Do criteria align with objectives?

### Complete Brief Review

Present the complete project brief to user for final review.

Use Facilitator's Action Recommendation Pattern:
1. Show complete brief
2. Ask review questions
3. Identify any remaining gaps
4. Offer to refine specific sections
5. Recommend: "Ready to finalize?" or "Let's adjust X"

Iterate until user approves.

### Quality Gate Validation

Before writing projectbrief.md, verify:
- [ ] All sections complete
- [ ] Objectives are measurable
- [ ] Scope is well-defined
- [ ] Constraints documented
- [ ] Success criteria align with objectives
- [ ] User has reviewed and approved

Only when all checks pass: Write to memory-bank/projectbrief.md

## Phase 3: Next Steps

Present next step options:
1. Customize agents for tech stack
2. Create detailed productContext.md
3. Start first feature

Recommend starting with /cf:sync to load the brief.

## Quick Mode (--quick flag)

If --quick flag used:
- Skip Phase 2 (brief creation)
- Create projectbrief.md with template structure and TODOs
- Create other stub files
- Inform user they need to manually complete the brief
- Recommend running /cf:init again without --quick for guided creation
```

---

## Example Interaction Flow

**Complete example showing all three agents working together:**

```
User: /cf:init awesome-task-manager

Claude: 
🚀 Initializing CCFlow for: awesome-task-manager

[Structure creation output]
✓ Structure created successfully!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 PROJECT BRIEF CREATION

We'll create your project brief through a guided conversation...
Ready to begin?

User: Yes

Claude (Facilitator): Great! Let's start.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎨 Product Agent: In 1-2 sentences, what are you building and why does it matter?

User: A task manager that helps developers track their coding tasks and integrate with their IDE

Claude (Facilitator): Let me capture that...

Draft Executive Summary:
"A task manager for developers that tracks coding tasks and integrates with IDEs"

Questions to refine:
- What makes this different from existing task managers?
- What specific problem does IDE integration solve?
- Is this focused on solo developers or teams?

What would you adjust?

User: It's for solo developers who context-switch between projects. IDE integration means tasks show up where they're coding, not in a separate app.

Claude (Facilitator): Much clearer! Updated version:

"A task manager for solo developers who context-switch between projects, surfacing tasks directly in their IDE to reduce app-switching and maintain focus."

Does this capture your vision?

User: Perfect!

Claude (Facilitator): ✓ Executive Summary captured

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎨 Product Agent: Now let's clarify the problem you're solving.

What problem or pain point does this project address?
Who experiences this problem?

User: Developers lose context when switching between projects because their tasks are in separate apps. They forget what they were working on.

Claude (Facilitator): Draft Problem Statement...

I notice some areas we should clarify:
- How often does context-switching happen?
- What's the current workaround? Other task managers? Sticky notes?
- What's the cost of losing context? Time? Quality?

Let's dig into these...

User: Context-switching happens daily for freelancers. They use Notion or Todoist but have to alt-tab constantly. Costs maybe 15-30 minutes daily remembering where they were.

Claude (Product): A strong problem statement typically includes:
- The specific user/persona affected
- The current situation and its limitations
- The impact of the problem
- Why existing solutions don't work

Here's a structured version:

**Who**: Solo developers and freelancers managing multiple projects
**Current Pain**: Task managers (Notion, Todoist) require constant app-switching, breaking flow state
**Impact**: 15-30 minutes daily lost to context recovery; reduced productivity
**Existing Solutions**: Traditional task managers → **Limitations**: Live outside IDE, require manual context switching

Does this capture it?

User: Yes! That's exactly it.

Claude (Facilitator): ✓ Problem Statement captured

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Process continues through all sections...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Claude (Facilitator): Here's the complete project brief draft:

[Shows complete brief]

Review questions:
1. Does this accurately capture your vision?
2. Is anything missing or unclear?
3. Would this guide someone else working on the project?
4. Are you confident this is the right scope?

What would you change?

User: Looks great! One thing - should add that we need keyboard shortcuts for everything since developers hate using mouse.

Claude (Facilitator): Excellent catch! That's a UX requirement.

Adding to constraints:
**UX Constraint**: All functions must have keyboard shortcuts (developer-optimized workflow)

Updated brief shows this in the Constraints section. 

Anything else, or ready to finalize?

User: Ready!

Claude (Facilitator): 
✓ Project Brief Complete!

Writing to: memory-bank/projectbrief.md
✓ Written successfully

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 RECOMMENDED NEXT STEPS:

1. Customize agents for your tech stack
2. Create productContext.md (optional): /cf:create-product-context
3. Start first task: /cf:feature [description]

Ready to customize agents, or want to jump right into development?

User: Let's start development

Claude (Facilitator):
Great! You're ready to begin.

Recommended: /cf:sync (loads your brief and shows status)
Then: /cf:feature [your first feature]

Good luck building awesome-task-manager! 🚀
```

---

## Success Metrics

A successful `/cf:init` completion results in:

### Artifacts Created:
- [ ] Complete directory structure
- [ ] All template files in templates/
- [ ] Agent template files with TODOs
- [ ] **Comprehensive projectbrief.md** (not a template, a real brief)

### Brief Quality:
- [ ] Executive summary is clear and compelling
- [ ] Problem statement identifies who, pain, impact, and gaps
- [ ] Objectives are specific and measurable
- [ ] Scope clearly defines must-have, should-have, and out-of-scope
- [ ] Constraints are documented with impact
- [ ] Success criteria are measurable
- [ ] User has reviewed and approved

### User Confidence:
- [ ] User understands what they're building
- [ ] User has clear picture of scope
- [ ] User knows what success looks like
- [ ] User is ready to proceed with development

---

## Edge Cases & Error Handling

### User Provides Minimal Information

**Facilitator response:**
```
I notice your description is quite brief. To create a solid foundation, we need more detail.

Let me ask some specific questions to help surface requirements...

[Targeted questions to extract information]
```

### User Wants to Skip Sections

**Facilitator response:**
```
I understand you want to move quickly, but skipping [section] means we won't have [critical information].

This will likely cause issues when:
- [Consequence 1]
- [Consequence 2]

Can we spend just 2-3 minutes on this? It'll save time later.

Or, if you prefer, I can use --quick mode which creates stub files you fill in manually. Want to do that instead?
```

### User Changes Mind Mid-Process

**Facilitator response:**
```
No problem! Let's go back to [section].

Current version:
[Shows current]

What would you like to change?
```

### Technical Feasibility Issues

**Architect response:**
```
🏗️ Architect: Quick heads up - [feature X] as described would require:
- [Technical requirement 1]
- [Technical requirement 2]

This adds significant complexity (Level 4).

Options:
1. Keep it, knowing it's complex
2. Start with simplified version
3. Move to "should have" instead of "must have"

Your call - what makes sense?
```

---

## Quick Mode Behavior

If user runs `/cf:init project-name --quick`:

```
🚀 Initializing CCFlow for: project-name (Quick Mode)

Creating directory structure...
✓ Structure created

Generating stub files...
✓ Created memory-bank/projectbrief.md (template with TODOs)
✓ Created memory-bank/productContext.md (template with TODOs)
✓ Created other templates...

⚠️ QUICK MODE: Templates created with TODOs

You'll need to manually complete:
- memory-bank/projectbrief.md

OR run /cf:init again without --quick for guided creation.

Ready to begin. Suggested: manually edit projectbrief.md, then /cf:sync
```

---

## Integration with Other Commands

### After /cf:init:

**Next logical commands:**
1. `/cf:sync` - Load the brief and show status
2. `/cf:create-product-context` - Expand brief into detailed product requirements
3. `/cf:feature [description]` - Start first feature

### Brief as Foundation:

All future commands reference projectbrief.md:
- `/cf:feature` checks scope to assess if feature is in/out
- `/cf:plan` validates plans align with objectives
- `/cf:creative` uses constraints to guide decisions
- `/cf:review` validates against success criteria

---

## Revision History

- v1.0 - Initial /cf:init specification with guided brief creation