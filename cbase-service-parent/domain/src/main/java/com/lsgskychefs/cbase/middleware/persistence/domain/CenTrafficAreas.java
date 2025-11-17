package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 23, 2019 2:41:41 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_TRAFFIC_AREAS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_TRAFFIC_AREAS", uniqueConstraints = { @UniqueConstraint(columnNames = { "CTEXT", "NCUSTOMER_KEY" }),
		@UniqueConstraint(columnNames = { "CSHORT", "NCUSTOMER_KEY" }) })
public class CenTrafficAreas implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** nareaKey */
	private long nareaKey;

	/** cclient */
	private String cclient;

	/** ncustomerKey */
	private long ncustomerKey;

	/** cshort */
	private String cshort;

	/** ctext */
	private String ctext;

	/** cdescription */
	private String cdescription;

	/** dtimestampModification */
	private Date dtimestampModification;

	/** nownerId */
	private Integer nownerId;

	/** nvatFlag */
	private Integer nvatFlag;

	/** cenCityPairses */
	private Set<CenCityPairs> cenCityPairses = new HashSet<>(0);

	@Id
	@Column(name = "NAREA_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNareaKey() {
		return this.nareaKey;
	}

	public void setNareaKey(final long nareaKey) {
		this.nareaKey = nareaKey;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "NCUSTOMER_KEY", nullable = false, precision = 12, scale = 0)
	public long getNcustomerKey() {
		return this.ncustomerKey;
	}

	public void setNcustomerKey(final long ncustomerKey) {
		this.ncustomerKey = ncustomerKey;
	}

	@Column(name = "CSHORT", nullable = false, length = 6)
	public String getCshort() {
		return this.cshort;
	}

	public void setCshort(final String cshort) {
		this.cshort = cshort;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CDESCRIPTION", length = 250)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_MODIFICATION", length = 7)
	public Date getDtimestampModification() {
		return this.dtimestampModification;
	}

	public void setDtimestampModification(final Date dtimestampModification) {
		this.dtimestampModification = dtimestampModification;
	}

	@Column(name = "NOWNER_ID", precision = 5, scale = 0)
	public Integer getNownerId() {
		return this.nownerId;
	}

	public void setNownerId(final Integer nownerId) {
		this.nownerId = nownerId;
	}

	@Column(name = "NVAT_FLAG", precision = 1, scale = 0)
	public Integer getNvatFlag() {
		return this.nvatFlag;
	}

	public void setNvatFlag(final Integer nvatFlag) {
		this.nvatFlag = nvatFlag;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenTrafficAreas")
	public Set<CenCityPairs> getCenCityPairses() {
		return this.cenCityPairses;
	}

	public void setCenCityPairses(final Set<CenCityPairs> cenCityPairses) {
		this.cenCityPairses = cenCityPairses;
	}

}
