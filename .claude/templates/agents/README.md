# Agent Templates

## Purpose

This directory contains **generic agent templates** that are copied and configured for each project during `/cf:init`.

## Template Structure

```
.claude/templates/agents/
├── workflow/                    # Workflow agents (already generic, no customization needed)
│   ├── assessor.template.md
│   ├── architect.template.md
│   ├── product.template.md
│   ├── facilitator.template.md
│   ├── documentarian.template.md
│   └── reviewer.template.md
└── implementation/              # Implementation agents (with TODO placeholders)
    ├── codeImplementer.template.md
    ├── testEngineer.template.md
    └── uiDeveloper.template.md
```

## Template Files

### Workflow Agents (.template.md)

**Purpose**: Orchestration, planning, quality, and documentation management.

**Customization**: These agents are **already generic** and work for all project types. They are copied as-is during init (no placeholder replacement needed).

**Files**:
- `assessor.template.md` - Task complexity analysis and routing
- `architect.template.md` - Technical design and system architecture
- `product.template.md` - Requirements analysis and user needs
- `facilitator.template.md` - Interactive refinement and guided exploration
- `documentarian.template.md` - Memory bank maintenance and consistency
- `reviewer.template.md` - Code quality assessment and technical debt tracking

### Implementation Agents (.template.md)

**Purpose**: Code and test implementation, UI development.

**Customization**: These agents contain **TODO placeholders** that get replaced with project-specific configuration during Phase 1.5 of `/cf:init`.

**Files**:
- `codeImplementer.template.md` - Backend/business logic implementation
- `testEngineer.template.md` - TDD coordination and test verification
- `uiDeveloper.template.md` - UI component development

## Configuration Placeholders

Implementation agent templates use placeholders like `{{LANGUAGE}}`, `{{FRAMEWORK}}`, `{{TEST_FRAMEWORK}}`, etc.

During `/cf:init` Phase 1.5:
1. Extract config from CLAUDE.md
2. Auto-detect from package.json and code structure
3. Merge with priority: CLAUDE.md > Auto-detected > Defaults
4. Prompt for critical gaps only
5. Replace placeholders with actual values
6. Remove TODO sections (replaced by config)
7. Write fully-configured agents to project's `.claude/agents/`

See [CONFIGURATION_SCHEMA.md](./CONFIGURATION_SCHEMA.md) for complete mapping.

## Modifying Templates

### Workflow Agent Changes

Simply edit the `.template.md` files. No placeholders to maintain.

### Implementation Agent Changes

When adding new TODO sections:
1. Add placeholder: `{{NEW_PLACEHOLDER}}`
2. Document in [CONFIGURATION_SCHEMA.md](./CONFIGURATION_SCHEMA.md)
3. Update Phase 1.5 logic in [/cf:init](../../commands/cf/init.md)
4. Consider: CLAUDE.md section, auto-detection source, default value, prompt

### Testing Template Changes

After modifying templates:
1. Run `/cf:init` on a test project
2. Verify agents are properly configured
3. Check that placeholders are replaced
4. Verify TODO sections are removed
5. Test with different tech stacks (JS, Python, etc.)

## Future: Stack Presets (Optional)

Planned enhancement for quick-start with popular stacks:

```
.claude/templates/agents/
├── base/                        # Current generic templates
│   ├── workflow/
│   └── implementation/
└── presets/                     # Pre-configured for common stacks
    ├── react-express/           # Full MERN-like stack
    ├── python-django/           # Python web stack
    ├── vue-laravel/             # PHP web stack
    └── ...                      # Community contributions
```

During init, users could choose:
- Auto-detect (use CLAUDE.md + project structure)
- Custom (manual configuration)
- Preset (e.g., "React + Express")

## Version

**Template Version**: 1.0
**Last Updated**: 2025-10-06
**Compatible with**: CCFlow 1.0+
