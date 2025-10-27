# Command: /cf:configure-team

Configure stack-specific implementation team with core agents and specialists, replacing or augmenting generic fallback agents.

## Usage

```bash
# Interactive mode with auto-detection
/cf:configure-team

# Quick mode (skip confirmation)
/cf:configure-team --quick

# Direct template selection
/cf:configure-team --template web/react-express
/cf:configure-team --template mobile/react-native
/cf:configure-team --template ai/langchain-python

# Custom team creation with Facilitator
/cf:configure-team --custom
```

## Parameters

**Flags**:
- **No flags** (default): Interactive mode with tech stack auto-detection and user confirmation
- `--quick`: Use auto-detected stack without confirmation prompts
- `--template [name]`: Direct template selection, bypasses auto-detection
  - Available templates: `web/react-express`, `mobile/react-native`, `ai/langchain-python`
- `--custom`: Force custom team creation with Facilitator-guided process

## Purpose

Configures a stack-specific implementation team (product team) tailored to your project's technology stack. This replaces generic fallback agents with specialized core agents and domain-specific specialists that understand your framework patterns, testing strategies, and architectural conventions.

**What You Get**:
- **Core Agents**: Stack-aware implementation agents (e.g., expressBackend, reactFrontend, jestTester)
- **Specialists**: Domain experts for specific technologies (e.g., sequelizeDb, jwtAuth, reactHooks)
- **Routing Configuration**: Keyword-based intelligent delegation from core → specialists
- **Memory Bank Integration**: Team configuration documented in systemPatterns.md

**When to Use**:
- After `/cf:init` when you have a defined tech stack
- When generic agents lack stack-specific knowledge
- When you want framework-aware TDD and implementation patterns
- When your project grows beyond simple full-stack needs

## Prerequisites

**Required**:
- ✅ Project initialized (`/cf:init` already run)
- ✅ `memory-bank/` directory exists with core files
- ✅ Generic agents exist (`.claude/agents/{codeImplementer,testEngineer,uiDeveloper}.md`)

**Optional**:
- Existing `routing.md` (will prompt for overwrite confirmation)
- Existing team agents (will be replaced with user confirmation)

**Error Response if Missing**:
```
❌ Prerequisites not met:
   - memory-bank/ directory not found

Run: /cf:init [project-name]
Then retry: /cf:configure-team
```

## Process

### Phase 1: Prerequisite Validation

1. **Check Memory Bank Exists**:
   - Verify `memory-bank/` directory present
   - Verify core files exist (projectbrief.md, systemPatterns.md)
   - If missing → Error with `/cf:init` guidance

2. **Check Generic Agents Exist**:
   - Verify `.claude/agents/codeImplementer.md` exists
   - Verify `.claude/agents/testEngineer.md` exists
   - Verify `.claude/agents/uiDeveloper.md` exists
   - If missing → Error with `/cf:init` guidance

3. **Check for Existing Team Configuration**:
   - If `.claude/agents/routing.md` exists:
     - Read existing configuration
     - Prompt: "Team already configured: [existing team]. Overwrite? (y/n)"
     - If 'n' → Abort with message "Team configuration unchanged"
     - If 'y' → Continue with backup warning
   - If team agents exist in `.claude/agents/` (non-generic):
     - List existing agents
     - Prompt: "Existing team agents will be replaced. Continue? (y/n)"

### Phase 2: Tech Stack Detection (Skip if --template or --custom flag)

1. **Analyze Project Structure**:
   - Read `package.json` if exists → Extract dependencies
   - Read `memory-bank/systemPatterns.md` → Look for "## Tech Stack" section
   - Read `CLAUDE.md` if exists → Look for tech stack information
   - Scan directory structure for framework indicators:
     - `pages/` or `app/` → Next.js
     - `src/components/` + React imports → React
     - `android/` + `ios/` → React Native
     - `requirements.txt` + `langchain` → AI/Python
     - `config/routes.rb` → Rails

2. **Match to Template**:
   - Score each template based on detected technologies
   - Select highest scoring template
   - If score < 70% confidence → No clear match

3. **Present Findings** (unless --quick):
   ```
   🔍 Tech Stack Detection:

   **Detected Technologies**:
   - React 18.x (frontend)
   - Express 4.x (backend)
   - Jest (testing)
   - PostgreSQL (database)

   **Recommended Template**: web/react-express (85% confidence)

   Options:
   1. Use recommended template (auto-configured)
   2. Choose different template
   3. Create custom team

   Select option (1-3): _
   ```

