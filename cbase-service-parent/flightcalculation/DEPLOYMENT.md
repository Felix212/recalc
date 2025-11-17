# Flight Calculation Service - Deployment Guide

Quick deployment guide for the Flight Calculation Service.

## 📋 Prerequisites

### System Requirements
- **Java:** OpenJDK 11 or later
- **Memory:** Minimum 512MB heap, Recommended 1GB+
- **Database:** Oracle 11g+ or PostgreSQL 9.6+
- **Network:** Access to CBASE database

### Database Setup
```sql
-- Verify required tables exist
SELECT COUNT(*) FROM SYS_QUEUE_FLIGHT_CALC;
SELECT COUNT(*) FROM SYS_QUEUE_FL_FUNCTION;
SELECT COUNT(*) FROM CEN_OUT_PPM_FLIGHTS;
SELECT COUNT(*) FROM CEN_OUT_PAX;
SELECT COUNT(*) FROM CEN_OUT_SPML;

-- Verify function configuration
SELECT * FROM SYS_QUEUE_FL_FUNCTION WHERE NFUNCTION = 1;
```

## 🚀 Deployment Steps

### 1. Build the Application

```bash
# Navigate to parent directory
cd cbase-service-parent

# Clean and build
mvn clean install -DskipTests

# Or with tests
mvn clean install

# JAR will be created at:
# flightcalculation/target/flightcalculation-1.0.0-SNAPSHOT.jar
```

### 2. Configure the Application

#### Option A: Using application.yml

Create `application-prod.yml`:

```yaml
spring:
  datasource:
    url: jdbc:oracle:thin:@//dbhost:1521/CBASE
    username: ${DB_USERNAME}
    password: ${DB_PASSWORD}
    driver-class-name: oracle.jdbc.OracleDriver
  jpa:
    properties:
      hibernate:
        dialect: org.hibernate.dialect.Oracle12cDialect
    show-sql: false

flight-calculation:
  instance-name: ${FLIGHT_CALC_INSTANCE:PRODUCTION}
  number-of-calculations-per-cycle: 50
  process-functions:
    - 1  # Function 1: FLIGHT_CALC
  scheduler:
    enabled: true
    interval-seconds: 30
    initial-delay-seconds: 10
  locking:
    timeout-millis: 60000
  always-force-meal-calculation: false
  logging:
    include-job-key: true
    include-result-key: true
    trace-level: INFO

logging:
  level:
    root: INFO
    com.lsgskychefs.cbase.middleware.flightcalculation: INFO
  file:
    name: /var/log/cbase/flightcalculation.log
    max-size: 100MB
    max-history: 30
```

#### Option B: Using Environment Variables

```bash
export DB_USERNAME=cbase_user
export DB_PASSWORD=secure_password
export FLIGHT_CALC_INSTANCE=PRODUCTION
export FLIGHT_CALC_BATCH_SIZE=50
export FLIGHT_CALC_INTERVAL=30
export FLIGHT_CALC_SCHEDULER_ENABLED=true
```

### 3. Run the Application

#### Development
```bash
cd flightcalculation
mvn spring-boot:run -Dspring.profiles.active=prod
```

#### Production (Standalone JAR)
```bash
java -jar \
  -Xms512m \
  -Xmx1g \
  -Dspring.profiles.active=prod \
  -Dspring.config.location=file:./config/application-prod.yml \
  flightcalculation/target/flightcalculation-1.0.0-SNAPSHOT.jar
```

#### Production (Service)
```bash
# Create systemd service file
sudo nano /etc/systemd/system/flightcalculation.service
```

```ini
[Unit]
Description=Flight Calculation Service
After=network.target

[Service]
Type=simple
User=cbase
Group=cbase
WorkingDirectory=/opt/cbase/flightcalculation
ExecStart=/usr/bin/java \
  -Xms512m \
  -Xmx1g \
  -Dspring.profiles.active=prod \
  -Dspring.config.location=file:/opt/cbase/flightcalculation/config/application-prod.yml \
  -jar /opt/cbase/flightcalculation/flightcalculation-1.0.0-SNAPSHOT.jar
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal
SyslogIdentifier=flightcalculation

[Install]
WantedBy=multi-user.target
```

```bash
# Enable and start service
sudo systemctl daemon-reload
sudo systemctl enable flightcalculation
sudo systemctl start flightcalculation

# Check status
sudo systemctl status flightcalculation

# View logs
sudo journalctl -u flightcalculation -f
```

### 4. Verify Deployment

#### Check Application Startup
```bash
# Wait for startup log
tail -f /var/log/cbase/flightcalculation.log | grep "Started FlightCalculationApplication"
```

