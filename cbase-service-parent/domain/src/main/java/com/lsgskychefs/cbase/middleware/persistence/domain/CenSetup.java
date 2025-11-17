package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 16.12.2015 15:52:07 by Hibernate Tools 4.3.1.Final

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.lsgskychefs.cbase.middleware.persistence.constant.CenSetupKeySection;
import com.lsgskychefs.cbase.middleware.persistence.utils.CbaseMiddlewareStringUtils;

/**
 * Entity(DomainObject) for table CEN_SETUP
 *
 * @see CenSetupKeySection
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_SETUP")
public class CenSetup implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenSetupId id;

	private String cvalue = " ";

	private Date dtimestamp;

	private String cchanged;

	public CenSetup() {
	}

	public CenSetup(final CenSetupId id) {
		this.id = id;
	}

	public CenSetup(final CenSetupId id, final String cvalue, final Date dtimestamp, final String cchanged) {
		this.id = id;
		this.cvalue = cvalue;
		this.dtimestamp = dtimestamp;
		this.cchanged = cchanged;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "cclient", column = @Column(name = "CCLIENT", nullable = false, length = 3)),
			@AttributeOverride(name = "csection", column = @Column(name = "CSECTION", nullable = false, length = 25)),
			@AttributeOverride(name = "ckey", column = @Column(name = "CKEY", nullable = false, length = 25)) })
	public CenSetupId getId() {
		return this.id;
	}

	public void setId(final CenSetupId id) {
		this.id = id;
	}

	@Column(name = "CVALUE")
	public String getCvalue() {
		return this.cvalue;
	}

	public void setCvalue(final String cvalue) {
		this.cvalue = CbaseMiddlewareStringUtils.defaultString(cvalue);
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
