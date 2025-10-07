# Configuration Extraction Specification

**Purpose**: Extract project configuration from CLAUDE.md and package.json for Phase 1.5 of `/cf:init`.

**Status**: Specification (Hybrid/Option C implementation)

---

## Overview

This module provides **simple extraction logic** for obvious configuration values. It does NOT attempt complex parsing or inference - that's reserved for Option A (Full Automation).

**Extraction Priority**:
1. CLAUDE.md (explicit user configuration) - **HIGHEST**
2. package.json (dependency detection) - **MEDIUM**
3. Defaults from CONFIGURATION_SCHEMA.md - **LOWEST**

---

## CLAUDE.md Extraction

### Supported Sections

**Tech Stack Section**:
Look for patterns:
```
## Tech Stack
- **Language**: JavaScript
- Language: Python
- **Framework**: Express
- Framework: Flask
```

**Extract using regex patterns**:
- `/\*\*Language\*\*:\s*(\w+)/i` OR `/Language:\s*(\w+)/i`
- `/\*\*Framework\*\*:\s*([\w\.]+)/i` OR `/Framework:\s*([\w\.]+)/i`
- `/\*\*Database\*\*:\s*(\w+)/i` OR `/Database:\s*(\w+)/i`
- `/\*\*Testing\*\*:\s*(\w+)/i` OR `/Testing:\s*(\w+)/i`
- `/\*\*Frontend\*\*:\s*([\w\s]+)/i` OR `/Frontend:\s*([\w\s]+)/i`

**Maps to placeholders**:
- Language → `LANGUAGE`
- Framework → `FRAMEWORK` (backend) or `UI_FRAMEWORK` (if frontend context)
- Database → `DATABASE`
- Testing → `TEST_FRAMEWORK`
- Frontend → `UI_FRAMEWORK`

### Conventions Section

**Extract naming conventions** (if explicitly stated):
```
## Conventions
- Variables: camelCase
- Naming: snake_case for variables
```

**Patterns**:
- `/Variables?:\s*(\w+)/i` → `VAR_NAMING`
- `/Functions?:\s*(\w+)/i` → `FUNC_NAMING`
- `/Classes?:\s*(\w+)/i` → `CLASS_NAMING`

### Quality Standards Section

**Extract coverage thresholds**:
```
## Quality Standards
- Coverage: 85% lines, 80% branches
- Minimum coverage: 90%
```

**Patterns**:
- `/(\d+)%?\s*lines?/i` → `MIN_LINES`
- `/(\d+)%?\s*branches?/i` → `MIN_BRANCHES`
- `/(\d+)%?\s*functions?/i` → `MIN_FUNCTIONS`

---

## package.json Detection

### Framework Detection

**Backend Frameworks** (from `dependencies`):
```javascript
if (dependencies.express) → FRAMEWORK = "Express"
if (dependencies.fastify) → FRAMEWORK = "Fastify"
if (dependencies.nestjs || dependencies["@nestjs/core"]) → FRAMEWORK = "NestJS"
if (dependencies.koa) → FRAMEWORK = "Koa"
if (dependencies.hapi || dependencies["@hapi/hapi"]) → FRAMEWORK = "Hapi"
```

**Frontend Frameworks** (from `dependencies`):
```javascript
if (dependencies.react) → UI_FRAMEWORK = "React"
if (dependencies.vue) → UI_FRAMEWORK = "Vue"
if (dependencies.angular || dependencies["@angular/core"]) → UI_FRAMEWORK = "Angular"
if (dependencies.svelte) → UI_FRAMEWORK = "Svelte"
if (dependencies["next"]) → UI_FRAMEWORK = "Next.js" (also sets FRAMEWORK)
```

### Database Detection

**From `dependencies`**:
```javascript
if (dependencies.pg) → DATABASE = "PostgreSQL"
if (dependencies.mysql || dependencies.mysql2) → DATABASE = "MySQL"
if (dependencies.mongodb || dependencies.mongoose) → DATABASE = "MongoDB"
if (dependencies.sqlite3 || dependencies["better-sqlite3"]) → DATABASE = "SQLite"
```

### ORM Detection