Expected output:
```
2025-11-17 10:00:00 INFO  FlightCalculationApplication - Started FlightCalculationApplication in 5.123 seconds
2025-11-17 10:00:10 INFO  FlightCalculationScheduler - Starting job polling cycle: instance=PRODUCTION
```

#### Verify Scheduler is Running
```bash
# Check logs for polling cycles
tail -f /var/log/cbase/flightcalculation.log | grep "polling cycle"
```

Expected output every 30 seconds:
```
2025-11-17 10:00:10 INFO  FlightCalculationScheduler - Starting job polling cycle
2025-11-17 10:00:11 INFO  FlightCalculationScheduler - Completed job polling cycle: processed=0
```

#### Check Database Connection
```sql
-- Verify jobs are being processed
SELECT
    NJOB_NR,
    NRESULT_KEY,
    NPROCESS_STATUS,
    DSTART_COMPUTING,
    DSTOP_COMPUTING,
    CINSTANCE
FROM SYS_QUEUE_FLIGHT_CALC
WHERE CINSTANCE = 'PRODUCTION'
  AND DSTART_COMPUTING > SYSDATE - 1/24  -- Last hour
ORDER BY DSTART_COMPUTING DESC;

-- Check processing statistics
SELECT
    NPROCESS_STATUS,
    COUNT(*) as JOB_COUNT,
    AVG(DSTOP_COMPUTING - DSTART_COMPUTING) * 24 * 60 * 60 as AVG_SECONDS
FROM SYS_QUEUE_FLIGHT_CALC
WHERE CINSTANCE = 'PRODUCTION'
  AND DSTART_COMPUTING > SYSDATE - 1  -- Last 24 hours
GROUP BY NPROCESS_STATUS
ORDER BY NPROCESS_STATUS;
```

## 🔒 Security Considerations

### 1. Database Credentials
```bash
# Never hardcode passwords!
# Use environment variables or secrets management

# Example: Using Kubernetes secrets
kubectl create secret generic cbase-db-credentials \
  --from-literal=username=cbase_user \
  --from-literal=password=secure_password
```

### 2. Application User
```bash
# Create dedicated user
sudo useradd -r -s /bin/false cbase

# Set file permissions
sudo chown -R cbase:cbase /opt/cbase/flightcalculation
sudo chmod 750 /opt/cbase/flightcalculation
sudo chmod 640 /opt/cbase/flightcalculation/config/*.yml
```

### 3. Network Security
- Restrict database access to application server IP
- Use VPN or private network for database connections
- Enable SSL/TLS for database connections

## 📊 Monitoring

### Health Checks

```bash
# Check if process is running
ps aux | grep flightcalculation

# Check memory usage
ps aux | grep flightcalculation | awk '{print $6}'

# Check file descriptors
lsof -p $(pgrep -f flightcalculation) | wc -l
```

### Application Metrics

Monitor these key metrics:

1. **Job Processing Rate**
   ```sql
   SELECT COUNT(*) / 60 as JOBS_PER_MINUTE
   FROM SYS_QUEUE_FLIGHT_CALC
   WHERE CINSTANCE = 'PRODUCTION'
     AND DSTART_COMPUTING > SYSDATE - 1/24;
   ```

2. **Success Rate**
   ```sql
   SELECT
       COUNT(CASE WHEN NPROCESS_STATUS = 3 THEN 1 END) * 100.0 / COUNT(*) as SUCCESS_RATE
   FROM SYS_QUEUE_FLIGHT_CALC
   WHERE CINSTANCE = 'PRODUCTION'
     AND DSTART_COMPUTING > SYSDATE - 1;
   ```

3. **Average Processing Time**
   ```sql
   SELECT
       AVG(DSTOP_COMPUTING - DSTART_COMPUTING) * 24 * 60 * 60 as AVG_SECONDS
   FROM SYS_QUEUE_FLIGHT_CALC
   WHERE CINSTANCE = 'PRODUCTION'
     AND NPROCESS_STATUS = 3
     AND DSTART_COMPUTING > SYSDATE - 1;
   ```

### Alerting

Set up alerts for:
- Job failure rate > 5%
- Average processing time > 30 seconds
- Queue depth > 1000 pending jobs
- No jobs processed in last 5 minutes (scheduler stalled)
- Application crash/restart

## 🔧 Troubleshooting

### Service Won't Start

1. **Check Java Version**
   ```bash
   java -version
   # Should be 11 or higher
   ```

2. **Check Database Connectivity**
   ```bash
   # Test connection
   telnet dbhost 1521

   # Or use sqlplus
   sqlplus cbase_user/password@dbhost:1521/CBASE
   ```

3. **Check Configuration**
   ```bash
   # Verify YAML syntax
   python -c "import yaml; yaml.safe_load(open('config/application-prod.yml'))"
   ```

