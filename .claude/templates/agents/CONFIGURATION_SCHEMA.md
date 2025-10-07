# Agent Configuration Schema

This document defines how implementation agent templates get configured during `/cf:init` Phase 1.5.

## Configuration Sources (Priority Order)

1. **CLAUDE.md** - Project's explicit configuration (highest priority)
2. **Auto-detection** - package.json, code structure analysis
3. **User prompts** - Interactive questions for gaps
4. **Defaults** - Sensible fallbacks (lowest priority)

---

## Configuration Mapping

### codeImplementer Template

#### Technology Stack Section

| Template Placeholder | CLAUDE.md Section | package.json | Code Structure | Prompt | Default |
|---------------------|-------------------|--------------|----------------|---------|----------|
| `{{LANGUAGE}}` | "Tech Stack" → language | - | File extensions | "Primary language?" | JavaScript |
| `{{FRAMEWORK}}` | "Tech Stack" → framework | dependencies (express, fastify, nestjs) | - | "Backend framework?" | Express |
| `{{DATABASE}}` | "Tech Stack" → database | dependencies (pg, mysql, mongodb) | - | "Database?" | PostgreSQL |
| `{{ORM}}` | "Tech Stack" → orm | dependencies (sequelize, typeorm, prisma) | - | "ORM/Query builder?" | None |
| `{{VERSION}}` | "Tech Stack" → version | engines.node | - | - | Latest LTS |

#### Coding Conventions Section

| Template Placeholder | CLAUDE.md Section | package.json | Code Structure | Prompt | Default |
|---------------------|-------------------|--------------|----------------|---------|----------|
| `{{VAR_NAMING}}` | "Conventions" → variables | - | Code analysis (camelCase/snake_case) | "Variable naming?" | camelCase |
| `{{FUNC_NAMING}}` | "Conventions" → functions | - | Code analysis | "Function naming?" | camelCase |
| `{{CLASS_NAMING}}` | "Conventions" → classes | - | Code analysis | "Class naming?" | PascalCase |
| `{{CONST_NAMING}}` | "Conventions" → constants | - | Code analysis | "Constant naming?" | UPPER_SNAKE_CASE |
| `{{FILE_NAMING}}` | "Conventions" → files | - | File analysis | "File naming?" | kebab-case |
| `{{INDENTATION}}` | "Conventions" → indentation | .editorconfig, .prettierrc | - | "Indentation?" | 2 spaces |
| `{{LINE_LENGTH}}` | "Conventions" → line_length | .eslintrc, .prettierrc | - | "Max line length?" | 100 |
| `{{QUOTES}}` | "Conventions" → quotes | .eslintrc, .prettierrc | - | "Quote style?" | single |
| `{{SEMICOLONS}}` | "Conventions" → semicolons | .eslintrc, .prettierrc | - | "Semicolons?" | required |

#### Common Patterns Section

| Template Placeholder | CLAUDE.md Section | package.json | Code Structure | Prompt | Default |
|---------------------|-------------------|--------------|----------------|---------|----------|
| `{{SERVICE_PATTERN}}` | "Architecture" → service_layer | - | src/services/ analysis | "Service layer pattern?" | Class-based |
| `{{ERROR_PATTERN}}` | "Architecture" → error_handling | - | Error handler analysis | "Error handling?" | Middleware |
| `{{VALIDATION_PATTERN}}` | "Architecture" → validation | dependencies (joi, yup, zod) | Validator analysis | "Validation approach?" | Joi |
| `{{MIDDLEWARE_PATTERN}}` | "Architecture" → middleware | - | Middleware analysis | "Middleware pattern?" | Express-style |
| `{{DB_PATTERN}}` | "Architecture" → database_access | - | Model/repository analysis | "DB access pattern?" | Repository |

#### File Templates Section

