package com.lsgskychefs.cbase.middleware.citp.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

/**
 * Date operations
 */
public final class DateHelper {

    private static final Logger LOGGER = LoggerFactory.getLogger(DateHelper.class);
    public static final String DEFAULT_FORMAT_IN = "ddMMyy";
    private static final String DEFAULT_FORMAT_OUT = "ddMMM";

    public static final String DEFAULT_HOUR_MINUTE = "HH:mm";

    /**
     * date format as specified in database.
     */
    public static final String DEFAULT_DATE_FORMAT = "dd:MM:yyyy HH:mm:ss";

    public static final String DATE_FORMAT_MESSAGE_QUEUE = "yyyy-MM-dd HH:mm:ss";
    public static final String DATE_FORMAT_MESSAGE_QUEUE_FSP = "yyyy-MM-dd'T'HH:mm";

    /**
     * date format not implemented static. For more information on this see Sun
     * Bug #6231579 and Sun Bug #6178997.
     */
    public final SimpleDateFormat DATE_FORMAT_0 = new SimpleDateFormat("dd.MM.yy");

    /**
     * date format not implemented static. For more information on this see Sun
     * Bug #6231579 and Sun Bug #6178997.
     */
    public final SimpleDateFormat DATE_FORMAT_1 = new SimpleDateFormat("yyyyMM");

    public static String convert(String date, String fmtin, String fmtout) {
        if (date == null || date.length() == 0)
            return "";
        if (fmtin == null || fmtin.length() == 0)
            fmtin = DEFAULT_FORMAT_IN;
        if (fmtout == null || fmtout.length() == 0)
            fmtout = DEFAULT_FORMAT_OUT;

        try {
            SimpleDateFormat fmtIN = new SimpleDateFormat(fmtin);
            SimpleDateFormat fmtOUT = new SimpleDateFormat(fmtout,
                    Locale.GERMAN);

            java.util.Date tdate = fmtIN.parse(date);
            return fmtOUT.format(tdate);

        } catch (Exception ex) {
            LOGGER.error("Error converting date:" + ex.toString(), ex);
            return "";
        }
    }

    /**
     * formatDate - Converts a date into string with format [ddMMyy].
     *
     * @param aDate current date
     * @return String formatted date as string
     */
    public static String formatDate(final Date aDate) {
        SimpleDateFormat fmt = new SimpleDateFormat("ddMMyy");
        return fmt.format(aDate);
    }

    public static Date parseDate(String aDate, SimpleDateFormat fmt) {
        try {
            Calendar cal = Calendar.getInstance();
            if (aDate != null) {
                cal.setTime(fmt.parse(aDate)); // the date now
            } else {
                cal.setTime(new Date());
            }
            cal.set(Calendar.HOUR_OF_DAY, 0);
            cal.set(Calendar.MINUTE, 0);
            cal.set(Calendar.SECOND, 0);
            cal.set(Calendar.MILLISECOND, 0);

            return cal.getTime();
        } catch (Exception ex) {
            LOGGER.error("Error parsing date:" + ex.toString(), ex);
            return null;
        }
    }

    /**
     * Delivers the Date in the standard format as String.
     *
     * @return date as string
     */
    public String getStandardDate() {
        return getStandardDate(new Date());
    }


    /**
     * Delivers the Date in the standard format as String.
     *
     * @return date as string
     */
    public static String getStandardDate(Date date) {
        SimpleDateFormat df = new SimpleDateFormat(DEFAULT_DATE_FORMAT);
        return df.format(date);
    }

    /**
     * Delivers the Date in the standard format as String.
     *
     * @return date as string
     */
    public static String getStandardDateMessageQueue(Date date) {
        SimpleDateFormat df = new SimpleDateFormat(DATE_FORMAT_MESSAGE_QUEUE);
        return df.format(date);
    }

    /**
     * Delivers the Date in the standard format as Date.
     *
     * @return date as Date
     */
    public static Date getStandardDateObjectMessageQueue(String date) {

        SimpleDateFormat fmtIN = new SimpleDateFormat(DATE_FORMAT_MESSAGE_QUEUE);
        SimpleDateFormat fmtINFSP = new SimpleDateFormat(DATE_FORMAT_MESSAGE_QUEUE_FSP);

        try {
            return fmtIN.parse(date);
        } catch (ParseException e) {

            try {
                return fmtINFSP.parse(date);
            } catch (ParseException pe) {
                LOGGER.error(pe.getMessage(), pe);
                return null;
            }
        }
    }
}