**From `dependencies`**:
```javascript
if (dependencies.prisma || dependencies["@prisma/client"]) → ORM = "Prisma"
if (dependencies.typeorm) → ORM = "TypeORM"
if (dependencies.sequelize) → ORM = "Sequelize"
if (dependencies.mongoose) → ORM = "Mongoose"
```

### Testing Framework Detection

**From `devDependencies`**:
```javascript
if (devDependencies.jest) → TEST_FRAMEWORK = "Jest"
if (devDependencies.vitest) → TEST_FRAMEWORK = "Vitest"
if (devDependencies.mocha) → TEST_FRAMEWORK = "Mocha"
if (devDependencies.pytest) → TEST_FRAMEWORK = "pytest" (Python project)
```

### Language Detection

**From file extensions** (simple heuristic):
```javascript
// Check if package.json exists → likely JavaScript/TypeScript
if (dependencies.typescript || devDependencies.typescript) → LANGUAGE = "TypeScript", UI_LANGUAGE = "TypeScript"
else if (package.json exists) → LANGUAGE = "JavaScript"

// Check for other language markers
if (pyproject.toml or requirements.txt exists) → LANGUAGE = "Python"
if (Gemfile exists) → LANGUAGE = "Ruby"
if (go.mod exists) → LANGUAGE = "Go"
```

---

## Extraction Algorithm

### Step 1: Load Files

```javascript
function extractConfiguration(projectRoot) {
  const config = {}

  // Try to load CLAUDE.md
  const claudeMdPath = path.join(projectRoot, 'CLAUDE.md')
  const claudeMdContent = fileExists(claudeMdPath) ? readFile(claudeMdPath) : null

  // Try to load package.json
  const packageJsonPath = path.join(projectRoot, 'package.json')
  const packageJson = fileExists(packageJsonPath) ? JSON.parse(readFile(packageJsonPath)) : null

  return { claudeMdContent, packageJson }
}
```

### Step 2: Extract from CLAUDE.md

```javascript
function extractFromClaudeMd(content) {
  if (!content) return {}

  const config = {}

  // Extract Tech Stack section
  const techStackMatch = content.match(/##\s*Tech\s*Stack([\s\S]*?)(?=##|$)/i)
  if (techStackMatch) {
    const techStack = techStackMatch[1]

    // Language
    const langMatch = techStack.match(/\*?\*?Language\*?\*?:\s*(\w+)/i)
    if (langMatch) config.LANGUAGE = langMatch[1]

    // Framework
    const frameworkMatch = techStack.match(/\*?\*?Framework\*?\*?:\s*([\w\s\.]+)/i)
    if (frameworkMatch) config.FRAMEWORK = frameworkMatch[1].trim()

    // Database
    const dbMatch = techStack.match(/\*?\*?Database\*?\*?:\s*(\w+)/i)
    if (dbMatch) config.DATABASE = dbMatch[1]

    // Testing
    const testMatch = techStack.match(/\*?\*?Testing\*?\*?:\s*(\w+)/i)
    if (testMatch) config.TEST_FRAMEWORK = testMatch[1]

    // Frontend (for UI framework)
    const frontendMatch = techStack.match(/\*?\*?Frontend\*?\*?:\s*([\w\s]+)/i)
    if (frontendMatch) config.UI_FRAMEWORK = frontendMatch[1].trim()
  }

  // Extract Quality Standards (coverage)
  const qualityMatch = content.match(/##\s*Quality\s*Standards([\s\S]*?)(?=##|$)/i)
  if (qualityMatch) {
    const quality = qualityMatch[1]

    const linesMatch = quality.match(/(\d+)%?\s*lines?/i)
    if (linesMatch) config.MIN_LINES = linesMatch[1]

    const branchesMatch = quality.match(/(\d+)%?\s*branches?/i)
    if (branchesMatch) config.MIN_BRANCHES = branchesMatch[1]

    const functionsMatch = quality.match(/(\d+)%?\s*functions?/i)
    if (functionsMatch) config.MIN_FUNCTIONS = functionsMatch[1]
  }

  return config
}
```

### Step 3: Detect from package.json

