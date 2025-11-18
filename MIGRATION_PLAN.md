# PowerBuilder to Java Migration Plan
## Flight Calculation Service Migration

**Source:** `flightcalc/trunk/PBL/cbase_flight_calculation` (PowerBuilder)
**Target:** `cbase-service-parent/flightcalculation` (Java/Spring Boot)
**Migration Date:** November 2025

---

## Executive Summary

This plan outlines the migration of the PowerBuilder-based `cbase_flight_calculation` service (~13,440 lines in main business object) to the existing Java Spring Boot service infrastructure in `cbase-service-parent/flightcalculation`.

---

## 1. Current State Analysis

### 1.1 PowerBuilder Service Components

#### Main Application Files
- **`cbase_flight_calculation.sra`** (17K) - Application entry point, service initialization
- **`f_loop.srf`** (7.8K) - Main service loop that processes flight calculations
- **`f_profile.srf`** (7.1K) - Configuration/profile management

#### Core Business Logic
- **`uo_flight_calculation.sru`** (13,440 lines!) - Main business object containing:
  - Flight calculation processing (`of_process_row`)
  - Record locking mechanism (`of_lock_record`)
  - History tracking (`of_write_history`)
  - Master change handling (`wf_chc_master_change`)
  - PAX calculation (`wf_chc_change_pax`)
  - SPML handling (`wf_chc_change_spml`)
  - Meal calculation (`wf_chc_change_handling`, `wf_chc_force_meal_calculation`)
  - Aircraft version management
  - Transaction management

#### Supporting Functions (28 functions total)
- **Database Connection:** `f_connect.srf`, `f_connect_log.srf`
- **Logging:** `f_log.srf`, `f_trace.srf`
- **Service Management:** `f_set_service_protocol.srf`, `f_set_logon_role.srf`
- **Utility Functions:** Various helper functions for token parsing, calendar calculations, etc.

#### DataWindows/UI (for GUI mode)
- `dw_screen_job_list_*.srd` - Job list displays
- `dw_setup_*.srd` - Setup/configuration screens
- `w_main_window.srw` - Main window
- `w_setup.srw` - Setup window

#### User Objects
- `uo_cbase_functions.sru` - CBASE helper functions
- `uo_cbase_datastore.sru` - Custom datastore implementation
- `uo_generate_datastore.sru` - Datastore generator
- `uo_comctl_statusbar.sru` - Status bar control

### 1.2 Java Target Architecture

#### Existing Structure
```
cbase-service-parent/
├── domain/                          # JPA entities (677 files)
│   └── src/main/java/.../persistence/
│       ├── constant/flightcalc/     # Enums already defined
│       │   ├── FlightCalcFunction.java
│       │   ├── FlightCalcProcessState.java
│       │   ├── FlightCalcModifier.java
│       │   └── FlightCalcHistory.java
│       └── domain/                  # JPA entities
│           ├── CenOutPpmFlights.java
│           ├── SysQueueFlightCalc.java
│           ├── SysQueueFlightPax.java
│           ├── SysQueueFlightMeals.java
│           └── [many more entities...]
│
├── persistence/                     # Repository base classes
│   └── CbaseMiddlewareRepository.java
│
├── common/                          # Shared services & utilities
│
├── base/                            # Base classes & exceptions
│
└── flightcalculation/               # TARGET MODULE
    ├── pom.xml
    └── src/main/java/.../flightcalculation/
        ├── FlightCalculationApplication.java         # Spring Boot app (exists)
        ├── FlightCalculationCbaseService.java        # Service runner
        ├── business/
        │   └── FlightCalculationService.java         # Skeleton exists
        └── persistance/
            ├── FlightCalculationRepository.java      # Skeleton exists
            └── constant/
                └── SysQueueFlightCalcProcessStatusType.java
```

---

## 2. Migration Strategy

### 2.1 Phase Approach

**Phase 1: Foundation & Infrastructure** (Week 1-2)
- Set up enhanced repository layer
- Implement service framework
- Create DTOs and mappers
- Set up logging infrastructure

**Phase 2: Core Business Logic Migration** (Week 3-6)
- Migrate main calculation engine
- Implement job processing
- Port locking mechanism
- Implement history tracking

