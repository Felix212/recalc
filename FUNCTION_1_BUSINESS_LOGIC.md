# Function 1 (FLIGHT_CALC) Business Logic Documentation

**Migration Reference:** PowerBuilder → Java Spring Boot
**Source:** `flightcalc/trunk/PBL/cbase_uo_flight_calculation/uo_flight_calculation.sru`
**Target:** `cbase-service-parent/flightcalculation`
**Date:** November 17, 2025

---

## Overview

Function 1 (FLIGHT_CALC) processes flight calculations based on data in auxiliary tables (PAX/SPML/ACTYPE). It is triggered by entries in `SYS_QUEUE_FLIGHT_CALC` and processes flights based on configuration data stored in `SYS_QUEUE_FL_FUNCTION`.

**Internal Function:** 1
**Function Description:** "Process sys_queue_flight_calc - Calculate everything based on auxiliary tables (PAX/SPML/ACTYPE)"
**History Tracking:** NO (vs Function 2/3/4 which have history)

---

## High-Level Processing Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    MAIN SERVICE LOOP                         │
│                     (f_loop.srf)                            │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│  1. of_retrieve_dsjobs()                                    │
│     - Lock instance (prevent concurrent processing)         │
│     - Read SYS_QUEUE_FL_FUNCTION configuration              │
│     - Read CEN_OUT if configured (bRead_cen_out=true)       │
│     - Insert new jobs from CEN_OUT into SYS_QUEUE_FLIGHT_CALC│
│     - Retrieve jobs for this instance                       │
│     - Mark N jobs (iNumberOfCalculationsToProcess)          │
│     - Update jobs with instance name and status=1           │
│     - Unlock instance                                       │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│  2. of_start()                                              │
│     - Filter jobs by instance                               │
│     - Check for duplicate jobs (set to ignore status=7)     │
│     - Process each job via of_process_row()                 │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│  3. of_process_row(lrow)                                    │
│     - Validate function exists in SYS_QUEUE_FL_FUNCTION     │
│     - Route to appropriate processor based on function      │
│     - For Function 1: Call of_process_auto_web_calc_cen_out │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│  4. of_process_auto_web_calc_cen_out(result_key)            │
│     - Lock flight record (pessimistic lock)                 │
│     - Retrieve flight data (wf_chc_retrieve_flight)         │
│     - Get PAX changes (of_get_sys_flight_pax)               │
│     - Get aircraft changes (of_get_sys_flight_actype)       │
│     - Get SPML changes (of_get_sys_flight_spml)             │
│     - Check if meal calculation required                    │
│     - If needed: wf_chc_master_change()                     │
│     - Save results: wf_chc_save()                           │
│     - Update job status to success (3) or error (9)         │
└─────────────────────────────────────────────────────────────┘
```

---

## Detailed Component Breakdown

### 1. Configuration and Initialization

#### 1.1 Function Configuration (SYS_QUEUE_FL_FUNCTION)

The function behavior is controlled by `SYS_QUEUE_FL_FUNCTION` table:

**Key Fields:**
- `NFUNCTION` = 1 (Function identifier)
- `NINTERNAL_FUNCTION` = 1 (Internal processing type)
- `NQUEUED_RELEASE_INTERFACE` = NULL (for Function 1)
- `NSTATUS_TO_PROCESS` = Status limit for processing
- `NSTATUS_AFTER_PROCESS` = Target status after success
- `NPAX_TYPE` = Which PAX fields to use
- `NUSE_AS_PAX_TYPE` = Which PAX fields to map to
- `NACTYPE` = Which aircraft version fields to use
- `NUSE_AS_ACTYPE` = Which version fields to map to

**Processing Logic:**
```powerbuilder
// Read function configuration
dsSysQueueFunctions.retrieve()

// Find function configuration
of_search_sys_queue_function(ifunction)
  → Sets: this.iinternal_function
  → Sets: this.lfunction_queued_release_interface
  → Sets: this.lstatus_to_process
  → Sets: this.lstatus_after_process
  → Sets: this.ifunction_pax_type
  → Sets: this.ifunction_use_as_pax_type
  → Sets: this.ifunction_actype
  → Sets: this.ifunction_use_as_actype
