---
description: "Interactive refinement and collaborative exploration with Facilitator agent"
allowed-tools: ['Read', 'Edit', 'Task']
argument-hint: "[topic|task-id] [--mode explore|refine|validate]"
---

# Command: /cf:facilitate

## Usage

```
/cf:facilitate [topic|task-id] [--mode explore|refine|validate]
```

## Parameters

- `[topic|task-id]`: **Optional** - Topic to explore or task ID to refine (default: current focus from activeContext.md)
- `[--mode explore]`: **Optional** - Open-ended exploration mode for ambiguous topics
- `[--mode refine]`: **Optional** - Refinement mode for improving existing plans or specs (default)
- `[--mode validate]`: **Optional** - Validation mode for confirming understanding and catching gaps

---

## Purpose

Engage the Facilitator agent for human-in-the-loop interaction:
1. Interactive exploration of ambiguous or complex topics
2. Refinement of plans, requirements, or specifications through dialogue
3. Gap identification and resolution before implementation
4. Validation of understanding and assumptions
5. Collaborative decision-making for high-impact choices

---

## Prerequisites

**Memory bank must be initialized**. Run `/cf:init` first if needed.

**Topic or task context**. Works best when there's something to explore or refine.

---

## When to Use

**Exploration mode** (--mode explore):
- Ambiguous requirements that need clarification
- New feature ideas that aren't fully formed
- Architecture decisions with multiple viable options
- Open-ended "what if" scenarios
- Early-stage project discovery

**Refinement mode** (--mode refine, default):
- Existing plans that need improvement
- Task specifications that feel incomplete
- Requirements that have gaps or ambiguities
- Technical approaches with unresolved questions
- Plans from /cf:plan that need iteration

**Validation mode** (--mode validate):
- Confirming shared understanding before implementation
- Catching assumptions that need validation
- Edge case discovery
- Risk identification
- Pre-implementation sanity check

---

## Process

### Step 1: Verify Memory Bank Exists

Check if `memory-bank/` directory exists:

**If NOT EXISTS**:
```
⚠️ Memory Bank Not Initialized

Run: /cf:init
```

**Stop execution.**

---

### Step 2: Determine Facilitation Context

**No topic/task-id provided**:
- Read `activeContext.md` to determine current focus
- Facilitate around current work
- Default to refine mode

**Topic provided** (natural language):
- Use topic as exploration starting point
- Default to explore mode
- Load relevant memory bank context if topic relates to existing features/patterns

**Task ID provided** (e.g., TASK-042):
- Read task from `tasks.md`
- Load any existing plan or specification
- Default to refine mode for existing task, validate mode if task is "Ready for Implementation"

---

### Step 3: Load Relevant Context

**For all modes**, read:
- `activeContext.md` - Current project state
- `systemPatterns.md` - Established patterns and conventions
- `productContext.md` - Product requirements and features

**For specific task ID**, additionally read:
- Task entry from `tasks.md`
- Any related checkpoint entries from `progress.md`
- Planning output if task has been through /cf:plan

**For general topic**, search memory bank:
- Grep for topic-related keywords
- Load relevant sections of memory bank files

---

### Step 4: Engage Facilitator Agent

**Invoke Facilitator agent** from `.claude/agents/workflow/facilitator.md`.

**Provide context**:
- Loaded memory bank content
- Topic or task to facilitate
- Mode (explore/refine/validate)
- User's initial question or goal (if provided)

**Facilitator will**:
1. Analyze context for gaps, ambiguities, assumptions
2. Formulate clarifying questions organized by theme
3. Present questions to user for response
4. Listen to user's answers and ask follow-up questions
5. Iterate until topic is well-understood or plan is refined
6. Synthesize final understanding or refined specification
7. No iteration limit - user controls when to stop

---

### Step 5: Interactive Facilitation Loop

**Facilitator's question pattern**:

```markdown
🤝 FACILITATION SESSION: [Topic/Task Name]
─────────────────────────────

**Mode**: [Explore/Refine/Validate]
**Context**: [Brief context summary]

## Round 1: [Question Theme]

I'd like to understand [area] better. Here are some questions:

**[Category 1]**: [Category description]
1. [Clarifying question]
2. [Probing question]

**[Category 2]**: [Category description]
1. [Validating question]
2. [Edge case question]

**[Category 3]**: [Category description]
1. [Trade-off question]

---

Please answer the questions that are most relevant to you. We can iterate as needed.

**Type 'continue' when ready for synthesis, or answer specific questions to refine further.**
```

