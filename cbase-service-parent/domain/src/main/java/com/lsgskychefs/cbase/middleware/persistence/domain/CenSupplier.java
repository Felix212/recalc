package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_SUPPLIER
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_SUPPLIER")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenSupplier implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nsupplierKey;

	private CenSupplierType cenSupplierType;

	private String csupplier;

	private Date dtimestampModification;

	private Integer nownerId;

	private String csuppNr;

	private Integer npackinglistPrefix;

	@JsonIgnore
	private Set<CenHandling> cenHandlings = new HashSet<>(0);

	@JsonIgnore
	private Set<CenPackinglistIndex> cenPackinglistIndexes = new HashSet<>(0);

	@JsonIgnore
	private Set<SysUnits> sysUnitses = new HashSet<>(0);

	@Id
	@Column(name = "NSUPPLIER_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsupplierKey() {
		return this.nsupplierKey;
	}

	public void setNsupplierKey(final long nsupplierKey) {
		this.nsupplierKey = nsupplierKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSUPP_TYPE_KEY")
	public CenSupplierType getCenSupplierType() {
		return this.cenSupplierType;
	}

	public void setCenSupplierType(final CenSupplierType cenSupplierType) {
		this.cenSupplierType = cenSupplierType;
	}

	@Column(name = "CSUPPLIER", nullable = false, length = 40)
	public String getCsupplier() {
		return this.csupplier;
	}

	public void setCsupplier(final String csupplier) {
		this.csupplier = csupplier;
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

	@Column(name = "CSUPP_NR", length = 18)
	public String getCsuppNr() {
		return this.csuppNr;
	}

	public void setCsuppNr(final String csuppNr) {
		this.csuppNr = csuppNr;
	}

	@Column(name = "NPACKINGLIST_PREFIX", precision = 4, scale = 0)
	public Integer getNpackinglistPrefix() {
		return this.npackinglistPrefix;
	}

	public void setNpackinglistPrefix(final Integer npackinglistPrefix) {
		this.npackinglistPrefix = npackinglistPrefix;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenSupplier")
	public Set<CenHandling> getCenHandlings() {
		return this.cenHandlings;
	}

	public void setCenHandlings(final Set<CenHandling> cenHandlings) {
		this.cenHandlings = cenHandlings;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenSupplier")
	public Set<CenPackinglistIndex> getCenPackinglistIndexes() {
		return this.cenPackinglistIndexes;
	}

	public void setCenPackinglistIndexes(final Set<CenPackinglistIndex> cenPackinglistIndexes) {
		this.cenPackinglistIndexes = cenPackinglistIndexes;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenSupplier")
	public Set<SysUnits> getSysUnitses() {
		return this.sysUnitses;
	}

	public void setSysUnitses(final Set<SysUnits> sysUnitses) {
		this.sysUnitses = sysUnitses;
	}

}