```javascript
function detectFromPackageJson(packageJson) {
  if (!packageJson) return {}

  const config = {}
  const deps = packageJson.dependencies || {}
  const devDeps = packageJson.devDependencies || {}

  // Framework detection
  if (deps.express) config.FRAMEWORK = "Express"
  else if (deps.fastify) config.FRAMEWORK = "Fastify"
  else if (deps["@nestjs/core"]) config.FRAMEWORK = "NestJS"

  // Frontend framework
  if (deps.react) config.UI_FRAMEWORK = "React"
  else if (deps.vue) config.UI_FRAMEWORK = "Vue"
  else if (deps["@angular/core"]) config.UI_FRAMEWORK = "Angular"

  // Database
  if (deps.pg) config.DATABASE = "PostgreSQL"
  else if (deps.mysql || deps.mysql2) config.DATABASE = "MySQL"
  else if (deps.mongodb || deps.mongoose) config.DATABASE = "MongoDB"

  // ORM
  if (deps["@prisma/client"]) config.ORM = "Prisma"
  else if (deps.typeorm) config.ORM = "TypeORM"
  else if (deps.sequelize) config.ORM = "Sequelize"

  // Testing
  if (devDeps.jest) config.TEST_FRAMEWORK = "Jest"
  else if (devDeps.vitest) config.TEST_FRAMEWORK = "Vitest"
  else if (devDeps.mocha) config.TEST_FRAMEWORK = "Mocha"

  // Language (from TypeScript presence)
  if (deps.typescript || devDeps.typescript) {
    config.LANGUAGE = "TypeScript"
    config.UI_LANGUAGE = "TypeScript"
  } else if (packageJson) {
    config.LANGUAGE = "JavaScript"
  }

  return config
}
```

### Step 4: Merge Configuration

```javascript
function mergeConfiguration(claudeConfig, packageConfig, defaults) {
  // Priority: CLAUDE.md > package.json > defaults
  const merged = { ...defaults }

  // Apply package.json detections
  for (const [key, value] of Object.entries(packageConfig)) {
    if (value) merged[key] = value
  }

  // Apply CLAUDE.md extractions (highest priority)
  for (const [key, value] of Object.entries(claudeConfig)) {
    if (value) merged[key] = value
  }

  return merged
}
```

---

## Output Format

```javascript
{
  // What was extracted
  extracted: {
    fromClaudeMd: { LANGUAGE: "JavaScript", FRAMEWORK: "Express", ... },
    fromPackageJson: { DATABASE: "PostgreSQL", TEST_FRAMEWORK: "Jest", ... }
  },

  // Final merged configuration
  config: {
    LANGUAGE: "JavaScript",  // from CLAUDE.md
    FRAMEWORK: "Express",    // from CLAUDE.md
    DATABASE: "PostgreSQL",  // from package.json
    TEST_FRAMEWORK: "Jest",  // from package.json
    MIN_LINES: "80",         // from defaults
    ...
  },

  // Gaps (using defaults)
  gaps: ["MIN_LINES", "VAR_NAMING", "INDENTATION"]
}
```

---

## Usage in /cf:init

```javascript
// Phase 1.5: Agent Configuration

// 1. Extract configuration
const { extracted, config, gaps } = extractConfiguration(projectRoot)

// 2. Display what was found
console.log("✓ Detected from CLAUDE.md:")
for (const [key, value] of Object.entries(extracted.fromClaudeMd)) {
  console.log(`  - ${key}: ${value}`)
}

console.log("✓ Detected from package.json:")
for (const [key, value] of Object.entries(extracted.fromPackageJson)) {
  console.log(`  - ${key}: ${value}`)
}

console.log("⚙️ Using defaults for:")
for (const key of gaps) {
  console.log(`  - ${key}: ${config[key]} (no explicit config found)`)
}

// 3. Proceed to template population with merged config
```

---

## Limitations (By Design)

This is **Option C (Hybrid)** - intentionally simple:

❌ **Does NOT**:
- Parse complex CLAUDE.md structures
- Infer conventions from code analysis
- Detect patterns from file structure
- Use LLM/AI for extraction
- Handle edge cases or ambiguity

✅ **DOES**:
- Extract obvious key-value pairs from CLAUDE.md
- Detect common dependencies from package.json
- Provide sensible defaults for everything else
- Keep extraction logic simple and fast (<1 second)

For advanced extraction, see **Option A (Full Automation)** roadmap.

---

## Version

**Spec Version**: 1.0 (Hybrid/Option C)
**Last Updated**: 2025-10-06
**Implementation**: Pseudo-code specification for reference
