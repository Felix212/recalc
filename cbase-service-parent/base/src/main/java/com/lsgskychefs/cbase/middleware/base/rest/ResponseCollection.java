/*
 * ResponseCollection.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.rest;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.lsgskychefs.cbase.middleware.base.rest.serializer.ResponseCollectionSerializer;

/**
 * Class representing a collection of <code>ResponseCollection</code> elements to be used as result of REST services.
 *
 * @author Andreas Morgenstern
 */
@JsonSerialize(using = ResponseCollectionSerializer.class)
public class ResponseCollection {

	/**
	 * The <code>List</code> containing the response elements.
	 */
	private final List<ResponseElement> responseElements = new ArrayList<>();

	/**
	 * Public constructor.
	 */
	public ResponseCollection() {
		super();
	}

	/**
	 * Adds a {@link ResponseElement} to the result collections.
	 *
	 * @param element the <code>ResponseCollection</code> to be added.
	 * @return <tt>true</tt> (as specified by {@link Collection#add})
	 */
	public boolean add(final ResponseElement element) {
		return responseElements.add(element);
	}

	/**
	 * Create a {@link ResponseElement} adds the element to the result collection and return the element.
	 *
	 * @param filter the array of attribute names that may be added to this <code>ResponseElement</code>. The order of filter defined the
	 *            order of serialized keys.
	 * @return the created and added {@link ResponseElement}
	 */
	public ResponseElement creatAndAdd(final String... filter) {
		final ResponseElement element = new ResponseElement(filter);
		responseElements.add(element);
		return element;
	}

	/**
	 * The {@link ResponseElement} collection
	 *
	 * @return the {@link ResponseElement} collection
	 */
	public List<ResponseElement> getResponseElements() {
		return this.responseElements;
	}

	/**
	 * Checks whether this <code>ResponseCollection</code> has no <code>ResponseElement</code>.
	 *
	 * @return true, if there is no <code>ResponseElement</code> contained in this <code>ResponseCollection</code>.
	 */
	public boolean isEmpty() {
		return responseElements.isEmpty();
	}

}
