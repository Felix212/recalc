/*
 * ResponseElement.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.rest;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.AbstractMap.SimpleEntry;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Table;
import javax.persistence.metamodel.Attribute;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.util.LinkedCaseInsensitiveMap;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException.CbaseMiddlewareTechnicalExceptionType;
import com.lsgskychefs.cbase.middleware.base.rest.serializer.ResponseElementSerializer;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOut;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpm_;
import com.lsgskychefs.cbase.middleware.persistence.domain.DomainObject;
import com.lsgskychefs.cbase.middleware.persistence.domain.MetaModelSupport;
import com.lsgskychefs.cbase.middleware.persistence.pojo.Pojo;
import com.lsgskychefs.cbase.middleware.persistence.query.MetaModelHelper;
import com.lsgskychefs.cbase.middleware.persistence.utils.CMMetaModelUtils;

/**
 * Class representing a result element to be returned by REST services. It extends <code>java.util.HashMap</code> taking String-keys as
 * attribute names and Objects as their values.
 *
 * @author Andreas Morgenstern
 */
@JsonSerialize(using = ResponseElementSerializer.class)
public class ResponseElement {

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(ResponseElement.class);

	/** Keys to put values into ResponseElement */
	public enum ElementAttribute {
		/** status information */
		STATUS,
		/** Message */
		MESSAGE,
		/** current unit */
		UNIT,
		/** client id */
		CLIENT,
		/** grace logins */
		GRACE_LOGINS,
		/** entity id */
		ID,
		/** current version */
		APPLICATION_VERSION,
		/** application name */
		APPLICATION_NAME,
		/** Information about current database connection */
		DATABASE_INFO,
		/** current server instance (jvm_route) */
		INSTANCE;
	}

	/**
	 * The attribute names that may be added to this <code>ResponseElement</code>.
	 */
	private Collection<String> filter;

	/**
	 * The <code>Map</code> containing the response element data. About the LinkedCaseInsensitiveMap the order of keys is fixed for
	 * serialized and the keys are lower case for json.
	 *
	 * @see ResponseElement
	 */
	private final Map<String, Object> element = new LinkedCaseInsensitiveMap<>(0);

	/**
	 * Public constructor.
	 */
	public ResponseElement() {
		super();
	}

	/**
	 * Public constructor setting a filter for the attribute names to be added to this <code>ResponseElement</code>. Attribute names not
	 * contained in the given array will not be added. The order of filter attribute names defined the order of serialized keys.
	 *
	 * @param filter The array of attribute names that may be added to this <code>ResponseElement</code>. The order of filter defined the
	 *            order of serialized keys.
	 */
	public ResponseElement(final String... filter) {
		super();
		if (filter != null) {
			this.filter = new ArrayList<>();
			for (int i = 0; i < filter.length; i++) {
				this.filter.add(filter[i]);
				element.put(filter[i], null);
			}
		}
	}