```

#### 1.2 Instance Parameters

Configured via INI file (`cbase_flight_calculation.ini`):

```ini
[INSTANCE99]
NumberOfCalculationsToProcess=1       # Jobs per cycle
Process_Function_1=1                  # Enable Function 1
Process_Function_2=2                  # Enable Function 2
ReadCenOut=true                       # Read from CEN_OUT
```

**Key Variables:**
- `iProcessFunction[]` - Array of functions to process (-1 = all)
- `iNumberOfCalculationsToProcess` - Jobs per processing cycle
- `bread_cen_out` - Whether to read CEN_OUT for new jobs
- `sInstance` - Instance name (e.g., "INSTANCE99")
- `il_maxlock` - Max lock time in seconds (default 60)

---

### 2. Job Retrieval (`of_retrieve_dsjobs`)

**Purpose:** Read pending jobs from database and mark them for processing

**Steps:**

#### 2.1 Instance Locking
```powerbuilder
// Prevent concurrent processing
if this.of_lock() = -1 then
   return -1  // Another instance is running
end if
```

**Lock Mechanism:**
- Uses INI file parameters: `Locked`, `Instance`, `TimeStamp`
- Lock expires after 60 seconds (il_maxlock)
- Prevents multiple instances from processing same jobs

#### 2.2 Read Function Configuration
```powerbuilder
dsSysQueueFunctions.retrieve()  // Read SYS_QUEUE_FL_FUNCTION
```

#### 2.3 Optional CEN_OUT Processing
```powerbuilder
if this.bRead_cen_out then
   // Find functions with NINTERNAL_FUNCTION = 2
   // Read CEN_OUT where NQUEUED_RELEASE_INTERFACE matches
   dsCenOut.Retrieve(lstatus[])

   // For each CEN_OUT record not yet in queue:
   for lrow = 1 to lrows
      // Check if already queued
      if not exists in dsJobs then
         // Insert into SYS_QUEUE_FLIGHT_CALC
         lSequence = f_Sequence("seq_sys_queue_flight_calc")
         dsSysQueueFlightCalc.InsertRow()
         dsSysQueueFlightCalc.SetItem("njob_nr", lsequence)
         dsSysQueueFlightCalc.SetItem("nresult_key", ...)
         dsSysQueueFlightCalc.SetItem("nfunction", ifunction)
         dsSysQueueFlightCalc.SetItem("nprocess_status", 0)
      end if
   next
   dsSysQueueFlightCalc.Update()
   commit
end if
```

#### 2.4 Retrieve and Mark Jobs
```powerbuilder
// Retrieve jobs for this instance
this.dsJobs.Retrieve(this.iProcessFunction, sInstance)

// Mark N jobs for processing
For i = 1 to dsJobs.RowCount()
   if dsJobs.GetItemNumber(i, "nprocess_status") = 1 then continue

   dsJobs.SetItem(i, "dstart_computing", DateTime(Today(), Now()))
   dsJobs.SetItem(i, "cinstance", sInstance)
   dsJobs.SetItem(i, "nprocess_status", 1)  // Mark as assigned

   iCount++
   if iCount >= iNumberOfCalculationsToProcess then exit
Next

dsJobs.update()
commit
this.of_unlock()
```

**Job Query (dw_job_list_new):**
- Reads from `SYS_QUEUE_FLIGHT_CALC`
- Joins with `CEN_OUT` for flight details
- Filters by:
  - `NFUNCTION` in (iProcessFunction[])
  - `CINSTANCE` = sInstance OR `CINSTANCE` IS NULL
  - `NPROCESS_STATUS` in (0, 1, 4)  // 0=new, 1=assigned, 4=retry
- Orders by:
  - `NPROCESS_STATUS`
  - `NSORT` (priority)
  - `DDEPARTURE` (departure date)

---

### 3. Job Processing (`of_start` and `of_process_row`)

#### 3.1 Pre-Processing (`of_start`)

```powerbuilder
// Filter jobs by instance
dsJobs.SetFilter("cinstance = '" + sInstance + "'")
dsJobs.Filter()