**User provides answers**:
- Can answer all questions, some questions, or add new information
- Can raise new questions or concerns
- Can request focus on specific area

**Facilitator follow-up**:
```markdown
## Round 2: [Refined Theme Based on Answers]

Thank you for that context. Based on your answers, I have some follow-up questions:

**Clarification on [topic from user's answer]**:
1. You mentioned [X]. Does that mean [interpretation A] or [interpretation B]?
2. What happens if [edge case scenario]?

**New questions based on your answers**:
1. [Question arising from user's response]
2. [Question about implications]

---

We're making progress. [Summary of what's now clear]

**Still exploring**: [What remains ambiguous]

Continue answering, or type 'continue' if ready for synthesis.
```

**Iteration continues** until:
- User types 'continue' (ready for synthesis)
- User types 'stop' (end facilitation without synthesis)
- No more questions remain (full understanding achieved)

---

### Step 6: Facilitator Synthesis

**After user signals readiness**, Facilitator produces synthesis:

#### Exploration Mode Synthesis

```markdown
✨ EXPLORATION SYNTHESIS: [Topic]
─────────────────────────────

## Understanding Achieved

**Topic**: [What we explored]
**Clarity Level**: [High/Medium - areas that are clear]

### What We Know

**Core Concept**:
[Clear description of the topic based on dialogue]

**Key Insights** (from our discussion):
- [Insight 1 from user's answers]
- [Insight 2 from clarifications]
- [Insight 3 from edge cases explored]

**User Needs**:
- [Need 1 identified through questions]
- [Need 2 clarified through dialogue]

**Constraints Identified**:
- [Constraint 1]
- [Constraint 2]

### Viable Approaches

Based on our discussion, here are potential approaches:

**Approach A**: [Name/Description]
- **Pros**: [Advantages from user's perspective]
- **Cons**: [Trade-offs acknowledged]
- **Fits when**: [Conditions where this works best]

**Approach B**: [Name/Description]
- **Pros**: [Advantages]
- **Cons**: [Trade-offs]
- **Fits when**: [Conditions]

### Open Questions (Remaining Ambiguities)

- ❓ [Question 1 that still needs resolution]
- ❓ [Question 2 for future consideration]

### Recommended Next Steps

1. **[Action 1]** - [Why this should be next]
2. **[Action 2]** - [Context]

**If creating a task**: /cf:feature [topic description]
**If planning approach**: /cf:plan TASK-[ID] (after task created)
**If continuing exploration**: /cf:facilitate [focused topic] --mode explore

---

**Session Summary**:
- Rounds of questions: [N]
- Areas clarified: [List]
- Decisions made: [List if any]
- Remaining unknowns: [List]
```

#### Refinement Mode Synthesis

```markdown
✨ REFINEMENT SYNTHESIS: [Task/Plan Name]
─────────────────────────────

## Original vs. Refined Understanding

**Original Plan/Spec**:
[Summary of what existed before facilitation]

**Gaps Identified** (through our discussion):
- [Gap 1 discovered through questions]
- [Gap 2 clarified through dialogue]

**Ambiguities Resolved**:
- [Ambiguity 1] → [Now clear: resolution]
- [Ambiguity 2] → [Now clear: resolution]

## Refined Specification

### Requirements (Updated)

**Functional Requirements**:
- [Requirement 1 - clarified or added]
- [Requirement 2 - refined based on discussion]

**Non-Functional Requirements**:
- [Requirement 1 - performance, security, etc.]

**Edge Cases** (identified through facilitation):
- [Edge case 1]: [How to handle]
- [Edge case 2]: [How to handle]

### Technical Approach (Refined)

**Approach**: [Updated approach based on clarifications]

**Key Decisions** (made during facilitation):
1. **[Decision 1]**: [Choice made]
   - Rationale: [From discussion]
   - Alternatives considered: [What else was discussed]

2. **[Decision 2]**: [Choice made]
   - Rationale: [From discussion]

**Implementation Notes**:
- [Note 1 from discussion]
- [Note 2 clarified through questions]

### Acceptance Criteria (Enhanced)

- [Criterion 1 - original or refined]
- [Criterion 2 - added through facilitation]
- [Criterion 3 - edge case coverage]

### Open Questions (If Any)

- ❓ [Question 1 requiring external input]

### Recommended Next Steps

1. **Update task in tasks.md** with refined specification
2. **Update systemPatterns.md** if new patterns emerged
3. **Proceed with implementation**: /cf:code TASK-[ID]

---

**Session Summary**:
- Rounds of refinement: [N]
- Gaps filled: [N]
- Decisions made: [N]
- Specification completeness: [High/Medium]
```

