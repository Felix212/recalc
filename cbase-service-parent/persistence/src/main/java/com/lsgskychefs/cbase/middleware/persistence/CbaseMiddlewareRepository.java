/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityGraph;
import javax.persistence.EntityManager;
import javax.persistence.EntityNotFoundException;
import javax.persistence.LockModeType;
import javax.persistence.LockTimeoutException;
import javax.persistence.PersistenceContext;
import javax.persistence.PessimisticLockException;
import javax.persistence.Query;
import javax.persistence.TransactionRequiredException;
import javax.persistence.TypedQuery;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lsgskychefs.cbase.middleware.persistence.domain.DomainObject;
import com.lsgskychefs.cbase.middleware.persistence.query.NativeQueryProviderImpl;

/**
 * Generic access for find one and findAll.
 *
 * @author Ingo Rietzschel - U125742
 */
@Service
public class CbaseMiddlewareRepository {

	/** Native query argument key - arg_result_key */
	public static final String ARG_RESULT_KEY = "arg_result_key";

	/** Native query argument key - arg_transaction */
	public static final String ARG_TRANSACTION = "arg_transaction";

	/** Native query argument key - arg_date */
	public static final String ARG_DATE = "arg_date";

	/** Native query argument key - arg_cunit */
	public static final String ARG_CUNIT = "arg_cunit";

	/** Native query argument key - arg_index */
	public static final String ARG_INDEX = "arg_index";

	/** Native query argument key - arg_reckoning */
	public static final String ARG_RECKONING = "arg_reckoning";

	/** Native query argument key - arg_csc */
	public static final String ARG_CSC = "arg_csc";

	/** The entity manager */
	@PersistenceContext
	protected EntityManager em;

	/** provider for native queries */
	@Autowired
	protected NativeQueryProviderImpl nativeQueryProvider;

	/**
	 * Find DomainObject by primary key.
	 *
	 * @param <T> the entity type
	 * @param clazz entity class
	 * @param pk primary key
	 * @return the found entity instance
	 * @throws IllegalArgumentException if the first argument does not denote an entity type or the second argument is is not a valid type
	 *             for that entityÂ’s primary key or is null
	 */
	public <T extends DomainObject> T findOne(final Class<T> clazz, final Object pk) {
		return em.find(clazz, pk);
	}

	/**
	 * Find DomainObject by primary key and lock.
	 *
	 * @param <T> the entity type
	 * @param domainClass domain/entity class
	 * @param pk primary key
	 * @param lockMode lock mode
	 * @return the found entity instance or null if the entity does not exist
	 * @throws CbaseMiddlewarePessimisticLockException if a LockTimeoutException or PessimisticLockException occured
	 * @see EntityManager#find(Class, Object, LockModeType)
	 */
	public <T extends DomainObject> T findOne(final Class<T> domainClass, final Object pk, final LockModeType lockMode) {
		try {
			return em.find(domainClass, pk, lockMode);
		} catch (final LockTimeoutException | PessimisticLockException e) {
			throw new CbaseMiddlewarePessimisticLockException(String.format("%s-%s is locked on database!", domainClass, pk), e);
		}
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
	 * @throws CbaseMiddlewarePessimisticLockException if a LockTimeoutException or PessimisticLockException occured
	 * @see EntityManager#find(Class, Object, LockModeType)
	 */
	public <T extends DomainObject> T findOne(final Class<T> domainClass, final Object pk, final LockModeType lockMode,
			final Map<String, Object> properties) {
		try {
			return em.find(domainClass, pk, lockMode, properties);
		} catch (final LockTimeoutException | PessimisticLockException e) {
			throw new CbaseMiddlewarePessimisticLockException(String.format("%s-%s is locked on database!", domainClass, pk), e);
		}
	}

	/**
	 * Find all entities for given type
	 *
	 * @param <T> the entity type
	 * @param clazz entity class
	 * @return all entities for given type.
	 */
	public <T extends DomainObject> List<T> findAll(final Class<T> clazz) {
		return em.createQuery("Select t from " + clazz.getSimpleName() + " t", clazz).getResultList();
	}

	/**
	 * Find all entities for given type
	 *
	 * @param <T> the entity type
	 * @param clazz entity class
	 * @param entityGraphName the name of the uses {@link EntityGraph}.
	 * @return all entities for given type.
	 */
	public <T extends DomainObject> List<T> findAll(final Class<T> clazz, final String entityGraphName) {
		final TypedQuery<T> query = em.createQuery("Select DISTINCT t from " + clazz.getSimpleName() + " t", clazz);
		query.setHint("javax.persistence.fetchgraph", em.getEntityGraph(entityGraphName));
		return query.getResultList();
	}

	/**
	 * Delete the given {@link DomainObject}(entity)
	 *
	 * @param domainObject domain object instance to delete/remove
	 */
	public void delete(final DomainObject domainObject) {
		em.remove(domainObject);
	}

	/**
	 * Make an instance managed and persistent.
	 *
	 * @param domainObject domain object instance to persist
	 */
	public void save(final DomainObject domainObject) {
		em.persist(domainObject);
	}

	/**
	 * Refresh the state of the instance from the database, overwriting changes made to the entity, if any.
	 *
	 * @param domainObject domain object instance to refresh
	 * @throws IllegalArgumentException if the instance is not an entity or the entity is not managed
	 * @throws TransactionRequiredException if invoked on a container-managed entity manager of type
	 *             <code>PersistenceContextType.TRANSACTION</code> and there is no transaction
	 * @throws EntityNotFoundException if the entity no longer exists in the database
	 */
	public void refresh(final DomainObject domainObject) {
		em.refresh(domainObject);
	}

	/**
	 * Remove the given entity from the persistence context, causing a managed entity to become detached. Unflushed changes made to the
	 * entity if any (including removal of the entity), will not be synchronized to the database. Entities which previously referenced the
	 * detached entity will continue to reference it.
	 *
	 * @param domainObject domain object instance to detach
	 * @throws IllegalArgumentException if the instance is not an entity
	 * @since Java Persistence 2.0
	 */
	public void detach(final DomainObject domainObject) {
		em.detach(domainObject);
	}

	/**
	 * Make the instance managed and persistent using a new transaction that is not bound to any surrounding transaction. Thus the persisted
	 * state will survive any rollbacks on surrounding transactions.
	 *
	 * @param <T> the entity type
	 * @param domainObject domain object instance to persist
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public <T extends DomainObject> void saveInOwnTransaction(final T domainObject) {
		em.merge(domainObject);
	}

	/**
	 * Makes the given instances managed and persistent using a new transaction that is not bound to any surrounding transaction. Thus the
	 * persisted states will survive any rollbacks on surrounding transactions.
	 *
	 * @param <T> the entity type
	 * @param domainObjects domain object instances to persist
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public <T extends DomainObject> void saveInOwnTransaction(final Collection<T> domainObjects) {
		for (final T domainObject : domainObjects) {
			em.merge(domainObject);
		}
		flush();
	}

	/**
	 * Manually advices the EntityManager to perform a flush now.
	 */
	public void flush() {
		em.flush();
	}

	/**
	 * Manually advices the EntityManager to perform a commit now.
	 */
	public void commit() {
		em.getTransaction().commit();
	}

	/**
	 * The count of active spring jdbc sessions. Error if spring jdbc session is not active (spring.session.jdbc.activated)
	 *
	 * @return the count of active spring jdbc sessions
	 */
	public int getActiveJdbcSessions() {
		final Query query = em.createNativeQuery("select count(*) from CBASE.SYS_SPRING_SESSION");
		return query.executeUpdate();
	}

}
