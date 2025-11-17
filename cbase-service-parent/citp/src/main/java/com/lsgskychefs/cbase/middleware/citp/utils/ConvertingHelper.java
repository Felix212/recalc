package com.lsgskychefs.cbase.middleware.citp.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import org.apache.commons.lang.StringUtils;

public class ConvertingHelper {

	public static List<Long> convertStringToArrayLong(final String requestCustomFlightType) {

		if (StringUtils.isNotEmpty(requestCustomFlightType)) {

			final Pattern pattern = Pattern.compile(",");
			return pattern.splitAsStream(requestCustomFlightType).map(Long::valueOf).collect(Collectors.toList());

		} else {
			return new ArrayList<>();
		}
	}

}