4. **User Confirmation**:
   - Option 1 → Proceed to Phase 3 (Template Mode)
   - Option 2 → Show template list → User selects → Proceed to Phase 3
   - Option 3 → Proceed to Phase 4 (Custom Mode)
   - If --quick flag → Auto-select Option 1

### Phase 3: Template-Based Team Configuration

**Decision Point**: Use when:
- User selected pre-built template
- Auto-detection matched with confirmation
- --template flag specified

1. **Load Template Metadata**:
   - Read `.claude/templates/team-types/[domain]/[stack]/team.yaml`
   - Extract: team name, core agents, specialists, description

2. **Copy Core Agents**:
   - Source: `.claude/templates/team-types/[domain]/[stack]/core/*.md`
   - Destination: `.claude/agents/[domain]/[stack]/core/`
   - Create destination directories if needed
   - Copy all core agent files
   - Validate YAML frontmatter in each copied file

3. **Copy Specialists**:
   - Source: `.claude/templates/team-types/[domain]/[stack]/specialists/*.md`
   - Destination: `.claude/agents/[domain]/[stack]/specialists/`
   - Create destination directories if needed
   - Copy all specialist files
   - Validate YAML frontmatter in each copied file

4. **Configure Routing**:
   - Copy `.claude/templates/team-types/[domain]/[stack]/routing.template.md`
   - Destination: `.claude/agents/routing.md`
   - Validate YAML frontmatter
   - Verify keyword mappings reference copied agents

5. **Update Memory Bank**:
   - Open `memory-bank/systemPatterns.md`
   - Add or update "## Team Configuration" section:
   ```markdown
   ## Team Configuration

   **Team Type**: [Template Name] (pre-built template)
   **Configured**: [Date]
   **Domain**: [domain]
   **Stack**: [stack]

   **Core Agents**:
   - **[agentName]**: [scope and responsibilities]
   - **[agentName]**: [scope and responsibilities]
   - **[testAgent]**: [testing scope and frameworks]

   **Specialists** (auto-delegated):
   - **[specialistName]**: [expertise] (from [coreAgent])
   - **[specialistName]**: [expertise] (from [coreAgent])

   **Routing Keywords**: See `.claude/agents/routing.md`

   **Delegation Flow**:
   /cf:code → routing.md → Core Agent → Specialist (if keywords match)
   ```

6. **Validation**:
   - Verify all agent files exist at expected paths
   - Verify YAML frontmatter valid in all agent files
   - Verify routing.md references only existing agents
   - If validation fails → Report errors with file paths

7. **Success Output**:
   ```
   ✅ Team Configured: React + Express Web Development

   **Core Agents** (.claude/agents/web/react-express/core/):
   - expressBackend: Express.js API development, middleware, routing
   - reactFrontend: React components, hooks, state management
   - jestTester: Jest unit tests, React Testing Library integration

   **Specialists** (.claude/agents/web/react-express/specialists/):
   - sequelizeDb: Database models, migrations, queries (from expressBackend)
   - jwtAuth: JWT authentication, middleware (from expressBackend)
   - reactHooks: Custom hooks, state patterns (from reactFrontend)

   **Routing**: Configured in `.claude/agents/routing.md`

   ℹ️ Use /cf:code [task] to invoke team agents
   ℹ️ Specialists auto-invoked when keywords detected (e.g., "database", "auth", "hooks")
   ℹ️ Generic agents remain as fallbacks for unmatched tasks
   ```

### Phase 4: Custom Team Creation (Facilitator-Guided)

**Decision Point**: Use when:
- User selected custom creation
- --custom flag specified
- No template match found and user chose custom

1. **Engage Facilitator Agent**:
   - Load Facilitator agent
   - Activate Action Recommendation Pattern
   - Initialize custom team creation context

