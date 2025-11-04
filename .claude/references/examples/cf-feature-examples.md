# /cf:feature Command Examples

Extended examples demonstrating the Conditional Expert Pre-Analysis Pattern for `/cf:feature` command.

**Pattern**: Conditional Expert Pre-Analysis Pattern (systemPatterns.md:585-716)

---

## Example 1: Level 3 Complex Feature with Full Architect Analysis

**Scenario**: Real-time collaborative editing (integration + data + algorithm complexity)

```
User: /cf:feature implement real-time collaborative editing

Claude:
📋 LOADING CONTEXT
- Reading tasks.md (highest task: TASK-015)
- Next ID: TASK-016
- Tech stack: React, Node.js, WebSockets

---

🔍 INVOKING AGENTS

**Assessor**: Analyzing complexity... (scanning codebase)
**Architect**: Performing rapid technical pre-analysis... (Level 3 detected)
**Product**: Analyzing requirements... (receiving Architect analysis)

---

🎯 TASK CREATED: TASK-016

## Task: Implement real-time collaborative editing

**Complexity**: Level 3 (Complex Feature)
**Effort**: 1-2 days

---

### 📋 ASSESSMENT (Assessor)

**Scope**: ~12 files (WebSocket infrastructure, state sync, UI components, middleware)
**Risk**: Medium-High (complex state management, concurrency handling, WebSocket lifecycle)
**Keywords**: implement, real-time, collaborative

---

### 🏗️ TECHNICAL PRE-ANALYSIS (Architect)

**Integration Concerns**:
- Affected Components: Editor component, document state management, user session handling
- Integration Points: WebSocket server, Redis (for state sync), authentication middleware
- Pattern Impact: Event-driven architecture pattern, state synchronization pattern

**Data Modeling Needs**:
- Entities: Document, EditSession, User, ChangeOperation
- Relationships: Document has many EditSessions, EditSession belongs to User, ChangeOperation belongs to EditSession
- Schema Changes: New tables for edit_sessions, change_operations; document versioning field

**Algorithmic Complexity**:
- Computational Concerns: Operational Transformation (OT) or CRDT algorithm for conflict resolution - O(n) per operation
- Business Logic: Change merging, conflict detection, causality tracking require careful sequencing

**Technical Constraints**:
- Platform Limits: WebSocket connection limits (~1000 per server), requires horizontal scaling plan
- Security/Compliance: Authorization for document access, encrypted WebSocket connections (WSS)
- External Dependencies: Socket.io or WS library, Redis for pub/sub, potentially Yjs for CRDT

**Hidden Complexity Signals**:
- 🔴 HIGH: Operational Transformation algorithm - requires deep understanding or library (suggest Yjs/ShareDB)
- 🔴 HIGH: State synchronization across servers - requires Redis pub/sub or similar
- 🟡 MEDIUM: Connection lifecycle management - reconnection, heartbeat, cleanup
- 🟡 MEDIUM: Presence awareness - tracking who's editing, cursor positions
- 🟢 LOW: UI for showing other users' cursors

**Assumptions & Uncertainties**:
- Assuming single-document editing (not multi-document sessions)
- Assuming text editing (not rich media collaborative editing)
- Redis availability assumed for production (development may use in-memory)

---

### 🎯 USER VALUE (Product)

**Why This Matters**: Enables team collaboration, core differentiator for product, significant user value

**Acceptance Criteria**:
- [ ] Multiple users can edit same document simultaneously
- [ ] Changes propagate in real-time (<100ms latency)
- [ ] Conflict resolution handles concurrent edits gracefully
- [ ] User presence indicators show who's editing
- [ ] Offline users can rejoin without data loss
- [ ] OT/CRDT algorithm correctly merges concurrent edits (addressing Architect HIGH signal)
- [ ] Redis pub/sub synchronizes state across server instances (addressing Architect HIGH signal)
- [ ] All tests passing (unit, integration, E2E)
- [ ] Code reviewed

**Edge Cases**:
- Concurrent edits to same line (from Architect algorithmic complexity analysis)
- Network interruptions during edit (from Architect connection lifecycle concern)
- User disconnects mid-edit (from Architect connection lifecycle concern)
- Scaling to 10+ simultaneous users (from Architect platform limits)
- Server restart doesn't lose active sessions (from Architect state sync concern)

**Non-Functional**:
- Performance: <100ms latency for change propagation
- Scalability: Support 10+ concurrent users per document (Architect notes: requires horizontal scaling)
- Reliability: No data loss on network interruption
- Security: WSS encrypted connections, document authorization (from Architect constraints)

---

### 📊 MEMORY BANK

✓ tasks.md updated (TASK-016 created)
✓ activeContext.md updated (task logged, current focus set)

---

### ⏭️ NEXT STEP

→ **RECOMMENDATION**: This task requires planning before implementation.

**Proceed with**:
```bash
/cf:plan TASK-016 --interactive
```

Interactive planning will:
1. Facilitator guides multi-perspective exploration
2. Architect analyzes WebSocket architecture options
3. Product validates UX requirements
4. Task broken into phased sub-tasks
5. Implementation approach documented

**Alternative** (if requirements are clear):
```bash
/cf:plan TASK-016
```

Standard planning without interactive refinement.
```

