package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 30.05.2016 15:08:06 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.ParameterMode;
import javax.persistence.StoredProcedureParameter;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PfIf203;

/**
 * Entity(DomainObject) for table GTT_SAP_IF203
 *
 * @author Hibernate Tools
 */
@NamedStoredProcedureQuery(name = PfIf203.PF_IF203_NAME, procedureName = "CBASE_SAP." + PfIf203.PF_IF203_NAME,
		parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfIf203.P_CPARM_RESULT_KEY, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfIf203.P_DDEPARTURE_FROM, type = Date.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfIf203.P_DDEPARTURE_TO, type = Date.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfIf203.P_CPARM_AREA_KEY, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfIf203.P_NWS_FROM, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfIf203.P_NWS_TO, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfIf203.P_CPARM_MATERIAL_INDEX_KEY, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfIf203.P_NALL, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfIf203.P_CPARM_RECKONING, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfIf203.P_CPARM_PL_KIND_KEY, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfIf203.P_CPARM_PLTYPE_KEY, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfIf203.P_CSAPUNIT, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfIf203.P_CSAP_SERIAL, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfIf203.P_CPARM_NSAP_KIND_KEY, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PfIf203.P_CCLIENT, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PfIf203.P_MSG, type = String.class)
		})
@Entity
@Table(name = "GTT_SAP_IF203")
public class GttSapIf203 implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nsapIf203Key;
	private Character csumFlag;
	private String csapSerial;
	private String csapUnit;
	private String cmrp;
	private String carea;
	private String cworkstation;
	private String citem;
	private String citemText;
	private String cunit;
	private Long nitemIndexKey;
	private Long nitemDetailKey;
	private BigDecimal nquantity;
	private String cairline;
	private String cpackinglist;
	private String cpackinglistText;
	private Long nplIndexKey;
	private Long nplDetailKey;
	private Date ddeparture;
	private Date dtimestamp;

	@Id
	@Column(name = "NSAP_IF203_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsapIf203Key() {
		return this.nsapIf203Key;
	}

	public void setNsapIf203Key(final long nsapIf203Key) {
		this.nsapIf203Key = nsapIf203Key;
	}

	@Column(name = "CSUM_FLAG", length = 1)
	public Character getCsumFlag() {
		return this.csumFlag;
	}

	public void setCsumFlag(final Character csumFlag) {
		this.csumFlag = csumFlag;
	}

	@Column(name = "CSAP_SERIAL", length = 30)
	public String getCsapSerial() {
		return this.csapSerial;
	}

	public void setCsapSerial(final String csapSerial) {
		this.csapSerial = csapSerial;
	}

	@Column(name = "CSAP_UNIT", length = 4)
	public String getCsapUnit() {
		return this.csapUnit;
	}

	public void setCsapUnit(final String csapUnit) {
		this.csapUnit = csapUnit;
	}

	@Column(name = "CMRP", length = 500)
	public String getCmrp() {
		return this.cmrp;
	}

	public void setCmrp(final String cmrp) {
		this.cmrp = cmrp;
	}

	@Column(name = "CAREA", length = 40)
	public String getCarea() {
		return this.carea;
	}

	public void setCarea(final String carea) {
		this.carea = carea;
	}

	@Column(name = "CWORKSTATION", length = 40)
	public String getCworkstation() {
		return this.cworkstation;
	}

	public void setCworkstation(final String cworkstation) {
		this.cworkstation = cworkstation;
	}

	@Column(name = "CITEM", length = 18)
	public String getCitem() {
		return this.citem;
	}

	public void setCitem(final String citem) {
		this.citem = citem;
	}

	@Column(name = "CITEM_TEXT", length = 80)
	public String getCitemText() {
		return this.citemText;
	}

	public void setCitemText(final String citemText) {
		this.citemText = citemText;
	}

	@Column(name = "CUNIT", length = 5)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NITEM_INDEX_KEY", precision = 12, scale = 0)
	public Long getNitemIndexKey() {
		return this.nitemIndexKey;
	}

	public void setNitemIndexKey(final Long nitemIndexKey) {
		this.nitemIndexKey = nitemIndexKey;
	}

	@Column(name = "NITEM_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNitemDetailKey() {
		return this.nitemDetailKey;
	}

	public void setNitemDetailKey(final Long nitemDetailKey) {
		this.nitemDetailKey = nitemDetailKey;
	}

	@Column(name = "NQUANTITY", precision = 15, scale = 6)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "CAIRLINE", length = 5)
	public String getCairline() {
		return this.cairline;
	}

	public void setCairline(final String cairline) {
		this.cairline = cairline;
	}

	@Column(name = "CPACKINGLIST", length = 18)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CPACKINGLIST_TEXT", length = 80)
	public String getCpackinglistText() {
		return this.cpackinglistText;
	}

	public void setCpackinglistText(final String cpackinglistText) {
		this.cpackinglistText = cpackinglistText;
	}

	@Column(name = "NPL_INDEX_KEY", precision = 12, scale = 0)
	public Long getNplIndexKey() {
		return this.nplIndexKey;
	}

	public void setNplIndexKey(final Long nplIndexKey) {
		this.nplIndexKey = nplIndexKey;
	}

	@Column(name = "NPL_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNplDetailKey() {
		return this.nplDetailKey;
	}

	public void setNplDetailKey(final Long nplDetailKey) {
		this.nplDetailKey = nplDetailKey;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDEPARTURE", length = 7)
	public Date getDdeparture() {
		return this.ddeparture;
	}

	public void setDdeparture(final Date ddeparture) {
		this.ddeparture = ddeparture;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}