#### Validation Mode Synthesis

```markdown
✅ VALIDATION SYNTHESIS: [Task/Plan Name]
─────────────────────────────

## Validation Results

**Overall Assessment**: [Ready/Needs Work/Has Concerns]

### Shared Understanding ✓

**What's Clear**:
- [Area 1]: Understanding confirmed through questions
- [Area 2]: Edge cases validated
- [Area 3]: Acceptance criteria agreed upon

**Alignment Score**: [High/Medium] - [rationale]

### Assumptions Validated

✓ **[Assumption 1]**: Confirmed through discussion
✓ **[Assumption 2]**: Validated as correct
⚠️ **[Assumption 3]**: Needs revision (see concerns)

### Concerns Identified

**🔴 Critical Concerns** (must address before proceeding):
- [Concern 1]: [Description and impact]
  - Resolution: [What needs to happen]

**🟡 Medium Concerns** (should address, but not blocking):
- [Concern 1]: [Description]
  - Mitigation: [How to handle]

**🟢 Minor Concerns** (nice to address):
- [Concern 1]: [Description]

### Edge Cases Discovered

Through validation questions, identified edge cases:

1. **[Edge case 1]**: [Scenario]
   - Current plan: [Does/doesn't handle]
   - Recommendation: [How to address]

2. **[Edge case 2]**: [Scenario]
   - Current plan: [Does/doesn't handle]
   - Recommendation: [How to address]

### Risks Identified

**Technical Risks**:
- [Risk 1]: [Description]
  - Mitigation: [Approach]

**Process Risks**:
- [Risk 1]: [Description]
  - Mitigation: [Approach]

### Readiness Assessment

**Ready to Proceed?**: [Yes/No/With Changes]

**If Yes**:
- All critical concerns addressed
- Shared understanding confirmed
- Edge cases identified and plan updated
- Proceed with: /cf:code TASK-[ID]

**If No**:
- Critical concerns require resolution: [List]
- Recommended: Address concerns, then re-validate
- Use: /cf:facilitate TASK-[ID] --mode refine

**If With Changes**:
- Minor adjustments needed: [List]
- Update: [What to update in tasks.md or memory bank]
- Then proceed with: /cf:code TASK-[ID]

---

**Session Summary**:
- Validation rounds: [N]
- Assumptions checked: [N]
- Concerns raised: [N critical] / [N medium] / [N minor]
- Edge cases found: [N]
- Overall readiness: [Assessment]
```

---

### Step 7: Update Memory Bank (If Applicable)

**If facilitation produced decisions or refined specs**:

**Update tasks.md** (for task refinement):
- Add clarified acceptance criteria
- Update task description with refined understanding
- Note decisions made during facilitation
- Add edge cases to "Notes" section

**Update activeContext.md**:
- Add entry to "Recent Changes" log
- Note facilitation session occurred
- Capture key decisions in "Active Decisions" section

**Update systemPatterns.md** (if new patterns emerged):
- Document new patterns identified during facilitation
- Update existing patterns if refined

**Update projectbrief.md** (for major decisions):
- Add to decision log if architectural or scope decisions made

---

## Examples

### Example 1: Exploration Mode - Ambiguous Feature

