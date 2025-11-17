/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant.report;

import java.util.HashMap;
import java.util.Map;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenCrBrowserDetail;

/**
 * Crystal report parameters.
 *
 * @author Ingo Rietzschel - U125742
 */
public enum ReportParam {

	/** Textfeld */
	PARAM_TEXT(1L, ReportParameterType.STRING),
	/** Zahlenfeld */
	PARAM_LONG(2, ReportParameterType.LONG),
	/** Datum */
	PARAM_DATE(3, ReportParameterType.DATE),
	/** DatumZeit */
	PARAM_DATETIME(4, ReportParameterType.DATE_TIME),
	/** Range [PT] */
	PARAM_RANGELIST2(8, ReportParameterType.PARAMETER_TABLE_STRING),
	/** Buchungsklassen [PT] */
	PARAM_AIRLINECLASS(9, ReportParameterType.PARAMETER_TABLE_LONG),
	/** Workstations [PT] */
	PARAM_WORKSTATIONLIST(10, ReportParameterType.PARAMETER_TABLE_LONG),
	/** Airline */
	PARAM_AIRLINE(11, ReportParameterType.LONG),
	/** Unit */
	PARAM_UNIT(12, ReportParameterType.STRING),
	/** Range */
	PARAM_RANGELIST(13, ReportParameterType.STRING_ARRAY),
	/** Airlineliste */
	PARAM_AIRLINELIST(14, ReportParameterType.LONG_ARRAY),
	/** Multi CSC */
	PARAM_UNITLIST(15, ReportParameterType.STRING_ARRAY),
	/** Multi Item List Level */
	PARAM_ITEMLISTLEVEL(16, ReportParameterType.LONG_ARRAY),
	/** Multi Item List Types */
	PARAM_ITEMLISTTYPE(17, ReportParameterType.LONG_ARRAY),
	/** String List */
	PARAM_FREETEXTLIST(18, ReportParameterType.STRING_ARRAY),
	/** Report Master Data */
	PARAM_REPORTMASTERDATA(19, ReportParameterType.LONG),
	/** Item Lists */
	PARAM_ITEMLIST(20, ReportParameterType.LONG_ARRAY),
	/** Breakdown Codes */
	PARAM_BREAKDOWNCODE(21, ReportParameterType.STRING_ARRAY),
	/** Item List */
	PARAM_ITEMLISTSINGLE(22, ReportParameterType.LONG),
	/** Lieferantenliste */
	PARAM_SUPPLIERLIST(23, ReportParameterType.LONG_ARRAY),
	/** Fertigungsarten [PT] */
	PARAM_PRODUCTIONTYPE(24, ReportParameterType.PARAMETER_TABLE_LONG),
	/** Speisekategorien [PT] */
	PARAM_FOODCATEGORY(25, ReportParameterType.PARAMETER_TABLE_LONG),
	/** Multi Item List Level [PT] */
	PARAM_ITEMLISTLEVEL2(26, ReportParameterType.PARAMETER_TABLE_LONG),
	/** Zeitfensterliste */
	PARAM_WSSCHEDULELIST(27, ReportParameterType.LONG_ARRAY),
	/** Textobjekt (wird nicht benutzt) */
	PARAM_TEXTOBJECT(31, ReportParameterType.STRING),
	/** Units [PT] 18.02.2015 HR: Neue Auswahl Betriebe über Paramtertabelle */
	PARAM_UNITLIST2(32, ReportParameterType.PARAMETER_TABLE_STRING),
	/** Airlineliste [PT] */
	PARAM_AIRLINELIST2(33, ReportParameterType.PARAMETER_TABLE_LONG),
	/** Lieferant */
	PARAM_SUPPLIER(34, ReportParameterType.STRING),
	/** Lieferant [PT] 22.05.2015 TBR: Neue Auswahl Lieferanten über Paramtertabelle */
	PARAM_SUPPLIERLIST2(35, ReportParameterType.PARAMETER_TABLE_LONG),
	/** Item List [PT] 15.07.2015 KF: Stücklisten über Paramtertabelle */
	PARAM_ITEMLIST_PT(36, ReportParameterType.PARAMETER_TABLE_LONG),
	/** Cost Catgeory [PT] CBASE-F4-CR-2016-03 */
	PARAM_COSTCATEGORY_PT(37, ReportParameterType.PARAMETER_TABLE_LONG),
	/** Cost Catgeory [ohne PT] CBASE-F4-CR-2016-03 */
	PARAM_COSTCATEGORY(38, ReportParameterType.LONG),
	/** Product Catgeory - request #1347 CBASE-UK-CR-2015-031web */
	PARAM_PRODUCT_CATEGORY(39, ReportParameterType.PARAMETER_TABLE_STRING),
	/** ITEM LIST TYPE2 new Implementation */
	PARAM_ITEMLIST_TYPE2(40, ReportParameterType.PARAMETER_TABLE_LONG);

	/** Contains mapping between the report integer value and {@link ReportParam} */
	private static Map<Long, ReportParam> map;

	static {
		map = new HashMap<>();
		for (final ReportParam reportParam : ReportParam.values()) {
			map.put(reportParam.reportValue, reportParam);
		}
	}

	/** The corresponding value of {@link CenCrBrowserDetail#getNtype()} */
	private long reportValue;

	/** The report parameter type */
	private ReportParameterType reportParameterType;

	/**
	 * Constructor
	 *
	 * @param reportValue the corresponding value of {@link CenCrBrowserDetail#getNtype()}
	 * @param reportParameterType the report parameter type
	 */
	ReportParam(final long reportValue, final ReportParameterType reportParameterType) {
		this.reportValue = reportValue;
		this.reportParameterType = reportParameterType;
	}

	/**
	 * Get typeValue
	 *
	 * @return the typeValue
	 */
	public long getTypeValue() {
		return reportValue;
	}

	/**
	 * Get reportParameterType
	 *
	 * @return the reportParameterType
	 */
	public ReportParameterType getReportParameterType() {
		return reportParameterType;
	}

	/**
	 * Get the corresponding ReportParam.
	 *
	 * @param reportValue report value
	 * @return the corresponding WorkOrderState.
	 */
	public static ReportParam getEnum(final long reportValue) {
		final ReportParam value = map.get(reportValue);
		if (value == null) {
			throw new IllegalArgumentException("Unsupported value " + reportValue);
		}
		return value;
	}
}
