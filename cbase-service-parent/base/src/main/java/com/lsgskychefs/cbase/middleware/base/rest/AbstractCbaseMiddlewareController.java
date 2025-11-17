/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lsgskychefs.cbase.middleware.base.CbaseDefaultParameter;
import com.lsgskychefs.cbase.middleware.base.business.CbaseMiddlewareConfigurationService;
import com.lsgskychefs.cbase.middleware.base.rest.ResponseElement.ElementAttribute;
import com.lsgskychefs.cbase.middleware.persistence.domain.DomainObject;
import com.lsgskychefs.cbase.middleware.persistence.domain.DomainObjectPk;
import com.lsgskychefs.cbase.middleware.persistence.domain.MetaModelSupport;
import com.lsgskychefs.cbase.middleware.persistence.pojo.Pojo;

/**
 * Base controller with methods for all controller.
 * <p>
 * All controller methods supports the {@link CbaseDefaultParameter}. The parameter mapping is case insensitive
 * {@link CbaseMiddlewareCaseInsensitiveRequestFilter}
 * <p>
 * HTTP Methods - http://www.restapitutorial.com/lessons/httpmethods.html
 * <table>
 * <tr>
 * <td>HTTP Verb</td>
 * <td>CRUD</td>
 * <td>Entire Collection (e.g. /customers)</td>
 * <td>Specific Item (e.g. /customers/{id})</td>
 * </tr>
 * <tr>
 * <td>POST</td>
 * <td>Create</td>
 * <td>201 (Created), 'Location' header with link to /customers/{id} containing new ID.</td>
 * <td>404 (Not Found), 409 (Conflict) if resource already exists.</td>
 * </tr>
 * <tr>
 * <td>GET</td>
 * <td>Read</td>
 * <td>200 (OK), list of customers. Use pagination, sorting and filtering to navigate big lists.</td>
 * <td>200 (OK), single customer. 404 (Not Found), if ID not found or invalid.</td>
 * </tr>
 * <tr>
 * <td>PUT</td>
 * <td>Update</td>
 * <td>404 (Not Found), unless you want to update/replace every resource in the entire collection.</td>
 * <td>200 (OK) or 204 (No Content). 404 (Not Found), if ID not found or invalid.</td>
 * </tr>
 * <tr>
 * <td>DELETE</td>
 * <td>Delete</td>
 * <td>404 (Not Found), unless you want to delete the whole collection—not often desirable.</td>
 * <td>200 (OK). 404 (Not Found), if ID not found or invalid.</td>
 * </tr>
 * </table>
 *
 * @author Ingo Rietzschel - U125742
 */
@ResponseBody // ( the @RestController annotation makes it obsolete, but is required by current enunciate version)
@Transactional(rollbackFor = java.lang.Throwable.class)
@RequestMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
public abstract class AbstractCbaseMiddlewareController implements CbaseMiddlewareController {

	/** CBASE-Middleware configuration property service */
	@Autowired
	protected CbaseMiddlewareConfigurationService configService;

	/**
	 * The application version number. e.g: 'CBASE-Middleware-1.0-build12'
	 *
	 * @return the applicator version number.
	 */
	protected String getVersionNumber() {
		return configService.getVersion();
	}

	/**
	 * Current application name.
	 *
	 * @return current application name
	 */
	protected String getApplicationName() {
		return configService.getApplicationName();
	}

	/**
	 * Current server instance
	 *
	 * @return current server instance
	 */
	protected String getJvmRoute() {
		return configService.getJvmRoute();
	}

	/**
	 * Creates a Response Collection and adds all entries.
	 *
	 * @param pojos object extends {@link Pojo}
	 * @param filter the filter list
	 * @return the {@link ResponseCollection} with added {@link ResponseElement}.
	 */
	protected ResponseCollection buildResponseCollectionPojo(final List<? extends Pojo> pojos, final String... filter) {
		final ResponseCollection response = new ResponseCollection();

		for (final Pojo pojo : pojos) {
			response.creatAndAdd(filter)
					.putAll(pojo);
		}
		return response;
	}

	/**
	 * Creates a Response Collection and adds all entries.
	 *
	 * @param domainObjects object extends {@link MetaModelSupport} ({@link DomainObject} or {@link DomainObjectPk})
	 * @param filter the filter list
	 * @return the {@link ResponseCollection} with added {@link ResponseElement}.
	 */
	protected ResponseCollection buildResponseCollectionDO(final List<? extends MetaModelSupport> domainObjects, final String... filter) {
		final ResponseCollection response = new ResponseCollection();

		for (final MetaModelSupport domainObject : domainObjects) {
			response.creatAndAdd(filter)
					.putAll(domainObject);
		}

		return response;
	}

	/**
	 * Add
	 *
	 * @param response the ResponseElement
	 * @param status the special status for response body
	 * @param msg the message
	 * @return this ResponseElement
	 */
	protected ResponseElement addToResponse(final ResponseElement response, final String status, final String msg) {
		response.put(ElementAttribute.STATUS, status);
		response.put(ElementAttribute.MESSAGE, msg);
		return response;
	}

}