---

## Example 2: Integration-Heavy Feature (Level 2)

**Scenario**: Feature that touches multiple existing components

```
User: /cf:feature add export functionality to dashboard

Claude:
📋 LOADING CONTEXT
- Reading tasks.md (highest task: TASK-020)
- Next ID: TASK-021
- Existing components: Dashboard, ReportGenerator, FileStorage, NotificationService

---

🔍 INVOKING AGENTS

**Assessor**: Analyzing complexity...
→ Level 2 detected (touches 4-5 existing components)

**Architect**: Performing rapid technical pre-analysis...
→ Reading systemPatterns.md to identify integration points

**Product**: Analyzing requirements (with Architect analysis)...

---

🎯 TASK CREATED: TASK-021

## Task: Add export functionality to dashboard

**Complexity**: Level 2 (Intermediate Feature)
**Effort**: 2-3 hours

---

### 📋 ASSESSMENT (Assessor)

**Scope**: ~5 files (dashboard UI, export service, file generation, notification)
**Risk**: Medium (integration complexity, file format handling)
**Keywords**: add, export, dashboard

---

### 🏗️ TECHNICAL PRE-ANALYSIS (Architect)

**Integration Concerns**:
- **Affected Components**: Dashboard (UI), ReportGenerator (backend), FileStorage (S3), NotificationService (email)
- **Integration Points**: Dashboard → ExportService → ReportGenerator → FileStorage + NotificationService
- **Pattern Impact**: Command Pattern (for export job), Observer Pattern (for completion notification)

**Data Modeling Needs**:
- **Entities**: ExportJob, ExportFormat, ExportDestination
- **Relationships**: ExportJob belongs to User, has one ExportFormat, has one ExportDestination
- **Schema Changes**: New export_jobs table with status tracking

**Algorithmic Complexity**:
- **Computational Concerns**: Large dataset exports may require pagination/streaming (O(n) but memory-bound)
- **Business Logic**: Format conversion (CSV, PDF, Excel) - each requires different library

**Technical Constraints**:
- **Platform Limits**: File size limits for S3 uploads (5GB), email attachment limits (25MB)
- **Security/Compliance**: User authorization for data export, audit logging required
- **External Dependencies**: csv-writer, pdfkit, exceljs libraries; S3 SDK

**Hidden Complexity Signals**:
- 🔴 **HIGH**: Multiple format support requires format-specific code paths (CSV/PDF/Excel each different)
- 🟡 **MEDIUM**: Large exports need background job processing (can't block UI thread)
- 🟡 **MEDIUM**: File storage integration requires error handling for S3 failures
- 🟢 **LOW**: Email notification uses existing NotificationService

**Assumptions & Uncertainties**:
- Assuming exports are user-initiated (not scheduled/automated)
- Assuming single export format per job (not multi-format)

---

### 🎯 USER VALUE (Product)

**Why This Matters**: Users need data portability for reporting, compliance, and offline analysis

**Acceptance Criteria**:
- [ ] Users can select export format (CSV, PDF, Excel) from dashboard
- [ ] Export generates file with current dashboard data
- [ ] File saved to user's storage location
- [ ] User receives email notification when export complete
- [ ] Export handles datasets up to 10,000 rows efficiently (addressing Architect MEDIUM signal)
- [ ] Format conversion uses appropriate libraries (addressing Architect HIGH signal)
- [ ] Authorization verified before export (addressing Architect security constraint)
- [ ] All tests passing
- [ ] Code reviewed

**Edge Cases**:
- Empty dataset export (from Architect data handling)
- Export failure mid-generation (from Architect S3 integration concern)
- User cancels export in progress (from Architect background job concern)
- File size exceeds email attachment limit (from Architect platform limits)

**Non-Functional**:
- Performance: Exports complete within 30 seconds for datasets <1000 rows
- Reliability: Failed exports don't leave orphaned files
- Security: Audit log records all export operations (from Architect compliance requirement)

---

→ **NEXT**: `/cf:plan TASK-021` (requires planning due to Level 2 complexity)
```

