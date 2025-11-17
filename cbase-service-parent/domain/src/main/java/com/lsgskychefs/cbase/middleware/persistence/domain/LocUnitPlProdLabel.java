package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

/**
 * Entity(DomainObject) for table LOC_UNIT_PL_PROD_LABEL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_PL_PROD_LABEL")
public class LocUnitPlProdLabel implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private Long nplAreaKey;
	private LocUnitPlAreas locUnitPlAreas;
	private CenLabelType cenLabelType;
	private String ctext;
	private int nitemsPerUnit;
	private int nlabelPrint;
	private String cunit;
	private String caddtext;
	private Integer nmassProduction;
	private Integer nfactor;
	private Long nworkstationKey;
	private Long nareaKey;
	private Long nrangeKey;
	private BigDecimal nrunrate;
	private long nccplog3;
	private Integer nccplog4;
	private Integer nccplog5;
	private Long nlabelTypeKeySpml;
	private Integer nlabelPrintSpml;
	private Long nlabelTypeKey2;
	private Integer nlabelPrint2;
	private BigDecimal nmaxbatchsize;
	private Long nworkstationKey2;
	private Integer nitemsPerUnit2;
	private String cunit2;
	private BigDecimal nsetuprate;

	@Id
	@GenericGenerator(name = "generator", strategy = "foreign", parameters = @Parameter(name = "property", value = "locUnitPlAreas"))
	@GeneratedValue(generator = "generator")
	@Column(name = "NPL_AREA_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public Long getNplAreaKey() {
		return this.nplAreaKey;
	}

	public void setNplAreaKey(final Long nplAreaKey) {
		this.nplAreaKey = nplAreaKey;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	public LocUnitPlAreas getLocUnitPlAreas() {
		return this.locUnitPlAreas;
	}

	public void setLocUnitPlAreas(final LocUnitPlAreas locUnitPlAreas) {
		this.locUnitPlAreas = locUnitPlAreas;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLABEL_TYPE_KEY", nullable = false)
	public CenLabelType getCenLabelType() {
		return this.cenLabelType;
	}

	public void setCenLabelType(final CenLabelType cenLabelType) {
		this.cenLabelType = cenLabelType;
	}

	@Column(name = "CTEXT", length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NITEMS_PER_UNIT", nullable = false, precision = 7, scale = 0)
	public int getNitemsPerUnit() {
		return this.nitemsPerUnit;
	}

	public void setNitemsPerUnit(final int nitemsPerUnit) {
		this.nitemsPerUnit = nitemsPerUnit;
	}

	@Column(name = "NLABEL_PRINT", nullable = false, precision = 1, scale = 0)
	public int getNlabelPrint() {
		return this.nlabelPrint;
	}

	public void setNlabelPrint(final int nlabelPrint) {
		this.nlabelPrint = nlabelPrint;
	}

	@Column(name = "CUNIT", length = 40)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CADDTEXT", length = 40)
	public String getCaddtext() {
		return this.caddtext;
	}

	public void setCaddtext(final String caddtext) {
		this.caddtext = caddtext;
	}

	@Column(name = "NMASS_PRODUCTION", precision = 1, scale = 0)
	public Integer getNmassProduction() {
		return this.nmassProduction;
	}

	public void setNmassProduction(final Integer nmassProduction) {
		this.nmassProduction = nmassProduction;
	}

	@Column(name = "NFACTOR", precision = 3, scale = 0)
	public Integer getNfactor() {
		return this.nfactor;
	}

	public void setNfactor(final Integer nfactor) {
		this.nfactor = nfactor;
	}

	@Column(name = "NWORKSTATION_KEY", precision = 12, scale = 0)
	public Long getNworkstationKey() {
		return this.nworkstationKey;
	}

	public void setNworkstationKey(final Long nworkstationKey) {
		this.nworkstationKey = nworkstationKey;
	}

	@Column(name = "NAREA_KEY", precision = 12, scale = 0)
	public Long getNareaKey() {
		return this.nareaKey;
	}

	public void setNareaKey(final Long nareaKey) {
		this.nareaKey = nareaKey;
	}

	@Column(name = "NRANGE_KEY", precision = 12, scale = 0)
	public Long getNrangeKey() {
		return this.nrangeKey;
	}

	public void setNrangeKey(final Long nrangeKey) {
		this.nrangeKey = nrangeKey;
	}

	@Column(name = "NRUNRATE", precision = 15, scale = 3)
	public BigDecimal getNrunrate() {
		return this.nrunrate;
	}

	public void setNrunrate(final BigDecimal nrunrate) {
		this.nrunrate = nrunrate;
	}

	@Column(name = "NCCPLOG3", nullable = false, precision = 12, scale = 0, columnDefinition = "NUMBER(12) DEFAULT -1")
	public long getNccplog3() {
		return this.nccplog3;
	}

	public void setNccplog3(final long nccplog3) {
		this.nccplog3 = nccplog3;
	}

	@Column(name = "NCCPLOG4", precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public Integer getNccplog4() {
		return this.nccplog4;
	}

	public void setNccplog4(final Integer nccplog4) {
		this.nccplog4 = nccplog4;
	}

	@Column(name = "NCCPLOG5", precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public Integer getNccplog5() {
		return this.nccplog5;
	}

	public void setNccplog5(final Integer nccplog5) {
		this.nccplog5 = nccplog5;
	}

	@Column(name = "NLABEL_TYPE_KEY_SPML", precision = 12, scale = 0)
	public Long getNlabelTypeKeySpml() {
		return this.nlabelTypeKeySpml;
	}

	public void setNlabelTypeKeySpml(final Long nlabelTypeKeySpml) {
		this.nlabelTypeKeySpml = nlabelTypeKeySpml;
	}

	@Column(name = "NLABEL_PRINT_SPML", precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public Integer getNlabelPrintSpml() {
		return this.nlabelPrintSpml;
	}

	public void setNlabelPrintSpml(final Integer nlabelPrintSpml) {
		this.nlabelPrintSpml = nlabelPrintSpml;
	}

	@Column(name = "NLABEL_TYPE_KEY2", precision = 12, scale = 0)
	public Long getNlabelTypeKey2() {
		return this.nlabelTypeKey2;
	}

	public void setNlabelTypeKey2(final Long nlabelTypeKey2) {
		this.nlabelTypeKey2 = nlabelTypeKey2;
	}

	@Column(name = "NLABEL_PRINT2", precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public Integer getNlabelPrint2() {
		return this.nlabelPrint2;
	}

	public void setNlabelPrint2(final Integer nlabelPrint2) {
		this.nlabelPrint2 = nlabelPrint2;
	}

	@Column(name = "NMAXBATCHSIZE", nullable = false, precision = 15, scale = 3, columnDefinition = "NUMBER(15,3) DEFAULT 0")
	public BigDecimal getNmaxbatchsize() {
		return this.nmaxbatchsize;
	}

	public void setNmaxbatchsize(final BigDecimal nmaxbatchsize) {
		this.nmaxbatchsize = nmaxbatchsize;
	}

	@Column(name = "NWORKSTATION_KEY2", precision = 12, scale = 0)
	public Long getNworkstationKey2() {
		return this.nworkstationKey2;
	}

	public void setNworkstationKey2(final Long nworkstationKey2) {
		this.nworkstationKey2 = nworkstationKey2;
	}

	@Column(name = "NITEMS_PER_UNIT2", precision = 7, scale = 0, columnDefinition = "NUMBER(7) DEFAULT 1")
	public Integer getNitemsPerUnit2() {
		return this.nitemsPerUnit2;
	}

	public void setNitemsPerUnit2(final Integer nitemsPerUnit2) {
		this.nitemsPerUnit2 = nitemsPerUnit2;
	}

	@Column(name = "CUNIT2", length = 40)
	public String getCunit2() {
		return this.cunit2;
	}

	public void setCunit2(final String cunit2) {
		this.cunit2 = cunit2;
	}

	@Column(name = "NSETUPRATE", precision = 15, scale = 3)
	public BigDecimal getNsetuprate() {
		return this.nsetuprate;
	}

	public void setNsetuprate(final BigDecimal nsetuprate) {
		this.nsetuprate = nsetuprate;
	}

}
