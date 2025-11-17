/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * Contain all available CenRequestTypes
 *
 * @see AbstractRequestService for its usage
 * @author Alex Schaab - U524036
 */
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum CenRequestTypes {
	INVENTORY_PAX(1L), INVENTORY_PAX_AND_SPML(2L), SEND_JFE_FIGURES(3L), PREORDER(6L);

	/** Contains mapping between the long value and {@link CenRequestTypes} */
	private static Map<Long, CenRequestTypes> map;

	static {
		map = new HashMap<>();
		for (final CenRequestTypes label : CenRequestTypes.values()) {
			map.put(label.value, label);
		}
	}

	/** The value for this type */
	private Long value;

	/** Constructor */
	CenRequestTypes(final Long value) {
		this.value = value;
	}

	/**
	 * The value.
	 *
	 * @return the value
	 */
	public Long getValue() {
		return value;
	}

	/**
	 * Returns the name of this enum constant, exactly as declared in its enum
	 * declaration.
	 *
	 * @return the name of this enum constant
	 */
	public String getName() {
		return name();
	}

	public static List<Long> getValues(final CenRequestTypes[] e) {
		return Stream.of(e).map(CenRequestTypes::getValue).collect(Collectors.toList());
	}

	public static CenRequestTypes[] getEnums(final String[] values) {
		return Stream.of(values).map(value -> map.get(Long.valueOf(value))).toArray(CenRequestTypes[]::new);
	}

	public static CenRequestTypes[] getEnums(final String commaSeperated) {
		return getEnums(Pattern.compile(",").splitAsStream(commaSeperated).toArray(String[]::new));
	}

}