// Remove duplicate jobs (same flight, same function, same status)
For lRows = 2 to dsJobs.RowCount()
   if dsJobs.GetItemNumber(lRows, "nresult_key") =
      dsJobs.GetItemNumber(lRows - 1, "nresult_key") AND
      dsJobs.GetItemNumber(lRows, "nfunction") =
      dsJobs.GetItemNumber(lRows - 1, "nfunction") then

      // Set duplicate to ignore
      dsJobs.SetItem(lRows, "nprocess_status", 7)  // Ignore
   end if
next
dsJobs.update()

// Process each job
For lRows = 1 to dsJobs.RowCount()
   if iSuccess >= iNumberOfCalculationsToProcess then exit

   this.lResultKeyCenOut = dsJobs.GetItemNumber(lRows, "nresult_key")
   this.ilJobNr = dsJobs.GetItemNumber(lRows, "njob_nr")

   lreturn = of_process_row(lRows)
Next
```

#### 3.2 Job Routing (`of_process_row`)

```powerbuilder
// Extract job details
lresult_key  = dsJobs.GetItemNumber(lrow, "nresult_key")
ifunction    = dsJobs.GetItemNumber(lrow, "nfunction")
istatus      = dsJobs.GetItemNumber(lrow, "nstatus")
iprocess_status = dsJobs.GetItemNumber(lrow, "nprocess_status")

// Handle status=0 flights (get status from history)
if istatus = 0 and ifunction <> 11 then
   select nstatus into :istatus
   from cen_out_history
   where nresult_key = :lresult_key
   and ntransaction in (select max(coh.ntransaction)
                       from cen_out_history coh
                       where nresult_key = :lresult_key
                       and nstatus <> 0)
   if sqlca.sqlcode <> 0 then istatus = 1
end if

// Only process jobs with status 1 (assigned) or 4 (retry)
if iprocess_status = 1 or iprocess_status = 4 then

   // Look up function configuration
   if of_search_sys_queue_function(ifunction) = 0 then

      // Route based on internal function
      choose case this.iinternal_function
         case 1, 2, 3, 4
            // Standard calculation
            dsJobs.SetItem(lRow, "dstart_computing", DateTime(Today(), Now()))

            iReturn = of_process_auto_web_calc_cen_out(lresult_key)

            if iReturn >= 0 then
               dsJobs.SetItem(lRow, "nerror", 1)           // Success
               dsJobs.SetItem(lRow, "nprocess_status", 3)  // Completed
            else
               if iReturn = -10 then
                  return 1  // Flight locked, retry later
               else
                  dsJobs.SetItem(lRow, "nerror", 2)        // Error
                  dsJobs.SetItem(lRow, "nprocess_status", 9) // Failed
               end if
            end if

            dsJobs.SetItem(lRow, "dstop_computing", DateTime(Today(), Now()))
            dsJobs.SetItem(lRow, "cerror", this.sreturn_error_message_short)

         case 8  // Flight delete
            // Delete flight logic

         case 10  // Meal distribution
            // Meal distribution logic

      end choose
   end if
end if

return 0
```

---

### 4. Flight Calculation (`of_process_auto_web_calc_cen_out`)

**Purpose:** Main calculation orchestrator for a single flight

#### 4.1 Initialization and Locking

```powerbuilder
// Lock the flight record
if of_lock_record(arg_lresult_key) = false then
   this.ireturn_error_status = -1
   this.sreturn_error_message = "Flight is locked"
   return -10  // Special return code for locked flights
end if
```

**Lock Implementation (`of_lock_record`):**
```powerbuilder
// Pessimistic lock using Oracle SELECT FOR UPDATE
SELECT cen_out.nresult_key
  INTO :lUpdateKey
  FROM cen_out
 WHERE cen_out.nresult_key = :lLockKey
 For Update NOWAIT

If SQLCA.SQLCODE <> 0 Then
   iLockStatus = 1
   return False  // ORA-0054: resource is busy
Else
   iLockStatus = 0
   return True