**Phase 3: Feature-by-Feature Migration** (Week 7-10)
- PAX calculation
- SPML handling
- Meal calculation
- Extra loading
- Aircraft changes

**Phase 4: Integration & Testing** (Week 11-12)
- Integration testing
- Performance tuning
- Parallel run setup

**Phase 5: Deployment & Cutover** (Week 13-14)
- Production deployment
- Monitoring setup
- Final cutover

### 2.2 Migration Principles

1. **Preserve Business Logic:** Maintain exact business rules from PowerBuilder
2. **Modern Architecture:** Use Spring Boot best practices
3. **Backward Compatibility:** Ensure same database tables/structure
4. **Incremental Migration:** Function-by-function approach
5. **Comprehensive Testing:** Unit, integration, and E2E tests

---

## 3. Detailed Component Mapping

### 3.1 Service Infrastructure

| PowerBuilder Component | Java Component | Notes |
|------------------------|----------------|-------|
| `cbase_flight_calculation.sra` (open event) | `FlightCalculationApplication.main()` | Already exists, enhance |
| `f_loop.srf` | `FlightCalculationScheduler.java` | NEW: Spring @Scheduled service |
| `f_profile.srf` | `application.yml` + `@ConfigurationProperties` | NEW: Spring configuration |
| `f_connect.srf` / `f_connect_log.srf` | Spring Data JPA auto-config | Use existing infrastructure |
| Service alive/monitoring | `FlightCalculationHealthIndicator.java` | NEW: Spring Actuator |

### 3.2 Core Business Logic

| PowerBuilder Method | Java Class/Method | Complexity |
|---------------------|-------------------|------------|
| `uo_flight_calculation::of_start()` | `FlightCalculationService.processJobs()` | Medium |
| `uo_flight_calculation::of_process_row()` | `FlightCalculationService.processFlightJob()` | High |
| `uo_flight_calculation::of_lock_record()` | `LockingService.acquireLock()` | Medium |
| `uo_flight_calculation::wf_chc_master_change()` | `MasterChangeService.handleMasterChange()` | High |
| `uo_flight_calculation::wf_chc_change_pax()` | `PaxCalculationService.calculatePax()` | High |
| `uo_flight_calculation::wf_chc_change_spml()` | `SpmlCalculationService.handleSpml()` | High |
| `uo_flight_calculation::wf_chc_change_handling()` | `MealCalculationService.calculateMeals()` | High |
| `uo_flight_calculation::wf_chc_change_extra()` | `ExtraLoadingService.calculateExtra()` | Medium |
| `uo_flight_calculation::of_write_history()` | `HistoryService.writeHistory()` | Medium |
| `uo_flight_calculation::wf_chc_save()` | `FlightCalculationService.saveCalculation()` | High |

### 3.3 Data Access Layer

| PowerBuilder Datastore | Java Repository | Entity |
|------------------------|-----------------|--------|
| `dsCenOut` | `CenOutPpmFlightsRepository` | `CenOutPpmFlights` |
| `dsSysQueueFlightCalc` | `SysQueueFlightCalcRepository` | `SysQueueFlightCalc` |
| `dsSysQueueFlightPax` | `SysQueueFlightPaxRepository` | `SysQueueFlightPax` |
| `dsSysQueueFlightMeals` | `SysQueueFlightMealsRepository` | `SysQueueFlightMeals` |
| `dsSysQueueFlightSPML` | `SysQueueFlightSpmlRepository` | `SysQueueFlightSpml` |
| `dsSupplierUnits` | `SupplierUnitRepository` | Various supplier entities |
| `dsPax` | `PaxRepository` | PAX-related entities |
| `dsMeals` | `MealsRepository` | Meal-related entities |

---

## 4. Proposed Java Package Structure