**Key Demonstration**: Integration analysis identifies 4 affected components and their interaction patterns. Product generates acceptance criteria addressing each technical concern (format libraries, background processing, S3 error handling).

---

## Example 3: Data Structure Feature (Level 2)

**Scenario**: Feature requiring new entities and relationships

```
User: /cf:feature implement team workspaces with shared resources

Claude:
🔍 INVOKING AGENTS

**Assessor**: Level 2 detected (new data model, 4-6 files)
**Architect**: Analyzing data modeling needs...
**Product**: Analyzing requirements...

---

🎯 TASK CREATED: TASK-022

---

### 🏗️ TECHNICAL PRE-ANALYSIS (Architect)

**Integration Concerns**:
- **Affected Components**: User authentication, Resource management, Permission system
- **Integration Points**: Existing user model, resource access control, billing system
- **Pattern Impact**: Multi-tenancy pattern, role-based access control (RBAC) pattern

**Data Modeling Needs**:
- **Entities**: Workspace, WorkspaceMember, WorkspaceResource, WorkspaceRole
- **Relationships**:
  - Workspace has many WorkspaceMembers (users can belong to multiple workspaces)
  - Workspace has many WorkspaceResources (many-to-many via workspace_resources join)
  - WorkspaceMember has one WorkspaceRole (owner, admin, member, viewer)
  - Resource belongs to Workspace (workspace_id foreign key)
- **Schema Changes**:
  - New tables: workspaces, workspace_members, workspace_resources, workspace_roles
  - Add workspace_id to resources table
  - Migration: existing users get personal workspace

**Algorithmic Complexity**:
- **Computational Concerns**: Permission checks on every resource access - requires caching (Redis)
- **Business Logic**: Nested permission inheritance (workspace → resource → user)

**Technical Constraints**:
- **Platform Limits**: Workspace member limit (100 per workspace), resource limit (1000 per workspace)
- **Security/Compliance**: Role-based access control, audit trail for workspace actions
- **External Dependencies**: None (uses existing PostgreSQL)

**Hidden Complexity Signals**:
- 🔴 **HIGH**: Data migration for existing resources → personal workspaces (requires careful batching)
- 🔴 **HIGH**: Permission model affects every resource query (N+1 query risk - needs optimization)
- 🟡 **MEDIUM**: Workspace deletion cascade rules (what happens to resources?)
- 🟡 **MEDIUM**: Billing integration (workspace-level vs user-level billing)
- 🟢 **LOW**: UI for workspace switcher

**Assumptions & Uncertainties**:
- Assuming workspace is primary tenant boundary (not organizations > workspaces)
- Assuming resources can only belong to one workspace (not shared across workspaces)

---

### 🎯 USER VALUE (Product)

**Acceptance Criteria**:
- [ ] Users can create workspaces with name and settings
- [ ] Users can invite members to workspace with specific roles
- [ ] Resources created in workspace context are accessible to all members
- [ ] Permission checks respect workspace membership (addressing Architect HIGH signal)
- [ ] Data migration creates personal workspaces for existing users (addressing Architect HIGH signal)
- [ ] Workspace deletion has configurable cascade behavior (addressing Architect MEDIUM signal)
- [ ] All tests passing
- [ ] Code reviewed

**Edge Cases**:
- User belongs to 10+ workspaces (from Architect permission caching concern)
- Workspace owner transfers ownership (from Architect role management)
- Last workspace admin leaves workspace (from Architect workspace lifecycle)
- Resource permissions conflict with workspace permissions (from Architect nested inheritance)
- Migration fails midway for some users (from Architect data migration concern)

**Non-Functional**:
- Performance: Permission checks cached, <10ms overhead per request
- Data Integrity: Migration transaction ensures all-or-nothing per user (from Architect concern)
- Security: RBAC enforced at database query level, not just UI

---

→ **NEXT**: `/cf:plan TASK-022` (complex data model requires detailed planning)
```

**Key Demonstration**: Data structure analysis maps out complete entity-relationship model with 4 entities, identifies data migration as HIGH priority concern, flags N+1 query risks requiring optimization.

---

## Example 4: Algorithmic Feature (Level 2)

**Scenario**: Feature with computational complexity concerns

