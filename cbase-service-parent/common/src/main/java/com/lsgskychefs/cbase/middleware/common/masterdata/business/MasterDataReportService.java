/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.masterdata.business;

import java.text.ParseException;
import java.util.AbstractMap.SimpleEntry;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.lang3.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lsgskychefs.cbase.middleware.base.business.AbstractCbaseMiddlewareService;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.persistence.constant.report.ReportParam;
import com.lsgskychefs.cbase.middleware.persistence.constant.report.ReportType;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenAirlines;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenCrBrowserDetail;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenReportParameters;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueBatch;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueBatchRpt;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysUnits;
import com.lsgskychefs.cbase.middleware.persistence.general.CenCrBrowserDetailRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenReportParametersRepository;
import com.lsgskychefs.cbase.middleware.persistence.global.FormatConstants;

/**
 * Helper for master data reports
 *
 * @author Ingo Rietzschel - U125742
 */
@Service
public class MasterDataReportService extends AbstractCbaseMiddlewareService {

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(MasterDataReportService.class);

	/** Maximum life time of report parameters in days. */
	private static final int MAX_LIFE_TIME = -7;

	/** _5 */
	private static final int NFUNCTION = 5;

	/** Repository to handle {@link CenReportParameters} */
	@Autowired
	private CenReportParametersRepository cenReportParametersRepository;
	/** Repository for {@link CenCrBrowserDetail} entity. */
	@Autowired
	private CenCrBrowserDetailRepository cenCrBrowserDetailRepository;

	/**
	 * Create crystal report job and return the job id.
	 *
	 * @param nreportKey the report key
	 * @param reportType type of report
	 * @param parameterMap parameter map (key,value)
	 * @return the ID of generated job
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT} if expected parameter does not exist
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID} if airline or unit not found for given id
	 *             </ul>
	 */
	public Long createCrystalReportJob(final Long nreportKey, final ReportType reportType, final Map<String, String> parameterMap)
			throws CbaseMiddlewareBusinessException {
		// load parameter details
		final List<CenCrBrowserDetail> parameterDetails = cenCrBrowserDetailRepository.findByNreportKey(nreportKey);

		// create queue entry (job)
		final SysQueueBatch queueBatch = createReportJob(nreportKey, reportType);

		final List<Long> airlineIds = new ArrayList<>();
		final List<String> unitIds = new ArrayList<>();

		final List<String> supportedReportParameterNames = new ArrayList<>();
		// create queue(job) details
		for (final CenCrBrowserDetail cenCrBrowserDetail : parameterDetails) {
			final String cparameterName = cenCrBrowserDetail.getCparameterName();
			supportedReportParameterNames.add(cparameterName);
			if (!parameterMap.containsKey(cparameterName)) {
				throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
						String.format("Missing report parameter: '%s' ! Not found on CenCrBrowserDetail.", cparameterName));
			}
			ReportParam reportParam = null;
			try {
				reportParam = ReportParam.getEnum(cenCrBrowserDetail.getNtype());
			} catch (final IllegalArgumentException e1) {
				throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
						String.format("Unsupported/not implemented ReportParam! parameter='%s' with type='%s'!", cparameterName,
								cenCrBrowserDetail.getNtype()),
						e1);
			}
			final String value = parameterMap.get(cparameterName);
			final Entry<String, String> param = new SimpleEntry<>(cparameterName, value);