End if
```

#### 4.2 Flight Data Retrieval

```powerbuilder
wf_chc_retrieve_flight(arg_lresult_key)
```

**Retrieves:**
- **dw_single** - Main flight data (CEN_OUT)
- **dw_pax** - PAX data (CEN_OUT_PAX)
- **dw_meal** - Meal data (CEN_OUT_MEALS)
- **dw_extra** - Extra loading (CEN_OUT_HANDLING)
- **dw_spml** - SPML data (CEN_OUT_SPML)
- **dw_handling** - Handling data
- **dsSingleOld** - Historic flight data (for comparison)
- **dsMealOld** - Historic meal data
- **dsExtraOld** - Historic extra data
- **dsSPMLOld** - Historic SPML data
- **dsPaxOld** - Historic PAX data

#### 4.3 Status Validation

```powerbuilder
lCheck_nstatus = dw_Single.GetItemNumber(dw_Single.GetRow(), "nstatus")

// Check if flight status allows processing
if lCheck_nstatus > this.lstatus_to_process then
   // Flight status too high for this function
   this.ireturn_error_status = -1
   this.sreturn_error_message = "Flight has wrong status for processing"
   return -1
end if
```

#### 4.4 Get Queue Table Changes

**PAX Changes (`of_get_sys_flight_pax`):**
```powerbuilder
// Read SYS_QUEUE_FLIGHT_PAX for this job
dsSysQueueFlightPax.Retrieve(ljob_nr)

// Apply changes to dw_pax
For lrow = 1 to dsSysQueueFlightPax.RowCount()
   cclass = dsSysQueueFlightPax.GetItemString(lrow, "cclass")

   // Find matching row in dw_pax
   lfound = dw_pax.Find("cclass = '" + cclass + "'", ...)

   if lfound > 0 then
      // Update existing PAX row
      dw_pax.SetItem(lfound, "npax", new_npax)
      dw_pax.SetItem(lfound, "nforecast", new_forecast)
      // ... other fields
   end if
Next
```

**Aircraft Changes (`of_get_sys_flight_actype`):**
```powerbuilder
// Read SYS_QUEUE_FLIGHT_ACTYPE for this job
dsSysQueueFlightACType.Retrieve(ljob_nr)

if dsSysQueueFlightACType.RowCount() > 0 then
   // Update aircraft in dw_single
   dw_single.SetItem(1, "naircrafttype_key", new_aircraft_key)
   dw_single.SetItem(1, "cregistration", new_registration)
   dw_single.SetItem(1, "nairconfiguration_key", new_config_key)

   return 1  // Aircraft changed
end if
```

**SPML Changes (`of_get_sys_flight_spml`):**
```powerbuilder
// Read SYS_QUEUE_FLIGHT_SPML for this job
dsSysQueueFlightSPML.Retrieve(ljob_nr)

// Apply changes to dw_spml
For lrow = 1 to dsSysQueueFlightSPML.RowCount()
   // Update or insert SPML rows
   dw_spml.SetItem(target_row, "nquantity", new_quantity)
   dw_spml.SetItem(target_row, "cclass", new_class)
   // ... other fields
Next
```

#### 4.5 PAX/Version Type Transfer

**PAX Type Mapping:**
```powerbuilder
// If function configured to use different PAX type
if this.ifunction_pax_type <> this.ifunction_use_as_pax_type then
   of_pax_type_transfer()
end if
```

**Example:** Function may use NFORECAST instead of NPAX for calculations

**Version Type Mapping:**
```powerbuilder
// If function configured to use different version fields
if this.ifunction_actype <> this.ifunction_use_as_actype then
   of_version_type_transfer()
end if
```

#### 4.6 Determine if Meal Calculation Needed

```powerbuilder
// Check for meal definition references
select count(*) into :lcount
from cen_out_meals
where nresult_key = :arg_lresult_key
  and nmodule_type = 0
  and not exists (select nhandling_detail_key
                  from cen_meals_detail
                  where cen_meals_detail.nhandling_detail_key =
                        cen_out_meals.nhandling_detail_key)

if lcount > 0 then
   bForceMealCalculation = True
end if