```
com.lsgskychefs.cbase.middleware.flightcalculation/
│
├── FlightCalculationApplication.java          # Main Spring Boot app (exists)
├── FlightCalculationCbaseService.java          # Service runner (exists)
│
├── config/
│   ├── FlightCalculationConfig.java            # NEW: @Configuration
│   ├── FlightCalculationProperties.java        # NEW: @ConfigurationProperties
│   └── SchedulingConfig.java                   # NEW: Scheduler configuration
│
├── business/
│   ├── FlightCalculationService.java           # EXISTS: Main orchestrator
│   ├── FlightJobProcessor.java                 # NEW: Job processing logic
│   ├── MasterChangeService.java                # NEW: Master change handling
│   ├── PaxCalculationService.java              # NEW: PAX calculations
│   ├── MealCalculationService.java             # NEW: Meal calculations
│   ├── SpmlCalculationService.java             # NEW: SPML handling
│   ├── ExtraLoadingService.java                # NEW: Extra loading calculations
│   ├── AircraftVersionService.java             # NEW: Aircraft version management
│   ├── HistoryService.java                     # NEW: History tracking
│   └── LockingService.java                     # NEW: Pessimistic locking
│
├── scheduler/
│   └── FlightCalculationScheduler.java         # NEW: @Scheduled job runner
│
├── persistence/
│   ├── FlightCalculationRepository.java        # EXISTS: Common repository
│   ├── CenOutPpmFlightsRepository.java         # NEW
│   ├── SysQueueFlightCalcRepository.java       # NEW
│   ├── SysQueueFlightPaxRepository.java        # NEW
│   ├── SysQueueFlightMealsRepository.java      # NEW
│   ├── SysQueueFlightSpmlRepository.java       # NEW
│   ├── SupplierUnitRepository.java             # NEW
│   └── constant/
│       └── SysQueueFlightCalcProcessStatusType.java  # EXISTS
│
├── pojo/                                       # DTOs
│   ├── FlightCalculationRequest.java           # NEW
│   ├── FlightCalculationResult.java            # NEW
│   ├── PaxCalculationData.java                 # NEW
│   ├── MealCalculationData.java                # NEW
│   └── HistoryEntry.java                       # NEW
│
├── rest/                                       # REST API (optional)
│   └── FlightCalculationController.java        # NEW (if needed)
│
└── util/
    ├── FlightCalculationUtil.java              # NEW: Utility methods
    └── DateUtil.java                           # NEW: Date calculations
```

---

## 5. Critical Migration Tasks

### 5.1 High Priority Components

#### 1. **Job Queue Processing** (Critical)
- **PB:** `f_loop.srf` reads from `SYS_QUEUE_FLIGHT_CALC` and `CEN_OUT`
- **Java:** Implement `FlightCalculationScheduler` with Spring `@Scheduled`
- **Complexity:** Medium
- **Risk:** Medium (polling logic must match)

#### 2. **Record Locking** (Critical)
- **PB:** Custom locking in `of_lock_record()` using database fields
- **Java:** Use JPA pessimistic locking or custom implementation
- **Complexity:** Medium
- **Risk:** High (concurrency issues if done wrong)

#### 3. **Flight Calculation Engine** (Critical)
- **PB:** `of_process_row()` - main calculation orchestrator
- **Java:** `FlightJobProcessor.processJob()`
- **Complexity:** High
- **Risk:** High (core business logic)

#### 4. **Master Change Handling** (Critical)
- **PB:** `wf_chc_master_change()` - handles flight/AC changes
- **Java:** `MasterChangeService.handleMasterChange()`
- **Complexity:** High
- **Risk:** High (complex business rules)

#### 5. **History Tracking** (Critical)
- **PB:** `of_write_history()` - audit trail
- **Java:** `HistoryService.writeHistory()`
- **Complexity:** Medium
- **Risk:** Medium (must preserve audit integrity)

### 5.2 Database Migration Considerations

**Tables Used (Primary):**
- `SYS_QUEUE_FLIGHT_CALC` - Job queue
- `CEN_OUT_PPM_FLIGHTS` - Flight data
- `SYS_QUEUE_FLIGHT_PAX` - PAX data
- `SYS_QUEUE_FLIGHT_MEALS` - Meal data
- `SYS_QUEUE_FLIGHT_SPML` - SPML data
- `SYS_QUEUE_FLIGHT_LOG` - Logging
- `CEN_OUT_CHANGES` - Change history
- `SYS_SERVICES_ALIVE` - Service monitoring

