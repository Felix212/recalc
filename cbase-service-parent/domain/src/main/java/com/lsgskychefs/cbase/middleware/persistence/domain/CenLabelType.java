package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Apr 19, 2019 11:40:14 AM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_LABEL_TYPE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_LABEL_TYPE", uniqueConstraints = @UniqueConstraint(columnNames = { "CCLIENT", "CTEXT" }))
public class CenLabelType implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long nlabelTypeKey;
	@JsonView(View.Simple.class)
	private String cclient;
	@JsonView(View.Simple.class)
	private String ctext;
	@JsonView(View.Simple.class)
	private Integer nownerId;
	@JsonView(View.Simple.class)
	private Long nlabelGroupKey;
	@JsonView(View.SimpleWithReferences.class)
	private Set<CenLabelTypeDetail> cenLabelTypeDetails = new HashSet<>(0);
	@JsonView(View.SimpleWithReferences.class)
	private Set<CenPackinglists> cenPackinglistses = new HashSet<>(0);
	@JsonView(View.SimpleWithReferences.class)
	private Set<LocUnitPlProdLabel> locUnitPlProdLabels = new HashSet<>(0);
	@JsonView(View.SimpleWithReferences.class)
	private Set<LocUnitPlFlightLabel> locUnitPlFlightLabels = new HashSet<>(0);

	@Id
	@Column(name = "NLABEL_TYPE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNlabelTypeKey() {
		return this.nlabelTypeKey;
	}

	public void setNlabelTypeKey(final long nlabelTypeKey) {
		this.nlabelTypeKey = nlabelTypeKey;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NOWNER_ID", precision = 5, scale = 0)
	public Integer getNownerId() {
		return this.nownerId;
	}

	public void setNownerId(final Integer nownerId) {
		this.nownerId = nownerId;
	}

	@Column(name = "NLABEL_GROUP_KEY", precision = 12, scale = 0)
	public Long getNlabelGroupKey() {
		return this.nlabelGroupKey;
	}

	public void setNlabelGroupKey(final Long nlabelGroupKey) {
		this.nlabelGroupKey = nlabelGroupKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenLabelType")
	public Set<CenLabelTypeDetail> getCenLabelTypeDetails() {
		return this.cenLabelTypeDetails;
	}

	public void setCenLabelTypeDetails(final Set<CenLabelTypeDetail> cenLabelTypeDetails) {
		this.cenLabelTypeDetails = cenLabelTypeDetails;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenLabelType")
	public Set<CenPackinglists> getCenPackinglistses() {
		return this.cenPackinglistses;
	}

	public void setCenPackinglistses(final Set<CenPackinglists> cenPackinglistses) {
		this.cenPackinglistses = cenPackinglistses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenLabelType")
	public Set<LocUnitPlProdLabel> getLocUnitPlProdLabels() {
		return this.locUnitPlProdLabels;
	}

	public void setLocUnitPlProdLabels(final Set<LocUnitPlProdLabel> locUnitPlProdLabels) {
		this.locUnitPlProdLabels = locUnitPlProdLabels;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenLabelType")
	public Set<LocUnitPlFlightLabel> getLocUnitPlFlightLabels() {
		return this.locUnitPlFlightLabels;
	}

	public void setLocUnitPlFlightLabels(final Set<LocUnitPlFlightLabel> locUnitPlFlightLabels) {
		this.locUnitPlFlightLabels = locUnitPlFlightLabels;
	}

}
