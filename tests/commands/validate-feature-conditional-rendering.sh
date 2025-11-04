#!/bin/bash
# Validation for TASK-004-7: Conditional template rendering logic in /cf:feature Step 8
# Verifies has_technical_analysis flag computation and conditional section rendering

FEATURE_CMD=".claude/commands/cf/feature.md"
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "Validating /cf:feature Step 8 conditional rendering logic..."
echo ""

PASS=0
FAIL=0

# Test 1: has_technical_analysis flag computation present
if grep -q "has_technical_analysis = (complexity_level >= 2 AND architect_output exists)" "$FEATURE_CMD"; then
    echo -e "${GREEN}✓${NC} has_technical_analysis flag computation documented"
    PASS=$((PASS + 1))
else
    echo -e "${RED}✗${NC} has_technical_analysis flag computation missing"
    FAIL=$((FAIL + 1))
fi

# Test 2: Conditional rendering logic documented
if grep -q "Conditional Rendering Logic" "$FEATURE_CMD"; then
    echo -e "${GREEN}✓${NC} Conditional rendering logic section found"
    PASS=$((PASS + 1))
else
    echo -e "${RED}✗${NC} Conditional rendering logic section missing"
    FAIL=$((FAIL + 1))
fi

# Test 3: TRUE branch rendering (Level 2+)
if grep -q "IF has_technical_analysis == TRUE:" "$FEATURE_CMD"; then
    echo -e "${GREEN}✓${NC} TRUE branch (Level 2+) rendering logic present"
    PASS=$((PASS + 1))
else
    echo -e "${RED}✗${NC} TRUE branch (Level 2+) rendering logic missing"
    FAIL=$((FAIL + 1))
fi

# Test 4: FALSE branch rendering (Level 1)
if grep -q "IF has_technical_analysis == FALSE:" "$FEATURE_CMD"; then
    echo -e "${GREEN}✓${NC} FALSE branch (Level 1) rendering logic present"
    PASS=$((PASS + 1))
else
    echo -e "${RED}✗${NC} FALSE branch (Level 1) rendering logic missing"
    FAIL=$((FAIL + 1))
fi

# Test 5: Conditional Technical Pre-Analysis section structure
if grep -q "\[CONDITIONAL\] Technical Pre-Analysis" "$FEATURE_CMD"; then
    echo -e "${GREEN}✓${NC} Conditional Technical Pre-Analysis section marker present"
    PASS=$((PASS + 1))
else
    echo -e "${RED}✗${NC} Conditional Technical Pre-Analysis section marker missing"
    FAIL=$((FAIL + 1))
fi

# Test 6: IF has_technical_analysis conditional logic in Technical Pre-Analysis
if grep -q "IF has_technical_analysis:" "$FEATURE_CMD"; then
    echo -e "${GREEN}✓${NC} IF has_technical_analysis conditional in Technical Pre-Analysis"
    PASS=$((PASS + 1))
else
    echo -e "${RED}✗${NC} IF has_technical_analysis conditional missing"
    FAIL=$((FAIL + 1))
fi

# Test 7: ELSE branch for Level 1 (empty section)
if grep -q "ELSE (Level 1):" "$FEATURE_CMD"; then
    echo -e "${GREEN}✓${NC} ELSE branch for Level 1 empty section present"
    PASS=$((PASS + 1))
else
    echo -e "${RED}✗${NC} ELSE branch for Level 1 empty section missing"
    FAIL=$((FAIL + 1))
fi

# Test 8: Level 1 empty section message
if grep -q "This section is empty - the feature was assessed as Level 1" "$FEATURE_CMD"; then
    echo -e "${GREEN}✓${NC} Level 1 empty section message present"
    PASS=$((PASS + 1))
else
    echo -e "${RED}✗${NC} Level 1 empty section message missing"
    FAIL=$((FAIL + 1))
fi

# Test 9: Conditional criteria in Acceptance Criteria
CRITERIA_CONDITIONALS=$(grep -c "IF has_technical_analysis:" "$FEATURE_CMD")
if [ "$CRITERIA_CONDITIONALS" -ge 3 ]; then
    echo -e "${GREEN}✓${NC} Conditional logic in Acceptance Criteria, Edge Cases, NFRs (3+ occurrences)"
    PASS=$((PASS + 1))
else
    echo -e "${RED}✗${NC} Insufficient conditional logic occurrences ($CRITERIA_CONDITIONALS, expected >= 3)"
    FAIL=$((FAIL + 1))
fi

# Test 10: All 6 Architect subsections in TRUE branch
SUBSECTIONS_IN_TRUE=(
    "Integration Concerns"
    "Data Modeling Needs"
    "Algorithmic Complexity"
    "Technical Constraints"
    "Hidden Complexity Signals"
    "Assumptions & Uncertainties"
)

echo ""
echo "Checking Architect subsections in TRUE branch:"
SUBSECTION_PASS=0
for subsection in "${SUBSECTIONS_IN_TRUE[@]}"; do
    # Check if subsection appears in Step 8 context (after "Step 8:" and before "Step 9:")
    if sed -n '/^### Step 8:/,/^### Step 9:/p' "$FEATURE_CMD" | grep -q "### $subsection"; then
        echo -e "  ${GREEN}✓${NC} $subsection"
        SUBSECTION_PASS=$((SUBSECTION_PASS + 1))
    else
        echo -e "  ${RED}✗${NC} $subsection (missing from TRUE branch)"
    fi
done

if [ $SUBSECTION_PASS -eq 6 ]; then
    echo -e "${GREEN}✓${NC} All 6 Architect subsections present in TRUE branch"
    PASS=$((PASS + 1))
else
    echo -e "${RED}✗${NC} Only $SUBSECTION_PASS/6 Architect subsections found"
    FAIL=$((FAIL + 1))
fi

# Test 11: Notes section conditional logic
if grep -q "IF has_technical_analysis: Architect pre-analysis performed (Level 2+)" "$FEATURE_CMD"; then
    echo -e "${GREEN}✓${NC} Notes section conditional for Level 2+ present"
    PASS=$((PASS + 1))
else
    echo -e "${RED}✗${NC} Notes section conditional for Level 2+ missing"
    FAIL=$((FAIL + 1))
fi

if grep -q "ELSE: Direct to implementation (Level 1)" "$FEATURE_CMD"; then
    echo -e "${GREEN}✓${NC} Notes section conditional for Level 1 present"
    PASS=$((PASS + 1))
else
    echo -e "${RED}✗${NC} Notes section conditional for Level 1 missing"
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
    echo ""
    echo "Conditional rendering logic validated:"
    echo "  ✓ has_technical_analysis flag computation"
    echo "  ✓ TRUE branch (Level 2+): Full Technical Pre-Analysis"
    echo "  ✓ FALSE branch (Level 1): Empty section with note"
    echo "  ✓ Conditional criteria/edge cases/NFRs"
    echo "  ✓ All 6 Architect subsections in TRUE branch"
    exit 0
else
    echo -e "${RED}❌ TESTS FAILED${NC}"
    exit 1
fi
