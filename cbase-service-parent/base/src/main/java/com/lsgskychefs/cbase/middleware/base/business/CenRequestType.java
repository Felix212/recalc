package com.lsgskychefs.cbase.middleware.base.business;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import com.lsgskychefs.cbase.middleware.persistence.constant.CenRequestTypes;

@Retention(RetentionPolicy.RUNTIME)
@Target({ ElementType.TYPE })
public @interface CenRequestType {

	CenRequestTypes[] types() default {};

	/** Can also be a property ${xxxx.xxxx.property} */
	String commaSeperatedTypes() default "";

	String includeAirlines() default "";
}