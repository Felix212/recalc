package com.lsgskychefs.cbase.middleware.preorder.business;

import java.util.concurrent.CompletableFuture;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsgskychefs.cbase.middleware.base.business.AbstractRequestService;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequest;

//@Service
//@ConditionalOnNotWebApplication
//@CenRequestType(type = CenRequestTypes.PREORDER)
public class PreorderCbaseService extends AbstractRequestService {
	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(PreorderCbaseService.class);

	@Autowired
	private PreorderService perorderService;

	@Override
	protected void init() {
		setServiceName("cbase_preorder_rim");
	}

	@Override
	public CompletableFuture<Boolean> processJob(final CenRequest jobEntity) {
		final CompletableFuture<Boolean> processFuture = new CompletableFuture<>();

		perorderService.process(jobEntity).thenApply(isDone -> processFuture.complete(isDone));

		return processFuture;
	}

	@Override
	protected Logger getLogger() {
		return LOGGER;
	}

	@Override
	public Boolean process(final CenRequest jobEntity) {
		// TODO Auto-generated method stub
		return null;
	}

}
