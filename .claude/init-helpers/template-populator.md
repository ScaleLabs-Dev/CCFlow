# Template Population Specification

**Purpose**: Replace {{PLACEHOLDER}} markers in agent templates with actual configuration values during Phase 1.5 of `/cf:init`.

**Status**: Specification (Hybrid/Option C implementation)

---

## Overview

This module takes:
1. **Template content** (with {{PLACEHOLDER}} markers)
2. **Configuration values** (from extraction + defaults)
3. **Output**: Fully configured agent content

**Simple replacement logic** - no complex templating engine needed for Option C.

---

## Placeholder Format

**Standard Placeholder**: `{{PLACEHOLDER_NAME}}`

**Examples**:
- `{{LANGUAGE}}` → Replaced with "JavaScript"
- `{{TEST_FRAMEWORK}}` → Replaced with "Jest"
- `{{MIN_LINES}}` → Replaced with "80"

**Case-sensitive**: Placeholders must match exactly.

---

## Replacement Algorithm

### Step 1: Load Template

```javascript
function populateTemplate(templatePath, config) {
  // Read template file
  let content = readFile(templatePath)

  // Replace all placeholders
  for (const [key, value] of Object.entries(config)) {
    const placeholder = `{{${key}}}`
    const regex = new RegExp(escapeRegex(placeholder), 'g')
    content = content.replace(regex, value)
  }

  return content
}
```

### Step 2: Replace Placeholders

**Simple string replacement**:
```javascript
// For each config key-value pair
for (const [key, value] of Object.entries(config)) {
  const placeholder = `{{${key}}}`

  // Global replacement (all occurrences)
  content = content.replaceAll(placeholder, value)
}
```

**Escape special regex characters** (if using regex):
```javascript
function escapeRegex(str) {
  return str.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')
}
```

### Step 3: Handle Missing Placeholders

**If placeholder not in config** → Leave as-is (will show {{MISSING}} in output)

**Better approach**: Warn about missing placeholders
```javascript
// After replacement, check for remaining placeholders
const remainingPlaceholders = content.match(/{{[A-Z_]+}}/g)

if (remainingPlaceholders && remainingPlaceholders.length > 0) {
  console.warn(`⚠️ Warning: Unresolved placeholders in ${templatePath}:`)
  remainingPlaceholders.forEach(p => console.warn(`  - ${p}`))
}
```

---

## Template Processing

### 1. Load All Templates