// Configuration option to always recalculate
if bDoAllwaysMealCalc then
   bForceMealCalculation = True
end if
```

#### 4.7 Master Change (Meal Calculation)

```powerbuilder
bOK = True
if bForceMealCalculation then
   bOK = wf_chc_master_change()
end if
```

**wf_chc_master_change() Logic:**
1. Validate flight data (`wf_chc_validation`)
2. Get differences from history (`wf_chc_get_differences`)
3. Call meal explosion library (`uo_generate`)
4. Update PAX (`wf_chc_change_pax`)
5. Update Meals (`wf_chc_change_meals`)
6. Update Extra loading (`wf_chc_change_extra`)
7. Update SPML (`wf_chc_change_spml`)
8. Update Handling (`wf_chc_change_handling`)

#### 4.8 Save Results

```powerbuilder
if bOK then
   // For Function 4 (recalc), use special save
   if this.iinternal_function = 4 then
      bOKSave = of_recalc_save()
   else
      bOKSave = wf_chc_save()
   end if

   of_check_save(bOKSave, arg_lresult_key)
else
   this.ireturn_error_status = -1
   this.sreturn_error_message = "Error in wf_chc_master_change"

   // Set flight to error status
   update cen_out
      set nqueued_release_interface = :i_Status_Queued_Errors,
          nstatus = :l_nstatus_hist,
          nstatus_release = :l_nstatus_release_hist
    where nresult_key = :arg_lresult_key

   commit
end if

return 1
```

**wf_chc_save() Logic:**
1. Update history (`of_write_history`)
2. Update `CEN_OUT` status
3. Update `CEN_OUT_PAX`
4. Update `CEN_OUT_MEALS`
5. Update `CEN_OUT_HANDLING`
6. Update `CEN_OUT_SPML`
7. Update `CEN_OUT_CHANGES` (change log)
8. Commit transaction
9. Request online explosion if needed
10. Create document generation jobs

---

## Data Flow Diagram

```
┌──────────────────────┐
│  SYS_QUEUE_FL_FUNCTION│  ← Function configuration
└──────────┬───────────┘
           │ (1. Read)
           ▼
┌──────────────────────┐
│    CEN_OUT           │  ← Flight master data
│  (if bRead_cen_out)  │
└──────────┬───────────┘
           │ (2. Read new flights)
           ▼
┌──────────────────────┐
│ SYS_QUEUE_FLIGHT_CALC│  ← Job queue
└──────────┬───────────┘
           │ (3. Mark jobs for instance)
           ▼
┌──────────────────────┐
│  Process Job Loop    │
└──────────┬───────────┘
           │
           ├─(4a)─► SYS_QUEUE_FLIGHT_PAX ──┐
           │                                │
           ├─(4b)─► SYS_QUEUE_FLIGHT_ACTYPE─┤
           │                                │ (Apply changes)
           ├─(4c)─► SYS_QUEUE_FLIGHT_SPML ─┤
           │                                │
           ▼                                ▼
    ┌──────────────┐              ┌──────────────┐
    │   CEN_OUT    │◄─────(5a)────│   dw_single  │
    │   CEN_OUT_PAX│◄─────(5b)────│   dw_pax     │
    │   CEN_OUT_MEALS│◄───(5c)────│   dw_meal    │
    │   CEN_OUT_HANDLING│◄(5d)────│   dw_extra   │
    │   CEN_OUT_SPML│◄────(5e)────│   dw_spml    │
    └──────────────┘              └──────────────┘
           │                                ▲
           │ (6. History)                   │
           ▼                                │
    ┌──────────────┐                       │
    │ CEN_OUT_HISTORY│              (7. Meal calculation)
    │ CEN_OUT_CHANGES│                     │
    └──────────────┘              ┌────────┴────────┐
           │                      │  uo_generate    │
           │                      │  (Meal Explosion)│
           │                      └─────────────────┘
           ▼
    ┌──────────────────┐
    │ SYS_QUEUE_FLIGHT_CALC│  ← Update job status
    │  (nprocess_status=3) │     (3=success, 9=error)
    └──────────────────────┘