**Migration Notes:**
- ✅ No schema changes required
- ✅ Entities already exist in `domain` module
- ⚠️ Need to verify entity mappings match PB datastores
- ⚠️ Ensure stored procedures (if any) are compatible

---

## 6. Testing Strategy

### 6.1 Test Pyramid

```
                    /\
                   /  \      E2E Tests (10%)
                  /----\     - Full flight calculation scenarios
                 /      \    - Production-like data
                /--------\
               /          \  Integration Tests (30%)
              /------------\ - Service layer tests
             /              \- Repository tests
            /----------------\
           /                  \ Unit Tests (60%)
          /--------------------\- Business logic
         /                      \- Calculations
        /------------------------\- Utilities
```

### 6.2 Test Data Strategy

1. **Export test data from PowerBuilder:**
   - Select representative flights
   - Export before/after states
   - Document expected outcomes

2. **Create test fixtures:**
   - Use DBUnit or similar
   - Version control test data

3. **Parallel validation:**
   - Run both PB and Java on same data
   - Compare results field-by-field

### 6.3 Performance Testing

- **Baseline:** Measure PowerBuilder service performance
  - Jobs per minute
  - Average processing time
  - Peak load capacity

- **Target:** Java should meet or exceed PB performance
  - Use JMH for micro-benchmarks
  - Load test with JMeter

---

## 7. Configuration Migration

### 7.1 PowerBuilder INI → Spring Configuration

**PowerBuilder `cbase_flight_calculation.ini`:**
```ini
[INSTANCE99]
NumberOfCalculationsToProcess=1
Process_Function_1=1
Process_Function_2=2
ReadCenOut=true
NumberOfMZVSpawnProcess=2
```

**Java `application.yml`:**
```yaml
flight-calculation:
  instance-name: INSTANCE99
  number-of-calculations-per-cycle: 1
  process-functions:
    - 1  # FLIGHT_CALC
    - 2  # WEB_CALC
  read-cen-out: true
  mzv-spawn-processes: 2

  scheduler:
    enabled: true
    interval-seconds: 60
    initial-delay-seconds: 10

  locking:
    max-lock-seconds: 60

  logging:
    trace-level: INFO
    include-job-key: true
    include-result-key: true
```

---

## 8. Risk Assessment & Mitigation

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Business logic discrepancies | Medium | High | Comprehensive test suite, parallel run |
| Performance degradation | Low | High | Performance testing, profiling |
| Data corruption | Low | Critical | Extensive integration tests, rollback plan |
| Missing requirements | Medium | Medium | Code review with PB experts |
| Concurrency issues | Medium | High | Thorough locking tests, pessimistic locking |
| Integration failures | Low | Medium | Staged rollout, feature flags |

---

## 9. Rollout Plan

### 9.1 Parallel Run Strategy

**Phase A: Shadow Mode (2 weeks)**
- Run Java service in read-only mode
- Compare outputs with PB service
- Log discrepancies
- No production writes

**Phase B: Percentage Rollout (2 weeks)**
- Route 10% → 25% → 50% → 75% of jobs to Java
- Monitor errors and performance
- Keep PB as fallback

**Phase C: Full Cutover (1 week)**
- Route 100% to Java
- Keep PB service warm for emergency rollback
- Monitor closely

**Phase D: Decommission (1 week)**
- Stop PB service
- Archive PB codebase
- Update documentation

### 9.2 Rollback Procedure

1. **Trigger:** Performance < 80% of baseline OR error rate > 1%
2. **Action:** Route traffic back to PB service
3. **Investigation:** Root cause analysis
4. **Resolution:** Fix and retry rollout

---

## 10. Success Criteria

### 10.1 Functional Requirements
- ✅ All flight calculation functions working (1-13)
- ✅ PAX calculation matches PB output
- ✅ Meal calculation matches PB output
- ✅ SPML handling matches PB output
- ✅ History tracking preserved
- ✅ Master change handling correct