```
User: /cf:facilitate "user notification preferences" --mode explore

Claude:
[Loads memory bank context, engages Facilitator...]

🤝 FACILITATION SESSION: User Notification Preferences
─────────────────────────────

**Mode**: Explore
**Context**: This topic hasn't been defined in the project yet. Let's explore what notification preferences means for your users.

## Round 1: Understanding User Needs

I'd like to understand what notification preferences means in your context. Here are some questions:

**User Perspective**:
1. What kinds of notifications do users receive currently (or will receive)? (e.g., email, SMS, push, in-app)
2. What events trigger notifications? (e.g., order status, promotions, account activity)
3. Do different user types need different notification options?

**Granularity**:
1. Should users control notifications per channel (email on, SMS off)?
2. Should users control notifications per event type (order updates on, marketing off)?
3. Both? Something else?

**Use Cases**:
1. What's the primary problem this solves for users?
2. What happens if a user wants "no notifications" - is that allowed?

---

Please answer the questions that are most relevant to you. We can iterate as needed.

User: Users get emails for order updates and marketing. They complain about too much marketing email. We want them to control email frequency and topics.

Claude:

## Round 2: Email Preferences Details

Thank you! So this is primarily about email notification control, focused on reducing marketing email overwhelm. Follow-up questions:

**Email Types**:
1. You mentioned "order updates" - should users be able to turn these off, or are they mandatory (transactional)?
2. For marketing emails, what "topics" exist? (e.g., new products, sales, personalized recommendations)

**Frequency Control**:
1. When you say "frequency," do you mean:
   - A: How often marketing emails are sent (daily/weekly/monthly digest)?
   - B: Total volume limit (max 3 emails per week)?
   - C: Something else?

**User Experience**:
1. Where do users set these preferences? (Account settings page, unsubscribe link, both?)
2. Do preferences apply immediately or at next email cycle?

---

We're making progress. **Now clear**: Email-focused, marketing overwhelm problem, need topic and frequency control.

**Still exploring**: Exact preference options, UI location, transactional email rules.

User: Order updates should be mandatory. Marketing topics: new products, sales, recommendations, newsletter. Frequency is daily/weekly/monthly digest. Settings page and unsubscribe link both.

Claude:

✨ EXPLORATION SYNTHESIS: User Notification Preferences
─────────────────────────────

## Understanding Achieved

**Topic**: Email notification preference system
**Clarity Level**: High - core requirements well-defined

### What We Know

**Core Concept**:
Email preference management focused on reducing marketing email overwhelm while preserving critical transactional notifications (order updates).

**Key Insights** (from our discussion):
- Problem: Users overwhelmed by marketing emails
- Solution: Topic-based control + frequency digest options
- Transactional emails (order updates) remain mandatory
- Preferences accessible from settings page and unsubscribe links

**User Needs**:
- Control over marketing email topics (opt-in/out per topic)
- Control over frequency (daily/weekly/monthly digest)
- Quick access from unsubscribe links (reduce full unsubscribe)
- Immediate preference application

**Constraints Identified**:
- Order update emails must remain on (transactional requirement)
- Must support both settings page and unsubscribe link flows
- Preferences apply immediately (no delay)

### Viable Approaches

Based on our discussion, here are potential approaches:

**Approach A: Granular Per-Topic + Global Frequency**
- **Pros**: Maximum user control, clear mental model (topics + frequency are separate controls)
- **Cons**: Slightly more complex UI (two-dimensional preference matrix)
- **Fits when**: Users want fine-grained control, willing to spend time on preferences

**Approach B: Preset Preference Bundles**
- **Pros**: Simpler UI (pick a preset: "Essentials Only", "Weekly Digest", "Everything")
- **Cons**: Less flexible, may not fit all user needs
- **Fits when**: Simplicity prioritized, most users fit common patterns

**Hybrid Recommendation**: Presets + "Customize" option for granular control (best of both)

### Open Questions (Remaining Ambiguities)

- ❓ How do digest emails work technically? (Batch job, queueing system)
- ❓ What's the default preference for new users? (All on, all off, middle ground)
- ❓ Analytics: Track preference changes to understand user behavior?

### Recommended Next Steps

1. **Create task for notification preference feature** - Now have clear requirements
   - Use: /cf:feature implement email notification preferences with topic and frequency control

2. **Plan implementation approach** - After task created, plan technical approach
   - Use: /cf:plan TASK-[ID] (will engage Architect + Product for detailed design)

3. **Consider UX design** - UI mockups for settings page and unsubscribe flow
   - May warrant separate task or sub-task

---

**Session Summary**:
- Rounds of questions: 2
- Areas clarified: Notification types, preference dimensions, UI locations, transactional rules
- Decisions made: Hybrid approach (presets + customize), mandatory order emails
- Remaining unknowns: Default preferences, digest implementation details, analytics tracking
```

