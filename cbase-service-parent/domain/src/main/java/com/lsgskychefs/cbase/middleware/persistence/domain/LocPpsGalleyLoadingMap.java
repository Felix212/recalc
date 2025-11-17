/*
 * Copyright (c) 2015-2023 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 21-Nov-2024 12:19:13 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table LOC_PPS_GALLEY_LOADING_MAP
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PPS_GALLEY_LOADING_MAP"
		, uniqueConstraints = @UniqueConstraint(columnNames = { "NGALLEY_KEY", "NHANDLING_TYPE_KEY", "CUNIT" })
)
public class LocPpsGalleyLoadingMap implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
    
	private long ngalleyLoadingMapKey;
	private LocPpsLoadingBox locPpsLoadingBox;
	private CenHandlingTypes cenHandlingTypes;
	private CenGalley cenGalley;
	private String cunit;

	@Id
	@Column(name = "NGALLEY_LOADING_MAP_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNgalleyLoadingMapKey() {
		return this.ngalleyLoadingMapKey;
	}

	public void setNgalleyLoadingMapKey(long ngalleyLoadingMapKey) {
		this.ngalleyLoadingMapKey = ngalleyLoadingMapKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLOADING_BOX_KEY", nullable = false)
	public LocPpsLoadingBox getLocPpsLoadingBox() {
		return this.locPpsLoadingBox;
	}

	public void setLocPpsLoadingBox(LocPpsLoadingBox locPpsLoadingBox) {
		this.locPpsLoadingBox = locPpsLoadingBox;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NHANDLING_TYPE_KEY", nullable = false)
	public CenHandlingTypes getCenHandlingTypes() {
		return this.cenHandlingTypes;
	}

	public void setCenHandlingTypes(CenHandlingTypes cenHandlingTypes) {
		this.cenHandlingTypes = cenHandlingTypes;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NGALLEY_KEY", nullable = false)
	public CenGalley getCenGalley() {
		return this.cenGalley;
	}

	public void setCenGalley(CenGalley cenGalley) {
		this.cenGalley = cenGalley;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(String cunit) {
		this.cunit = cunit;
	}

}


