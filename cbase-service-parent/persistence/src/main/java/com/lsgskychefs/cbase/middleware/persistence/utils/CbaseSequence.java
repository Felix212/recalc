/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.utils;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenKeyList;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOut;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMaster;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpm;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysFlightPricer;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightMeals;
import com.lsgskychefs.cbase.middleware.persistence.query.NativeQueryProviderImpl;

/**
 * Name of special sequence.
 *
 * @author Ingo Rietzschel - U125742
 * @see NativeQueryProviderImpl
 */
public enum CbaseSequence {
	/** Name of sequence to generate a new {@link CenOutPpm} nbatchSeq number */
	SEQ_CEN_OUT_PPM_BATCH_SEQ,
	/** Name of sequence to generate a id part of {@link SysQueueFlightMeals} */
	SEQ_CEN_OUT_MEALS,
	/** Name of sequence to generate a new transaction for {@link CenOut} */
	SEQ_CEN_OUT_HISTORY,
	/** Name of sequence to generate a new {@link SysFlightPricer} */
	SEQ_SYS_FLIGHT_PRICER,
	/** Name of sequence to generate a new {@link CenKeyList} */
	SEQ_CEN_KEY_LIST,
	/** Name of sequence to generate a new {@link CenOutMaster} */
	SEQ_CEN_OUT_MASTER,
	/** Name of sequence to generate a new flight */
	SEQ_CEN_OUT;
}