### Example 2: Refinement Mode - Existing Task Plan

```
User: /cf:facilitate TASK-042 --mode refine

Claude:
[Loads TASK-042 from tasks.md, loads existing plan from activeContext.md, engages Facilitator...]

🤝 FACILITATION SESSION: TASK-042 - Email Notification Service
─────────────────────────────

**Mode**: Refine
**Context**: This task has a plan from /cf:plan, but let's refine it to catch any gaps or ambiguities before implementation.

**Current Plan Summary**:
- Build email service using SendGrid
- Support transactional (order updates) and marketing emails
- Template system for email content
- Queue system for sending (async)

## Round 1: Gap Identification

Looking at the current plan, I have questions about some areas that seem underspecified:

**Error Handling**:
1. What happens if SendGrid is down or returns an error?
2. Should failed emails be retried? How many times?
3. Where do we log failed email attempts?

**Template Management**:
1. Who creates/edits email templates? (Developers, marketers, both?)
2. Are templates in code, database, or external system?
3. How do we preview templates before sending?

**User Data**:
1. Where does user email address come from? (Users table, separate preferences table?)
2. What if user's email is invalid or bounces?
3. Do we track email open rates, click rates?

**Queue System**:
1. Which queue technology? (Bull, BullMQ, AWS SQS, something else?)
2. What's the queue priority? (Transactional before marketing?)
3. Rate limiting to avoid overwhelming SendGrid?

---

These aren't criticisms of the plan - just areas that need specification before implementation can start smoothly.

User: Good catches. Errors should retry 3 times with exponential backoff, then log failure to database. Templates in database, marketers edit via admin UI (separate task?). Email from users table. We should track bounces but not opens/clicks (privacy). Use Bull queue, transactional emails priority 1, marketing priority 2. SendGrid has rate limits, we should respect them.

Claude:

## Round 2: Clarifying Details

Great! That fills in a lot. Follow-up clarifications:

**Error Handling Details**:
1. Retry 3 times - what's the backoff schedule? (e.g., 1min, 5min, 15min?)
2. After 3 failures, just log or also alert someone? (Ops team, developer?)
3. Should failed emails be manually re-triggerable by admin?

**Template Management**:
1. Admin UI for templates - is that a separate task or sub-task of TASK-042?
2. For initial implementation (TASK-042), can we start with code-based templates and move to DB later?
3. Template variables (e.g., {{userName}}, {{orderNumber}}) - need specification?

**Bounce Handling**:
1. When an email bounces, do we mark the user's email as invalid?
2. Do we stop sending future emails to bounced addresses?
3. Hard bounce (invalid email) vs soft bounce (mailbox full) - different handling?

**Queue Rate Limiting**:
1. SendGrid limits - do you know the limit? (e.g., X emails per second)
2. Should rate limiting be built into our queue processor or rely on SendGrid API errors?

---

Almost there! These details will make implementation much smoother.

User: Backoff: 1min, 5min, 15min. Alert ops on repeated failures (>10 in hour). Manual retry would be nice but not MVP. Start with code templates for MVP, admin UI is TASK-043. Template variables we should define. Hard bounce = mark invalid and stop sending, soft bounce = retry. SendGrid limit is 100 emails/second, we should stay under that in queue processor.

Claude:

✨ REFINEMENT SYNTHESIS: TASK-042 - Email Notification Service
─────────────────────────────────

## Original vs. Refined Understanding

**Original Plan/Spec**:
Basic email service with SendGrid, templates, and async queue. High-level only.

**Gaps Identified** (through our discussion):
- Error handling strategy unspecified
- Template management approach unclear
- Bounce handling not considered
- Queue rate limiting not detailed
- Priority system mentioned but not designed

**Ambiguities Resolved**:
- Error handling → 3 retries (1min, 5min, 15min backoff) + ops alerts
- Templates → Start with code templates (MVP), DB templates in TASK-043
- Bounces → Hard bounce = mark invalid, soft bounce = retry
- Rate limiting → Built into queue processor (< 100/sec SendGrid limit)
- Queue priority → Transactional priority 1, marketing priority 2

## Refined Specification

### Requirements (Updated)

**Functional Requirements**:
- Send transactional emails (order updates) with high priority
- Send marketing emails with lower priority
- Code-based email templates with variable substitution ({{userName}}, etc.)
- Async queue processing with Bull
- Error retry logic (3 attempts, exponential backoff)
- Bounce handling (differentiate hard vs soft bounces)

**Non-Functional Requirements**:
- Rate limiting: < 100 emails/second (SendGrid limit)
- Reliability: Retry failed sends, alert ops on repeated failures
- Privacy: Track bounces only, no open/click tracking

**Edge Cases** (identified through facilitation):
- SendGrid service outage: Retries handle temporary failures
- Invalid email addresses: Hard bounces mark user email as invalid
- Mailbox full (soft bounce): Retry via same retry logic
- High volume spikes: Queue + rate limiting prevent SendGrid throttling
- Repeated failures (>10/hour): Ops team alerted via monitoring

### Technical Approach (Refined)

**Approach**: Bull queue + SendGrid SDK + retry logic + bounce webhook

**Key Decisions** (made during facilitation):

1. **Template Storage for MVP**: Code-based templates
   - Rationale: Faster to implement, DB templates come in TASK-043
   - Alternatives considered: DB templates now (rejected - adds complexity)

2. **Retry Strategy**: Exponential backoff (1min, 5min, 15min)
   - Rationale: Gives transient issues time to resolve
   - Alternatives considered: Fixed interval (rejected - less effective)

3. **Bounce Handling**: Hard bounce = mark invalid, soft bounce = retry
   - Rationale: Prevent wasting sends on invalid addresses
   - Requires: SendGrid bounce webhook + user email validation flag

4. **Rate Limiting**: Queue processor enforces < 100/sec
   - Rationale: Prevent SendGrid throttling/rejection
   - Implementation: Bull rate limiter option

**Implementation Notes**:
- Template variables to define: {{userName}}, {{orderNumber}}, {{orderStatus}}, {{productName}}, {{trackingLink}}
- Bull queue naming: `email-transactional` (priority 1), `email-marketing` (priority 2)
- Failed email logging: New table `email_failures` (timestamp, user_id, template, error, retry_count)
- Ops alerts: Use existing monitoring system (Slack webhook if >10 failures/hour)
- SendGrid bounce webhook: Endpoint `/api/webhooks/sendgrid/bounce` to handle bounce events

### Acceptance Criteria (Enhanced)

- ✓ Transactional emails sent successfully for order updates
- ✓ Marketing emails sent successfully with lower priority
- ✓ Templates support variable substitution (all defined variables work)
- ✓ Failed sends retry 3 times with correct backoff (1min, 5min, 15min)
- ✓ Ops alerted if >10 failures in 1 hour
- ✓ Rate limiting prevents exceeding 100 emails/second
- ✓ Hard bounces mark user email as invalid and stop further sends
- ✓ Soft bounces trigger retry logic
- ✓ All tests passing (TDD GREEN gate)

### Open Questions (If Any)

None - specification is complete and ready for implementation.

### Recommended Next Steps

1. **Update task in tasks.md** with refined specification (acceptance criteria + implementation notes)
2. **Create TASK-043** for admin UI for email templates (future task)
3. **Proceed with implementation**: /cf:code TASK-042

---

**Session Summary**:
- Rounds of refinement: 2
- Gaps filled: 7 (error handling, templates, bounces, rate limiting, priorities, alerting, variables)
- Decisions made: 4 (template storage, retry strategy, bounce handling, rate limiting approach)
- Specification completeness: High - ready for implementation
```