			try {
				// Collect parameter informations
				collectParameterInfos(airlineIds, unitIds, reportParam, value);

				// Handle the different parameter types
				handleParameter(queueBatch, param, reportParam);
			} catch (final ParseException | NumberFormatException e) {
				throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
						String.format("Could not parse parameter %s='%s' to type: %s", cparameterName, value,
								reportParam.getReportParameterType()),
						e);
			}

		}

		final List<String> parameters = new ArrayList<>(parameterMap.keySet());
		parameters.removeAll(supportedReportParameterNames);
		if (!parameters.isEmpty()) {
			LOGGER.warn("Unsupported parameters for crytal report reportType='{}' - {}", reportType, parameters);
		}

		// set job parameter infos
		setJobParameterInfos(queueBatch, airlineIds, unitIds);
		return queueBatch.getNjobNr();
	}

	/**
	 * Create a report job with given key and type.
	 *
	 * @param nreportKey report key
	 * @param reportType type of report
	 * @return the created job
	 */
	private SysQueueBatch createReportJob(final Long nreportKey, final ReportType reportType) {
		final SysQueueBatch queueBatch = new SysQueueBatch();
		queueBatch.setNfunction(NFUNCTION);
		queueBatch.setDcreated(now());
		queueBatch.setCuser(getLoginUser().getUsername());
		queueBatch.setCtext("Crystal Report");
		queueBatch.setNstatus(0);
		queueBatch.setCfileName("New");
		queueBatch.setNreportKey(nreportKey);
		queueBatch.setNsubfunction(reportType.getSubfunction());
		save(queueBatch);
		return queueBatch;
	}

	/**
	 * Collect parameter informations(airline ids and unit ids).
	 *
	 * @param airlineIds list of airline ids
	 * @param unitIds list of unit ids
	 * @param reportParam current {@link ReportParam}
	 * @param value current value
	 */
	private void collectParameterInfos(final List<Long> airlineIds, final List<String> unitIds, final ReportParam reportParam,
			final String value) {
		final String[] parameterValues = value.split(",");

		switch (reportParam) {
		case PARAM_AIRLINE:
		case PARAM_AIRLINELIST:
			for (final String stringValue : parameterValues) {
				airlineIds.add(Long.parseLong(stringValue));
			}
			break;
		case PARAM_UNIT:
		case PARAM_UNITLIST:
			for (final String stringValue : parameterValues) {
				unitIds.add(stringValue);
			}
			break;

		default:
			break;
		}
	}

	/**
	 * Handle the different parameter types
	 *
	 * @param queueBatch job
	 * @param param current parameter name and value
	 * @param reportParam current report parameter (corresponding to parameter name)
	 * @throws ParseException on Parse error - String to Date
	 */
	private void handleParameter(final SysQueueBatch queueBatch, final Entry<String, String> param, final ReportParam reportParam)
			throws ParseException {
		String[] split;
		Long nvalue;
		switch (reportParam.getReportParameterType()) {
		case DATE:
		case DATE_TIME:
			createDateJobDetails(queueBatch, param, reportParam);
			break;
		case LONG:
			createLongJobDetails(queueBatch, param, reportParam, 0);
			break;
		case STRING_ARRAY:
			createArrayJobDetail(queueBatch, param, reportParam, false);
			break;
		case LONG_ARRAY:
			createArrayJobDetail(queueBatch, param, reportParam, true);
			break;
		case PARAMETER_TABLE_LONG:
			split = param.getValue().split(",");
			nvalue = ceateJobParameters(split, true);
			createJobDetails(queueBatch, param.getKey(), reportParam, null, nvalue, null, 0);
			break;
		case PARAMETER_TABLE_STRING:
			split = param.getValue().split(",");
			nvalue = ceateJobParameters(split, false);
			createJobDetails(queueBatch, param.getKey(), reportParam, null, nvalue, null, 0);
			break;
		default: // STRING
			createStringJobDetails(queueBatch, param, reportParam, 0);
			break;
		}
	}

	/**
	 * Set job parameter informations
	 *
	 * @param queueBatch job
	 * @param airlineIds list of airline ids
	 * @param unitIds list of unit ids
	 * @throws CbaseMiddlewareBusinessException {@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID} if airline or unit not found for
	 *             given id
	 */
	private void setJobParameterInfos(final SysQueueBatch queueBatch, final List<Long> airlineIds, final List<String> unitIds)
			throws CbaseMiddlewareBusinessException {
		final StringBuilder cparameters = new StringBuilder();
		if (airlineIds.size() == 1) {
			final CenAirlines cenAirline = findOne(CenAirlines.class, airlineIds.get(0));
			cparameters.append("Airline:").append(cenAirline.getCairline());
		}
		if (airlineIds.size() > 1) {
			cparameters.append("Airline number:").append(airlineIds.size());
		}
		if (unitIds.size() == 1) {
			final SysUnits unit = findOne(SysUnits.class, unitIds.get(0));
			cparameters.append("Unit:").append(unit.getCtext());
		}
		if (unitIds.size() > 1) {
			cparameters.append("Unit number:").append(unitIds.size());
		}

		queueBatch.setCparameters(cparameters.toString());
	}

	/**
	 * Create the job parameters ({@link CenReportParameters}) and return the report parameter group key <br>
	 * Speichert die Werte eines Arrays in die Tabelle cen_report_parameters. Das hat den Vorteil, dass auch in Crystal Reports eine Gruppe
	 * von Parametern benutzt werden kann, indem mit dem Gruppenschlüssel in die Tabelle retrieved wird.
	 *
	 * @param values the parameter value array
	 * @param isLong are parameter values Long(true) or String(false)
	 * @return the report parameter group key
	 */
	private Long ceateJobParameters(final String[] values, final boolean isLong) {
		final Date date = now();
		// remove all parameters that are older than 7 days
		cenReportParametersRepository.deleteByDtimestampBefore(DateUtils.addDays(date, MAX_LIFE_TIME));

		Long parameterGroup = null;
		for (final String string : values) {
			String cvalue = null;
			Long nvalue = null;
			if (isLong) {
				nvalue = Long.parseLong(string);
			} else {
				cvalue = string;
			}
			final CenReportParameters reportParam = new CenReportParameters();
			reportParam.setCvalue(cvalue);
			reportParam.setNvalue(nvalue);
			reportParam.setDtimestamp(date);

			save(reportParam);
			// parameter group key is the nparameterId from first report parameter
			if (parameterGroup == null) {
				parameterGroup = reportParam.getNparameterId();
			}
			reportParam.setNparameterGroup(parameterGroup);
		}
		return parameterGroup;
	}

	/**
	 * Create job details with Long value.
	 *
	 * @param queueBatch job
	 * @param param current parameter name and value
	 * @param reportParam current report parameter (corresponding to parameter name)
	 * @param isLong are parameter values Long(true) or String(false)
	 */
	private void createArrayJobDetail(final SysQueueBatch queueBatch, final Entry<String, String> param, final ReportParam reportParam,
			final boolean isLong) {
		final String[] parameterValues = param.getValue().split(",");
		final Long narrayCount = Long.valueOf(parameterValues.length);
		for (final String stringValue : parameterValues) {
			final Entry<String, String> singleParameter = new SimpleEntry<>(param.getKey(), stringValue);
			if (isLong) {
				createLongJobDetails(queueBatch, singleParameter, reportParam, narrayCount);
				continue;
			}
			createStringJobDetails(queueBatch, singleParameter, reportParam, narrayCount);
		}
	}

	/**
	 * Create job details with String value.
	 *
	 * @param queueBatch job
	 * @param param current parameter name and value
	 * @param reportParam current report parameter (corresponding to parameter name)
	 * @param narrayCount current count
	 */
	private void createStringJobDetails(final SysQueueBatch queueBatch, final Entry<String, String> param, final ReportParam reportParam,
			final long narrayCount) {
		createJobDetails(queueBatch, param.getKey(), reportParam, param.getValue(), null, null, narrayCount);
	}

	/**
	 * Create job details with Date value.
	 *
	 * @param queueBatch job
	 * @param param current parameter name and value
	 * @param reportParam current report parameter (corresponding to parameter name)
	 * @throws ParseException on Parse error - String to Date
	 */
	private void createDateJobDetails(final SysQueueBatch queueBatch, final Entry<String, String> param, final ReportParam reportParam)
			throws ParseException {
		final Date dvalue = DateUtils.parseDateStrictly(param.getValue(), FormatConstants.DATE_PATTERN);
		createJobDetails(queueBatch, param.getKey(), reportParam, null, null, dvalue, 0);
	}

	/**
	 * Create job details with Long value.
	 *
	 * @param queueBatch job
	 * @param param current parameter name and value
	 * @param reportParam current report parameter (corresponding to parameter name)
	 * @param narrayCount current count
	 */
	private void createLongJobDetails(final SysQueueBatch queueBatch, final Entry<String, String> param, final ReportParam reportParam,
			final long narrayCount) {
		final Long nvalue = Long.parseLong(param.getValue());
		createJobDetails(queueBatch, param.getKey(), reportParam, null, nvalue, null, narrayCount);
	}

	/**
	 * Create job details.
	 *
	 * @param queueBatch job
	 * @param cparameterName current parameter name
	 * @param reportParam current report parameter (corresponding to parameter name)
	 * @param cvalue current string value
	 * @param nvalue current long value
	 * @param dvalue current date value
	 * @param narrayCount current count
	 */
	private void createJobDetails(final SysQueueBatch queueBatch, final String cparameterName, final ReportParam reportParam,
			final String cvalue, final Long nvalue, final Date dvalue, final long narrayCount) {
		final SysQueueBatchRpt queueRpt = new SysQueueBatchRpt();
		queueRpt.setSysQueueBatch(queueBatch);
		queueRpt.setCparameter(cparameterName);
		queueRpt.setCdatatype(reportParam.getReportParameterType().getTypeName());
		queueRpt.setCvalue(cvalue);
		queueRpt.setDvalue(dvalue);
		queueRpt.setNvalue(nvalue);
		queueRpt.setNarrayCount(narrayCount);
		save(queueRpt);
	}
}