```

---

## Key Database Tables

### Input Tables

| Table | Purpose | Key Fields |
|-------|---------|------------|
| **SYS_QUEUE_FL_FUNCTION** | Function configuration | NFUNCTION, NINTERNAL_FUNCTION, NSTATUS_TO_PROCESS, NSTATUS_AFTER_PROCESS |
| **SYS_QUEUE_FLIGHT_CALC** | Job queue | NJOB_NR, NRESULT_KEY, NFUNCTION, NPROCESS_STATUS, CINSTANCE |
| **SYS_QUEUE_FLIGHT_PAX** | PAX changes | NJOB_NR, CCLASS, NPAX, NFORECAST |
| **SYS_QUEUE_FLIGHT_ACTYPE** | Aircraft changes | NJOB_NR, NAIRCRAFTTYPE_KEY, CREGISTRATION |
| **SYS_QUEUE_FLIGHT_SPML** | SPML changes | NJOB_NR, CCLASS, NQUANTITY |
| **CEN_OUT** | Flight master | NRESULT_KEY, NSTATUS, NQUEUED_RELEASE_INTERFACE |
| **CEN_OUT_HISTORY** | Flight history | NRESULT_KEY, NTRANSACTION, NSTATUS |

### Output Tables

| Table | Purpose | Key Fields |
|-------|---------|------------|
| **CEN_OUT** | Updated flight | NSTATUS, NQUEUED_RELEASE_INTERFACE |
| **CEN_OUT_PAX** | Updated PAX | NRESULT_KEY, CCLASS, NPAX |
| **CEN_OUT_MEALS** | Updated meals | NRESULT_KEY, NHANDLING_DETAIL_KEY, NQUANTITY |
| **CEN_OUT_HANDLING** | Updated extra loading | NRESULT_KEY, NHANDLING_DETAIL_KEY, NQUANTITY |
| **CEN_OUT_SPML** | Updated SPML | NRESULT_KEY, CCLASS, NQUANTITY |
| **CEN_OUT_HISTORY** | History record | NRESULT_KEY, NTRANSACTION |
| **CEN_OUT_CHANGES** | Change log | NRESULT_KEY, CCHANGE_TYPE, CCHANGE_TEXT |

---

## Process Status Values

| Status | Name | Description |
|--------|------|-------------|
| 0 | NEW | New job, not yet assigned |
| 1 | ASSIGNED | Assigned to instance, ready to process |
| 2 | RUNNING | Currently being processed (for MZV spawn) |
| 3 | SUCCESS | Successfully completed |
| 4 | RETRY | Retry later (e.g., waiting for explosion) |
| 7 | IGNORE | Duplicate job, ignore |
| 9 | ERROR | Processing failed |
| 10 | TIMEOUT | Job exceeded max runtime |

---

## Flight Status Values (CEN_OUT.NSTATUS)

| Status | Name | Description |
|--------|------|-------------|
| 0 | INITIAL | Initial status (get from history) |
| 1 | NEW | New flight |
| 3 | UPDATE | Flight updated |
| 5 | RELEASE_PAX | PAX released by station |
| 6 | CLOSED | Flight closed |
| 8 | RECALC | Recalculation status |
| 10 | RELEASE_FLIGHT | Flight released by IFMS |

---

## Queued Release Interface Values

| Value | Description |
|-------|-------------|
| 1 | Waiting for release |
| 2 | Waiting for interface creation |
| 3 | Waiting for error resolution |
| 4 | Waiting for recalculation after PAX change (Web) |
| 5 | Waiting for recalculation after AC change (Web) |
| 7 | Waiting for recalculation after SPML change (AMOS) |

---

## Critical Business Rules

### 1. Locking Strategy
- **Pessimistic locking** using Oracle `SELECT FOR UPDATE NOWAIT`
- Lock timeout: 60 seconds (configurable via `il_maxlock`)
- If lock fails (ORA-0054), job is retried later
- Commit releases lock

### 2. Status Management
- Flights with `NSTATUS = 0` get status from history (most recent non-zero status)
- Function 11 (recalc) always uses `NSTATUS = 8`
- Flight status must be ≤ `NSTATUS_TO_PROCESS` (from function config)
- After successful processing, status set to `NSTATUS_AFTER_PROCESS`

### 3. Meal Calculation Triggers
- **Always calculate** if `bDoAllwaysMealCalc = True`
- **Force calculate** if invalid meal definition references exist
- **Calculate** if `bForceMealCalculation = True` (set by various conditions)
- **Calculate** if PAX/SPML/Aircraft changes detected

### 4. Duplicate Job Handling
- Before processing, check for multiple jobs with same:
  - `NRESULT_KEY` (flight)
  - `NFUNCTION` (function)
  - `NPROCESS_STATUS` (status)
- Set duplicates to `NPROCESS_STATUS = 7` (ignore)

### 5. History Tracking
- For Function 1: `NHISTORY = 0` (no history)
- For Functions 2/3/4: `NHISTORY = 1` (with history)
- History written to `CEN_OUT_HISTORY` before changes
- Changes logged to `CEN_OUT_CHANGES`

### 6. Transaction Management
- All changes within single transaction
- Commit only after successful save
- Rollback on error
- Lock released on commit

### 7. PAX/Version Type Mapping
- Function config can specify to use different fields:
  - `NPAX_TYPE` vs `NUSE_AS_PAX_TYPE`
  - `NACTYPE` vs `NUSE_AS_ACTYPE`
- Transfer logic copies data between field types
- Example: Use `NFORECAST` instead of `NPAX`

---

## Error Handling

### Error Status Codes

```powerbuilder
this.ireturn_error_status:
   0  = Success
  -1  = Error
 -10  = Flight locked (retry)