2. **Facilitator Question Flow**:

   **Round 1: Tech Stack Discovery**
   ```
   Let's configure your custom implementation team.

   **Current State**: Generic fallback agents active
   **Goal**: Create stack-specific core agents and specialists

   **Questions**:
   1. What is your tech stack? (frameworks, languages, key libraries)
   2. What are your main implementation domains?
      Examples: backend API, frontend UI, database, mobile, testing, deployment
   3. Are there specialized areas needing dedicated agents?
      Examples: authentication, caching, performance, security, data processing

   Please describe your tech stack and implementation needs.
   ```

   **Round 2: Core Agent Definition**
   - Based on user response, Facilitator identifies core agents needed
   - For each proposed core agent:
     ```
     **Proposed Core Agent**: [agentName]
     **Scope**: [domain and technologies]
     **Responsibilities**: [what it handles]

     Is this correct? Any adjustments?
     ```
   - User confirms or refines
   - Repeat until all core agents defined

   **Round 3: Specialist Identification**
   - For each core agent, Facilitator asks:
     ```
     **Core Agent**: [agentName]

     Should this agent have specialized sub-agents for specific technologies?
     Examples for backend: database ORM, authentication, caching, API validation

     What specialists (if any) should [agentName] delegate to?
     ```
   - User lists specialists or chooses none
   - Facilitator confirms delegation triggers (keywords)

3. **Generate Core Agents**:
   - For each core agent identified:
     - Create directory: `.claude/agents/custom/core/`
     - Copy template: `.claude/templates/blank-agents/core-agent.template.md`
     - Destination: `.claude/agents/custom/core/[agentName].md`
     - Facilitator helps populate:
       - YAML frontmatter (name, role, triggers, dependencies)
       - Role description
       - Responsibilities
       - Process steps
       - Specialist delegation rules
       - TDD integration specifics
   - Validate YAML frontmatter

