package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 24.05.2016 09:45:22 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_LABEL_TYPE_DETAIL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_LABEL_TYPE_DETAIL")
public class CenLabelTypeDetail implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenLabelTypeDetailId id;
	private CenLabelType cenLabelType;
	private CenJasperReport cenJasperReport;
	private Date dvalidTo;
	private String ctext;
	private Set<CenLabelDetail> cenLabelDetails = new HashSet<>(0);

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nlabelTypeKey", column = @Column(name = "NLABEL_TYPE_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "dvalidFrom", column = @Column(name = "DVALID_FROM", nullable = false, length = 7)) })
	public CenLabelTypeDetailId getId() {
		return this.id;
	}

	public void setId(final CenLabelTypeDetailId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLABEL_TYPE_KEY", nullable = false, insertable = false, updatable = false)
	public CenLabelType getCenLabelType() {
		return this.cenLabelType;
	}

	public void setCenLabelType(final CenLabelType cenLabelType) {
		this.cenLabelType = cenLabelType;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NJASPER_KEY")
	public CenJasperReport getCenJasperReport() {
		return this.cenJasperReport;
	}

	public void setCenJasperReport(final CenJasperReport cenJasperReport) {
		this.cenJasperReport = cenJasperReport;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "CTEXT", length = 128)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenLabelTypeDetail")
	public Set<CenLabelDetail> getCenLabelDetails() {
		return this.cenLabelDetails;
	}

	public void setCenLabelDetails(final Set<CenLabelDetail> cenLabelDetails) {
		this.cenLabelDetails = cenLabelDetails;
	}

}