| Template Placeholder | CLAUDE.md Section | package.json | Code Structure | Prompt | Default |
|---------------------|-------------------|--------------|----------------|---------|----------|
| `{{SERVICE_TEMPLATE}}` | "Templates" → service | - | Existing service analysis | - | Generic template |
| `{{MODEL_TEMPLATE}}` | "Templates" → model | - | Existing model analysis | - | Generic template |
| `{{ROUTE_TEMPLATE}}` | "Templates" → route | - | Existing route analysis | - | Generic template |

#### Specialist Routing Section

| Template Placeholder | CLAUDE.md Section | package.json | Code Structure | Prompt | Default |
|---------------------|-------------------|--------------|----------------|---------|----------|
| `{{DB_SPECIALIST_TRIGGER}}` | "Specialists" → database | - | - | "When delegate DB work?" | Complex queries |
| `{{API_SPECIALIST_TRIGGER}}` | "Specialists" → api_integration | - | - | "When delegate API work?" | External APIs |
| `{{AUTH_SPECIALIST_TRIGGER}}` | "Specialists" → auth | - | - | "When delegate auth work?" | Auth logic |
| `{{PERF_SPECIALIST_TRIGGER}}` | "Specialists" → performance | - | - | "When delegate perf work?" | < 100ms requirements |

---

### testEngineer Template

#### Testing Framework Section

| Template Placeholder | CLAUDE.md Section | package.json | Code Structure | Prompt | Default |
|---------------------|-------------------|--------------|----------------|---------|----------|
| `{{TEST_FRAMEWORK}}` | "Tech Stack" → testing | devDependencies (jest, vitest, mocha) | - | "Testing framework?" | Jest |
| `{{TEST_DIRECTORY}}` | - | - | tests/ or __tests__/ or spec/ | - | tests/ |
| `{{TEST_FILE_PATTERN}}` | - | - | File analysis | - | *.test.js |
| `{{COVERAGE_TOOL}}` | "Tech Stack" → coverage | devDependencies, scripts | - | - | Framework default |

#### Test Running Commands Section

| Template Placeholder | CLAUDE.md Section | package.json | Code Structure | Prompt | Default |
|---------------------|-------------------|--------------|----------------|---------|----------|
| `{{TEST_COMMAND}}` | - | scripts.test | - | - | npm test |
| `{{TEST_FILE_COMMAND}}` | - | - | - | - | npm test <file> |
| `{{COVERAGE_COMMAND}}` | - | scripts["test:coverage"] | - | - | npm test -- --coverage |
| `{{WATCH_COMMAND}}` | - | scripts["test:watch"] | - | - | npm test -- --watch |

#### Coverage Thresholds Section

| Template Placeholder | CLAUDE.md Section | package.json | Code Structure | Prompt | Default |
|---------------------|-------------------|--------------|----------------|---------|----------|
| `{{MIN_LINES}}` | "Quality Standards" → coverage_lines | jest.coverageThreshold | - | "Min line coverage?" | 80 |
| `{{MIN_BRANCHES}}` | "Quality Standards" → coverage_branches | jest.coverageThreshold | - | "Min branch coverage?" | 75 |
| `{{MIN_FUNCTIONS}}` | "Quality Standards" → coverage_functions | jest.coverageThreshold | - | "Min function coverage?" | 80 |

#### Test Patterns Section

| Template Placeholder | CLAUDE.md Section | package.json | Code Structure | Prompt | Default |
|---------------------|-------------------|--------------|----------------|---------|----------|
| `{{TEST_NAMING}}` | "Conventions" → test_naming | - | Test file analysis | - | should X when Y |
| `{{FIXTURE_LOCATION}}` | - | - | Fixture analysis | - | tests/fixtures/ |
| `{{MOCK_STRATEGY}}` | "Architecture" → mocking | - | Mock analysis | "Mocking strategy?" | Mock externals only |
| `{{TEST_DATA_LOCATION}}` | - | - | Test data analysis | - | tests/data/ |

#### Specialist Routing Section

