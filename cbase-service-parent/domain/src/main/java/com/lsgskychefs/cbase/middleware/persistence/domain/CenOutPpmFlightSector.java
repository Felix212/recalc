package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 22.08.2017 08:17:04 by Hibernate Tools 4.3.5.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_FLIGHT_SECTOR
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_FLIGHT_SECTOR")
public class CenOutPpmFlightSector implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutPpmFlightSectorId id;

	private String ccomment;

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nsectorKey", column = @Column(name = "NSECTOR_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenOutPpmFlightSectorId getId() {
		return this.id;
	}

	public void setId(final CenOutPpmFlightSectorId id) {
		this.id = id;
	}

	@Column(name = "CCOMMENT", length = 40)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(final String ccomment) {
		this.ccomment = ccomment;
	}

}
