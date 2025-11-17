package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_OUT_SD
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_SD")
public class CenOutSd implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private CenOutSdId id;
	private CenOut cenOut;
	private Date dtimestamp;
	private Long nindexKey;
	private Long ndetailKey;
	private String cheader;
	private String cflight;
	private String cfrom;
	private String cto;
	private Date ddeparture;
	private String ctime;
	private String caircraft;
	private String cregistration;
	private String cworkstation;
	private String cstowage;
	private Integer nbelly;
	private String cclass;
	private String carea;
	private String cloadinglist;
	private String cmultiWs1;
	private String cmultiWs2;
	private Integer ncateringLeg;
	private String cclass1;
	private String cplUnit;
	private String nworkstationKey;
	private Long nclassNumber;
	private String cpackinglist;
	private String ctext;
	private String ccomputeRampbox;
	private Integer nrampBoxMode;
	private String caddOnText;

	public CenOutSd() {
	}

	public CenOutSd(final CenOutSdId id, final CenOut cenOut) {
		this.id = id;
		this.cenOut = cenOut;
	}

	public CenOutSd(final CenOutSdId id, final CenOut cenOut, final Date dtimestamp, final Long nindexKey, final Long ndetailKey,
			final String cheader, final String cflight, final String cfrom, final String cto, final Date ddeparture, final String ctime,
			final String caircraft, final String cregistration, final String cworkstation, final String cstowage, final Integer nbelly,
			final String cclass, final String carea, final String cloadinglist, final String cmultiWs1, final String cmultiWs2,
			final Integer ncateringLeg, final String cclass1, final String cplUnit, final String nworkstationKey, final Long nclassNumber,
			final String cpackinglist, final String ctext, final String ccomputeRampbox, final Integer nrampBoxMode,
			final String caddOnText) {
		this.id = id;
		this.cenOut = cenOut;
		this.dtimestamp = dtimestamp;
		this.nindexKey = nindexKey;
		this.ndetailKey = ndetailKey;
		this.cheader = cheader;
		this.cflight = cflight;
		this.cfrom = cfrom;
		this.cto = cto;
		this.ddeparture = ddeparture;
		this.ctime = ctime;
		this.caircraft = caircraft;
		this.cregistration = cregistration;
		this.cworkstation = cworkstation;
		this.cstowage = cstowage;
		this.nbelly = nbelly;
		this.cclass = cclass;
		this.carea = carea;
		this.cloadinglist = cloadinglist;
		this.cmultiWs1 = cmultiWs1;
		this.cmultiWs2 = cmultiWs2;
		this.ncateringLeg = ncateringLeg;
		this.cclass1 = cclass1;
		this.cplUnit = cplUnit;
		this.nworkstationKey = nworkstationKey;
		this.nclassNumber = nclassNumber;
		this.cpackinglist = cpackinglist;
		this.ctext = ctext;
		this.ccomputeRampbox = ccomputeRampbox;
		this.nrampBoxMode = nrampBoxMode;
		this.caddOnText = caddOnText;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nrowid", column = @Column(name = "NROWID", nullable = false, precision = 12, scale = 0)) })
	public CenOutSdId getId() {
		return this.id;
	}

	public void setId(final CenOutSdId id) {
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

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NINDEX_KEY", precision = 12, scale = 0)
	public Long getNindexKey() {
		return this.nindexKey;
	}

	public void setNindexKey(final Long nindexKey) {
		this.nindexKey = nindexKey;
	}

	@Column(name = "NDETAIL_KEY", precision = 12, scale = 0)
	public Long getNdetailKey() {
		return this.ndetailKey;
	}

	public void setNdetailKey(final Long ndetailKey) {
		this.ndetailKey = ndetailKey;
	}

	@Column(name = "CHEADER", length = 40)
	public String getCheader() {
		return this.cheader;
	}

	public void setCheader(final String cheader) {
		this.cheader = cheader;
	}

	@Column(name = "CFLIGHT", length = 20)
	public String getCflight() {
		return this.cflight;
	}

	public void setCflight(final String cflight) {
		this.cflight = cflight;
	}

	@Column(name = "CFROM", length = 10)
	public String getCfrom() {
		return this.cfrom;
	}

	public void setCfrom(final String cfrom) {
		this.cfrom = cfrom;
	}

	@Column(name = "CTO", length = 10)
	public String getCto() {
		return this.cto;
	}

	public void setCto(final String cto) {
		this.cto = cto;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDEPARTURE", length = 7)
	public Date getDdeparture() {
		return this.ddeparture;
	}

	public void setDdeparture(final Date ddeparture) {
		this.ddeparture = ddeparture;
	}

	@Column(name = "CTIME", length = 5)
	public String getCtime() {
		return this.ctime;
	}

	public void setCtime(final String ctime) {
		this.ctime = ctime;
	}

	@Column(name = "CAIRCRAFT", length = 20)
	public String getCaircraft() {
		return this.caircraft;
	}

	public void setCaircraft(final String caircraft) {
		this.caircraft = caircraft;
	}

	@Column(name = "CREGISTRATION", length = 20)
	public String getCregistration() {
		return this.cregistration;
	}

	public void setCregistration(final String cregistration) {
		this.cregistration = cregistration;
	}

	@Column(name = "CWORKSTATION", length = 80)
	public String getCworkstation() {
		return this.cworkstation;
	}

	public void setCworkstation(final String cworkstation) {
		this.cworkstation = cworkstation;
	}

	@Column(name = "CSTOWAGE", length = 200)
	public String getCstowage() {
		return this.cstowage;
	}

	public void setCstowage(final String cstowage) {
		this.cstowage = cstowage;
	}

	@Column(name = "NBELLY", precision = 1, scale = 0)
	public Integer getNbelly() {
		return this.nbelly;
	}

	public void setNbelly(final Integer nbelly) {
		this.nbelly = nbelly;
	}

	@Column(name = "CCLASS", length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "CAREA", length = 40)
	public String getCarea() {
		return this.carea;
	}

	public void setCarea(final String carea) {
		this.carea = carea;
	}

	@Column(name = "CLOADINGLIST", length = 20)
	public String getCloadinglist() {
		return this.cloadinglist;
	}

	public void setCloadinglist(final String cloadinglist) {
		this.cloadinglist = cloadinglist;
	}

	@Column(name = "CMULTI_WS_1", length = 254)
	public String getCmultiWs1() {
		return this.cmultiWs1;
	}

	public void setCmultiWs1(final String cmultiWs1) {
		this.cmultiWs1 = cmultiWs1;
	}

	@Column(name = "CMULTI_WS_2", length = 254)
	public String getCmultiWs2() {
		return this.cmultiWs2;
	}

	public void setCmultiWs2(final String cmultiWs2) {
		this.cmultiWs2 = cmultiWs2;
	}

	@Column(name = "NCATERING_LEG", precision = 2, scale = 0)
	public Integer getNcateringLeg() {
		return this.ncateringLeg;
	}

	public void setNcateringLeg(final Integer ncateringLeg) {
		this.ncateringLeg = ncateringLeg;
	}

	@Column(name = "CCLASS_1", length = 10)
	public String getCclass1() {
		return this.cclass1;
	}

	public void setCclass1(final String cclass1) {
		this.cclass1 = cclass1;
	}

	@Column(name = "CPL_UNIT", length = 10)
	public String getCplUnit() {
		return this.cplUnit;
	}

	public void setCplUnit(final String cplUnit) {
		this.cplUnit = cplUnit;
	}

	@Column(name = "NWORKSTATION_KEY", length = 10)
	public String getNworkstationKey() {
		return this.nworkstationKey;
	}

	public void setNworkstationKey(final String nworkstationKey) {
		this.nworkstationKey = nworkstationKey;
	}

	@Column(name = "NCLASS_NUMBER", precision = 12, scale = 0)
	public Long getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final Long nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "CPACKINGLIST", length = 36)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CTEXT", length = 80)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CCOMPUTE_RAMPBOX", length = 80)
	public String getCcomputeRampbox() {
		return this.ccomputeRampbox;
	}

	public void setCcomputeRampbox(final String ccomputeRampbox) {
		this.ccomputeRampbox = ccomputeRampbox;
	}

	@Column(name = "NRAMP_BOX_MODE", precision = 1, scale = 0)
	public Integer getNrampBoxMode() {
		return this.nrampBoxMode;
	}

	public void setNrampBoxMode(final Integer nrampBoxMode) {
		this.nrampBoxMode = nrampBoxMode;
	}

	@Column(name = "CADD_ON_TEXT", length = 80)
	public String getCaddOnText() {
		return this.caddOnText;
	}

	public void setCaddOnText(final String caddOnText) {
		this.caddOnText = caddOnText;
	}

}