| Template Placeholder | CLAUDE.md Section | package.json | Code Structure | Prompt | Default |
|---------------------|-------------------|--------------|----------------|---------|----------|
| `{{PERF_TEST_TRIGGER}}` | "Specialists" → performance | - | - | "When delegate perf testing?" | Load testing needed |
| `{{SECURITY_TEST_TRIGGER}}` | "Specialists" → security | - | - | "When delegate security testing?" | Auth/crypto code |
| `{{INTEGRATION_TEST_TRIGGER}}` | "Specialists" → integration | - | - | "When delegate integration testing?" | Multi-service flows |
| `{{E2E_TEST_TRIGGER}}` | "Specialists" → e2e | devDependencies (playwright, cypress) | - | "When delegate E2E testing?" | User journeys |

---

### uiDeveloper Template

#### UI Framework Section

| Template Placeholder | CLAUDE.md Section | package.json | Code Structure | Prompt | Default |
|---------------------|-------------------|--------------|----------------|---------|----------|
| `{{UI_FRAMEWORK}}` | "Tech Stack" → frontend | dependencies (react, vue, angular, svelte) | - | "UI framework?" | React |
| `{{UI_VERSION}}` | "Tech Stack" → version | dependencies version | - | - | Latest |
| `{{STATE_MGMT}}` | "Tech Stack" → state_management | dependencies (redux, zustand, pinia) | - | "State management?" | Context API |
| `{{ROUTER}}` | "Tech Stack" → router | dependencies (react-router, vue-router) | - | "Router?" | Framework default |

#### Styling Approach Section

| Template Placeholder | CLAUDE.md Section | package.json | Code Structure | Prompt | Default |
|---------------------|-------------------|--------------|----------------|---------|----------|
| `{{CSS_FRAMEWORK}}` | "Tech Stack" → styling | dependencies (tailwind, bootstrap, mui) | - | "CSS framework?" | CSS Modules |
| `{{CSS_IN_JS}}` | "Tech Stack" → css_in_js | dependencies (styled-components, emotion) | - | "CSS-in-JS?" | No |
| `{{DESIGN_TOKENS}}` | "Architecture" → design_tokens | - | tokens/ or theme/ analysis | "Design tokens?" | None |

#### Component Patterns Section

| Template Placeholder | CLAUDE.md Section | package.json | Code Structure | Prompt | Default |
|---------------------|-------------------|--------------|----------------|---------|----------|
| `{{COMPONENT_STRUCTURE}}` | "Architecture" → component_pattern | - | Component analysis | "Component pattern?" | Functional |
| `{{PROP_TYPES}}` | "Tech Stack" → typescript | dependencies (typescript, prop-types) | .ts/.tsx files | - | TypeScript/PropTypes |
| `{{HOOKS_PATTERN}}` | "Architecture" → custom_hooks | - | hooks/ analysis | "Custom hooks pattern?" | Use liberally |

#### Accessibility Standards Section

| Template Placeholder | CLAUDE.md Section | package.json | Code Structure | Prompt | Default |
|---------------------|-------------------|--------------|----------------|---------|----------|
| `{{WCAG_LEVEL}}` | "Quality Standards" → accessibility | - | - | "WCAG compliance level?" | AA |
| `{{A11Y_TESTING}}` | "Tech Stack" → a11y_testing | devDependencies (axe, pa11y) | - | "A11y testing tool?" | Manual review |

---

## Extraction Logic

### Phase 1: Parse CLAUDE.md

```javascript
// Pseudo-code for extraction
function extractFromClaudeMd(claudeMdContent) {
  const config = {}

  // Extract Tech Stack section
  const techStack = extractSection(claudeMdContent, "Tech Stack")
  config.language = extractField(techStack, "language") || extractField(techStack, "Language")
  config.framework = extractField(techStack, "framework") || extractField(techStack, "Framework")
  config.database = extractField(techStack, "database") || extractField(techStack, "Database")
  // ... etc

  // Extract Conventions section
  const conventions = extractSection(claudeMdContent, "Conventions")
  config.naming = extractField(conventions, "naming") || {}
  config.style = extractField(conventions, "style") || {}

  // Extract Architecture section
  const architecture = extractSection(claudeMdContent, "Architecture")
  config.patterns = extractField(architecture, "patterns") || {}

  // Extract Quality Standards section
  const quality = extractSection(claudeMdContent, "Quality Standards")
  config.coverage = extractField(quality, "coverage") || {}
  config.accessibility = extractField(quality, "accessibility")

  return config
}
```