	/**
	 * Adds the given String as attribute name and the given Object as its value to the REST result. If a filter was set in the constructor,
	 * the value is only added if the attribute name is contained in the filter list.
	 *
	 * @param attributeName The name of the attribute a value should be added for.
	 * @param value The value.
	 * @return The ResponseElement itself.
	 */
	public ResponseElement put(final String attributeName, final Object value) {
		if (StringUtils.isBlank(attributeName)) {
			return this;
		}
		// If a filter was set in the constructor, the value can only added if the attribute name is contained in the filter list.
		if (filter != null && !filter.isEmpty() && !filter.contains(attributeName)) {
			return this;
		}
		if (element.put(attributeName, value) != null) {
			throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.ATTRIBUTE_NAME_ALREADY_EXIST,
					String.format("the attribute name (%s) alreadey exist in ResponseElement", attributeName));
		}
		return this;
	}

	/**
	 * Adds the given {@link ElementAttribute#name()} as attribute name and the given Object as its value to the REST result. If a filter
	 * was set in the constructor, the value is only added if the attribute name is contained in the filter list. <br>
	 * If no modelAttribute is set, all direct properties will put.<br>
	 * Dependency Objects(DomainObjects) will never added.
	 *
	 * @param attributeName The name of the attribute a value should be added for.
	 * @param value The value.
	 * @return The ResponseElement itself.
	 */
	public ResponseElement put(final ElementAttribute attributeName, final Object value) {
		if (attributeName == null) {
			return this;
		}
		return put(attributeName.name().toLowerCase(), value);
	}

	/**
	 * Get the properties(by modelAttributes) from {@link DomainObject} and put the value into ResponseElement with table and column name as
	 * key. If a filter was set in the constructor, the value is only added if the attribute name is contained in the filter list. <br>
	 * Dependency Objects(DomainObjects) will never added. <br>
	 * <b> LocUnitAreas#ctext -> loc_unit_areas_ctext</b>
	 *
	 * @param <DO> entity type
	 * @param domainObject the Entity wherefrom the value(s) read and put into ResponseElement
	 * @param modelAttributes {@link Attribute} from metamodel of given DomainObject to get the corresponding value
	 * @return The ResponseElement itself.
	 * @throws IllegalArgumentException if {@link DomainObject} is {@code null}.
	 */
	@SafeVarargs
	public final <DO extends MetaModelSupport> ResponseElement putWithObjectName(final DO domainObject,
			final Attribute<DO, ?>... modelAttributes) {
		return internalPut(true, domainObject, modelAttributes);
	}

	/**
	 * Get all properties from given pojo and put the values into ResponseElement with property name as key(converted form cameCase to
	 * underscore). If a filter was set in the constructor, the value is only added if the attribute name is contained in the filter list.
	 * <br>
	 * Dependency Objects(DomainObjects) will never added.<br>
	 * On null object nothing is added.
	 *
	 * @param pojo the object wherefrom the values come
	 * @return The ResponseElement itself.
	 */
	public ResponseElement putAll(final Pojo pojo) {
		if (pojo == null) {
			return this;
		}
		final PropertyDescriptor[] propertyDescriptors = BeanUtils.getPropertyDescriptors(pojo.getClass());
		for (final PropertyDescriptor propertyDescriptor : propertyDescriptors) {
			final Method getter = propertyDescriptor.getReadMethod();
			try {
				final Object value = getter.invoke(pojo);

				final String fieldName = CMMetaModelUtils.convertToUnderScore(propertyDescriptor.getName());
				if ("class".equals(fieldName)) {
					continue;
				}
				put(fieldName, value);

			} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
				final String msg = String.format("Could't put the value! %s-%S pojo: %S field: %s ", e, e.getMessage(),
						pojo, propertyDescriptor.getName());
				throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.UNKNOWN, msg, e);
			}
		}
		return this;
	}

	/**
	 * Get the all direct properties(by MetaModel-Attributes) from {@link DomainObject} and put the values into ResponseElement with column
	 * name as key. If a filter was set in the constructor, the value is only added if the attribute name is contained in the filter list.
	 * <br>
	 * Filter is also active. <br>
	 * Dependency Objects(DomainObjects) will never added.<br>
	 * On null object nothing is added.
	 *
	 * @param <DO> entity type
	 * @param domainObject the Entity wherefrom the value(s) read and put into ResponseElement
	 * @throws IllegalArgumentException if {@link DomainObject} is {@code null}.
	 * @return The ResponseElement itself.
	 */
	public <DO extends MetaModelSupport> ResponseElement putAll(final DO domainObject) {
		if (domainObject == null) {
			return this;
		}
		return put(domainObject);
	}

	/**
	 * Get the properties(by modelAttributes) from {@link DomainObject} and put the values into ResponseElement with column name as key. If
	 * a filter was set in the constructor, the value is only added if the attribute name is contained in the filter list. <br>
	 * If no modelAttribute is set, all direct properties will put. <br>
	 * Dependency Objects(DomainObjects) will never added.
	 *
	 * @param <DO> entity type
	 * @param domainObject the Entity wherefrom the value(s) read and put into ResponseElement
	 * @param modelAttributes {@link Attribute} from metamodel of given DomainObject to get the corresponding value
	 * @return The ResponseElement itself.
	 * @throws IllegalArgumentException if {@link DomainObject} and model attribute be {@code null}.
	 */
	@SafeVarargs
	public final <DO extends MetaModelSupport> ResponseElement put(final DO domainObject,
			final Attribute<DO, ?>... modelAttributes) {
		return internalPut(false, domainObject, modelAttributes);
	}

	/**
	 * Get the properties(by modelAttributes) from {@link DomainObject} and put the values into ResponseElement with table and column name
	 * as key. If a filter was set in the constructor, the value is only added if the attribute name is contained in the filter list. <br>
	 * Dependency Objects(DomainObjects) will never added.
	 * <ul>
	 * key for {@link CenOutPpm_#nlabelCounter}
	 * <li>withoutObjectName: NLABEL_COUNTER
	 * <li>withObjectName: CEN_OUT_PPM_NLABEL_COUNTER
	 * </ul>
	 *
	 * @param <DO> entity type
	 * @param withObjectName true if the uses table and column name as key on false the column name is the key
	 * @param domainObject the Entity wherefrom the value(s) read and put into ResponseElement
	 * @param modelAttributes {@link Attribute} from metamodel of given DomainObject to get the corresponding value
	 * @return The ResponseElement itself.
	 */
	@SafeVarargs
	private final <DO extends MetaModelSupport> ResponseElement internalPut(final boolean withObjectName, final DO domainObject,
			final Attribute<DO, ?>... modelAttributes) {
		if (domainObject == null && (modelAttributes == null || modelAttributes.length == 0)) {
			throw new IllegalArgumentException(
					"Domain object and model attributes are null or empty, nothing is put into ResponseElement!");
		}
		Attribute<DO, ?>[] handledAttributes = modelAttributes;
		if (handledAttributes == null || handledAttributes.length == 0) {
			handledAttributes = getAttributes(domainObject);
		}
		if (handledAttributes.length > 0) {
			final Class<DO> clazz = handledAttributes[0].getDeclaringType().getJavaType();
			for (final Attribute<DO, ?> attr : handledAttributes) {
				final SimpleEntry<String, Object> keyValue = getKeyValue(domainObject, attr);
				if (keyValue == null) { // no dependency object is put
					continue;
				}
				String attributeName = "";
				if (withObjectName) {
					final Table table = clazz.getAnnotation(Table.class);
					attributeName = table.name().toLowerCase() + "_" + keyValue.getKey();
				} else {
					attributeName = keyValue.getKey();
				}
				put(attributeName, keyValue.getValue());
			}
		}
		return this;
	}

	/**
	 * Get the key and the value for given {@link Attribute} and {@link DomainObject} as SimpleEntry. The key is the column name from jpa
	 * {@link Column} annotation and the value is the DomainObject attribute value.<br>
	 * Example:<br>
	 * {@link CenOut#getNresultKey()}=1<br>
	 * {@link SimpleEntry#getKey()}=NRESULT_KEY<br>
	 * {@link SimpleEntry#getValue()}=1
	 *
	 * @param <DO> entity type
	 * @param domainObject the Entity wherefrom the value(s) read and put into ResponseElement
	 * @param modelAttribute {@link Attribute} from metamodel of given DomainObject to get the corresponding value
	 * @return the key-value pair as {@link SimpleEntry} or null if the {@link Column} annotation not exist(The attribute is a dependency
	 *         entity object or not mapped).
	 */
	private <DO extends MetaModelSupport> SimpleEntry<String, Object> getKeyValue(final DO domainObject,
			final Attribute<DO, ?> modelAttribute) {

		final Class<DO> clazz = modelAttribute.getDeclaringType().getJavaType();
		final PropertyDescriptor pd = BeanUtils.getPropertyDescriptor(clazz, modelAttribute.getName());
		final Method getter = pd.getReadMethod();
		final Column aColumn = getter.getAnnotation(Column.class);
		// no column annotation -> a dependency object -> not put into response
		if (aColumn == null) { // isAnnotationPresent use also the getAnnotation
			return null;
		}
		try {
			final String columnName = aColumn.name().toLowerCase();
			if (domainObject == null) {
				return new SimpleEntry<>(columnName, null);
			}
			final Object value = getter.invoke(domainObject);

			return new SimpleEntry<>(columnName, value);

		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
			final String msg = String.format("Could't put the value! %s-%s DomainObject: %s field: %s ", e, e.getMessage(),
					domainObject, modelAttribute.getName());
			throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.UNKNOWN, msg, e);
		}
	}

	/**
	 * Get the all direct properties(by MetaModel-Attributes) from {@link DomainObject}.
	 *
	 * @param <DO> entity type
	 * @param domainObject the Entity to get metamodel fields
	 * @return metamodel attribute for entity
	 */
	@SuppressWarnings("unchecked")
	private <DO extends MetaModelSupport> Attribute<DO, ?>[] getAttributes(final DO domainObject) {
		try {
			final List<Attribute<DO, ?>> attributeList = new ArrayList<>();
			final String className = MetaModelHelper.getEntity(domainObject).getClass().getName() + "_";
			final Class<?> clazz = Class.forName(className);
			final Field[] fields = clazz.getFields();
			for (final Field field : fields) {
				attributeList.add((Attribute<DO, ?>) field.get(null));
				ResponseElement.LOGGER.trace("fieldName: {}", field.getName());
			}
			return attributeList.toArray(new Attribute[] {});

		} catch (final ClassNotFoundException e) {
			final String msg = String.format("No metamodel class for given DomainObject found! %s-%s - DomainObject: %s ", e,
					e.getMessage(), domainObject);
			throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.UNKNOWN, msg, e);
		} catch (IllegalArgumentException | IllegalAccessException e) {
			final String msg = String.format("Problem: %s - DomainObject: %s-%s ", e, e.getMessage(), domainObject);
			throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.UNKNOWN, msg, e);
		}
	}

	/**
	 * Returns the Map containing the response element data.
	 *
	 * @return the response element data.
	 */
	public Map<String, Object> getResponseElement() {
		return element;
	}

}
