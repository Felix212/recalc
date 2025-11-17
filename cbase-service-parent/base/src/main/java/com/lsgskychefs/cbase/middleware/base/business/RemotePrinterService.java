/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.business;

import java.util.Date;

import org.springframework.stereotype.Service;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.persistence.constant.RemotePrinterFunction;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenDocGenQueueRp;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysRemotePrinter;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysRemotePrinterFunc;

/**
 * @author Dirk Bunk - U200035
 */
@Service
public class RemotePrinterService extends AbstractCbaseMiddlewareService {
	/**
	 * Adds a new job to the remote printing queue {@link CenDocGenQueueRp}.
	 * 
	 * @param printerKey the key of the printer (see {@link SysRemotePrinter}).
	 * @param reportData the data to print.
	 * @param remotePrinterFunction the remote printer function to use (see {@link SysRemotePrinterFunc}). If possible use a constant from
	 *            {@link RemotePrinterFunction}.
	 * @param filename the filename for the print job.
	 * @param description the description for the print job.
	 * @return {@code true} job added / {@code false} failed to add job
	 * @throws CbaseMiddlewareBusinessException
	 */
	public boolean addPrintJob(final Long printerKey, final byte[] reportData, final Long remotePrinterFunction,
			final String filename, final String description) throws CbaseMiddlewareBusinessException {

		if (printerKey == null) {
			return false;
		}

		final SysRemotePrinter remotePrinter = this.findOne(SysRemotePrinter.class, printerKey);
		if (remotePrinter == null) {
			return false;
		}

		final CenDocGenQueueRp cenDocGenQueueRp = new CenDocGenQueueRp();
		final SysRemotePrinterFunc sysRemotePrinterFunc = this.findOne(SysRemotePrinterFunc.class, remotePrinterFunction);

		cenDocGenQueueRp.setSysRemotePrinterFunc(sysRemotePrinterFunc);
		cenDocGenQueueRp.setBreport(reportData);
		cenDocGenQueueRp.setCfilename(filename);
		cenDocGenQueueRp.setCjobCreatedBy(getLoginUser().getUsername());
		cenDocGenQueueRp.setDjobCreated(new Date());
		cenDocGenQueueRp.setSysRemotePrinter(remotePrinter);
		cenDocGenQueueRp.setCjobDescription(description);
		save(cenDocGenQueueRp);

		return true;
	}

	/**
	 * Adds a new job to the remote printing queue {@link CenDocGenQueueRp}.
	 * 
	 * @param printerKey the key of the printer (see {@link SysRemotePrinter}).
	 * @param reportData the data to print.
	 * @param remotePrinterFunction the {@link RemotePrinterFunction} to use.
	 * @param filename the filename for the print job.
	 * @param description the description for the print job.
	 * @return {@code true} job added / {@code false} failed to add job
	 * @throws CbaseMiddlewareBusinessException
	 */
	public boolean addPrintJob(final Long printerKey, final byte[] reportData, final RemotePrinterFunction remotePrinterFunction,
			final String filename, final String description) throws CbaseMiddlewareBusinessException {
		return addPrintJob(printerKey, reportData, remotePrinterFunction.getFunctionValue(), filename, description);
	}
}