### Phase 2: Auto-Detect from Project

```javascript
// Pseudo-code for detection
function autoDetectConfig(projectRoot) {
  const config = {}

  // Parse package.json
  const packageJson = readPackageJson(projectRoot)
  config.framework = detectFramework(packageJson.dependencies)
  config.testFramework = detectTestFramework(packageJson.devDependencies)
  config.database = detectDatabase(packageJson.dependencies)
  // ... etc

  // Analyze code structure
  const codeFiles = glob(projectRoot, "**/*.{js,ts,jsx,tsx,py,rb}")
  config.naming = detectNamingConventions(codeFiles)
  config.structure = detectFileStructure(projectRoot)

  // Analyze test structure
  const testFiles = glob(projectRoot, "**/*.{test,spec}.*")
  config.testPatterns = detectTestPatterns(testFiles)
  config.testDirectory = detectTestDirectory(testFiles)

  return config
}
```

### Phase 3: Merge and Identify Gaps

```javascript
// Pseudo-code for merging
function mergeConfig(claudeConfig, autoDetected, defaults) {
  const merged = { ...defaults }

  // Auto-detected overrides defaults
  Object.assign(merged, autoDetected)

  // CLAUDE.md overrides auto-detected (highest priority)
  Object.assign(merged, claudeConfig)

  // Identify gaps (missing required fields)
  const gaps = findMissingFields(merged, REQUIRED_FIELDS)

  return { config: merged, gaps }
}
```

### Phase 4: Prompt for Gaps

```javascript
// Pseudo-code for prompting
async function promptForGaps(gaps) {
  const answers = {}

  for (const gap of gaps) {
    const prompt = getPromptForField(gap)
    const choices = getChoicesForField(gap)
    const defaultValue = getDefaultForField(gap)

    answers[gap] = await interactivePrompt(prompt, choices, defaultValue)
  }

  return answers
}
```

### Phase 5: Populate Templates

```javascript
// Pseudo-code for population
function populateTemplate(templateContent, config) {
  let populated = templateContent

  // Replace placeholders with config values
  for (const [key, value] of Object.entries(config)) {
    const placeholder = `{{${key.toUpperCase()}}}`
    populated = populated.replace(new RegExp(placeholder, 'g'), value)
  }

  // Remove TODO sections (they're replaced by config)
  populated = removeTodoSections(populated)

  return populated
}
```

---

## Example Configuration

### Sample CLAUDE.md (User Provides)

```markdown
## Tech Stack
- **Language**: JavaScript (Node.js 18)
- **Framework**: Express 4.x
- **Database**: PostgreSQL 15
- **ORM**: Prisma
- **Testing**: Jest
- **Frontend**: React 18 with TypeScript

## Conventions
- **Naming**: camelCase for variables/functions, PascalCase for classes
- **Style**: 2 spaces, single quotes, semicolons required
- **Imports**: Group by external → internal → relative

## Architecture
- **Service Layer**: Class-based services with dependency injection
- **Error Handling**: Custom error classes with middleware
- **Validation**: Zod for runtime validation
- **Database**: Repository pattern with Prisma

## Quality Standards
- **Coverage**: 85% lines, 80% branches minimum
- **Accessibility**: WCAG 2.1 AA compliance
```

### Resulting Agent Configuration

**codeImplementer agent** populated with:
- Language: JavaScript (Node.js 18)
- Framework: Express 4.x
- Service pattern: Class-based with DI
- Error handling: Custom classes + middleware
- Validation: Zod

**testEngineer agent** populated with:
- Framework: Jest
- Coverage: 85% lines, 80% branches
- Test directory: tests/ (detected)
- Commands: npm test (from package.json)

