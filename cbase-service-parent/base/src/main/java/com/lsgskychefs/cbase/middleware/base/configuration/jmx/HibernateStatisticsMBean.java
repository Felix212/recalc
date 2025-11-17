/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.configuration.jmx;

import javax.persistence.EntityManagerFactory;
import javax.servlet.ServletContext;

import org.hibernate.SessionFactory;
import org.hibernate.jpa.HibernateEntityManagerFactory;
import org.hibernate.stat.CollectionStatistics;
import org.hibernate.stat.EntityStatistics;
import org.hibernate.stat.QueryStatistics;
import org.hibernate.stat.SecondLevelCacheStatistics;
import org.hibernate.stat.Statistics;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnWebApplication;
import org.springframework.jmx.export.annotation.ManagedAttribute;
import org.springframework.jmx.export.annotation.ManagedOperation;
import org.springframework.jmx.export.annotation.ManagedResource;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * The Class HibernateStatisticsMBean.
 */
@Component
@ManagedResource("Hibernate:application=Statistics")
@ConditionalOnWebApplication
public class HibernateStatisticsMBean implements InitializingBean {

	/** The servlet context. */
	@Autowired
	private ServletContext servletContext;

	/** The stats. */
	private Statistics stats;

	/*
	 * (non-Javadoc)
	 * @see org.springframework.beans.factory.InitializingBean#afterPropertiesSet()
	 */
	@Override
	public void afterPropertiesSet() throws Exception {
		final WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(servletContext);
		final EntityManagerFactory emf = (EntityManagerFactory) wac.getBean("entityManagerFactory");
		final SessionFactory sessionFactory = ((HibernateEntityManagerFactory) emf).getSessionFactory();
		sessionFactory.getStatistics().setStatisticsEnabled(true);
		this.stats = sessionFactory.getStatistics();
	}

	/**
	 * Clear.
	 */
	@ManagedOperation
	public void clear() {
		stats.clear();
	}

	/**
	 * Gets the entity statistics.
	 *
	 * @param entityName the entity name
	 * @return the entity statistics
	 */
	@ManagedOperation
	public EntityStatistics getEntityStatistics(final String entityName) {
		return stats.getEntityStatistics(entityName);
	}

	/**
	 * Gets the collection statistics.
	 *
	 * @param role the role
	 * @return the collection statistics
	 */
	@ManagedOperation
	public CollectionStatistics getCollectionStatistics(final String role) {
		return stats.getCollectionStatistics(role);
	}

	/**
	 * Gets the second level cache statistics.
	 *
	 * @param regionName the region name
	 * @return the second level cache statistics
	 */
	@ManagedOperation
	public SecondLevelCacheStatistics getSecondLevelCacheStatistics(final String regionName) {
		return stats.getSecondLevelCacheStatistics(regionName);
	}

	/**
	 * Gets the query statistics.
	 *
	 * @param hql the hql
	 * @return the query statistics
	 */
	@ManagedOperation
	public QueryStatistics getQueryStatistics(final String hql) {
		return stats.getQueryStatistics(hql);
	}

	/**
	 * Gets the entity delete count.
	 *
	 * @return the entity delete count
	 */
	@ManagedAttribute
	public long getEntityDeleteCount() {
		return stats.getEntityDeleteCount();
	}

	/**
	 * Gets the entity insert count.
	 *
	 * @return the entity insert count
	 */
	@ManagedAttribute
	public long getEntityInsertCount() {
		return stats.getEntityInsertCount();
	}

	/**
	 * Gets the entity load count.
	 *
	 * @return the entity load count
	 */
	@ManagedAttribute
	public long getEntityLoadCount() {
		return stats.getEntityLoadCount();
	}

	/**
	 * Gets the entity fetch count.
	 *
	 * @return the entity fetch count
	 */
	@ManagedAttribute
	public long getEntityFetchCount() {
		return stats.getEntityFetchCount();
	}

	/**
	 * Gets the entity update count.
	 *
	 * @return the entity update count
	 */
	@ManagedAttribute
	public long getEntityUpdateCount() {
		return stats.getEntityUpdateCount();
	}

	/**
	 * Gets the query execution count.
	 *
	 * @return the query execution count
	 */
	@ManagedAttribute
	public long getQueryExecutionCount() {
		return stats.getQueryExecutionCount();
	}

	/**
	 * Gets the query cache hit count.
	 *
	 * @return the query cache hit count
	 */
	@ManagedAttribute
	public long getQueryCacheHitCount() {
		return stats.getQueryCacheHitCount();
	}

	/**
	 * Gets the query execution max time.
	 *
	 * @return the query execution max time
	 */
	@ManagedAttribute
	public long getQueryExecutionMaxTime() {
		return stats.getQueryExecutionMaxTime();
	}

	/**
	 * Gets the query cache miss count.
	 *
	 * @return the query cache miss count
	 */
	@ManagedAttribute
	public long getQueryCacheMissCount() {
		return stats.getQueryCacheMissCount();
	}

	/**
	 * Gets the query cache put count.
	 *
	 * @return the query cache put count
	 */
	@ManagedAttribute
	public long getQueryCachePutCount() {
		return stats.getQueryCachePutCount();
	}

	/**
	 * Gets the flush count.
	 *
	 * @return the flush count
	 */
	@ManagedAttribute
	public long getFlushCount() {
		return stats.getFlushCount();
	}

