/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.query;

import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.FlushModeType;
import javax.persistence.LockModeType;
import javax.persistence.Parameter;
import javax.persistence.TemporalType;

import org.apache.commons.lang.StringUtils;
import org.hibernate.FlushMode;
import org.hibernate.type.StandardBasicTypes;
import org.hibernate.type.Type;

import com.lsgskychefs.cbase.middleware.persistence.pojo.Pojo;

/**
 * A CbaseMiddleWare Delegate query to avoid provider specific code.
 *
 * @param <POJO> the non entity object for mapping
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareQuery<POJO extends Pojo> implements javax.persistence.Query {

	/** NOT_IMPLEMENTED */
	private static final String NOT_IMPLEMENTED = "not implemented";

	/** The underlying query. */
	private final org.hibernate.Query hibernateQuery;

	/**
	 * Constructor
	 *
	 * @param query Query to delegate
	 */
	CbaseMiddlewareQuery(final org.hibernate.Query query) {
		this.hibernateQuery = query;
	}

	/** {@inheritDoc} **/
	@SuppressWarnings("unchecked")
	@Override
	public List<POJO> getResultList() {
		return hibernateQuery.list();
	}

	/** {@inheritDoc} **/
	@Override
	public Object getSingleResult() {
		return hibernateQuery.uniqueResult();
	}

	/** {@inheritDoc} **/
	@Override
	public int executeUpdate() {
		return hibernateQuery.executeUpdate();
	}

	/** {@inheritDoc} **/
	@Override
	public CbaseMiddlewareQuery<POJO> setMaxResults(final int maxResult) {
		hibernateQuery.setMaxResults(maxResult);
		return this;
	}

	/** {@inheritDoc} **/
	@Override
	public int getMaxResults() {
		return hibernateQuery.getMaxResults();
	}

	/** {@inheritDoc} **/
	@Override
	public CbaseMiddlewareQuery<POJO> setFirstResult(final int startPosition) {
		hibernateQuery.setFirstResult(startPosition);
		return this;
	}

	/** {@inheritDoc} **/
	@Override
	public int getFirstResult() {
		return hibernateQuery.getFirstResult();
	}

	/** {@inheritDoc} **/
	@Override
	public CbaseMiddlewareQuery<POJO> setHint(final String hintName, final Object value) {
		throw new UnsupportedOperationException(NOT_IMPLEMENTED);
	}

	/** {@inheritDoc} **/
	@Override
	public Map<String, Object> getHints() {
		throw new UnsupportedOperationException(NOT_IMPLEMENTED);
	}

	/** {@inheritDoc} **/
	@Override
	public <T> CbaseMiddlewareQuery<POJO> setParameter(final Parameter<T> param, final T value) {
		throw new UnsupportedOperationException(NOT_IMPLEMENTED);
	}

	/** {@inheritDoc} **/
	@Override
	public CbaseMiddlewareQuery<POJO> setParameter(final Parameter<Calendar> param, final Calendar value, final TemporalType temporalType) {
		if (StringUtils.isNotBlank(param.getName())) {
			hibernateQuery.setCalendar(param.getName(), value);
		} else if (param.getPosition() != null) {
			hibernateQuery.setCalendar(param.getPosition(), value);
		} else {
			throw new IllegalArgumentException("No position and no name exist, parameter can't assign to query!");
		}
		return this;
	}

	/** {@inheritDoc} **/
	@Override
	public CbaseMiddlewareQuery<POJO> setParameter(final Parameter<Date> param, final Date value, final TemporalType temporalType) {
		if (StringUtils.isNotBlank(param.getName())) {
			hibernateQuery.setDate(param.getName(), value);
		} else if (param.getPosition() != null) {
			hibernateQuery.setDate(param.getPosition(), value);
		} else {
			throw new IllegalArgumentException("No position and no name exist, parameter can't assign to query!");
		}

		return this;
	}

	/** {@inheritDoc} **/
	@Override
	public CbaseMiddlewareQuery<POJO> setParameter(final String name, final Object value) {
		if (value instanceof Object[]) {
			hibernateQuery.setParameterList(name, (Object[]) value);
		} else if (value instanceof Collection) {
			hibernateQuery.setParameterList(name, (Collection<?>) value);
		} else {
			hibernateQuery.setParameter(name, value);
		}
		return this;
	}

	/** {@inheritDoc} **/
	@Override
	public CbaseMiddlewareQuery<POJO> setParameter(final String name, final Calendar value, final TemporalType temporalType) {
		hibernateQuery.setCalendar(name, value);
		return this;
	}

	/** {@inheritDoc} **/
	@Override
	public CbaseMiddlewareQuery<POJO> setParameter(final String name, final Date value, final TemporalType temporalType) {
		hibernateQuery.setDate(name, value);
		return this;
	}

	/** {@inheritDoc} **/
	@Override
	public CbaseMiddlewareQuery<POJO> setParameter(final int position, final Object value) {
		hibernateQuery.setParameter(position, value);
		return this;
	}

	/**
	 * Bind an instance of given type to a named parameter.
	 *
	 * @param name parameter name
	 * @param value parameter value
	 * @param type the type of value
	 * @return the same query instance
	 * @throws IllegalArgumentException if the parameter name does not correspond to a parameter of the query or if the value argument is of
	 *             incorrect type
	 */
	public CbaseMiddlewareQuery<POJO> setParameter(final String name, final Object value, final Class<?> type) {
		Type determinedType = null;
		if (Long.class == type) {
			determinedType = StandardBasicTypes.LONG;
		} else if (Integer.class == type) {
			determinedType = StandardBasicTypes.INTEGER;
		} else {
			throw new UnsupportedOperationException(NOT_IMPLEMENTED);
		}

		hibernateQuery.setParameter(name, value, determinedType);
		return this;
	}

	/** {@inheritDoc} **/
	@Override
	public CbaseMiddlewareQuery<POJO> setParameter(final int position, final Calendar value, final TemporalType temporalType) {
		hibernateQuery.setCalendar(position, value);
		return this;
	}

	/** {@inheritDoc} **/
	@Override
	public CbaseMiddlewareQuery<POJO> setParameter(final int position, final Date value, final TemporalType temporalType) {
		hibernateQuery.setDate(position, value);
		return this;
	}

	/** {@inheritDoc} **/
	@Override
	public Set<Parameter<?>> getParameters() {
		throw new UnsupportedOperationException(NOT_IMPLEMENTED);
	}

	/** {@inheritDoc} **/
	@Override
	public Parameter<?> getParameter(final String name) {
		throw new UnsupportedOperationException(NOT_IMPLEMENTED);
	}

	/** {@inheritDoc} **/
	@Override
	public <T> Parameter<T> getParameter(final String name, final Class<T> type) {
		throw new UnsupportedOperationException(NOT_IMPLEMENTED);
	}

	/** {@inheritDoc} **/
	@Override
	public Parameter<?> getParameter(final int position) {
		throw new UnsupportedOperationException(NOT_IMPLEMENTED);
	}

	/** {@inheritDoc} **/
	@Override
	public <T> Parameter<T> getParameter(final int position, final Class<T> type) {
		throw new UnsupportedOperationException(NOT_IMPLEMENTED);
	}

	/** {@inheritDoc} **/
	@Override
	public boolean isBound(final Parameter<?> param) {
		throw new UnsupportedOperationException(NOT_IMPLEMENTED);
	}

	/** {@inheritDoc} **/
	@Override
	public <T> T getParameterValue(final Parameter<T> param) {
		throw new UnsupportedOperationException(NOT_IMPLEMENTED);
	}

	/** {@inheritDoc} **/
	@Override
	public Object getParameterValue(final String name) {
		throw new UnsupportedOperationException(NOT_IMPLEMENTED);
	}

	/** {@inheritDoc} **/
	@Override
	public Object getParameterValue(final int position) {
		throw new UnsupportedOperationException(NOT_IMPLEMENTED);
	}

	/** {@inheritDoc} **/
	@Override
	public CbaseMiddlewareQuery<POJO> setFlushMode(final FlushModeType flushMode) {
		if (FlushModeType.COMMIT == flushMode) {
			hibernateQuery.setFlushMode(FlushMode.COMMIT);
		} else {
			hibernateQuery.setFlushMode(FlushMode.AUTO);
		}
		return this;
	}

	/** {@inheritDoc} **/
	@Override
	public FlushModeType getFlushMode() {
		throw new UnsupportedOperationException(NOT_IMPLEMENTED);
	}

	/** {@inheritDoc} **/
	@Override
	public CbaseMiddlewareQuery<POJO> setLockMode(final LockModeType lockMode) {
		throw new UnsupportedOperationException(NOT_IMPLEMENTED);
	}

	/** {@inheritDoc} **/
	@Override
	public LockModeType getLockMode() {
		throw new UnsupportedOperationException(NOT_IMPLEMENTED);
	}

	/** {@inheritDoc} **/
	@Override
	public <T> T unwrap(final Class<T> cls) {
		throw new UnsupportedOperationException(NOT_IMPLEMENTED);
	}

}
