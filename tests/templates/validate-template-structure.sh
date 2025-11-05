#!/bin/bash
# Simple validation for feature-task-template.md structure
# Verifies Technical Pre-Analysis section is correctly added

TEMPLATE=".claude/templates/workflow/feature-task-template.md"
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "Validating feature-task-template.md structure..."
echo ""

PASS=0
FAIL=0

# Test 1: Technical Pre-Analysis section exists
if grep -q "^## Technical Pre-Analysis" "$TEMPLATE"; then
    echo -e "${GREEN}✓${NC} Technical Pre-Analysis section found"
    PASS=$((PASS + 1))
else
    echo -e "${RED}✗${NC} Technical Pre-Analysis section missing"
    FAIL=$((FAIL + 1))
fi

# Test 2: Level 2+ conditional marker present
if grep -q "Level 2+" "$TEMPLATE"; then
    echo -e "${GREEN}✓${NC} Conditional rendering instruction present"
    PASS=$((PASS + 1))
else
    echo -e "${RED}✗${NC} Conditional rendering instruction missing"
    FAIL=$((FAIL + 1))
fi

# Test 3: All 6 required subsections present
SUBSECTIONS=(
    "### Integration Concerns"
    "### Data Modeling Needs"
    "### Algorithmic Complexity"
    "### Technical Constraints"
    "### Hidden Complexity Signals"
    "### Assumptions & Uncertainties"
)

echo ""
echo "Checking subsections:"
for subsection in "${SUBSECTIONS[@]}"; do
    if grep -q "^$subsection" "$TEMPLATE"; then
        echo -e "  ${GREEN}✓${NC} $subsection"
        PASS=$((PASS + 1))
    else
        echo -e "  ${RED}✗${NC} $subsection (missing)"
        FAIL=$((FAIL + 1))
    fi
done

# Test 4: Section ordering (Technical Pre-Analysis between Complexity Assessment and Edge Cases)
COMPLEXITY_LINE=$(grep -n "^## Complexity Assessment" "$TEMPLATE" | cut -d: -f1)
TECH_PRE_LINE=$(grep -n "^## Technical Pre-Analysis" "$TEMPLATE" | cut -d: -f1)
EDGE_CASES_LINE=$(grep -n "^## Edge Cases" "$TEMPLATE" | cut -d: -f1)

echo ""
if [ "$TECH_PRE_LINE" -gt "$COMPLEXITY_LINE" ] && [ "$TECH_PRE_LINE" -lt "$EDGE_CASES_LINE" ]; then
    echo -e "${GREEN}✓${NC} Section correctly positioned (line $TECH_PRE_LINE, between Complexity Assessment and Edge Cases)"
    PASS=$((PASS + 1))
else
    echo -e "${RED}✗${NC} Section positioning incorrect"
    FAIL=$((FAIL + 1))
fi

# Summary
echo ""
echo "================================"
echo "Validation Results:"
echo -e "${GREEN}Passed: $PASS${NC}"
echo -e "${RED}Failed: $FAIL${NC}"
echo "================================"

if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}✅ ALL TESTS PASSED (GREEN)${NC}"
    exit 0
else
    echo -e "${RED}❌ TESTS FAILED${NC}"
    exit 1
fi
