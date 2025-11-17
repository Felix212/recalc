/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.query;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;

import javax.persistence.Column;
import javax.persistence.metamodel.Attribute;

import org.hibernate.proxy.HibernateProxy;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import com.lsgskychefs.cbase.middleware.persistence.domain.MetaModelSupport;

/**
 * Helper for JPA/Metamodel functionlity.
 *
 * @author Ingo Rietzschel - U125742
 */
@Component
public class MetaModelHelper {

	/**
	 * Check if the object is a proxy and return the entity
	 *
	 * @param <DO> the entity class
	 * @param potencialProxy the proxy class or the entity.
	 * @return the entity
	 */
	@SuppressWarnings("unchecked")
	public static <DO extends MetaModelSupport> DO getEntity(final DO potencialProxy) {
		if (potencialProxy instanceof HibernateProxy) {
			return (DO) ((HibernateProxy) potencialProxy).getHibernateLazyInitializer().getImplementation();
		}
		return potencialProxy;
	}

	/**
	 * Get the corresponding column name for given attribute(property) name of an Entity.
	 *
	 * @param domainObjectClass entity class
	 * @param attribute the attribute to get column name
	 * @return the column name
	 */
	public String getColumnName(final Class<?> domainObjectClass, final Attribute<?, ?> attribute) {

		final PropertyDescriptor pd = BeanUtils.getPropertyDescriptor(domainObjectClass, attribute.getName());
		final Method getter = pd.getReadMethod();
		final Column aColumn = getter.getAnnotation(Column.class);
		// no column annotation -> a dependency object -> not put into response
		if (aColumn == null) { // isAnnotationPresent use also the getAnnotation
			return null;
		}

		return aColumn.name().toLowerCase();

	}

}