4. **Generate Specialists**:
   - For each specialist identified:
     - Create directory: `.claude/agents/custom/specialists/`
     - Copy template: `.claude/templates/blank-agents/specialist.template.md`
     - Destination: `.claude/agents/custom/specialists/[specialistName].md`
     - Facilitator helps populate:
       - YAML frontmatter (name, expertise, triggers)
       - Expertise description
       - Scope (what it handles, what it doesn't)
       - Trigger keywords
       - Output format
   - Validate YAML frontmatter

5. **Generate Routing Configuration**:
   - Copy template: `.claude/templates/blank-agents/routing.template.md`
   - Destination: `.claude/agents/routing.md`
   - Facilitator helps populate:
     - Keyword → Core Agent mappings
     - Keyword → Specialist mappings (via core agent)
     - Delegation rules
     - Fallback logic
   - **IMPORTANT**: Order core agents by priority (most specific first)
     - Reason: First match wins for ambiguous tasks
     - Example: Database-focused backend before general backend
   - Validate YAML frontmatter

6. **Update Memory Bank**:
   - Open `memory-bank/systemPatterns.md`
   - Add "## Team Configuration" section:
   ```markdown
   ## Team Configuration

   **Team Type**: Custom (Facilitator-guided creation)
   **Configured**: [Date]

   **Core Agents** (.claude/agents/custom/core/):
   - **[agentName]**: [scope and responsibilities]
   - **[agentName]**: [scope and responsibilities]
   - **[testAgent]**: [testing scope and frameworks]

   **Specialists** (.claude/agents/custom/specialists/):
   - **[specialistName]**: [expertise] (delegated from [coreAgent])
     - Triggers: [keywords]
   - **[specialistName]**: [expertise] (delegated from [coreAgent])
     - Triggers: [keywords]

   **Routing Configuration**: See `.claude/agents/routing.md`

   **Custom Team Rationale**:
   [User's explanation of why custom team needed]

   **Delegation Flow**:
   /cf:code → routing.md → Core Agent → Specialist (if keywords match)
   ```

7. **Facilitator Final Recommendation**:
   ```
   ✅ Custom team configuration complete!

   **Next Steps**:
   1. Review generated agents in `.claude/agents/custom/`
   2. Test with: /cf:code [simple task matching your stack]
   3. Refine agent definitions based on results
   4. Create checkpoint: /cf:checkpoint "Custom team configured"

   **Recommended Action**: Test your new team with a small implementation task

   Try: /cf:code "Add a simple [framework-specific feature]"
   ```

### Phase 5: Post-Configuration Actions

**All Modes Complete Here**:

1. **Validate Complete Configuration**:
   - Count core agents created/copied
   - Count specialists created/copied
   - Verify routing.md exists and is valid
   - Verify systemPatterns.md updated
   - Report validation summary

2. **Test Routing Configuration** (optional automatic check):
   - Read routing.md
   - For each keyword mapping:
     - Verify target agent file exists
     - Verify agent YAML frontmatter matches routing entry
   - Report any broken references

3. **Suggest Next Actions**:
   ```
   **Recommended Next Steps**:
   1. Test team with simple task: /cf:code "Add [feature]"
   2. Review agent definitions in `.claude/agents/[team-path]/`
   3. Create checkpoint: /cf:checkpoint "Team configured: [team-name]"

   **Learn More**:
   - Agent architecture: docs/system/architecture.md
   - Team customization: docs/user-guide/customizing-teams.md
   ```

## Examples

### Example 1: Interactive with Auto-Detection

```bash
/cf:configure-team
```

**Interaction Flow**:
```
🔍 Analyzing project structure...

**Detected Technologies**:
- React 18.2.0 (frontend)
- Express 4.18.2 (backend)
- Jest 29.5.0 (testing)
- Sequelize 6.32.0 (database)

**Recommended Template**: web/react-express (92% confidence)

This template provides:
- expressBackend (Express.js core agent)
- reactFrontend (React core agent)
- jestTester (Jest testing agent)
- Specialists: sequelizeDb, jwtAuth, reactHooks

Options:
1. Use recommended template ← Recommended
2. Choose different template
3. Create custom team

Select option (1-3): 1

✅ Copying core agents...
✅ Copying specialists...
✅ Configuring routing...
✅ Updating memory bank...

✅ Team Configured: React + Express Web Development

**Core Agents**:
- expressBackend: Express.js API development, middleware, routing
- reactFrontend: React components, hooks, state management
- jestTester: Jest unit tests, React Testing Library integration

**Specialists**:
- sequelizeDb: Database models, migrations, queries
- jwtAuth: JWT authentication, middleware
- reactHooks: Custom hooks, state patterns

ℹ️ Use /cf:code [task] to invoke team agents
```

### Example 2: Quick Mode (No Confirmation)

```bash
/cf:configure-team --quick
```

**Output**:
```
🔍 Auto-detecting tech stack...
✅ Matched template: web/react-express (92% confidence)
✅ Configuring team...
✅ Team configured successfully

Use /cf:code [task] to test your new team
```

### Example 3: Direct Template Selection

```bash
/cf:configure-team --template mobile/react-native
```

**Output**:
```
✅ Using template: mobile/react-native
✅ Copying core agents...
✅ Copying specialists...
✅ Configuring routing...

✅ Team Configured: React Native Mobile Development

**Core Agents**:
- rnDeveloper: React Native components, navigation, platform APIs
- rnTester: Jest + Detox testing for mobile
- nativeModuleDev: Native module bridging (iOS/Android)

**Specialists**:
- asyncStorageManager: Local data persistence
- navigationSpecialist: React Navigation patterns
- platformSpecific: Platform-specific implementations

ℹ️ Use /cf:code [task] to invoke team agents
```

### Example 4: Custom Team with Facilitator

```bash
/cf:configure-team --custom
```

**Interaction Flow**:
```
🤝 Engaging Facilitator for custom team creation...

Let's configure your custom implementation team.

**Current State**: Generic fallback agents active
**Goal**: Create stack-specific core agents and specialists

**Questions**:
1. What is your tech stack? (frameworks, languages, key libraries)
2. What are your main implementation domains?
3. Are there specialized areas needing dedicated agents?

Please describe your tech stack and implementation needs.

> User: "Rails backend with GraphQL API, Vue.js frontend, RSpec testing"

Great! Based on that, I'm identifying these implementation domains:

**Proposed Core Agents**:
1. **railsBackend**: Rails MVC, ActiveRecord, GraphQL schema
2. **vueFrontend**: Vue components, Vuex store, Apollo client
3. **rspecTester**: RSpec unit/integration tests, FactoryBot

Does this match your needs? Any adjustments?

> User: "Yes, but add graphqlSchemaDesigner as specialist"

Perfect! Let's define specialists:

**For railsBackend**, should we have specialists for:
- Database (ActiveRecord models, migrations)
- GraphQL (schema, resolvers, types)
- Authentication/Authorization

Which would you like as specialists?

> User: "GraphQL and database"

**Specialists Identified**:
- graphqlSchemaDesigner (from railsBackend): Schema design, resolver patterns
- activeRecordOptimizer (from railsBackend): Query optimization, associations

✅ Generating custom team...
✅ Creating core agents (3)...
✅ Creating specialists (2)...
✅ Configuring routing...
✅ Updating memory bank...

✅ Custom Team Configured!

**Next Steps**:
1. Review agents in `.claude/agents/custom/`
2. Test with: /cf:code "Add GraphQL query for users"
3. Refine definitions based on results

**Recommended Action**: Test your new team
Try: /cf:code "Add a simple GraphQL query"
```

### Example 5: Overwriting Existing Team

```bash
/cf:configure-team --template web/react-express
```

**Output with Existing Team**:
```
⚠️ Team Already Configured

**Current Team**: Custom Rails + Vue Team
**Configured**: 2025-10-05

**Existing Core Agents**:
- railsBackend
- vueFrontend
- rspecTester

**Existing Specialists**:
- graphqlSchemaDesigner
- activeRecordOptimizer

Replace with template 'web/react-express'? (y/n): y

⚠️ Backing up existing configuration to memory-bank/backups/team-2025-10-05.md
✅ Removing old team agents...
✅ Configuring new team...
✅ Team replaced successfully

ℹ️ Previous team backed up - restore manually if needed
```

## Error Handling

### Error 1: Prerequisites Not Met

**Trigger**: Memory bank or generic agents missing

**Response**:
```
❌ Prerequisites not met:

Missing:
- memory-bank/ directory not found
- .claude/agents/codeImplementer.md not found

**Required Setup**:
1. Initialize project: /cf:init [project-name]
2. Complete initialization process
3. Retry: /cf:configure-team

Current directory: /Users/[user]/projects/[project]/
```

### Error 2: Invalid Template Name

**Trigger**: --template flag with non-existent template

**Response**:
```
❌ Template not found: 'web/react-vue'

**Available Templates**:
- web/react-express: React frontend + Express backend
- mobile/react-native: React Native mobile development
- ai/langchain-python: LangChain AI applications

Usage: /cf:configure-team --template [template-name]
Or: /cf:configure-team (auto-detect)
Or: /cf:configure-team --custom (guided creation)
```

### Error 3: Agent File Validation Failed

**Trigger**: Copied agent has invalid YAML frontmatter

**Response**:
```
❌ Agent validation failed during team configuration

**Invalid Files**:
- .claude/agents/web/react-express/core/expressBackend.md
  Error: Missing required YAML field 'triggers'

- .claude/agents/web/react-express/specialists/jwtAuth.md
  Error: YAML parse error at line 4: unexpected character

**Fix Instructions**:
1. Open invalid files listed above
2. Verify YAML frontmatter between '---' markers
3. Check required fields: name, role, triggers
4. Retry: /cf:configure-team

**Template Issue?**: Report to CCFlow maintainers with error details
```

### Error 4: Tech Stack Detection Failed

**Trigger**: No clear template match and user didn't select option

**Response**:
```
🤔 Unable to auto-detect tech stack with confidence

**Detected Files**:
- package.json found
- No clear framework indicators

**Options**:
1. Specify template manually: /cf:configure-team --template [name]
2. Create custom team: /cf:configure-team --custom
3. Review available templates: See docs/user-guide/team-templates.md

**Need help?**: Run /cf:configure-team --custom for guided setup
```

### Error 5: Routing Configuration Broken References

**Trigger**: routing.md references non-existent agents

**Response**:
```
⚠️ Routing validation warnings:

**Broken References in routing.md**:
- Keyword 'database' → Agent 'sequelizeDb' (file not found)
- Keyword 'graphql' → Agent 'graphqlResolver' (file not found)

**Team Still Configured**: Core agents operational
**Impact**: Keywords above will fall back to generic agents

**Fix Options**:
1. Create missing specialists: /cf:create-specialist
2. Update routing.md to remove broken keywords
3. Reconfigure team: /cf:configure-team

**Current Status**: Partial team functionality (core agents working)
```

## Memory Bank Updates

### systemPatterns.md

**Section Added/Updated**: `## Team Configuration`

**Content Structure**:
```markdown
## Team Configuration

**Team Type**: [Template Name | Custom]
**Configured**: [ISO Date]
**Domain**: [domain] (if template)
**Stack**: [stack] (if template)

**Core Agents** (.claude/agents/[path]/core/):
- **[agentName]**: [scope and responsibilities]
  - Dependencies: [systemPatterns.md sections]
  - Delegates to: [specialist names]
- **[agentName]**: [scope and responsibilities]
  - Dependencies: [systemPatterns.md sections]
  - Delegates to: [specialist names]

**Specialists** (.claude/agents/[path]/specialists/):
- **[specialistName]**: [expertise description]
  - Delegated from: [core agent name]
  - Trigger keywords: [comma-separated keywords]
  - Scope: [what it handles, what it excludes]

**Routing Configuration**: See `.claude/agents/routing.md`

**Delegation Flow**:
```
/cf:code [task]
    ↓ (reads routing.md)
Core Agent (based on keywords)
    ↓ (if specialist keywords detected)
Specialist (focused implementation)
    ↓ (always)
TDD Enforcement (testEngineer | stack-specific tester)
```

**Fallback Strategy**:
- Unmatched keywords → Generic agents (codeImplementer, testEngineer, uiDeveloper)
- Generic agents remain active as safety net
- Specialist unavailable → Core agent handles directly

**Team Rationale** (custom teams only):
[Why custom team was needed, user's explanation]
```

**Update Strategy**:
- If "## Team Configuration" section exists → Replace entirely
- If not exists → Append before "## Architectural Decisions"
- Preserve all other sections unchanged

### activeContext.md

**Section Added**: Entry in "## Recent Changes"

**Content**:
```markdown
### [ISO DateTime] - Team Configuration

**Action**: Configured [template-name | custom] implementation team

**Changes**:
- Created [N] core agents in `.claude/agents/[path]/core/`
- Created [M] specialists in `.claude/agents/[path]/specialists/`
- Created routing configuration: `.claude/agents/routing.md`
- Updated systemPatterns.md with team configuration

**Impact**:
- `/cf:code` now routes to stack-specific agents
- Specialists auto-invoked for [list keywords]
- Generic agents remain as fallbacks

**Next Actions**:
- Test team with implementation task
- Refine agent definitions if needed
- Create checkpoint after validation
```

### Backup Strategy (on Overwrite)

**Trigger**: Existing team being replaced

**Action**:
1. Create `memory-bank/backups/` directory if not exists
2. Create backup file: `memory-bank/backups/team-[ISO-date].md`
3. Copy contents:
   ```markdown
   # Team Configuration Backup

   **Backup Date**: [ISO DateTime]
   **Reason**: Team reconfiguration

   ## Previous Team Configuration
   [Full content of systemPatterns.md ## Team Configuration section]

   ## Previous Agents Backed Up
   - [List of agent files that were replaced]

   ## Routing Configuration
   [Full content of previous routing.md]
   ```

## Notes

### Pre-Built Templates

**Location**: `.claude/templates/team-types/[domain]/[stack]/`

**Available Templates**:
- `web/react-express/`: React frontend + Express backend + Jest
- `mobile/react-native/`: React Native mobile + Detox testing
- `ai/langchain-python/`: LangChain + Python + pytest

**Template Structure**:
```
team-types/
  web/
    react-express/
      team.yaml              # Metadata
      routing.template.md    # Routing configuration
      core/
        expressBackend.md
        reactFrontend.md
        jestTester.md
      specialists/
        sequelizeDb.md
        jwtAuth.md
        reactHooks.md
```

### Blank Agent Templates

**Location**: `.claude/templates/blank-agents/`

**Templates Available**:
- `core-agent.template.md`: For implementation agents with delegation capability
- `specialist.template.md`: For focused expertise agents
- `routing.template.md`: For routing configuration

**Usage**: Custom team creation with Facilitator

### Routing Configuration

**File**: `.claude/agents/routing.md`

**Purpose**: Single source of truth for keyword → agent mapping

**Format**:
```yaml
---
version: 1.0
team: [team-name]
configured: [ISO-date]
---

# Agent Routing Configuration

## Keyword Mappings

### Backend Keywords → expressBackend
database, db, model, migration, schema, sequelize, orm

### Frontend Keywords → reactFrontend
component, react, jsx, hooks, state, props, ui

### Testing Keywords → jestTester
test, spec, jest, coverage, mock, assertion

## Specialist Delegation

### From expressBackend → sequelizeDb
database, model, migration, query, association, sequelize

### From expressBackend → jwtAuth
auth, jwt, token, authentication, authorization, session

### From reactFrontend → reactHooks
hook, useEffect, useState, useContext, custom hook

## Fallback Rules

1. No keyword match → codeImplementer (generic)
2. Multiple matches → Most specific agent
3. Specialist unavailable → Core agent handles
4. Core agent unavailable → Generic agent
```

**Usage by /cf:code**:
```
/cf:code "Add database migration for users"
    ↓
routing.md: "database" → expressBackend
    ↓
expressBackend: "database" → sequelizeDb specialist
    ↓
sequelizeDb implements with Sequelize-specific patterns
```

### Agent Discovery Pattern

**Implementation Agent Behavior**:
- After 3+ delegations to same domain → Recommend specialist creation
- Check `specialists/` subdirectory before each delegation
- If specialist exists → Delegate with context
- If specialist missing → Handle directly + log recommendation

**Facilitator Pattern**:
- Detects repeated delegation patterns during custom creation
- Suggests specialists proactively
- Helps define specialist scope and triggers

### Integration with /cf:code

**Reading Routing Configuration**:
```
/cf:code [task]
    ↓
Step 1: Read .claude/agents/routing.md
Step 2: Extract keywords from task description
Step 3: Match keywords to core agent
Step 4: Load core agent
Step 5: Core agent checks for specialist keywords
Step 6: Delegate to specialist OR implement directly
Step 7: TDD enforcement (testEngineer or stack tester)
```

**Fallback Chain**:
```
routing.md match → Core agent → Specialist
                ↓ (no match)
            Generic agent (codeImplementer/testEngineer/uiDeveloper)
```

### Generic Agents as Fallbacks

**Behavior After Team Configuration**:
- Generic agents remain active in `.claude/agents/`
- Act as safety net for unmatched keywords
- No changes to generic agent files
- Routing preference: Stack-specific → Generic

**Example**:
```
Task: "Add caching layer"
Keywords: caching, redis, cache

routing.md: No match for "caching" (not in template)
    ↓
Fallback to codeImplementer (generic)
    ↓
Recommendation: Create caching specialist for frequent use
```

### Reconfiguration Strategy

**Safe Reconfiguration**:
1. User runs `/cf:configure-team` again
2. System detects existing team
3. Prompts for overwrite confirmation
4. Creates backup before replacement
5. Replaces agents and routing
6. Updates systemPatterns.md

**Incremental Enhancement**:
- Add specialists: `/cf:create-specialist` (doesn't require reconfiguration)
- Modify routing: Edit `.claude/agents/routing.md` directly
- Refine agents: Edit agent files in place

### Token Efficiency

**Detection Logic Location**: Inline in command (not in agents)
- Package.json parsing: Direct file read
- Pattern matching: Lightweight keyword scoring
- Template selection: Simple confidence calculation

**Rationale**: Avoid loading detection logic into memory bank or agent context

### Future Template Expansion

**Adding New Templates**:
1. Create directory: `.claude/templates/team-types/[domain]/[stack]/`
2. Add `team.yaml` metadata
3. Create core agents in `core/`
4. Create specialists in `specialists/`
5. Create `routing.template.md`
6. Document in `docs/user-guide/team-templates.md`

**Community Templates**:
- Users can create custom templates in same structure
- Share via `.claude/templates/team-types/` directory
- Load with `--template custom/[name]`

## Related Commands

**Prerequisites**:
- `/cf:init`: Must run first to create memory bank and generic agents

**Team Management**:
- `/cf:create-specialist`: Add specialist to existing team (no reconfiguration needed)
- `/cf:code`: Reads routing.md created by this command for agent selection

**Workflow Integration**:
- `/cf:plan`: Works with configured team agents for Level 2-4 tasks
- `/cf:checkpoint`: Recommended after team configuration for savepoint

**Documentation**:
- See `docs/user-guide/team-templates.md` for template details
- See `docs/system/agent-architecture.md` for agent design patterns
- See `docs/user-guide/customizing-teams.md` for advanced customization

---

**Version**: 1.0
**Last Updated**: 2025-10-08
**Command Type**: Team Configuration
**Agent Dependencies**: Facilitator (custom mode only)
**Memory Bank Impact**: systemPatterns.md (Team Configuration section), activeContext.md (Recent Changes)
