package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table LOC_UNIT_LABEL_GROUPS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_LABEL_GROUPS", uniqueConstraints = @UniqueConstraint(columnNames = { "CTEXT", "CUNIT", "CCLIENT", "NBULK" }))
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class LocUnitLabelGroups implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long nlabelGroupKey;

	@JsonView(View.Simple.class)
	private String cclient;

	@JsonView(View.Simple.class)
	private String cunit;

	@JsonView(View.Simple.class)
	private String ctext;

	@JsonView(View.Simple.class)
	private String cdescription;

	@JsonView(View.Simple.class)
	private Integer nbulk;

	@JsonView(View.Simple.class)
	private int naddNewWs;

	@JsonView(View.SimpleWithReferences.class)
	private Set<LocUnitLabelArea> locUnitLabelAreas = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_UNIT_LABEL_GROUPS")
	@SequenceGenerator(name = "SEQ_LOC_UNIT_LABEL_GROUPS", sequenceName = "SEQ_LOC_UNIT_LABEL_GROUPS", allocationSize = 1)
	@Column(name = "NLABEL_GROUP_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNlabelGroupKey() {
		return this.nlabelGroupKey;
	}

	public void setNlabelGroupKey(final long nlabelGroupKey) {
		this.nlabelGroupKey = nlabelGroupKey;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CTEXT", nullable = false, length = 30)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CDESCRIPTION", length = 254)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NBULK", precision = 1, scale = 0)
	public Integer getNbulk() {
		return this.nbulk;
	}

	public void setNbulk(final Integer nbulk) {
		this.nbulk = nbulk;
	}

	@Column(name = "NADD_NEW_WS", nullable = false, precision = 1, scale = 0)
	public int getNaddNewWs() {
		return this.naddNewWs;
	}

	public void setNaddNewWs(final int naddNewWs) {
		this.naddNewWs = naddNewWs;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitLabelGroups")
	public Set<LocUnitLabelArea> getLocUnitLabelAreas() {
		return this.locUnitLabelAreas;
	}

	public void setLocUnitLabelAreas(final Set<LocUnitLabelArea> locUnitLabelAreas) {
		this.locUnitLabelAreas = locUnitLabelAreas;
	}

}
