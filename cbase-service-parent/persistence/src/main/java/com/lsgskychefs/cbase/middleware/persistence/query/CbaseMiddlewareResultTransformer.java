/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.query;

import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.persistence.Transient;

import org.hibernate.transform.ResultTransformer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;

import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareEntry;
import com.lsgskychefs.cbase.middleware.persistence.pojo.Pojo;
import com.lsgskychefs.cbase.middleware.persistence.utils.CMMetaModelUtils;

/**
 * Maps the SQL Query results in an object of the specified class. Column name and property name rule:<br>
 * SQL <-> Class <br>
 * column_name <-> columnName<br>
 * <ul>
 * <li>column: no corresponding attribute exist -> no error no info!
 * <li>attribute without @Transient annotation on getter: no corresponding column exist -> warning on log with detail informations
 * </ul>
 *
 * @param <T> the Entry type for transformation
 * @author Ingo Rietzschel - U125742
 */
class CbaseMiddlewareResultTransformer<T extends CbaseMiddlewareEntry> implements ResultTransformer {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(CbaseMiddlewareResultTransformer.class);

	/** The result entry object */
	private final Class<? extends Pojo> resultClass;

	/** aliases are initialized */
	private transient boolean isAliasesInitialized;

	/** array of result set aliases - converted e.g nbatchSeq. */
	private transient String[] aliases;

	/** unconverted aliases (original from database e.g. nbatch_seq) */
	private transient String[] unConvertedAliases;

	/** setter/write method) for entry properties */
	private transient Method[] setter;

	/** entry property type, used for special type handling */
	private transient Class<?>[] types;

	/**
	 * Create the transformer.
	 *
	 * @param clazz the data put into an object of this type
	 */
	CbaseMiddlewareResultTransformer(final Class<T> clazz) {
		this.resultClass = clazz;

	}

	/** {@inheritDoc} */
	@Override
	public Object transformTuple(final Object[] tuple, final String[] aliases) {

		Object result;
		String currentAlias = "";
		Method currentSetter = null;
		Object currentValue = null;
		try {
			if (!isAliasesInitialized) {
				initialize(aliases);
			} else {
				check(aliases);
			}

			result = resultClass.newInstance();

			for (int i = 0; i < aliases.length; i++) {
				currentAlias = aliases[i];
				currentSetter = setter[i];
				if (currentSetter != null) {
					currentValue = getValue(tuple[i], i);
					currentSetter.invoke(result, currentValue);

				}
			}
		} catch (InstantiationException | IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
			final String msg =
					String.format("Error on transform result into: %s - alias: %s - value: %s - setter: %s", resultClass, currentAlias,
							currentValue, currentSetter);
			LOGGER.error(msg, e);
			throw new IllegalArgumentException(msg, e);
		}

		return result;
	}

	/** {@inheritDoc} */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<T> transformList(final List collection) {
		return collection;
	}

	/**
	 * initalize the relevant elements aliases,setter, types
	 *
	 * @param aliases current result set aliases(columns)
	 */
	private void initialize(final String... aliases) {
		// Initialize arrays
		this.aliases = new String[aliases.length];
		this.unConvertedAliases = new String[aliases.length];
		this.setter = new Method[aliases.length];
		this.types = new Class[aliases.length];
		final PropertyDescriptor[] propertyDescriptors = BeanUtils.getPropertyDescriptors(resultClass);
		final Set<PropertyDescriptor> pdSet = new HashSet<>(Arrays.asList(propertyDescriptors));

		for (int i = 0; i < aliases.length; i++) {
			String alias = aliases[i];
			if (alias != null) {
				this.unConvertedAliases[i] = alias;
				alias = CMMetaModelUtils.convertToCamelCase(alias);
				final PropertyDescriptor pd = BeanUtils.getPropertyDescriptor(resultClass, alias);
				pdSet.remove(pd);
				this.setter[i] = pd == null ? null : pd.getWriteMethod();
				this.types[i] = pd == null ? null : pd.getPropertyType();
				this.aliases[i] = alias;
			}
		}
		isAliasesInitialized = true;

		// check for unused attributes, remove default class attribute and as transient marked attributes
		pdSet.remove(BeanUtils.getPropertyDescriptor(resultClass, "class"));
		for (final Iterator<PropertyDescriptor> iterator = pdSet.iterator(); iterator.hasNext();) {
			final PropertyDescriptor pd = iterator.next();
			if (pd.getReadMethod().getDeclaredAnnotation(Transient.class) != null) {
				iterator.remove();
			}
		}
		if (!pdSet.isEmpty()) {
			LOGGER.warn(
					"On current result class '{}', the following attributes not used: {}. "
							+ "To avoid this message use @Transient on getter or add a corresponding column on SQL-Statement! "
							+ "Check column and method name!",
					resultClass, pdSet);
		}

	}

	/**
	 * check if the new aliases equal to initalized
	 *
	 * @param aliases current result set aliases(columns)
	 */
	private void check(final String... aliases) {
		if (!Arrays.equals(aliases, this.unConvertedAliases)) {
			throw new IllegalStateException(
					"aliases are different from what is cached; aliases=" + Arrays.asList(aliases) +
							" cached=" + Arrays.asList(this.aliases));
		}
	}

	/**
	 * Special handling for some types
	 *
	 * @param value the database column value
	 * @param index the result set index
	 * @return the current value
	 */
	private Object getValue(final Object value, final int index) {
		Object handledValue = value;
		if (handledValue != null) {
			final Class<?> propertyType = types[index];
			try {
				if (value instanceof Number) {
					handledValue = handleNumber((Number) value, propertyType);
				} else if (value instanceof Character && propertyType == String.class) {
					handledValue = String.valueOf(value);
				}
			} catch (final ClassCastException e) {
				throw new UnsupportedOperationException(
						String.format("ClassCastException on result mapping for value '%s', type '%s' and attribute '%s'", value,
								types[index], aliases[index]),
						e);
			}

		}
		return handledValue;
	}

	/**
	 * Handle all Numbers (BigDecimal, BigInteger, Float, Integer, ..), convert given Number into Entry property type.
	 *
	 * <pre>
	 * 	BigDecimal -> Integer or int or Long or long or Boolean or boolean
	 * </pre>
	 *
	 * @param value the database column value
	 * @param propertyType the Entry property type
	 * @return the current value
	 */
	private Object handleNumber(final Number value, final Class<?> propertyType) {
		if (propertyType == Long.class || propertyType == long.class) {
			return value.longValue();
		}
		if (propertyType == Integer.class || propertyType == int.class) {
			return value.intValue();
		}
		if (propertyType == Boolean.class || propertyType == boolean.class) {
			return value.intValue() == 1;
		}
		return value;
	}

	@Override
	public boolean equals(final Object o) {
		if (this == o) {
			return true;
		}
		if (o == null || getClass() != o.getClass()) {
			return false;
		}

		@SuppressWarnings("unchecked")
		final CbaseMiddlewareResultTransformer<T> that = (CbaseMiddlewareResultTransformer<T>) o;

		if (!resultClass.equals(that.resultClass)) {
			return false;
		}
		if (!Arrays.equals(aliases, that.aliases)) {
			return false;
		}

		return true;
	}

	@Override
	public int hashCode() {
		int result = resultClass.hashCode();
		result = 31 * result + (aliases != null ? Arrays.hashCode(aliases) : 0);
		return result;
	}

}