	/**
	 * Gets the connect count.
	 *
	 * @return the connect count
	 */
	@ManagedAttribute
	public long getConnectCount() {
		return stats.getConnectCount();
	}

	/**
	 * Gets the second level cache hit count.
	 *
	 * @return the second level cache hit count
	 */
	@ManagedAttribute
	public long getSecondLevelCacheHitCount() {
		return stats.getSecondLevelCacheHitCount();
	}

	/**
	 * Gets the second level cache miss count.
	 *
	 * @return the second level cache miss count
	 */
	@ManagedAttribute
	public long getSecondLevelCacheMissCount() {
		return stats.getSecondLevelCacheMissCount();
	}

	/**
	 * Gets the second level cache put count.
	 *
	 * @return the second level cache put count
	 */
	@ManagedAttribute
	public long getSecondLevelCachePutCount() {
		return stats.getSecondLevelCachePutCount();
	}

	/**
	 * Gets the session close count.
	 *
	 * @return the session close count
	 */
	@ManagedAttribute
	public long getSessionCloseCount() {
		return stats.getSessionCloseCount();
	}

	/**
	 * Gets the session open count.
	 *
	 * @return the session open count
	 */
	@ManagedAttribute
	public long getSessionOpenCount() {
		return stats.getSessionOpenCount();
	}

	/**
	 * Gets the collection load count.
	 *
	 * @return the collection load count
	 */
	@ManagedAttribute
	public long getCollectionLoadCount() {
		return stats.getCollectionLoadCount();
	}

	/**
	 * Gets the collection fetch count.
	 *
	 * @return the collection fetch count
	 */
	@ManagedAttribute
	public long getCollectionFetchCount() {
		return stats.getCollectionFetchCount();
	}

	/**
	 * Gets the collection update count.
	 *
	 * @return the collection update count
	 */
	@ManagedAttribute
	public long getCollectionUpdateCount() {
		return stats.getCollectionUpdateCount();
	}

	/**
	 * Gets the collection remove count.
	 *
	 * @return the collection remove count
	 */
	@ManagedAttribute
	public long getCollectionRemoveCount() {
		return stats.getCollectionRemoveCount();
	}

	/**
	 * Gets the collection recreate count.
	 *
	 * @return the collection recreate count
	 */
	@ManagedAttribute
	public long getCollectionRecreateCount() {
		return stats.getCollectionRecreateCount();
	}

	/**
	 * Gets the start time.
	 *
	 * @return the start time
	 */
	@ManagedAttribute
	public long getStartTime() {
		return stats.getStartTime();
	}

	/**
	 * Checks if is statistics enabled.
	 *
	 * @return true, if is statistics enabled
	 */
	@ManagedAttribute
	public boolean isStatisticsEnabled() {
		return stats.isStatisticsEnabled();
	}

	/**
	 * Sets the statistics enabled.
	 *
	 * @param enable the new statistics enabled
	 */
	@ManagedOperation
	public void setStatisticsEnabled(final boolean enable) {
		stats.setStatisticsEnabled(enable);
	}

	/**
	 * Log summary.
	 */
	@ManagedOperation
	public void logSummary() {
		stats.logSummary();
	}

	/**
	 * Gets the collection role names.
	 *
	 * @return the collection role names
	 */
	@ManagedAttribute
	public String[] getCollectionRoleNames() {
		return stats.getCollectionRoleNames();
	}

	/**
	 * Gets the entity names.
	 *
	 * @return the entity names
	 */
	@ManagedAttribute
	public String[] getEntityNames() {
		return stats.getEntityNames();
	}

	/**
	 * Gets the queries.
	 *
	 * @return the queries
	 */
	@ManagedAttribute
	public String[] getQueries() {
		return stats.getQueries();
	}

	/**
	 * Gets the second level cache region names.
	 *
	 * @return the second level cache region names
	 */
	@ManagedAttribute
	public String[] getSecondLevelCacheRegionNames() {
		return stats.getSecondLevelCacheRegionNames();
	}

	/**
	 * Gets the successful transaction count.
	 *
	 * @return the successful transaction count
	 */
	@ManagedAttribute
	public long getSuccessfulTransactionCount() {
		return stats.getSuccessfulTransactionCount();
	}

	/**
	 * Gets the transaction count.
	 *
	 * @return the transaction count
	 */
	@ManagedAttribute
	public long getTransactionCount() {
		return stats.getTransactionCount();
	}

	/**
	 * Gets the close statement count.
	 *
	 * @return the close statement count
	 */
	@ManagedAttribute
	public long getCloseStatementCount() {
		return stats.getCloseStatementCount();
	}

	/**
	 * Gets the prepare statement count.
	 *
	 * @return the prepare statement count
	 */
	@ManagedAttribute
	public long getPrepareStatementCount() {
		return stats.getPrepareStatementCount();
	}

	/**
	 * Gets the optimistic failure count.
	 *
	 * @return the optimistic failure count
	 */
	@ManagedAttribute
	public long getOptimisticFailureCount() {
		return stats.getOptimisticFailureCount();
	}

	/**
	 * Gets the query execution max time query string.
	 *
	 * @return the query execution max time query string
	 */
	@ManagedAttribute
	public String getQueryExecutionMaxTimeQueryString() {
		return stats.getQueryExecutionMaxTimeQueryString();
	}

}