```

### Error Messages

```powerbuilder
this.sreturn_error_message         // Full error message
this.sreturn_error_message_short   // Short error message
this.is_web_message                // Translated message for web service
```

### Error Recovery

1. **Flight Locked:** Return -10, job stays in status 1, retried next cycle
2. **Validation Error:** Set job to status 9 (error), log error message
3. **Database Error:** Rollback, set job to status 9, flight status restored from history
4. **Meal Calculation Error:** Rollback, set `NQUEUED_RELEASE_INTERFACE = 3` (error status)

---

## Performance Considerations

### 1. Job Batch Size
- Configurable: `iNumberOfCalculationsToProcess`
- Typical value: 1-10 jobs per cycle
- Balance between throughput and responsiveness

### 2. Instance Locking
- Prevents concurrent processing
- Lock timeout: 60 seconds
- Use INI file for coordination

### 3. Database Operations
- Single transaction per job
- Pessimistic locking on `CEN_OUT`
- Bulk updates where possible

### 4. Datastore Management
- Reuse datastores across jobs
- Clear/reset between jobs
- Memory cleanup via `garbagecollect()`

---

## Logging and Monitoring

### Log Levels

```powerbuilder
guoLog.uf_allways()   // Always log
guoLog.uf_error()     // Error
guoLog.uf_info()      // Info
guoLog.uf_debug()     // Debug
guoLog.uf_trace()     // Trace
```

### Key Log Points

1. **Job Start:** `of_start` - number of jobs
2. **Job Assignment:** `of_retrieve_dsjobs` - stamped N of M rows
3. **Job Processing:** `of_process_row` - function, flight, status
4. **Calculation Start:** `of_process_auto_web_calc_cen_out` - flight details
5. **Errors:** All error conditions
6. **Completion:** Status update, duration

### Job State Logging

```powerbuilder
of_log_jobstate(ii_log_info, "Recalc Start")
of_log_jobstate(ii_log_warning, "Flight locked")
of_log_jobstate(ii_log_fehler, "Error message")
```

---

## Integration Points

### 1. Meal Explosion Library (`uo_generate`)
- External library for meal calculations
- Called from `wf_chc_master_change`
- Returns calculated meals/extra/SPML

### 2. Online Explosion Request
- `wf_chc_request_explosion` - Request online explosion
- Sets flag in database
- Processed by separate service

### 3. Document Generation
- `uo_doc_gen_queue` - Enqueue flight for doc generation
- Creates jobs in `CEN_DOC_GEN_QUEUE`
- Processed by separate service

### 4. BOB (Bill of Burdens)
- `of_retrieve_bob_figures` - Retrieve BOB data
- Integration with external system

### 5. WAB (Weight and Balance)
- `wf_wab_send_galleyweights` - Send weights to ALTEA
- Triggered on registration change

---

## Migration Considerations for Java

### 1. Replace PowerBuilder Datastores
- Use **Spring Data JPA Repositories**
- Create **DTOs** for data transfer
- Use **EntityManager** for custom queries

### 2. Replace PowerBuilder Transactions
- Use **Spring @Transactional**
- Configure **isolation level** (READ_COMMITTED or REPEATABLE_READ)
- Handle **pessimistic locking** with JPA `LockModeType.PESSIMISTIC_WRITE`

### 3. Replace Instance Locking
- Use **distributed locking** (Redis, Hazelcast, or database-based)
- Or use **ShedLock** library for Spring
- Or use **Quartz Scheduler** with clustering

### 4. Replace Configuration (INI files)
- Use **Spring `application.yml`**
- Use **`@ConfigurationProperties`**
- Support **profiles** for different instances

### 5. Replace Logging
- Use **SLF4J + Logback**
- Use **MDC** for job/flight context
- Integrate with **Graylog** (already configured in pom.xml)

### 6. Replace Meal Explosion Library
- **Reuse** existing Java implementation if available
- Or **port** PowerBuilder library to Java
- Or **wrap** PowerBuilder as external service (temporary)

### 7. Job Scheduling
- Use **Spring `@Scheduled`** for simple scheduling
- Or use **Quartz Scheduler** for advanced features
- Configure **polling interval** (currently ~60 seconds in PB)

---

## Testing Strategy

### 1. Unit Tests
- Test job retrieval logic
- Test status transitions
- Test PAX/SPML/Aircraft change application
- Test error handling
- Mock database repositories

### 2. Integration Tests
- Test complete job processing flow
- Test with real database
- Test locking behavior
- Test transaction rollback
- Use **Testcontainers** for database

### 3. Performance Tests
- Load test with multiple jobs
- Test concurrent job processing
- Measure throughput (jobs/minute)
- Compare with PowerBuilder baseline

### 4. Parallel Validation
- Run Java and PowerBuilder side-by-side
- Process same jobs in both
- Compare results field-by-field
- Use **DBUnit** for data comparison

---

## Open Questions for Implementation

1. **Meal Explosion Library:**
   - Is `uo_generate` available in Java?
   - What is the API/interface?

2. **External Integrations:**
   - MZV Spawn process - how to handle in Java?
   - BOB integration - REST API or database?
   - WAB integration - REST API?

3. **Configuration:**
   - Multiple instances - how to configure?
   - Per-instance settings - profiles or database?

4. **Locking:**
   - Clustered environment - distributed lock needed?
   - Lock timeout strategy - same 60 seconds?

5. **Performance:**
   - Current throughput - jobs per hour?
   - Peak load - concurrent jobs?
   - Target SLA - processing time per job?

6. **Error Handling:**
   - Retry strategy - max retries?
   - Dead letter queue - for permanent failures?
   - Alerting - on errors?

---

## Summary

**Function 1 (FLIGHT_CALC)** is the core flight calculation function that:
1. Reads jobs from `SYS_QUEUE_FLIGHT_CALC`
2. Applies PAX/SPML/Aircraft changes from queue tables
3. Calculates meals using external library
4. Saves results to `CEN_OUT` tables
5. Updates job status

**Key Characteristics:**
- **No history tracking** (unlike Functions 2/3/4)
- **Pessimistic locking** for concurrency
- **Transaction-based** processing
- **Configurable** via function table and INI file
- **Extensible** via internal function routing

**Java Migration Priority:**
- ✅ Critical component - used for all standard flight calculations
- ⚠️ Complex business logic - requires careful porting
- ✅ Well-structured - clear separation of concerns
- ✅ Database-centric - maps well to JPA/Spring Data

---

**Document Version:** 1.0
**Status:** COMPLETE
**Next Steps:** Begin Java implementation
