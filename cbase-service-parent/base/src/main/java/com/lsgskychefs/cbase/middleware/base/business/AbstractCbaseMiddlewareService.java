/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.business;

import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.persistence.EntityManager;
import javax.persistence.LockModeType;

import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.transaction.annotation.Transactional;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.persistence.CbaseMiddlewarePessimisticLockException;
import com.lsgskychefs.cbase.middleware.persistence.CbaseMiddlewareRepository;
import com.lsgskychefs.cbase.middleware.persistence.domain.DomainObject;
import com.lsgskychefs.cbase.middleware.persistence.query.NativeQueryProvider;

/**
 * Base service with methods for all services
 *
 * @author Ingo Rietzschel - U125742
 */
@Transactional
public abstract class AbstractCbaseMiddlewareService {

	/** The database time zone */
	private TimeZone dbTimeZone;

	/** CBASE-Middleware configuration property service */
	@Autowired
	protected CbaseMiddlewareConfigurationService configService;

	/** Generic Repository. */
	@Autowired
	protected CbaseMiddlewareRepository cbaseMiddlewareRepository;

	/** provider to get db time zone and sequences */
	@Autowired
	protected NativeQueryProvider nativeQueryProvider;

	/**
	 * Current user.
	 *
	 * @return current user
	 */
	protected CbaseMiddlewareUser getLoginUser() {
		final Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		return (CbaseMiddlewareUser) auth.getPrincipal();
	}

	/**
	 * The current mandant/client (cclient on db)
	 *
	 * @return the current mandant/client
	 */
	protected String getClient() {
		return configService.getClient();
	}

	/**
	 * The context relevant supplier.
	 *
	 * @return the context relevant supplier.
	 */
	protected Long getSupplier() {
		return configService.getSupplier();
	}

	/**
	 * Get the current date with database timezone
	 *
	 * @return the current date with database timezone
	 */
	protected Date now() {

		if (dbTimeZone == null) {
			dbTimeZone = nativeQueryProvider.getDatabaseTimeZone();
		}
		return Calendar.getInstance(dbTimeZone).getTime();
	}

	/**
	 * Get the current date with database timezone
	 *
	 * @return the current date without time with database timezone
	 */
	protected Date today() {
		return DateUtils.truncate(now(), Calendar.DAY_OF_MONTH);
	}

	/**
	 * Find DomainObject by primary key.
	 *
	 * @param <T> the entity type
	 * @param clazz entity class
	 * @param pk primary key
	 * @return the found entity instance
	 * @throws CbaseMiddlewareBusinessException if no entity is found {@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID}
	 */
	protected <T extends DomainObject> T findOne(final Class<T> clazz, final Object pk) throws CbaseMiddlewareBusinessException {
		final T domainObject = cbaseMiddlewareRepository.findOne(clazz, pk);
		if (domainObject == null) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.UNKNOWN_ID,
					String.format("Could not found %s with pk=%s ", clazz, pk));
		}
		return domainObject;
	}

	/**
	 * Find DomainObject by primary key and lock.
	 *
	 * @param <T> the entity type
	 * @param domainClass domain/entity class
	 * @param pk primary key
	 * @param lockMode lock mode
	 * @return the found entity instance or null if the entity does not exist
	 * @throws CbaseMiddlewarePessimisticLockException if a LockTimeoutException or PessimisticLockException occured (if the entity is
	 *             locked)
	 * @see EntityManager#find(Class, Object, LockModeType)
	 */
	public <T extends DomainObject> T findOne(final Class<T> domainClass, final Object pk, final LockModeType lockMode) {
		return cbaseMiddlewareRepository.findOne(domainClass, pk, lockMode);
	}

	/**
	 * Find DomainObject by primary key and lock, using the specified properties.
	 *
	 * @param <T> the entity type
	 * @param domainClass domain/entity class
	 * @param pk primary key
	 * @param lockMode lock mode
	 * @param properties standard and vendor-specific properties and hints
	 * @return the found entity instance or null if the entity does not exist
	 * @throws CbaseMiddlewareBusinessException - {@link CbaseMiddlewareBusinessExceptionType#LOCKED} if the entity is locked
	 * @see EntityManager#find(Class, Object, LockModeType, Map)
	 */
	public <T extends DomainObject> T findOne(final Class<T> domainClass, final Object pk, final LockModeType lockMode,
			final Map<String, Object> properties) throws CbaseMiddlewareBusinessException {
		try {
			return cbaseMiddlewareRepository.findOne(domainClass, pk, lockMode, properties);
		} catch (final CbaseMiddlewarePessimisticLockException e) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.LOCKED, e.getMessage(), e);
		}
	}

	/**
	 * Find all entities for given type
	 *
	 * @param <T> the entity type
	 * @param clazz entity class
	 * @return all entities for given type.
	 */
	protected <T extends DomainObject> List<T> findAll(final Class<T> clazz) {
		return cbaseMiddlewareRepository.findAll(clazz);
	}

	/**
	 * Find all entities for given type
	 *
	 * @param <T> the entity type
	 * @param clazz entity class
	 * @param entityGraphName the name of entity graph
	 * @return all entities for given type.
	 */
	protected <T extends DomainObject> List<T> findAll(final Class<T> clazz, final String entityGraphName) {
		return cbaseMiddlewareRepository.findAll(clazz, entityGraphName);
	}

	/**
	 * Delete the given {@link DomainObject}(entity)
	 *
	 * @param domainObject domain object instance to delete/remove
	 */
	protected void delete(final DomainObject domainObject) {
		cbaseMiddlewareRepository.delete(domainObject);
	}

	/**
	 * Make an instance managed and persistent.
	 *
	 * @param domainObject domain object instance to persist
	 */
	protected void save(final DomainObject domainObject) {
		cbaseMiddlewareRepository.save(domainObject);
	}

	/**
	 * Make an instance managed and persistent using a new transaction that is not bound to any surrounding transaction. Thus the persisted
	 * state will survive any rollbacks on surrounding transactions.
	 *
	 * @param domainObject domain object instance to persist
	 */
	// TODO @iri: Die Methode sollte protected sein. NotificationControllerWebIntegrationTest verhindert das aktuell
	public void saveInOwnTransaction(final DomainObject domainObject) {
		cbaseMiddlewareRepository.saveInOwnTransaction(domainObject);
	}

	/**
	 * Makes the given instances managed and persistent using a new transaction that is not bound to any surrounding transaction. Thus the
	 * persisted states will survive any rollbacks on surrounding transactions.
	 *
	 * @param <T> the entity type
	 * @param domainObjects domain objects to persist
	 */
	protected <T extends DomainObject> void saveInOwnTransaction(final Collection<T> domainObjects) {
		cbaseMiddlewareRepository.saveInOwnTransaction(domainObjects);
	}

	/**
	 * Manually advices the EntityManager to perform a flush now. Synchronize the persistence context to the underlying database. (deleted
	 * entities will be detach)
	 */
	protected void flush() {
		cbaseMiddlewareRepository.flush();
	}

	/**
	 * Should not be used. Just useful for UnitTests
	 * 
	 * @param dbTimeZone
	 */
	public void setDbTimeZone(final TimeZone dbTimeZone) {
		this.dbTimeZone = dbTimeZone;
	}

}
