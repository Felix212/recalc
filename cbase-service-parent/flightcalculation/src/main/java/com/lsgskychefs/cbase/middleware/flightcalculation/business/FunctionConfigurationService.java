/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.SysQueueFlFunctionRepository;
import com.lsgskychefs.cbase.middleware.flightcalculation.pojo.FunctionConfiguration;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlFunction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * Service for managing flight calculation function configurations.
 * Caches function configurations from SYS_QUEUE_FL_FUNCTION table.
 *
 * <p>PowerBuilder equivalent: dsSysQueueFunctions datastore
 *
 * @author Migration Team
 */
@Service
public class FunctionConfigurationService {

	private static final Logger LOGGER = LoggerFactory.getLogger(FunctionConfigurationService.class);

	@Autowired
	private SysQueueFlFunctionRepository functionRepository;

	/**
	 * Cache of function configurations by function ID.
	 */
	private final Map<Integer, FunctionConfiguration> functionCache = new HashMap<>();

	/**
	 * Load all function configurations on startup.
	 * PowerBuilder equivalent: dsSysQueueFunctions.retrieve()
	 */
	@PostConstruct
	public void loadFunctionConfigurations() {
		LOGGER.info("Loading flight calculation function configurations");

		List<SysQueueFlFunction> functions = functionRepository.findAllOrderedByFunction();

		if (functions.isEmpty()) {
			LOGGER.error("No functions found in SYS_QUEUE_FL_FUNCTION - no processing possible!");
			throw new IllegalStateException("No function configurations found in database");
		}

		functions.forEach(this::cacheFunctionConfiguration);

		LOGGER.info("Loaded {} function configurations", functionCache.size());
	}

	/**
	 * Get function configuration by function ID.
	 *
	 * @param functionId Function ID
	 * @return Optional function configuration
	 */
	public Optional<FunctionConfiguration> getFunctionConfiguration(Integer functionId) {
		FunctionConfiguration config = functionCache.get(functionId);

		if (config == null) {
			LOGGER.warn("Function configuration not found for function={}", functionId);
			// Try to reload from database
			reloadFunctionConfiguration(functionId);
			config = functionCache.get(functionId);
		}

		return Optional.ofNullable(config);
	}

	/**
	 * Get all function configurations with a specific internal function type.
	 *
	 * @param internalFunction Internal function type
	 * @return List of function configurations
	 */
	public List<FunctionConfiguration> getFunctionsByInternalType(Integer internalFunction) {
		return functionCache.values().stream()
				.filter(config -> config.getInternalFunction() != null &&
						config.getInternalFunction().equals(internalFunction))
				.toList();
	}

	/**
	 * Get all function configurations with a specific queued release interface.
	 *
	 * @param queuedReleaseInterface Queued release interface value
	 * @return List of function configurations
	 */
	public List<FunctionConfiguration> getFunctionsByQueuedReleaseInterface(Integer queuedReleaseInterface) {
		return functionCache.values().stream()
				.filter(config -> config.getQueuedReleaseInterface() != null &&
						config.getQueuedReleaseInterface().equals(queuedReleaseInterface))
				.toList();
	}

	/**
	 * Reload all function configurations from database.
	 */
	public void reloadAllConfigurations() {
		LOGGER.info("Reloading all function configurations");
		functionCache.clear();
		loadFunctionConfigurations();
	}

	/**
	 * Reload a specific function configuration from database.
	 *
	 * @param functionId Function ID
	 */
	private void reloadFunctionConfiguration(Integer functionId) {
		LOGGER.debug("Reloading function configuration for function={}", functionId);

		functionRepository.findByNfunction(functionId)
				.ifPresent(this::cacheFunctionConfiguration);
	}

	/**
	 * Convert entity to DTO and cache it.
	 *
	 * @param entity SysQueueFlFunction entity
	 */
	private void cacheFunctionConfiguration(SysQueueFlFunction entity) {
		FunctionConfiguration config = new FunctionConfiguration();
		config.setFunction(entity.getNfunction());
		config.setText(entity.getCtext());
		config.setProtocolText(entity.getCprotocolText());
		config.setInternalFunction(entity.getNinternalFunction());
		config.setQueuedReleaseInterface(entity.getNqueuedReleaseInterface());
		config.setReadFromHistory(entity.getNreadFromHistory());
		config.setPaxType(entity.getNpaxType());
		config.setUseAsPaxType(entity.getNuseAsPaxType());
		config.setStatusAfterProcess(entity.getNstatusAfterProcess());
		config.setStatusToProcess(entity.getNstatusToProcess());
		config.setActype(entity.getNactype());
		config.setUseAsActype(entity.getNuseAsActype());

		functionCache.put(entity.getNfunction(), config);

		LOGGER.debug("Cached function configuration: function={}, internalFunction={}, text={}",
				entity.getNfunction(), entity.getNinternalFunction(), entity.getCtext());
	}

	/**
	 * Get the number of cached function configurations.
	 *
	 * @return Number of configurations
	 */
	public int getCachedConfigurationCount() {
		return functionCache.size();
	}
}