4. **Check Logs**
   ```bash
   tail -100 /var/log/cbase/flightcalculation.log
   ```

### Jobs Not Processing

1. **Verify Scheduler is Enabled**
   ```yaml
   flight-calculation:
     scheduler:
       enabled: true  # Must be true
   ```

2. **Check for Pending Jobs**
   ```sql
   SELECT COUNT(*)
   FROM SYS_QUEUE_FLIGHT_CALC
   WHERE NPROCESS_STATUS IN (0, 4)
     AND (CINSTANCE = 'PRODUCTION' OR CINSTANCE IS NULL);
   ```

3. **Check Instance Name**
   ```bash
   # Verify instance name matches
   grep "instance-name" config/application-prod.yml
   ```

4. **Check Function Configuration**
   ```sql
   SELECT * FROM SYS_QUEUE_FL_FUNCTION WHERE NFUNCTION = 1;
   ```

### High Memory Usage

1. **Check Heap Settings**
   ```bash
   # Increase heap if needed
   -Xms1g -Xmx2g
   ```

2. **Enable GC Logging**
   ```bash
   -XX:+PrintGCDetails
   -XX:+PrintGCDateStamps
   -Xloggc:/var/log/cbase/gc.log
   ```

3. **Reduce Batch Size**
   ```yaml
   flight-calculation:
     number-of-calculations-per-cycle: 10  # Reduce from 50
   ```

### Database Lock Conflicts

1. **Check Lock Timeout**
   ```yaml
   flight-calculation:
     locking:
       timeout-millis: 120000  # Increase to 2 minutes
   ```

2. **Monitor Retry Rate**
   ```sql
   SELECT COUNT(*)
   FROM SYS_QUEUE_FLIGHT_CALC
   WHERE NPROCESS_STATUS = 4  -- RETRY status
     AND CINSTANCE = 'PRODUCTION';
   ```

3. **Increase Polling Interval**
   ```yaml
   flight-calculation:
     scheduler:
       interval-seconds: 60  # Increase from 30
   ```

## 🔄 Rollback Procedure

If issues occur after deployment:

1. **Stop the Service**
   ```bash
   sudo systemctl stop flightcalculation
   ```

2. **Reset Job Statuses**
   ```sql
   -- Reset stuck jobs
   UPDATE SYS_QUEUE_FLIGHT_CALC
   SET NPROCESS_STATUS = 0
   WHERE CINSTANCE = 'PRODUCTION'
     AND NPROCESS_STATUS = 1
     AND DSTART_COMPUTING < SYSDATE - 1/24;  -- Older than 1 hour

   COMMIT;
   ```

3. **Restore Previous Version**
   ```bash
   # Restore previous JAR
   cp flightcalculation-previous.jar flightcalculation-1.0.0-SNAPSHOT.jar

   # Restart service
   sudo systemctl start flightcalculation
   ```

## 📈 Performance Tuning

### Recommended Settings

**Small Environment (< 100 jobs/hour)**
```yaml
flight-calculation:
  number-of-calculations-per-cycle: 10
  scheduler:
    interval-seconds: 60
```
```bash
-Xms256m -Xmx512m
```

**Medium Environment (100-500 jobs/hour)**
```yaml
flight-calculation:
  number-of-calculations-per-cycle: 25
  scheduler:
    interval-seconds: 30
```
```bash
-Xms512m -Xmx1g
```

**Large Environment (> 500 jobs/hour)**
```yaml
flight-calculation:
  number-of-calculations-per-cycle: 50
  scheduler:
    interval-seconds: 15
```
```bash
-Xms1g -Xmx2g
```

### Database Connection Pool

```yaml
spring:
  datasource:
    hikari:
      maximum-pool-size: 10
      minimum-idle: 5
      connection-timeout: 30000
      idle-timeout: 600000
      max-lifetime: 1800000
```

## ✅ Post-Deployment Checklist

- [ ] Application starts successfully
- [ ] Database connection working
- [ ] Scheduler polling visible in logs
- [ ] Test job processed successfully
- [ ] Monitoring alerts configured
- [ ] Log rotation configured
- [ ] Backup procedure documented
- [ ] Rollback procedure tested
- [ ] Team trained on operations

## 📞 Support

### During Deployment
- Migration Team: Available for deployment support
- Database Team: For database access issues
- Operations Team: For server and network issues

### After Deployment
- Check documentation in README.md
- Review logs in /var/log/cbase/
- Monitor job queue statistics
- Contact support if issues persist

---

*Deployment Guide - Flight Calculation Service*
*Version: 1.0.0*
*Last Updated: 2025-11-17*