```javascript
function loadTemplates(templatesDir) {
  return {
    workflow: glob(`${templatesDir}/workflow/*.template.md`),
    implementation: glob(`${templatesDir}/implementation/*.template.md`)
  }
}
```

### 2. Populate Each Template

```javascript
function populateAllTemplates(templates, config) {
  const populated = {
    workflow: [],
    implementation: []
  }

  // Workflow agents (already generic, just copy)
  for (const templatePath of templates.workflow) {
    const content = readFile(templatePath)
    // Workflow agents have no placeholders, just copy
    populated.workflow.push({
      name: basename(templatePath, '.template.md'),
      content: content
    })
  }

  // Implementation agents (replace placeholders)
  for (const templatePath of templates.implementation) {
    const content = populateTemplate(templatePath, config)
    populated.implementation.push({
      name: basename(templatePath, '.template.md'),
      content: content
    })
  }

  return populated
}
```

### 3. Write Configured Agents

```javascript
function writeConfiguredAgents(populated, outputDir) {
  // Create output directories
  mkdir(`${outputDir}/workflow`)
  mkdir(`${outputDir}/development`)
  mkdir(`${outputDir}/testing`)
  mkdir(`${outputDir}/ui`)

  // Write workflow agents
  for (const agent of populated.workflow) {
    const outputPath = `${outputDir}/workflow/${agent.name}.md`
    writeFile(outputPath, agent.content)
  }

  // Write implementation agents
  const agentDirs = {
    'codeImplementer': 'development',
    'testEngineer': 'testing',
    'uiDeveloper': 'ui'
  }

  for (const agent of populated.implementation) {
    const dir = agentDirs[agent.name]
    const outputPath = `${outputDir}/${dir}/${agent.name}.md`
    writeFile(outputPath, agent.content)
  }

  // Create empty specialists directories
  mkdir(`${outputDir}/development/specialists`)
  mkdir(`${outputDir}/testing/specialists`)
  mkdir(`${outputDir}/ui/specialists`)
}
```

---

## Full Workflow

```javascript
// Phase 1.5: Agent Configuration

// 1. Extract configuration
const { config } = extractConfiguration(projectRoot)

// 2. Load templates
const templates = loadTemplates('.claude/templates/agents')

// 3. Populate templates
const populated = populateAllTemplates(templates, config)

// 4. Write to .claude/agents/
writeConfiguredAgents(populated, '.claude/agents')

// 5. Summary
console.log("✅ AGENTS CONFIGURED SUCCESSFULLY")
console.log("")
console.log("Implementation agents customized for your project:")
console.log(`- Language: ${config.LANGUAGE}`)
console.log(`- Framework: ${config.FRAMEWORK}`)
console.log(`- Testing: ${config.TEST_FRAMEWORK}`)
console.log("")
console.log("Agents saved to: .claude/agents/")
```

---

## Example: codeImplementer Population

**Template** (`.claude/templates/agents/implementation/codeImplementer.template.md`):
```yaml
### Technology Stack
language: "{{LANGUAGE}}"
framework: "{{FRAMEWORK}}"
database: "{{DATABASE}}"
```

**Configuration**:
```javascript
{
  LANGUAGE: "TypeScript",
  FRAMEWORK: "NestJS",
  DATABASE: "PostgreSQL"
}
```

**Output** (`.claude/agents/development/codeImplementer.md`):
```yaml
### Technology Stack
language: "TypeScript"
framework: "NestJS"
database: "PostgreSQL"
```

---

## Handling Special Cases

### Multi-line Values

Some placeholders may contain multi-line text:
```javascript
config.SERVICE_TEMPLATE = `class ServiceName {
  constructor() {}

  async execute() {
    // Implementation
  }
}`
```

**Replacement works the same**:
```
{{SERVICE_TEMPLATE}}
```
→
```
class ServiceName {
  constructor() {}

  async execute() {
    // Implementation
  }
}
```

### Empty Values

If a value is empty or undefined:
```javascript
config.ORM = ""  // User has no ORM
```

**Options**:
1. Replace with empty string (default)
2. Replace with placeholder like "None" or "Not configured"
3. Leave {{PLACEHOLDER}} as-is to show it's not set

**Recommended**: Use "None" or descriptive empty value
```javascript
function sanitizeValue(value) {
  if (!value || value.trim() === '') {
    return "Not configured"
  }
  return value
}
```

### Language Extensions

Some placeholders determine code block language:
```
```{{LANGUAGE_EXT}}
{{SERVICE_TEMPLATE}}
```
```

**Configuration**:
```javascript
if (config.LANGUAGE === "TypeScript") {
  config.LANGUAGE_EXT = "ts"
} else if (config.LANGUAGE === "JavaScript") {
  config.LANGUAGE_EXT = "js"
} else if (config.LANGUAGE === "Python") {
  config.LANGUAGE_EXT = "py"
}
```

---

## Validation

### Before Writing

Check that all critical placeholders were replaced:
```javascript
const criticalPlaceholders = [
  'LANGUAGE',
  'FRAMEWORK',
  'TEST_FRAMEWORK',
  'UI_FRAMEWORK'
]

function validatePopulation(content, config) {
  const errors = []

  for (const key of criticalPlaceholders) {
    if (!config[key] || config[key] === '') {
      errors.push(`Missing critical configuration: ${key}`)
    }
  }

  // Check for unreplaced placeholders in content
  const unreplaced = content.match(/{{[A-Z_]+}}/g)
  if (unreplaced) {
    errors.push(`Unreplaced placeholders: ${unreplaced.join(', ')}`)
  }

  return errors
}
```

### Error Handling

```javascript
const errors = validatePopulation(populated.content, config)

if (errors.length > 0) {
  console.error("⚠️ Agent Configuration Issues:")
  errors.forEach(err => console.error(`  - ${err}`))
  console.error("")
  console.error("Agents may not work correctly. Consider:")
  console.error("- Adding missing config to CLAUDE.md")
  console.error("- Running with defaults (may need manual adjustment)")

  // Ask user: Continue or abort?
}
```

---

## Performance

**Optimization for large templates**:
- Use single-pass replacement (iterate config, not template lines)
- Compile regex patterns once, reuse
- Stream large files if needed

**Current approach is fine for**:
- Templates ~500-1000 lines each
- ~50 placeholders total
- Completes in <100ms

---

## Testing

**Unit test examples**:
```javascript
// Test 1: Basic replacement
const template = "language: {{LANGUAGE}}"
const config = { LANGUAGE: "JavaScript" }
const result = populateTemplate(template, config)
assert(result === "language: JavaScript")

// Test 2: Multiple occurrences
const template = "{{LANG}} uses {{LANG}} syntax"
const config = { LANG: "Python" }
const result = populateTemplate(template, config)
assert(result === "Python uses Python syntax")

// Test 3: Unreplaced placeholders
const template = "{{KNOWN}} and {{UNKNOWN}}"
const config = { KNOWN: "value" }
const result = populateTemplate(template, config)
assert(result === "value and {{UNKNOWN}}")
```

---

## Integration with /cf:init

**Phase 1.5 Step 5** (in init.md):
```markdown
**Step 5: Load and Populate Agent Templates**

Loading templates from .claude/templates/agents/...
✓ codeImplementer.template.md
✓ testEngineer.template.md
✓ uiDeveloper.template.md
✓ Workflow agents (6 files)

Populating with project configuration...
- Replacing {{LANGUAGE}} with JavaScript
- Replacing {{FRAMEWORK}} with Express
- Replacing {{TEST_FRAMEWORK}} with Jest
[... all replacements logged ...]

Writing configured agents to .claude/agents/...
✓ .claude/agents/development/codeImplementer.md (fully configured)
✓ .claude/agents/testing/testEngineer.md (fully configured)
✓ .claude/agents/ui/uiDeveloper.md (fully configured)
✓ .claude/agents/workflow/ (6 agents copied)
✓ .claude/agents/*/specialists/ (empty, ready for specialists)
```

---

## Future Enhancements (Option A)

For full automation, add:
- **Conditional sections**: `{{#if HAS_DATABASE}}...{{/if}}`
- **Loops**: `{{#each PATTERNS}}...{{/each}}`
- **Computed values**: `{{TEST_COMMAND || "npm test"}}`
- **Template inheritance**: Base templates + overrides

Current simple replacement is sufficient for Option C.

---

## Version

**Spec Version**: 1.0 (Hybrid/Option C)
**Last Updated**: 2025-10-06
**Implementation**: Pseudo-code specification for reference