### 10.2 Non-Functional Requirements
- ✅ Performance: ≥100% of PB throughput
- ✅ Reliability: <0.1% error rate
- ✅ Maintainability: Code coverage >80%
- ✅ Observability: Logging, metrics, tracing
- ✅ Documentation: API docs, runbooks

---

## 11. Dependencies & Prerequisites

### 11.1 Technical Dependencies
- ✅ Java 8+ (already in use)
- ✅ Spring Boot 2.3.1 (already in use)
- ✅ JPA/Hibernate (already configured)
- ✅ Database access (already configured)
- ⚠️ May need: Quartz Scheduler (for advanced scheduling)
- ⚠️ May need: Flyway/Liquibase (for schema versioning)

### 11.2 Team Dependencies
- PowerBuilder domain expert (for business rules clarification)
- Database administrator (for performance tuning)
- QA team (for test execution)
- DevOps (for deployment automation)

---

## 12. Timeline Summary

| Phase | Duration | Deliverable |
|-------|----------|-------------|
| **Phase 1: Foundation** | 2 weeks | Infrastructure ready |
| **Phase 2: Core Logic** | 4 weeks | Core engine migrated |
| **Phase 3: Features** | 4 weeks | All features migrated |
| **Phase 4: Testing** | 2 weeks | Test suite complete |
| **Phase 5: Deployment** | 2 weeks | Production ready |
| **Total** | **14 weeks** | **Full migration** |

---

## 13. Next Steps

### Immediate Actions (Week 1)
1. ✅ **Review and approve this migration plan**
2. 🔲 Set up development branch: `feature/flight-calc-migration`
3. 🔲 Create JIRA epic and stories
4. 🔲 Identify PowerBuilder domain expert for consultation
5. 🔲 Set up test environment with production-like data
6. 🔲 Begin Phase 1: Repository layer implementation

### Quick Wins (Week 1-2)
1. Implement basic repositories for main tables
2. Set up Spring configuration
3. Create skeleton services
4. Implement health check endpoint
5. Set up logging infrastructure

---

## 14. Open Questions

1. **Are there any stored procedures or database triggers** that interact with the flight calculation?
2. **What is the average job volume** (jobs/hour, jobs/day)?
3. **Peak load requirements?** (concurrent jobs, max throughput)
4. **Are there any external integrations** we need to maintain?
5. **What is the current PB service uptime/reliability?** (baseline metrics)
6. **Do we need to maintain the GUI functionality** or is this purely a service migration?
7. **Are there any special handling for MZV spawn process** that we need to replicate?

---

## Appendix A: PowerBuilder Function Inventory

### Functions in `uo_flight_calculation` (50+ methods)
- `of_init()` - Initialization
- `of_start()` - Main entry point
- `of_process_row()` - Process single job
- `of_lock_record()` - Record locking
- `of_write_history()` - History writing
- `wf_chc_master_change()` - Master change
- `wf_chc_change_pax()` - PAX changes
- `wf_chc_change_spml()` - SPML changes
- `wf_chc_change_handling()` - Handling changes
- `wf_chc_change_extra()` - Extra loading
- `wf_chc_save()` - Save calculation
- `wf_chc_save_final_pax()` - Save final PAX
- `wf_chc_force_meal_calculation()` - Force meal calc
- ... and many more

---

## Appendix B: Database Entity Checklist

Entities already available in `domain` module:
- ✅ `CenOutPpmFlights` - Main flight data
- ✅ `CenOutPpmFlightsId` - Composite key
- ✅ `SysQueueFlightCalc` - Job queue
- ✅ `SysQueueFlightPax` - PAX queue
- ✅ `SysQueueFlightMeals` - Meals queue
- ✅ `SysQueueFlightSpml` - SPML queue
- ✅ `SysQueueFlightActype` - AC type
- ✅ `SysQueueFlightLog` - Logging
- ✅ `FlightCalcFunction` - Function enum
- ✅ `FlightCalcProcessState` - State enum
- ✅ `FlightCalcModifier` - Modifier enum
- ✅ `FlightCalcHistory` - History enum

---

**Document Version:** 1.0
**Last Updated:** November 17, 2025
**Author:** Migration Team
**Status:** DRAFT - Pending Approval
