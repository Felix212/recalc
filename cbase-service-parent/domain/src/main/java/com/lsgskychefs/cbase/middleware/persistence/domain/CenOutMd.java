package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

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
 * Entity(DomainObject) for table CEN_OUT_MD
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_MD")
public class CenOutMd implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutMdId id;
	private CenOut cenOut;
	private Long lloadrow;
	private String cclass1;
	private String cclass2;
	private String cclass3;
	private String cclass4;
	private String cclass5;
	private String cclass6;
	private String cunit;
	private String cpackinglist;
	private String cstowage;
	private String ctext1;
	private String ctext2;
	private String ctext3;
	private String cerror;
	private String cworkstation;
	private Long nranking;
	private Long nrankingspml;
	private Long nbelly;
	private Long nlabeltypekey;
	private Long nseparate;
	private Integer nmultileg;
	private Long ndistributionmealkey;
	private Long ndistributionaddkey;
	private Long ngalleykey;
	private Long nstowagekey;
	private Long nstowagesort;
	private Long nlimit;
	private Long nlimitspml;
	private Long ndistributiongroup;
	private Integer nclassnumber;
	private Integer nuse;
	private Integer nmcd;
	private Integer nmulticlass;
	private Integer nmixed;
	private Integer naccummulatespml;
	private String cstowagegroup;
	private String ccreatedBy;
	private Date dcreatedDate;
	private Set<CenOutMdCo> cenOutMdCos = new HashSet<>(0);
	private Set<CenOutMdPs> cenOutMdPses = new HashSet<>(0);

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "narrayCount",
					column = @Column(name = "NARRAY_COUNT", nullable = false, precision = 12, scale = 0)) })
	public CenOutMdId getId() {
		return this.id;
	}

	public void setId(final CenOutMdId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false, insertable = false, updatable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@Column(name = "LLOADROW", precision = 12, scale = 0)
	public Long getLloadrow() {
		return this.lloadrow;
	}

	public void setLloadrow(final Long lloadrow) {
		this.lloadrow = lloadrow;
	}

	@Column(name = "CCLASS1", length = 10)
	public String getCclass1() {
		return this.cclass1;
	}

	public void setCclass1(final String cclass1) {
		this.cclass1 = cclass1;
	}

	@Column(name = "CCLASS2", length = 10)
	public String getCclass2() {
		return this.cclass2;
	}

	public void setCclass2(final String cclass2) {
		this.cclass2 = cclass2;
	}

	@Column(name = "CCLASS3", length = 10)
	public String getCclass3() {
		return this.cclass3;
	}

	public void setCclass3(final String cclass3) {
		this.cclass3 = cclass3;
	}

	@Column(name = "CCLASS4", length = 10)
	public String getCclass4() {
		return this.cclass4;
	}

	public void setCclass4(final String cclass4) {
		this.cclass4 = cclass4;
	}

	@Column(name = "CCLASS5", length = 10)
	public String getCclass5() {
		return this.cclass5;
	}

	public void setCclass5(final String cclass5) {
		this.cclass5 = cclass5;
	}

	@Column(name = "CCLASS6", length = 10)
	public String getCclass6() {
		return this.cclass6;
	}

	public void setCclass6(final String cclass6) {
		this.cclass6 = cclass6;
	}

	@Column(name = "CUNIT", length = 5)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CPACKINGLIST", length = 18)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CSTOWAGE", length = 20)
	public String getCstowage() {
		return this.cstowage;
	}

	public void setCstowage(final String cstowage) {
		this.cstowage = cstowage;
	}

	@Column(name = "CTEXT1", length = 100)
	public String getCtext1() {
		return this.ctext1;
	}

	public void setCtext1(final String ctext1) {
		this.ctext1 = ctext1;
	}

	@Column(name = "CTEXT2", length = 100)
	public String getCtext2() {
		return this.ctext2;
	}

	public void setCtext2(final String ctext2) {
		this.ctext2 = ctext2;
	}

	@Column(name = "CTEXT3", length = 100)
	public String getCtext3() {
		return this.ctext3;
	}

	public void setCtext3(final String ctext3) {
		this.ctext3 = ctext3;
	}

	@Column(name = "CERROR", length = 100)
	public String getCerror() {
		return this.cerror;
	}

	public void setCerror(final String cerror) {
		this.cerror = cerror;
	}

	@Column(name = "CWORKSTATION", length = 200)
	public String getCworkstation() {
		return this.cworkstation;
	}

	public void setCworkstation(final String cworkstation) {
		this.cworkstation = cworkstation;
	}

	@Column(name = "NRANKING", precision = 12, scale = 0)
	public Long getNranking() {
		return this.nranking;
	}

	public void setNranking(final Long nranking) {
		this.nranking = nranking;
	}

	@Column(name = "NRANKINGSPML", precision = 12, scale = 0)
	public Long getNrankingspml() {
		return this.nrankingspml;
	}

	public void setNrankingspml(final Long nrankingspml) {
		this.nrankingspml = nrankingspml;
	}

	@Column(name = "NBELLY", precision = 12, scale = 0)
	public Long getNbelly() {
		return this.nbelly;
	}

	public void setNbelly(final Long nbelly) {
		this.nbelly = nbelly;
	}

	@Column(name = "NLABELTYPEKEY", precision = 12, scale = 0)
	public Long getNlabeltypekey() {
		return this.nlabeltypekey;
	}

	public void setNlabeltypekey(final Long nlabeltypekey) {
		this.nlabeltypekey = nlabeltypekey;
	}

	@Column(name = "NSEPARATE", precision = 12, scale = 0)
	public Long getNseparate() {
		return this.nseparate;
	}

	public void setNseparate(final Long nseparate) {
		this.nseparate = nseparate;
	}

	@Column(name = "NMULTILEG", precision = 6, scale = 0)
	public Integer getNmultileg() {
		return this.nmultileg;
	}

	public void setNmultileg(final Integer nmultileg) {
		this.nmultileg = nmultileg;
	}

	@Column(name = "NDISTRIBUTIONMEALKEY", precision = 12, scale = 0)
	public Long getNdistributionmealkey() {
		return this.ndistributionmealkey;
	}

	public void setNdistributionmealkey(final Long ndistributionmealkey) {
		this.ndistributionmealkey = ndistributionmealkey;
	}

	@Column(name = "NDISTRIBUTIONADDKEY", precision = 12, scale = 0)
	public Long getNdistributionaddkey() {
		return this.ndistributionaddkey;
	}

	public void setNdistributionaddkey(final Long ndistributionaddkey) {
		this.ndistributionaddkey = ndistributionaddkey;
	}

	@Column(name = "NGALLEYKEY", precision = 12, scale = 0)
	public Long getNgalleykey() {
		return this.ngalleykey;
	}

	public void setNgalleykey(final Long ngalleykey) {
		this.ngalleykey = ngalleykey;
	}

	@Column(name = "NSTOWAGEKEY", precision = 12, scale = 0)
	public Long getNstowagekey() {
		return this.nstowagekey;
	}

	public void setNstowagekey(final Long nstowagekey) {
		this.nstowagekey = nstowagekey;
	}

	@Column(name = "NSTOWAGESORT", precision = 12, scale = 0)
	public Long getNstowagesort() {
		return this.nstowagesort;
	}

	public void setNstowagesort(final Long nstowagesort) {
		this.nstowagesort = nstowagesort;
	}

	@Column(name = "NLIMIT", precision = 12, scale = 0)
	public Long getNlimit() {
		return this.nlimit;
	}

	public void setNlimit(final Long nlimit) {
		this.nlimit = nlimit;
	}

	@Column(name = "NLIMITSPML", precision = 12, scale = 0)
	public Long getNlimitspml() {
		return this.nlimitspml;
	}

	public void setNlimitspml(final Long nlimitspml) {
		this.nlimitspml = nlimitspml;
	}

	@Column(name = "NDISTRIBUTIONGROUP", precision = 12, scale = 0)
	public Long getNdistributiongroup() {
		return this.ndistributiongroup;
	}

	public void setNdistributiongroup(final Long ndistributiongroup) {
		this.ndistributiongroup = ndistributiongroup;
	}

	@Column(name = "NCLASSNUMBER", precision = 6, scale = 0)
	public Integer getNclassnumber() {
		return this.nclassnumber;
	}

	public void setNclassnumber(final Integer nclassnumber) {
		this.nclassnumber = nclassnumber;
	}

	@Column(name = "NUSE", precision = 6, scale = 0)
	public Integer getNuse() {
		return this.nuse;
	}

	public void setNuse(final Integer nuse) {
		this.nuse = nuse;
	}

	@Column(name = "NMCD", precision = 6, scale = 0)
	public Integer getNmcd() {
		return this.nmcd;
	}

	public void setNmcd(final Integer nmcd) {
		this.nmcd = nmcd;
	}

	@Column(name = "NMULTICLASS", precision = 6, scale = 0)
	public Integer getNmulticlass() {
		return this.nmulticlass;
	}

	public void setNmulticlass(final Integer nmulticlass) {
		this.nmulticlass = nmulticlass;
	}

	@Column(name = "NMIXED", precision = 6, scale = 0)
	public Integer getNmixed() {
		return this.nmixed;
	}

	public void setNmixed(final Integer nmixed) {
		this.nmixed = nmixed;
	}

	@Column(name = "NACCUMMULATESPML", precision = 6, scale = 0)
	public Integer getNaccummulatespml() {
		return this.naccummulatespml;
	}

	public void setNaccummulatespml(final Integer naccummulatespml) {
		this.naccummulatespml = naccummulatespml;
	}

	@Column(name = "CSTOWAGEGROUP", length = 10)
	public String getCstowagegroup() {
		return this.cstowagegroup;
	}

	public void setCstowagegroup(final String cstowagegroup) {
		this.cstowagegroup = cstowagegroup;
	}

	@Column(name = "CCREATED_BY", length = 40)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(final String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_DATE", length = 7)
	public Date getDcreatedDate() {
		return this.dcreatedDate;
	}

	public void setDcreatedDate(final Date dcreatedDate) {
		this.dcreatedDate = dcreatedDate;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutMd")
	public Set<CenOutMdCo> getCenOutMdCos() {
		return this.cenOutMdCos;
	}

	public void setCenOutMdCos(final Set<CenOutMdCo> cenOutMdCos) {
		this.cenOutMdCos = cenOutMdCos;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutMd")
	public Set<CenOutMdPs> getCenOutMdPses() {
		return this.cenOutMdPses;
	}

	public void setCenOutMdPses(final Set<CenOutMdPs> cenOutMdPses) {
		this.cenOutMdPses = cenOutMdPses;
	}

}
