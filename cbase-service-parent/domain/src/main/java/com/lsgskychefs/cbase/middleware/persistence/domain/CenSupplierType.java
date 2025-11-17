package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 12.12.2019 14:59:46 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_SUPPLIER_TYPE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_SUPPLIER_TYPE")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenSupplierType implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nsuppTypeKey;

	private String ctext;

	private Date dvalidFrom;

	private Date dvalidTo;

	private Date dtimestampModification;

	@JsonIgnore
	private Set<CenSupplier> cenSuppliers = new HashSet<>(0);

	@Id
	@Column(name = "NSUPP_TYPE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsuppTypeKey() {
		return this.nsuppTypeKey;
	}

	public void setNsuppTypeKey(final long nsuppTypeKey) {
		this.nsuppTypeKey = nsuppTypeKey;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(final Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_MODIFICATION", length = 7)
	public Date getDtimestampModification() {
		return this.dtimestampModification;
	}

	public void setDtimestampModification(final Date dtimestampModification) {
		this.dtimestampModification = dtimestampModification;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenSupplierType")
	public Set<CenSupplier> getCenSuppliers() {
		return this.cenSuppliers;
	}

	public void setCenSuppliers(final Set<CenSupplier> cenSuppliers) {
		this.cenSuppliers = cenSuppliers;
	}

}