**uiDeveloper agent** populated with:
- Framework: React 18
- TypeScript: Yes
- State: Context API (default, not specified)
- Accessibility: WCAG 2.1 AA

---

## Template Placeholder Format

All placeholders use double curly braces: `{{PLACEHOLDER_NAME}}`

**Special placeholders:**
- `{{TODO_SECTION_START}}` and `{{TODO_SECTION_END}}` - Removed during population
- `{{OPTIONAL_SECTION_IF:condition}}` - Conditional sections

---

## Default Values

All placeholders have sensible defaults used when values cannot be extracted or detected.

### codeImplementer Defaults

```yaml
# Technology Stack
LANGUAGE: "JavaScript"
FRAMEWORK: "Express"
DATABASE: "PostgreSQL"
ORM: "Prisma"
VERSION: "Latest LTS"
LANGUAGE_EXT: "js"

# Naming Conventions
VAR_NAMING: "camelCase"
FUNC_NAMING: "camelCase"
CLASS_NAMING: "PascalCase"
CONST_NAMING: "UPPER_SNAKE_CASE"
FILE_NAMING: "kebab-case"

# Code Style
INDENTATION: "2 spaces"
LINE_LENGTH: "100"
QUOTES: "single"
SEMICOLONS: "required"
IMPORT_ORGANIZATION: "External modules → Internal modules → Relative imports"

# Common Patterns
SERVICE_PATTERN: "Class-based services with dependency injection"
ERROR_PATTERN: "Custom error classes with centralized error middleware"
VALIDATION_PATTERN: "Joi/Zod schema validation"
MIDDLEWARE_PATTERN: "Express-style middleware functions"
DB_ACCESS_PATTERN: "Repository pattern with ORM abstraction"

# File Templates
SERVICE_TEMPLATE: "class {{ServiceName}}Service { constructor() {} }"
MODEL_TEMPLATE: "export interface {{ModelName}} { id: string; }"
ROUTE_TEMPLATE: "router.{{method}}('{{path}}', {{handler}})"

# Specialist Triggers
DB_SPECIALIST_TRIGGER: "Complex queries, migrations, or query optimization needed"
API_SPECIALIST_TRIGGER: "External API integration or webhook processing required"
AUTH_SPECIALIST_TRIGGER: "Authentication/authorization logic implementation needed"
PERF_SPECIALIST_TRIGGER: "Performance requirements <100ms or high-load scenarios"
CUSTOM_SPECIALISTS: "No custom specialists defined"
```

### testEngineer Defaults

```yaml
# Testing Framework
TEST_FRAMEWORK: "Jest"
TEST_DIRECTORY: "tests/"
TEST_FILE_PATTERN: "*.test.js"
COVERAGE_TOOL: "jest --coverage"

# Test Commands
TEST_COMMAND: "npm test"
TEST_FILE_COMMAND: "npm test <file-path>"
COVERAGE_COMMAND: "npm test -- --coverage"
WATCH_COMMAND: "npm test -- --watch"

# Coverage Thresholds
MIN_LINES: "80"
MIN_BRANCHES: "75"
MIN_FUNCTIONS: "80"

# Test Patterns
TEST_FILE_NAMING: "*.test.js (or .spec.js)"
TEST_DESCRIPTION_PATTERN: "should [expected behavior] when [condition]"
TEST_SETUP_PATTERN: "beforeEach/afterEach for setup/teardown"
TEST_FIXTURES: "Stored in tests/fixtures/ directory"
MOCKING_STRATEGY: "Mock external dependencies, use real internal modules"
TEST_DATA_MANAGEMENT: "Test data in tests/data/, cleanup in afterEach hooks"

# Specialist Triggers
PERF_TEST_TRIGGER: "Load testing or performance benchmarking required"
SECURITY_TEST_TRIGGER: "Auth/crypto code or input validation testing needed"
INTEGRATION_TEST_TRIGGER: "Multi-service flows or external API testing required"
E2E_TEST_TRIGGER: "Full user journey or browser automation needed"
A11Y_TEST_TRIGGER: "Accessibility compliance testing required"
CUSTOM_TEST_SPECIALISTS: "No custom test specialists defined"
```