```
User: /cf:feature add smart scheduling algorithm for resource allocation

Claude:
🔍 INVOKING AGENTS

**Assessor**: Level 2-3 detected (algorithm complexity, optimization required)
**Architect**: Analyzing algorithmic complexity...
**Product**: Analyzing requirements...

---

🎯 TASK CREATED: TASK-023

---

### 🏗️ TECHNICAL PRE-ANALYSIS (Architect)

**Integration Concerns**:
- **Affected Components**: Booking system, Resource manager, Calendar view
- **Integration Points**: Existing booking API, resource availability service, notification system
- **Pattern Impact**: Strategy pattern (for different scheduling algorithms), Queue pattern (for processing)

**Data Modeling Needs**:
- **Entities**: ScheduleRequest, ResourceAllocation, SchedulingConstraint, SchedulingResult
- **Relationships**: ScheduleRequest has many Constraints, generates one SchedulingResult with multiple Allocations
- **Schema Changes**: New scheduling_requests, resource_allocations tables

**Algorithmic Complexity**:
- **Computational Concerns**:
  - Constraint satisfaction problem (CSP) - NP-hard in general case
  - With n resources and m time slots: O(n^m) brute force, O(n*m) with greedy heuristics
  - Need timeout mechanism (max 5 seconds) and fallback strategy
- **Business Logic**:
  - Hard constraints: resource availability, capacity limits, booking conflicts
  - Soft constraints: preference matching, load balancing, proximity optimization
  - Optimization goal: maximize bookings OR minimize cost OR balance load

**Technical Constraints**:
- **Platform Limits**: Algorithm must complete <5 seconds (UI responsiveness), fallback if timeout
- **Security/Compliance**: Fair allocation (no discrimination), audit trail for decisions
- **External Dependencies**: Consider constraint solver library (e.g., OR-Tools, choco-solver) vs custom heuristic

**Hidden Complexity Signals**:
- 🔴 **HIGH**: Algorithm selection crucial - constraint solver vs greedy heuristic vs genetic algorithm
- 🔴 **HIGH**: Timeout and fallback strategy required (can't block indefinitely)
- 🟡 **MEDIUM**: Testing algorithm correctness requires property-based testing framework
- 🟡 **MEDIUM**: Performance varies wildly with input size - needs benchmarking suite
- 🟢 **LOW**: UI shows scheduling progress/status

**Assumptions & Uncertainties**:
- Assuming batch scheduling (not real-time incremental updates)
- Assuming single optimization goal (not multi-objective with weights)
- Algorithm library choice affects complexity significantly - needs investigation

---

### 🎯 USER VALUE (Product)

**Acceptance Criteria**:
- [ ] System automatically schedules resources based on requests and constraints
- [ ] Algorithm respects hard constraints (availability, capacity)
- [ ] Algorithm optimizes for defined goal (e.g., maximize utilization)
- [ ] Scheduling completes within 5 seconds OR returns partial result (addressing Architect timeout concern)
- [ ] Algorithm choice documented with rationale (addressing Architect HIGH signal)
- [ ] Performance benchmarks for various input sizes (addressing Architect MEDIUM signal)
- [ ] Property-based tests verify constraint satisfaction (addressing Architect testing concern)
- [ ] All tests passing
- [ ] Code reviewed

**Edge Cases**:
- No feasible solution exists (from Architect constraint satisfaction concern)
- Algorithm timeout with large input (from Architect performance concern)
- Tie-breaking when multiple valid solutions (from Architect optimization goal)
- Resource availability changes during scheduling (from Architect dynamic constraints)

**Non-Functional**:
- Performance: <5s for inputs up to 100 resources × 50 time slots (from Architect platform limit)
- Correctness: Property-based tests verify hard constraints never violated
- Explainability: Algorithm decisions auditable (from Architect compliance requirement)
- Fallback: Greedy heuristic used if optimal solver times out (from Architect HIGH signal)

---

→ **NEXT**: `/cf:creative TASK-023` (Level 3 complexity - algorithm requires creative exploration)
```

**Key Demonstration**: Algorithmic analysis identifies NP-hard constraint satisfaction problem, evaluates O(n^m) vs O(n*m) complexity trade-offs, suggests specific libraries (OR-Tools, choco-solver) vs custom heuristics.

---

## Pattern Summary

All examples demonstrate the Conditional Expert Pre-Analysis Pattern:

1. **Assessor** detects Level 2+ complexity
2. **Architect** performs 6-8 minute rapid pre-analysis (IDENTIFICATION, not SOLUTION):
   - Integration: Which components affected, what patterns apply
   - Data: Entities, relationships, schema changes, migrations
   - Algorithm: Computational concerns, complexity analysis
   - Constraints: Platform limits, security, dependencies
   - Signals: Prioritized HIGH/MEDIUM/LOW hidden complexity
3. **Product** receives Architect output → generates technically-informed:
   - Acceptance criteria addressing each HIGH/MEDIUM signal
   - Edge cases derived from technical analysis
   - NFRs related to constraints and complexity

**Key Value**: Technical pre-analysis catches hidden complexity (integration touchpoints, data migration needs, algorithmic challenges) BEFORE implementation, eliminating mid-coding "stop and spec" pauses.
