package com.lsgskychefs.cbase.middleware.citp.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.SimpleDateFormat;

public class Statistics implements Runnable {

    /**
     * Identifier for CITPTask statistics.
     */
    public static final String CITP_TASK = "CITPTask";
    /**
     * Identifier for IFLIR request call statistics.
     */
    public static final String IFLIR_REQUEST = "IFLIR request";
    /**
     * Identifier for SBRList request call statistics.
     */
    public static final String SBRLIST_REQUEST = "SBRList request";
    /**
     * Identifier for IFLIR request call statistics.
     */
    public static final String DCSFLT_REQUEST = "DCSFLT request";
    /**
     * Identifier for result storing statistics.
     */
    public static final String RESULT_ELABORATION = "Request elaborated";
    private static final Logger LOGGER = LoggerFactory.getLogger(Statistics.class);
    /**
     * The static instance
     */
    private static Statistics instance = null;
    private static Thread thisThread = null;
    /**
     * Indicates if the statistics thread already is running.
     */
    private static boolean started = false;
    private static boolean stillRunning = true;
    /**
     * The number of logged CITPTasks.
     */
    private long numberCITPTasks = 0;
    /**
     * The average time needed to complete a CITPTask.
     */
    private long averageCITPTask = 0;
    /**
     * The number of logged IFLIR calls.
     */
    private long numberIflir = 0;
    /**
     * The average time needed to complete a IFLIR call.
     */
    private long averageIflir = 0;
    /**
     * The number of logged SBRList calls.
     */
    private long numberSbrlist = 0;
    /**
     * The average time needed to complete a SBRList call.
     */
    private long averageSbrlist = 0;
    /**
     * The number of logged result storings.
     */
    private long numberResultStoring = 0;
    /**
     * The average time needed to complete a result storing.
     */
    private long averageResultStoring = 0;
    /**
     * The lock object for the synchronization of this class
     */
    private Object lock;
    /**
     * The time intervall the statistics thread logs its data
     */
    private long intervall;

    /**
     * Private constructor.
     */
    private Statistics() {
        lock = new Object();
    }

    /**
     * @return the static <code>Statistics</code> instance.
     */
    public static synchronized Statistics getInstance() {
        if (instance == null) {
            instance = new Statistics();
        }
        return instance;
    }

    /**
     * Starts a Statistics thread that will log the statistics in the given time
     * intervall.
     */
    public static void startStatistics(long timeIntervall) {
        if (!started) {
            Statistics.getInstance().setIntervall(timeIntervall);
            thisThread = new Thread(Statistics.getInstance());
            thisThread.setDaemon(true);
            thisThread.start();
            started = true;
        } else {
            throw new RuntimeException("Statistics thread started twice!");
        }
    }

    public static void stopStatistics() {
        if (thisThread != null) {
            setStillRunning(false);
            if (thisThread.isAlive()) {
                thisThread.interrupt();
            }
        }
    }

    public static boolean isStillRunning() {
        return stillRunning;
    }

    public static void setStillRunning(boolean stillRunning) {
        Statistics.stillRunning = stillRunning;
    }

    /**
     * Logs the given statistical data for a finished action and includes the
     * data in the overall statistics.
     *
     * @param action     The action that was finished.
     * @param startTime  The time when the action started.
     * @param endTime    The time when the action finished.
     * @param threadName The name of the thread that run the action.
     */
    public void notifyStatistic(String action, long startTime, long endTime,
                                String threadName) {
        SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss,SSS");
        long duration = endTime - startTime;
        LOGGER.info(action + " started at " + format.format(startTime)
                + " finished at " + format.format(endTime) + " and took "
                + (endTime - startTime) + " ms. Thread name: " + threadName);

        synchronized (lock) {
            if (CITP_TASK.equals(action)) {
                averageCITPTask = computeAverage(averageCITPTask,
                        numberCITPTasks, duration);
                numberCITPTasks++;
            }
            if (IFLIR_REQUEST.equals(action)) {
                averageIflir = computeAverage(averageIflir, numberIflir,
                        duration);
                numberIflir++;
            }
            if (SBRLIST_REQUEST.equals(action)) {
                averageSbrlist = computeAverage(averageSbrlist, numberSbrlist,
                        duration);
                numberSbrlist++;
            }
            if (RESULT_ELABORATION.equals(action)) {
                averageResultStoring = computeAverage(averageResultStoring,
                        numberResultStoring, duration);
                numberResultStoring++;
            }
        }
    }

    /**
     * Computes a new average from an old average and a new element.
     *
     * @param oldAverage  The old average value.
     * @param oldNumber   The old number of elements the old average was computed for.
     * @param newDuration The new element.
     * @return the new average duration.
     */
    private long computeAverage(long oldAverage, long oldNumber,
                                long newDuration) {
        return ((oldAverage * oldNumber) + newDuration) / (oldNumber + 1);
    }

    /**
     * Logs the statistics.
     */
    public void logStatistics() {
        long myNumberCITPTasks;
        long myAverageCITPTask;
        long myNumberIflir;
        long myAverageIflir;
        long myNumberSbrlist;
        long myAverageSbrlist;
        long myNumberResultStoring;
        long myAverageResultStoring;

        // copy the values into temporary variables to minimize the
        // locking-times, so that
        // the logging does not have to be inside the synchronized-block
        synchronized (lock) {
            myNumberCITPTasks = numberCITPTasks;
            myAverageCITPTask = averageCITPTask;
            myNumberIflir = numberIflir;
            myAverageIflir = averageIflir;
            myNumberSbrlist = numberSbrlist;
            myAverageSbrlist = averageSbrlist;
            myNumberResultStoring = numberResultStoring;
            myAverageResultStoring = averageResultStoring;
        }

        LOGGER.info("Statistics:");
        LOGGER.info(String.format("Number of finished CITPTasks:                      %d", myNumberCITPTasks));
        LOGGER.info(String.format("Average time spent for CITPTasks (ms):             %d", myAverageCITPTask));
        LOGGER.info(String.format("Number of finished IFLIR requests:                 %d", myNumberIflir));
        LOGGER.info(String.format("Average time spent for IFLIR requests (ms):        %d", myAverageIflir));
        LOGGER.info(String.format("Number of finished SBRList requests:               %d", myNumberSbrlist));
        LOGGER.info(String.format("Average time spent for SBRList requests (ms):      %d", myAverageSbrlist));
        LOGGER.info(String.format("Number of finished result storings to DB:          %d", myNumberResultStoring));
        LOGGER.info(String.format("Average time spent for result storings to DB (ms): %d", myAverageResultStoring));
    }

    /**
     * @see java.lang.Runnable#run()
     */
    public void run() {
        while (Statistics.isStillRunning()) {
            try {
                Thread.sleep(intervall);
            } catch (InterruptedException e) {
                LOGGER.info("Statistics thread interrupted. Finishing...");
                return;
            }
            logStatistics();
        }
    }

    /**
     * @param intervall The new time interval
     */
    public void setIntervall(long intervall) {
        this.intervall = intervall;
    }
}