### Example 3: Validation Mode - Pre-Implementation Check

```
User: /cf:facilitate TASK-035 --mode validate

Claude:
[Loads TASK-035, loads existing plan, engages Facilitator in validation mode...]

✅ VALIDATION SESSION: TASK-035 - Order Management System
─────────────────────────────────

**Mode**: Validate
**Context**: This task has been planned and is marked "Ready for Implementation". Let's validate understanding and catch any assumptions or edge cases before coding starts.

## Round 1: Shared Understanding Check

Let me confirm we have shared understanding on core aspects:

**Order Lifecycle**:
1. An order goes through states: Created → Paid → Fulfilled → Delivered. Correct?
2. Can orders be cancelled? If so, at which states?
3. Can orders be refunded? Full refund only or partial?

**Order Data**:
1. Order contains: items, quantities, prices, shipping address, payment info. Anything else?
2. Is order data immutable after creation, or can it be edited (e.g., address change)?

**Assumptions to Validate**:
1. Assumption: Payment happens before order is created (via TASK-032 payment integration). Correct?
2. Assumption: Inventory is checked/reserved when order is created. Correct?
3. Assumption: Shipping is handled externally (we just track status). Correct?

---

Validation is about catching misunderstandings early. Please confirm or correct the above.

User: Order states correct. Orders can be cancelled if not yet fulfilled. Full refunds only for now. Order data immutable except shipping address (user can update if not yet shipped). Payment does happen first. But we don't have inventory system yet - that's out of scope. Shipping is external, we just track.

Claude:

## Round 2: Edge Cases and Gap Discovery

Thanks for clarifications! Identified a gap: **No inventory system**. This affects order creation. Follow-up questions:

**Inventory Gap**:
1. If no inventory system, can orders be created for products that don't exist or are "out of stock"?
2. What prevents overselling? (e.g., 100 users order last item simultaneously)
3. Is this a problem for MVP, or acceptable risk?

**Address Update Edge Case**:
1. User updates shipping address after order created but before fulfillment - who approves?
2. Does address update trigger notification to user/seller?

**Cancellation Logic**:
1. User cancels order - is refund automatic or manual approval needed?
2. What if order is "Paid" but payment settlement is pending (Stripe payout)?

**Refund Scope**:
1. Full refunds only - does that mean refund all items, or refund one complete order?
2. What if user received some items but not others? (Partial delivery scenario)

---

**Concern Identified**: Inventory gap could lead to overselling. Need to address or explicitly accept risk.

User: Inventory gap is known issue, out of scope for MVP. We'll manually monitor stock for now. Acceptable risk for small beta (50 users). Address update is user self-service, auto-notification. Cancellation triggers automatic refund (Stripe refund API). Partial delivery: refund is all-or-nothing for MVP, partial refund is future enhancement.

Claude:

✅ VALIDATION SYNTHESIS: TASK-035 - Order Management System
─────────────────────────────────

## Validation Results

**Overall Assessment**: Ready with one documented risk

### Shared Understanding ✓

**What's Clear**:
- Order lifecycle: Created → Paid → Fulfilled → Delivered (with cancellation if not fulfilled)
- Order data: Immutable except shipping address (user can update until shipped)
- Payment integration: Orders created after payment (depends on TASK-032)
- Shipping tracking: External system, we track status only

**Alignment Score**: High - core requirements well understood

### Assumptions Validated

✓ **Payment before order**: Confirmed - integrates with TASK-032
✓ **Shipping external**: Confirmed - track status only
⚠️ **Inventory system exists**: INCORRECT - no inventory system (MVP scope decision)

### Concerns Identified

**🟡 Medium Concerns** (accepted for MVP):
- **Overselling Risk**: No inventory system means potential overselling
  - Mitigation: Manual stock monitoring, small beta user base (50 users)
  - Acceptance: Explicit MVP scope decision, future enhancement planned

**🟢 Minor Concerns** (nice to address):
- **Partial delivery handling**: All-or-nothing refund model may frustrate users
  - Current approach: Full refund only for MVP
  - Future enhancement: Partial refund capability

### Edge Cases Discovered

Through validation questions, identified edge cases:

1. **Address update after order creation**:
   - Current plan: User self-service update, auto-notification ✓
   - Handles edge case: Yes

2. **Cancellation with pending payment settlement**:
   - Current plan: Automatic Stripe refund API call ✓
   - Handles edge case: Yes (Stripe handles settlement timing)

3. **Partial delivery (some items received, some not)**:
   - Current plan: Full refund only (all-or-nothing)
   - Handles edge case: Partially (user experience not ideal, but functional)

4. **Simultaneous order attempts for last item**:
   - Current plan: No prevention (inventory gap)
   - Handles edge case: No (accepted risk for MVP)

### Risks Identified

**Technical Risks**:
- Overselling risk (no inventory): Mitigated by manual monitoring + small beta
- Stripe refund API failures: Should have error handling + retry logic

**Process Risks**:
- Manual stock monitoring dependency: Single point of failure, requires process discipline

### Readiness Assessment

**Ready to Proceed?**: Yes, with documented risk

**Conditions Met**:
- ✓ Shared understanding confirmed
- ✓ Edge cases identified and addressed (or explicitly scoped out)
- ✓ Integration points validated (TASK-032 payment dependency)
- ⚠️ Inventory risk documented and accepted

**Recommended Before Implementation**:
1. **Document inventory gap risk** in tasks.md notes for TASK-035
2. **Add acceptance criterion**: "Manual stock monitoring process established"
3. **Consider Stripe refund error handling** in implementation plan

**Proceed with**: /cf:code TASK-035

---

**Session Summary**:
- Validation rounds: 2
- Assumptions checked: 3 (1 corrected)
- Concerns raised: 0 critical / 1 medium (accepted) / 1 minor
- Edge cases found: 4 (3 handled, 1 accepted risk)
- Overall readiness: Ready (with documented risk)
```

