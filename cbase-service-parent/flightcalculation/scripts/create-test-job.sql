-- =============================================================================
-- Create Test Job for Flight Calculation Service
-- =============================================================================
-- Purpose: Create a test job in SYS_QUEUE_FLIGHT_CALC for Function 1 testing
-- Usage: Execute this script in SQL*Plus or database tool
-- =============================================================================

-- Variables (modify these for your test)
DEFINE result_key = 96389531;  -- Your test flight result_key
DEFINE instance_name = 'INSTANCE99';  -- Your instance name

-- =============================================================================
-- 1. Verify Flight Exists
-- =============================================================================
PROMPT Checking if flight exists...
SELECT
    NRESULT_KEY,
    CORIGIN,
    CDESTINATION,
    DDEPARTURE,
    NSTATUS
FROM CEN_OUT_PPM_FLIGHTS
WHERE NRESULT_KEY = &result_key;

-- If no rows returned, the flight doesn't exist. You'll need to create it first.

-- =============================================================================
-- 2. Check for Existing Jobs
-- =============================================================================
PROMPT Checking for existing jobs...
SELECT
    NJOB_NR,
    NFUNCTION,
    NPROCESS_STATUS,
    DSTART_COMPUTING,
    DSTOP_COMPUTING,
    CERROR
FROM SYS_QUEUE_FLIGHT_CALC
WHERE NRESULT_KEY = &result_key
ORDER BY NJOB_NR DESC;

-- =============================================================================
-- 3. Create Test Job (Function 1: FLIGHT_CALC)
-- =============================================================================
PROMPT Creating test job...

INSERT INTO SYS_QUEUE_FLIGHT_CALC (
    NJOB_NR,
    NRESULT_KEY,
    NFUNCTION,
    NPROCESS_STATUS,
    NSORT,
    DDEPARTURE,
    CINSTANCE,
    DTIMESTAMP,
    NERROR,
    CERROR,
    DSTART_COMPUTING,
    DSTOP_COMPUTING,
    CMODIFIED
) VALUES (
    SYS_QUEUE_FLIGHT_CALC_SEQ.NEXTVAL,  -- Auto-generate job number
    &result_key,                         -- Flight result key
    1,                                   -- Function 1 (FLIGHT_CALC)
    0,                                   -- Status: PENDING
    1,                                   -- Sort priority
    SYSDATE,                             -- Departure date (today)
    '&instance_name',                    -- Instance name
    SYSDATE,                             -- Timestamp
    0,                                   -- No error initially
    NULL,                                -- No error message
    NULL,                                -- Start computing (set by service)
    NULL,                                -- Stop computing (set by service)
    'TEST'                               -- Modified by TEST
);

COMMIT;

PROMPT Test job created successfully!
PROMPT Job Number: (see below)

-- =============================================================================
-- 4. Display Created Job
-- =============================================================================
SELECT
    NJOB_NR,
    NRESULT_KEY,
    NFUNCTION,
    NPROCESS_STATUS,
    CINSTANCE
FROM SYS_QUEUE_FLIGHT_CALC
WHERE NRESULT_KEY = &result_key
  AND NFUNCTION = 1
ORDER BY NJOB_NR DESC
FETCH FIRST 1 ROW ONLY;

-- =============================================================================
-- 5. (Optional) Create PAX Change for Testing
-- =============================================================================
PROMPT Creating test PAX change (optional)...

-- Get the job number we just created
VARIABLE v_job_nr NUMBER;
BEGIN
    SELECT NJOB_NR
    INTO :v_job_nr
    FROM SYS_QUEUE_FLIGHT_CALC
    WHERE NRESULT_KEY = &result_key
      AND NFUNCTION = 1
      AND NPROCESS_STATUS = 0
    ORDER BY NJOB_NR DESC
    FETCH FIRST 1 ROW ONLY;
END;
/

-- Insert PAX change
INSERT INTO SYS_QUEUE_FLIGHT_PAX (
    NJOB_NR,
    CCLASS,
    NPAX,
    NFORECAST,
    NVERSION
) VALUES (
    :v_job_nr,      -- Job number from above
    'Y',            -- Economy class
    150,            -- 150 passengers
    160,            -- Forecast 160
    1               -- Version 1
);

COMMIT;

PROMPT Test PAX change created!

-- =============================================================================
-- 6. Verification Queries
-- =============================================================================
PROMPT ========================================
PROMPT Verification
PROMPT ========================================

PROMPT Job status:
SELECT
    NJOB_NR,
    NFUNCTION,
    NPROCESS_STATUS,
    CASE NPROCESS_STATUS
        WHEN 0 THEN 'PENDING'
        WHEN 1 THEN 'PROCESSING'
        WHEN 3 THEN 'SUCCESS'
        WHEN 4 THEN 'RETRY'
        WHEN 7 THEN 'IGNORE'
        WHEN 9 THEN 'ERROR'
        ELSE 'UNKNOWN'
    END AS STATUS_TEXT,
    CINSTANCE
FROM SYS_QUEUE_FLIGHT_CALC
WHERE NJOB_NR = :v_job_nr;

PROMPT PAX changes:
SELECT
    NJOB_NR,
    CCLASS,
    NPAX,
    NFORECAST,
    NVERSION
FROM SYS_QUEUE_FLIGHT_PAX
WHERE NJOB_NR = :v_job_nr;

-- =============================================================================
-- 7. Instructions
-- =============================================================================
PROMPT ========================================
PROMPT Next Steps
PROMPT ========================================
PROMPT 1. Start the Flight Calculation Service
PROMPT 2. The service will automatically pick up this job
PROMPT 3. Monitor logs: tail -f logs/application.log
PROMPT 4. Check job status with the queries below
PROMPT ========================================

-- =============================================================================
-- Monitoring Queries (run these after service starts)
-- =============================================================================

-- Check job processing status
/*
SELECT
    NJOB_NR,
    NPROCESS_STATUS,
    DSTART_COMPUTING,
    DSTOP_COMPUTING,
    (DSTOP_COMPUTING - DSTART_COMPUTING) * 24 * 60 * 60 AS PROCESSING_SECONDS,
    NERROR,
    CERROR
FROM SYS_QUEUE_FLIGHT_CALC
WHERE NJOB_NR = :v_job_nr;
*/

-- Check PAX data was updated
/*
SELECT
    NRESULT_KEY,
    CCLASS,
    NPAX,
    NPAX_OLD,
    NPAX_FORECAST,
    NVERSION,
    DTIMESTAMP
FROM CEN_OUT_PAX
WHERE NRESULT_KEY = &result_key
ORDER BY CCLASS;
*/

-- Check flight status
/*
SELECT
    NRESULT_KEY,
    NSTATUS,
    NAIRCRAFTTYPE_KEY,
    CREGISTRATION,
    NAIRCONFIGURATION_KEY
FROM CEN_OUT_PPM_FLIGHTS
WHERE NRESULT_KEY = &result_key;
*/

-- =============================================================================
-- Cleanup (if needed)
-- =============================================================================
/*
-- Delete test job
DELETE FROM SYS_QUEUE_FLIGHT_PAX WHERE NJOB_NR = :v_job_nr;
DELETE FROM SYS_QUEUE_FLIGHT_CALC WHERE NJOB_NR = :v_job_nr;
COMMIT;
*/

PROMPT ========================================
PROMPT Script completed successfully!
PROMPT ========================================
