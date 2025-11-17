/*
 * Copyright (c) 2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.persistence.utils;

/**
 * Can be used with @JsonView
 *
 * @author Alex Schaab - U524036
 */
public class View {
	/**
	 * Use this as @JsonView to serialize [a subset of all] simple datatypes like string, boolean, long ...
	 */
	public interface Simple {
	}

	/**
	 * Use this as @JsonView to serialize [a subset of all] complex datatypes like object references.
	 */
	public interface SimpleWithReferences extends Simple {
	}

	/**
	 * Use this as @JsonView to serialize [a subset of all] along side with one or more special relations
	 */
	public interface SpecialRelation extends Simple {
	}

	/**
	 * Use this as @JsonView to serialize all simple datatypes like string, boolean, long ...
	 */
	public interface Full extends Simple {
	}

	/**
	 * Use this as @JsonView to serialize all simple datatypes like string, boolean, long ...
	 */
	public interface FullWithReferences extends SimpleWithReferences {
	}
}