---

## Error Handling

### Memory Bank Not Initialized

```
⚠️ Memory Bank Not Initialized

Memory bank not found at: memory-bank/

To initialize, run: /cf:init

Example: /cf:init MyProject
```

### Task Not Found

```
❌ Error: Task not found

Task ID: TASK-[ID]

Could not find this task in memory-bank/tasks.md

Available tasks:
- TASK-001: [Name] (Status)
- TASK-002: [Name] (Status)

Check task ID, or use /cf:status to see all tasks.
```

### No Context for Topic

```
ℹ️ Limited Context for Topic

Topic: [user's topic]

This topic has no existing context in the memory bank. Facilitation will start from scratch.

This is fine for exploration mode. For refinement or validation, ensure topic exists first.

**Proceeding with exploration mode...**
```

---

## Integration with Other Commands

**Typical workflow patterns**:

```
# Before planning complex task
/cf:feature [vague description] → Creates task
/cf:facilitate TASK-[ID] --mode explore → Clarify requirements
/cf:plan TASK-[ID] → Formal planning with clarified requirements

# Improving existing plan
/cf:plan TASK-[ID] → Initial plan created
/cf:facilitate TASK-[ID] --mode refine → Interactive improvement
/cf:code TASK-[ID] → Implementation with refined plan

# Pre-implementation validation
/cf:plan TASK-[ID] --interactive → Creates plan (already uses Facilitator internally)
/cf:facilitate TASK-[ID] --mode validate → Additional validation before coding
/cf:code TASK-[ID] → Implementation with confidence

# Exploring new ideas
/cf:facilitate "feature idea" --mode explore → Collaborative discovery
/cf:feature [clarified description] → Create task from exploration
```

