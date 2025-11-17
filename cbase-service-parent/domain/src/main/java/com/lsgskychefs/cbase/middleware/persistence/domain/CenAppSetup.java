package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 22.03.2019 13:07:37 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_APP_SETUP
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_APP_SETUP")
public class CenAppSetup implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenAppSetupId id;
	private String cvalue;
	private Date dtimestamp;
	private String cchanged;

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "capp", column = @Column(name = "CAPP", nullable = false, length = 40)),
			@AttributeOverride(name = "csection", column = @Column(name = "CSECTION", nullable = false, length = 25)),
			@AttributeOverride(name = "ckey", column = @Column(name = "CKEY", nullable = false, length = 25)) })
	public CenAppSetupId getId() {
		return this.id;
	}

	public void setId(final CenAppSetupId id) {
		this.id = id;
	}

	@Column(name = "CVALUE", length = 4000)
	public String getCvalue() {
		return this.cvalue;
	}

	public void setCvalue(final String cvalue) {
		this.cvalue = cvalue;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CCHANGED", length = 40)
	public String getCchanged() {
		return this.cchanged;
	}

	public void setCchanged(final String cchanged) {
		this.cchanged = cchanged;
	}

}
