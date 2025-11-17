/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence;

import java.io.Serializable;
import java.util.Locale;

import org.hibernate.AssertionFailure;
import org.hibernate.cfg.NamingStrategy;
import org.hibernate.internal.util.StringHelper;

/**
 * @author Dirk Bunk - U200035
 */
public class CbaseMiddlewarePhysicalNamingStrategy implements NamingStrategy, Serializable {
	/**
	 * A convenient singleton instance
	 */
	public static final NamingStrategy INSTANCE = new CbaseMiddlewarePhysicalNamingStrategy();

	/**
	 * Return the unqualified class name, mixed case converted to underscores
	 * 
	 * @param className
	 * @return the unqualified class name
	 */
	@Override
	public String classToTableName(final String className) {
		return addUnderscores(StringHelper.unqualify(className));
	}

	/**
	 * Return the full property path with underscore separators, mixed case converted to underscores
	 * 
	 * @param propertyName
	 * @return the full property path with underscore separators
	 */
	@Override
	public String propertyToColumnName(final String propertyName) {
		return addUnderscores(StringHelper.unqualify(propertyName));
	}

	/**
	 * Convert mixed case to underscores
	 * 
	 * @param tableName
	 * @return converted table name
	 */
	@Override
	public String tableName(final String tableName) {
		return addUnderscores(tableName).toUpperCase();
	}

	/**
	 * Convert mixed case to underscores
	 * 
	 * @param columnName
	 * @return converted column name
	 */
	@Override
	public String columnName(final String columnName) {
		return addUnderscores(columnName);
	}

	protected static String addUnderscores(final String name) {
		final StringBuilder buf = new StringBuilder(name.replace('.', '_'));
		for (int i = 1; i < buf.length() - 1; i++) {
			if (Character.isLowerCase(buf.charAt(i - 1)) &&
					Character.isUpperCase(buf.charAt(i)) &&
					Character.isLowerCase(buf.charAt(i + 1))) {
				buf.insert(i++, '_');
			}
		}
		return buf.toString().toLowerCase(Locale.ROOT);
	}

	/**
	 * Return a collection table name ie an association having a join table
	 * 
	 * @param ownerEntity
	 * @param ownerEntityTable
	 * @param associatedEntity
	 * @param associatedEntityTable
	 * @param propertyName
	 * @return the collection table name
	 */
	@Override
	public String collectionTableName(
			final String ownerEntity,
			final String ownerEntityTable,
			final String associatedEntity,
			final String associatedEntityTable,
			final String propertyName) {
		return tableName(ownerEntityTable + '_' + propertyToColumnName(propertyName));
	}

	/**
	 * Return the join key column name ie a FK column used in a JOINED strategy or for a secondary table
	 * 
	 * @param joinedColumn
	 * @param joinedTable
	 * @return the join key column name
	 */
	@Override
	public String joinKeyColumnName(final String joinedColumn, final String joinedTable) {
		return columnName(joinedColumn);
	}

	/**
	 * Return the foreign key column name for the given parameters
	 * 
	 * @param propertyName
	 * @param propertyEntityName
	 * @param propertyTableName
	 * @param referencedColumnName
	 * @return the foreign key column name
	 */
	@Override
	public String foreignKeyColumnName(
			final String propertyName, final String propertyEntityName, final String propertyTableName, final String referencedColumnName) {
		final String header = propertyName != null ? StringHelper.unqualify(propertyName) : propertyTableName;
		if (header == null) {
			throw new AssertionFailure("NamingStrategy not properly filled");
		}
		return columnName(header); // + "_" + referencedColumnName not used for backward compatibility
	}

	/**
	 * Return the logical column name used to refer to a column in the metadata (like index, unique constraints etc) A full bijection is
	 * required between logicalNames and physical ones logicalName have to be case insersitively unique for a given table
	 * 
	 * @param columnName
	 * @param propertyName
	 * @return the logical column name
	 */
	@Override
	public String logicalColumnName(final String columnName, final String propertyName) {
		return StringHelper.isNotEmpty(columnName) ? columnName : StringHelper.unqualify(propertyName);
	}

	/**
	 * Returns either the table name if explicit or if there is an associated table, the concatenation of owner entity table and associated
	 * table otherwise the concatenation of owner entity table and the unqualified property name
	 * 
	 * @param tableName
	 * @param ownerEntityTable
	 * @param associatedEntityTable
	 * @param propertyName
	 * @return the logical collection table name
	 */
	@Override
	public String logicalCollectionTableName(
			final String tableName,
			final String ownerEntityTable,
			final String associatedEntityTable,
			final String propertyName) {
		if (tableName != null) {
			return tableName;
		} else {
			// use of a stringbuffer to workaround a JDK bug
			return new StringBuffer(ownerEntityTable).append("_")
					.append(
							associatedEntityTable != null ? associatedEntityTable : StringHelper.unqualify(propertyName))
					.toString();
		}
	}

	/**
	 * Return the column name if explicit or the concatenation of the property name and the referenced column
	 * 
	 * @param columnName
	 * @param propertyName
	 * @param referencedColumn
	 * @return the logical collection column name
	 */
	@Override
	public String logicalCollectionColumnName(final String columnName, final String propertyName, final String referencedColumn) {
		return StringHelper.isNotEmpty(columnName) ? columnName : (StringHelper.unqualify(propertyName) + "_" + referencedColumn);
	}
}
