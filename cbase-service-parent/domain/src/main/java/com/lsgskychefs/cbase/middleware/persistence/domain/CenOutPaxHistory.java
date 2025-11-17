package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 09.03.2020 14:54:27 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_OUT_PAX_HISTORY
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PAX_HISTORY"
)
public class CenOutPaxHistory implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutPaxHistoryId id;
	private CenOutHistory cenOutHistory;
	private String cclass;
	private String cclassName;
	private int nbookingClass;
	private int nversion;
	private int npax;
	private int npaxOld;
	private int npaxSpml;
	private int npaxSpmlOld;
	private Date dtimestamp;
	private int nstatus;
	private String cdescription;
	private String cremark;
	private Integer nmanualReserve;
	private Integer npaxAirline;
	private Integer nstationentry;
	private Integer npaxForecast;
	private Integer npaxSystemFinal;
	private Integer npaxSpmlForecast;
	private String cqueryPeriod;
	private Integer nfinalVersion;
	private Integer nbosta1;
	private Integer nbosta2;
	private Integer nbosta3;
	private Integer nbosta4;
	private Integer nbosta5;
	private Date dtimestamp1;
	private Date dtimestamp2;
	private Date dtimestamp3;
	private Date dtimestamp4;
	private Date dtimestamp5;
	private String cuser1;
	private String cuser2;
	private String cuser3;
	private String cuser4;
	private String cuser5;
	private Long ntransaction1;
	private Long ntransaction2;
	private Long ntransaction3;
	private Long ntransaction4;
	private Long ntransaction5;
	private String ccomment;
	private Integer noverrideConfig;
	private String csource;
	private Date dpaxAirline;
	private Date dpaxSystemFinal;

	public CenOutPaxHistory() {
	}

	public CenOutPaxHistory(CenOutPaxHistoryId id, CenOutHistory cenOutHistory, String cclass, String cclassName, int nbookingClass,
			int nversion, int npax, int npaxOld, int npaxSpml, int npaxSpmlOld, Date dtimestamp, int nstatus) {
		this.id = id;
		this.cenOutHistory = cenOutHistory;
		this.cclass = cclass;
		this.cclassName = cclassName;
		this.nbookingClass = nbookingClass;
		this.nversion = nversion;
		this.npax = npax;
		this.npaxOld = npaxOld;
		this.npaxSpml = npaxSpml;
		this.npaxSpmlOld = npaxSpmlOld;
		this.dtimestamp = dtimestamp;
		this.nstatus = nstatus;
	}

	public CenOutPaxHistory(CenOutPaxHistoryId id, CenOutHistory cenOutHistory, String cclass, String cclassName, int nbookingClass,
			int nversion, int npax, int npaxOld, int npaxSpml, int npaxSpmlOld, Date dtimestamp, int nstatus, String cdescription,
			String cremark, Integer nmanualReserve, Integer npaxAirline, Integer nstationentry, Integer npaxForecast,
			Integer npaxSystemFinal, Integer npaxSpmlForecast, String cqueryPeriod, Integer nfinalVersion, Integer nbosta1, Integer nbosta2,
			Integer nbosta3, Integer nbosta4, Integer nbosta5, Date dtimestamp1, Date dtimestamp2, Date dtimestamp3, Date dtimestamp4,
			Date dtimestamp5, String cuser1, String cuser2, String cuser3, String cuser4, String cuser5, Long ntransaction1,
			Long ntransaction2, Long ntransaction3, Long ntransaction4, Long ntransaction5, String ccomment, Integer noverrideConfig,
			String csource) {
		this.id = id;
		this.cenOutHistory = cenOutHistory;
		this.cclass = cclass;
		this.cclassName = cclassName;
		this.nbookingClass = nbookingClass;
		this.nversion = nversion;
		this.npax = npax;
		this.npaxOld = npaxOld;
		this.npaxSpml = npaxSpml;
		this.npaxSpmlOld = npaxSpmlOld;
		this.dtimestamp = dtimestamp;
		this.nstatus = nstatus;
		this.cdescription = cdescription;
		this.cremark = cremark;
		this.nmanualReserve = nmanualReserve;
		this.npaxAirline = npaxAirline;
		this.nstationentry = nstationentry;
		this.npaxForecast = npaxForecast;
		this.npaxSystemFinal = npaxSystemFinal;
		this.npaxSpmlForecast = npaxSpmlForecast;
		this.cqueryPeriod = cqueryPeriod;
		this.nfinalVersion = nfinalVersion;
		this.nbosta1 = nbosta1;
		this.nbosta2 = nbosta2;
		this.nbosta3 = nbosta3;
		this.nbosta4 = nbosta4;
		this.nbosta5 = nbosta5;
		this.dtimestamp1 = dtimestamp1;
		this.dtimestamp2 = dtimestamp2;
		this.dtimestamp3 = dtimestamp3;
		this.dtimestamp4 = dtimestamp4;
		this.dtimestamp5 = dtimestamp5;
		this.cuser1 = cuser1;
		this.cuser2 = cuser2;
		this.cuser3 = cuser3;
		this.cuser4 = cuser4;
		this.cuser5 = cuser5;
		this.ntransaction1 = ntransaction1;
		this.ntransaction2 = ntransaction2;
		this.ntransaction3 = ntransaction3;
		this.ntransaction4 = ntransaction4;
		this.ntransaction5 = ntransaction5;
		this.ccomment = ccomment;
		this.noverrideConfig = noverrideConfig;
		this.csource = csource;
	}

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nclassNumber", column = @Column(name = "NCLASS_NUMBER", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)) })
	public CenOutPaxHistoryId getId() {
		return this.id;
	}

	public void setId(CenOutPaxHistoryId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NRESULT_KEY", referencedColumnName = "NRESULT_KEY", nullable = false, insertable = false, updatable = false),
			@JoinColumn(name = "NTRANSACTION", referencedColumnName = "NTRANSACTION", nullable = false, insertable = false, updatable = false) })
	public CenOutHistory getCenOutHistory() {
		return this.cenOutHistory;
	}

	public void setCenOutHistory(CenOutHistory cenOutHistory) {
		this.cenOutHistory = cenOutHistory;
	}

	@Column(name = "CCLASS", nullable = false, length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "CCLASS_NAME", nullable = false, length = 30)
	public String getCclassName() {
		return this.cclassName;
	}

	public void setCclassName(String cclassName) {
		this.cclassName = cclassName;
	}

	@Column(name = "NBOOKING_CLASS", nullable = false, precision = 1, scale = 0)
	public int getNbookingClass() {
		return this.nbookingClass;
	}

	public void setNbookingClass(int nbookingClass) {
		this.nbookingClass = nbookingClass;
	}

	@Column(name = "NVERSION", nullable = false, precision = 4, scale = 0)
	public int getNversion() {
		return this.nversion;
	}

	public void setNversion(int nversion) {
		this.nversion = nversion;
	}

	@Column(name = "NPAX", nullable = false, precision = 4, scale = 0)
	public int getNpax() {
		return this.npax;
	}

	public void setNpax(int npax) {
		this.npax = npax;
	}

	@Column(name = "NPAX_OLD", nullable = false, precision = 4, scale = 0)
	public int getNpaxOld() {
		return this.npaxOld;
	}

	public void setNpaxOld(int npaxOld) {
		this.npaxOld = npaxOld;
	}

	@Column(name = "NPAX_SPML", nullable = false, precision = 4, scale = 0)
	public int getNpaxSpml() {
		return this.npaxSpml;
	}

	public void setNpaxSpml(int npaxSpml) {
		this.npaxSpml = npaxSpml;
	}

	@Column(name = "NPAX_SPML_OLD", nullable = false, precision = 4, scale = 0)
	public int getNpaxSpmlOld() {
		return this.npaxSpmlOld;
	}

	public void setNpaxSpmlOld(int npaxSpmlOld) {
		this.npaxSpmlOld = npaxSpmlOld;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NSTATUS", nullable = false, precision = 2, scale = 0)
	public int getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(int nstatus) {
		this.nstatus = nstatus;
	}

	@Column(name = "CDESCRIPTION", length = 30)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CREMARK", length = 40)
	public String getCremark() {
		return this.cremark;
	}

	public void setCremark(String cremark) {
		this.cremark = cremark;
	}

	@Column(name = "NMANUAL_RESERVE", precision = 3, scale = 0)
	public Integer getNmanualReserve() {
		return this.nmanualReserve;
	}

	public void setNmanualReserve(Integer nmanualReserve) {
		this.nmanualReserve = nmanualReserve;
	}

	@Column(name = "NPAX_AIRLINE", precision = 4, scale = 0)
	public Integer getNpaxAirline() {
		return this.npaxAirline;
	}

	public void setNpaxAirline(Integer npaxAirline) {
		this.npaxAirline = npaxAirline;
	}

	@Column(name = "NSTATIONENTRY", precision = 1, scale = 0)
	public Integer getNstationentry() {
		return this.nstationentry;
	}

	public void setNstationentry(Integer nstationentry) {
		this.nstationentry = nstationentry;
	}

	@Column(name = "NPAX_FORECAST", precision = 4, scale = 0)
	public Integer getNpaxForecast() {
		return this.npaxForecast;
	}

	public void setNpaxForecast(Integer npaxForecast) {
		this.npaxForecast = npaxForecast;
	}

	@Column(name = "NPAX_SYSTEM_FINAL", precision = 4, scale = 0)
	public Integer getNpaxSystemFinal() {
		return this.npaxSystemFinal;
	}

	public void setNpaxSystemFinal(Integer npaxSystemFinal) {
		this.npaxSystemFinal = npaxSystemFinal;
	}

	@Column(name = "NPAX_SPML_FORECAST", precision = 4, scale = 0)
	public Integer getNpaxSpmlForecast() {
		return this.npaxSpmlForecast;
	}

	public void setNpaxSpmlForecast(Integer npaxSpmlForecast) {
		this.npaxSpmlForecast = npaxSpmlForecast;
	}

	@Column(name = "CQUERY_PERIOD", length = 10)
	public String getCqueryPeriod() {
		return this.cqueryPeriod;
	}

	public void setCqueryPeriod(String cqueryPeriod) {
		this.cqueryPeriod = cqueryPeriod;
	}

	@Column(name = "NFINAL_VERSION", precision = 3, scale = 0)
	public Integer getNfinalVersion() {
		return this.nfinalVersion;
	}

	public void setNfinalVersion(Integer nfinalVersion) {
		this.nfinalVersion = nfinalVersion;
	}

	@Column(name = "NBOSTA1", precision = 4, scale = 0)
	public Integer getNbosta1() {
		return this.nbosta1;
	}

	public void setNbosta1(Integer nbosta1) {
		this.nbosta1 = nbosta1;
	}

	@Column(name = "NBOSTA2", precision = 4, scale = 0)
	public Integer getNbosta2() {
		return this.nbosta2;
	}

	public void setNbosta2(Integer nbosta2) {
		this.nbosta2 = nbosta2;
	}

	@Column(name = "NBOSTA3", precision = 4, scale = 0)
	public Integer getNbosta3() {
		return this.nbosta3;
	}

	public void setNbosta3(Integer nbosta3) {
		this.nbosta3 = nbosta3;
	}

	@Column(name = "NBOSTA4", precision = 4, scale = 0)
	public Integer getNbosta4() {
		return this.nbosta4;
	}

	public void setNbosta4(Integer nbosta4) {
		this.nbosta4 = nbosta4;
	}

	@Column(name = "NBOSTA5", precision = 4, scale = 0)
	public Integer getNbosta5() {
		return this.nbosta5;
	}

	public void setNbosta5(Integer nbosta5) {
		this.nbosta5 = nbosta5;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP1", length = 7)
	public Date getDtimestamp1() {
		return this.dtimestamp1;
	}

	public void setDtimestamp1(Date dtimestamp1) {
		this.dtimestamp1 = dtimestamp1;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP2", length = 7)
	public Date getDtimestamp2() {
		return this.dtimestamp2;
	}

	public void setDtimestamp2(Date dtimestamp2) {
		this.dtimestamp2 = dtimestamp2;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP3", length = 7)
	public Date getDtimestamp3() {
		return this.dtimestamp3;
	}

	public void setDtimestamp3(Date dtimestamp3) {
		this.dtimestamp3 = dtimestamp3;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP4", length = 7)
	public Date getDtimestamp4() {
		return this.dtimestamp4;
	}

	public void setDtimestamp4(Date dtimestamp4) {
		this.dtimestamp4 = dtimestamp4;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP5", length = 7)
	public Date getDtimestamp5() {
		return this.dtimestamp5;
	}

	public void setDtimestamp5(Date dtimestamp5) {
		this.dtimestamp5 = dtimestamp5;
	}

	@Column(name = "CUSER1", length = 40)
	public String getCuser1() {
		return this.cuser1;
	}

	public void setCuser1(String cuser1) {
		this.cuser1 = cuser1;
	}

	@Column(name = "CUSER2", length = 40)
	public String getCuser2() {
		return this.cuser2;
	}

	public void setCuser2(String cuser2) {
		this.cuser2 = cuser2;
	}

	@Column(name = "CUSER3", length = 40)
	public String getCuser3() {
		return this.cuser3;
	}

	public void setCuser3(String cuser3) {
		this.cuser3 = cuser3;
	}

	@Column(name = "CUSER4", length = 40)
	public String getCuser4() {
		return this.cuser4;
	}

	public void setCuser4(String cuser4) {
		this.cuser4 = cuser4;
	}

	@Column(name = "CUSER5", length = 40)
	public String getCuser5() {
		return this.cuser5;
	}

	public void setCuser5(String cuser5) {
		this.cuser5 = cuser5;
	}

	@Column(name = "NTRANSACTION1", precision = 12, scale = 0)
	public Long getNtransaction1() {
		return this.ntransaction1;
	}

	public void setNtransaction1(Long ntransaction1) {
		this.ntransaction1 = ntransaction1;
	}

	@Column(name = "NTRANSACTION2", precision = 12, scale = 0)
	public Long getNtransaction2() {
		return this.ntransaction2;
	}

	public void setNtransaction2(Long ntransaction2) {
		this.ntransaction2 = ntransaction2;
	}

	@Column(name = "NTRANSACTION3", precision = 12, scale = 0)
	public Long getNtransaction3() {
		return this.ntransaction3;
	}

	public void setNtransaction3(Long ntransaction3) {
		this.ntransaction3 = ntransaction3;
	}

	@Column(name = "NTRANSACTION4", precision = 12, scale = 0)
	public Long getNtransaction4() {
		return this.ntransaction4;
	}

	public void setNtransaction4(Long ntransaction4) {
		this.ntransaction4 = ntransaction4;
	}

	@Column(name = "NTRANSACTION5", precision = 12, scale = 0)
	public Long getNtransaction5() {
		return this.ntransaction5;
	}

	public void setNtransaction5(Long ntransaction5) {
		this.ntransaction5 = ntransaction5;
	}

	@Column(name = "CCOMMENT", length = 40)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(String ccomment) {
		this.ccomment = ccomment;
	}

	@Column(name = "NOVERRIDE_CONFIG", precision = 1, scale = 0)
	public Integer getNoverrideConfig() {
		return this.noverrideConfig;
	}

	public void setNoverrideConfig(Integer noverrideConfig) {
		this.noverrideConfig = noverrideConfig;
	}

	@Column(name = "CSOURCE", length = 10)
	public String getCsource() {
		return this.csource;
	}

	public void setCsource(String csource) {
		this.csource = csource;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPAX_AIRLINE", length = 7)
	public Date getDpaxAirline() {
		return this.dpaxAirline;
	}

	public void setDpaxAirline(Date dpaxAirline) {
		this.dpaxAirline = dpaxAirline;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPAX_SYSTEM_FINAL", length = 7)
	public Date getDpaxSystemFinal() {
		return this.dpaxSystemFinal;
	}

	public void setDpaxSystemFinal(Date dpaxSystemFinal) {
		this.dpaxSystemFinal = dpaxSystemFinal;
	}

}