### uiDeveloper Defaults

```yaml
# UI Technology Stack
UI_FRAMEWORK: "React"
UI_LANGUAGE: "JavaScript"
UI_STYLING: "CSS Modules"
STATE_MANAGEMENT: "Context API"
BUILD_TOOL: "Vite"
UI_VERSION: "18"
UI_LANGUAGE_EXT: "jsx"

# Component Conventions
COMPONENT_TYPE: "Functional components with hooks"
FILE_ORGANIZATION: "One component per file with index exports"
COMPONENT_NAMING: "PascalCase for components, camelCase for instances"
PROPS_INTERFACE_EXAMPLE: "interface Props { title: string; onClick: () => void; }"
LOCAL_STATE_PATTERN: "useState hook"
GLOBAL_STATE_PATTERN: "React Context"
SERVER_STATE_PATTERN: "fetch with useEffect"
EVENT_HANDLER_NAMING: "handleClick, handleSubmit pattern"
EVENT_HANDLER_PATTERN: "Extract for reuse, inline for simple cases"

# Styling Conventions
CSS_FILE_STRUCTURE: "Co-located with components (Button.module.css)"
CSS_NAMING_CONVENTION: "CSS Modules (local scope by default)"
RESPONSIVE_BREAKPOINTS: "mobile: 320px, tablet: 768px, desktop: 1024px"
COLOR_TOKENS: "CSS custom properties in :root"
SPACING_SCALE: "0.25rem base unit (4px)"
TYPOGRAPHY_SCALE: "1rem base, 1.5 line-height"
STYLING_EXAMPLE: "import styles from './Component.module.css';"

# Accessibility Standards
SEMANTIC_HTML_REQUIREMENT: "Always use appropriate elements (button, nav, header)"
ARIA_USAGE_PATTERN: "Use ARIA only when semantic HTML insufficient"
KEYBOARD_NAV_REQUIREMENT: "All interactive elements keyboard-accessible"
COLOR_CONTRAST_RATIO: "WCAG AA: 4.5:1 for text, 3:1 for large text"
ALT_TEXT_REQUIREMENT: "All images must have descriptive alt text"
A11Y_TESTING_TOOLS: "jest-axe for automated testing"
A11Y_MANUAL_TESTING: "Keyboard navigation and screen reader checks"
SKIP_LINK_PATTERN: "Provide skip to main content link"
FOCUS_MANAGEMENT_PATTERN: "Trap focus in modals, return focus on close"
ARIA_LIVE_PATTERN: "Use aria-live for dynamic content updates"

# Common UI Patterns
FORM_PATTERN: "Controlled inputs with validation on submit"
BUTTON_PATTERN: "Primary, secondary, and tertiary variants"
MODAL_PATTERN: "Portal-based with focus trap and ESC to close"
LOADING_PATTERN: "Skeleton screens or spinners with aria-busy"
ERROR_PATTERN: "Inline error messages with role=alert"
RESPONSIVE_PATTERN: "Mobile-first responsive design"

# Specialist Triggers
A11Y_SPECIALIST_TRIGGER: "WCAG AAA compliance or complex ARIA patterns needed"
ANIMATION_SPECIALIST_TRIGGER: "Complex animations or gesture interactions required"
RESPONSIVE_SPECIALIST_TRIGGER: "Advanced multi-device layouts needed"
DATA_VIZ_SPECIALIST_TRIGGER: "Charts, graphs, or data visualizations required"
FORM_SPECIALIST_TRIGGER: "Multi-step forms or complex validation needed"
CUSTOM_UI_SPECIALISTS: "No custom UI specialists defined"
```

---

## Version

**Schema Version**: 1.0
**Last Updated**: 2025-10-06
