package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 23.08.2018 11:45:35 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_PACKINGLIST_TYPES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PACKINGLIST_TYPES", uniqueConstraints = @UniqueConstraint(columnNames = { "CTEXT", "CCLIENT" }))
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenPackinglistTypes implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long npackinglistKey;
	private String cclient;
	private String ctext;
	private String cpackinglistTypeCobis;
	private Integer nownerId;
	private String ctext1;
	private String ctext2;
	private String ctext3;
	private String ctext4;
	private Integer nselection;
	private int nclassification;
	private int nallocateAuto;
	private int nmenuGrid;
	@JsonIgnore
	private CenPackinglistTypePictures cenPackinglistTypePictures;

	@JsonIgnore
	private Set<CenPackinglists> cenPackinglistses = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_PACKINGLIST_TYPES")
	@SequenceGenerator(name = "SEQ_CEN_PACKINGLIST_TYPES", sequenceName = "SEQ_CEN_PACKINGLIST_TYPES", allocationSize = 1)
	@Column(name = "NPACKINGLIST_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNpackinglistKey() {
		return this.npackinglistKey;
	}

	public void setNpackinglistKey(final long npackinglistKey) {
		this.npackinglistKey = npackinglistKey;
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

	@Column(name = "CPACKINGLIST_TYPE_COBIS", length = 3)
	public String getCpackinglistTypeCobis() {
		return this.cpackinglistTypeCobis;
	}

	public void setCpackinglistTypeCobis(final String cpackinglistTypeCobis) {
		this.cpackinglistTypeCobis = cpackinglistTypeCobis;
	}

	@Column(name = "NOWNER_ID", precision = 5, scale = 0)
	public Integer getNownerId() {
		return this.nownerId;
	}

	public void setNownerId(final Integer nownerId) {
		this.nownerId = nownerId;
	}

	@Column(name = "CTEXT1", length = 40)
	public String getCtext1() {
		return this.ctext1;
	}

	public void setCtext1(final String ctext1) {
		this.ctext1 = ctext1;
	}

	@Column(name = "CTEXT2", length = 40)
	public String getCtext2() {
		return this.ctext2;
	}

	public void setCtext2(final String ctext2) {
		this.ctext2 = ctext2;
	}

	@Column(name = "CTEXT3", length = 40)
	public String getCtext3() {
		return this.ctext3;
	}

	public void setCtext3(final String ctext3) {
		this.ctext3 = ctext3;
	}

	@Column(name = "CTEXT4", length = 40)
	public String getCtext4() {
		return this.ctext4;
	}

	public void setCtext4(final String ctext4) {
		this.ctext4 = ctext4;
	}

	@Column(name = "NSELECTION", precision = 1, scale = 0)
	public Integer getNselection() {
		return this.nselection;
	}

	public void setNselection(final Integer nselection) {
		this.nselection = nselection;
	}

	@Column(name = "NCLASSIFICATION", nullable = false, precision = 2, scale = 0, columnDefinition = "NUMBER(2) DEFAULT 1")
	public int getNclassification() {
		return this.nclassification;
	}

	public void setNclassification(final int nclassification) {
		this.nclassification = nclassification;
	}

	@Column(name = "NALLOCATE_AUTO", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNallocateAuto() {
		return this.nallocateAuto;
	}

	public void setNallocateAuto(final int nallocateAuto) {
		this.nallocateAuto = nallocateAuto;
	}

	@Column(name = "NMENU_GRID", precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNmenuGrid() {
		return nmenuGrid;
	}

	public void setNmenuGrid(int nmenuGrid) {
		this.nmenuGrid = nmenuGrid;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglistTypes")
	public Set<CenPackinglists> getCenPackinglistses() {
		return this.cenPackinglistses;
	}

	public void setCenPackinglistses(final Set<CenPackinglists> cenPackinglistses) {
		this.cenPackinglistses = cenPackinglistses;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "cenPackinglistTypes")
	public CenPackinglistTypePictures getCenPackinglistTypePictures() {
		return this.cenPackinglistTypePictures;
	}

	public void setCenPackinglistTypePictures(CenPackinglistTypePictures cenPackinglistTypePictures) {
		this.cenPackinglistTypePictures = cenPackinglistTypePictures;
	}
}