**When to use facilitation**:
- **Use /cf:facilitate** when: Ambiguity, complexity, high stakes, collaborative exploration needed
- **Skip facilitation** when: Requirements clear, task simple (Level 1), urgency high

---

## Notes

- **No iteration limit**: User controls when facilitation ends (type 'continue' or 'stop')
- **Human-in-the-loop**: Requires user participation and answers
- **Can be time-intensive**: May take multiple rounds of questions (worth it for complex topics)
- **Synthesis is valuable output**: Final synthesis is actionable specification
- **Pairs with /cf:plan**: Use facilitate to refine, then plan for formal breakdown
- **Built into /cf:plan --interactive**: Planning's interactive mode already uses Facilitator
- **Standalone value**: Can facilitate topics that aren't tasks yet (exploration mode)

**Best practices**:
- Use exploration mode for fuzzy ideas and brainstorming
- Use refinement mode to improve existing plans or specs
- Use validation mode as final check before implementation
- Answer questions honestly, including "I don't know"
- Raise new concerns or questions as they occur to you
- Take time to think through answers (better than rushing)
- Use 'continue' when feel confident in understanding
- Request focus on specific areas if facilitation is too broad

---

## Related Commands

- `/cf:plan` - Formal planning (includes --interactive flag that uses Facilitator)
- `/cf:feature` - Create task (facilitation often precedes or refines tasks)
- `/cf:code` - Implementation (facilitation ensures readiness)
- `/cf:ask` - Query memory bank (facilitation is interactive, ask is read-only)

---

**Command Version**: 1.0
**Last Updated**: 2025-10-05
