package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_PACKINGLIST_TYPE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_PACKINGLIST_TYPE")
public class SysPackinglistType implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private SysPackinglistTypeId id;
	private String ctext;
	private int nbcExclude;
	private int ndefault;
	private Integer ndefaultOwnerId;

	public SysPackinglistType() {
	}

	public SysPackinglistType(final SysPackinglistTypeId id, final String ctext, final int nbcExclude, final int ndefault) {
		this.id = id;
		this.ctext = ctext;
		this.nbcExclude = nbcExclude;
		this.ndefault = ndefault;
	}

	public SysPackinglistType(final SysPackinglistTypeId id, final String ctext, final int nbcExclude, final int ndefault,
			final Integer ndefaultOwnerId) {
		this.id = id;
		this.ctext = ctext;
		this.nbcExclude = nbcExclude;
		this.ndefault = ndefault;
		this.ndefaultOwnerId = ndefaultOwnerId;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "cclient", column = @Column(name = "CCLIENT", nullable = false, length = 3)),
			@AttributeOverride(name = "cpackinglistMatch", column = @Column(name = "CPACKINGLIST_MATCH", nullable = false, length = 18)),
			@AttributeOverride(name = "npackinglist1stGroup",
					column = @Column(name = "NPACKINGLIST_1ST_GROUP", nullable = false, precision = 6, scale = 0)),
			@AttributeOverride(name = "npackinglist2ndGroup",
					column = @Column(name = "NPACKINGLIST_2ND_GROUP", nullable = false, precision = 6, scale = 0)) })
	public SysPackinglistTypeId getId() {
		return this.id;
	}

	public void setId(final SysPackinglistTypeId id) {
		this.id = id;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NBC_EXCLUDE", nullable = false, precision = 1, scale = 0)
	public int getNbcExclude() {
		return this.nbcExclude;
	}

	public void setNbcExclude(final int nbcExclude) {
		this.nbcExclude = nbcExclude;
	}

	@Column(name = "NDEFAULT", nullable = false, precision = 1, scale = 0)
	public int getNdefault() {
		return this.ndefault;
	}

	public void setNdefault(final int ndefault) {
		this.ndefault = ndefault;
	}

	@Column(name = "NDEFAULT_OWNER_ID", precision = 5, scale = 0)
	public Integer getNdefaultOwnerId() {
		return this.ndefaultOwnerId;
	}

	public void setNdefaultOwnerId(final Integer ndefaultOwnerId) {
		this.ndefaultOwnerId = ndefaultOwnerId;
	}

}
