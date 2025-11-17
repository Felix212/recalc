package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_SD_MESSAGE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_SD_MESSAGE")
public class CenOutSdMessage implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long nsdMsgKey;
	private CenOut cenOut;
	private Long ntransaction;
	private Long nrowid;
	private Integer npage;
	private Integer nmsgtype;
	private Long nsdCartKey;
	private Integer nrow;
	private Integer ncolumn;
	private String cmessage;
	private String cgalley;
	private String cstowage;
	private String ccart;
	private String cloadinglist;
	private String ccomponent;
	private String ctext;
	private Integer ndistribution;
	private String cparameter;
	private String cpackinglist;
	private Integer ncounter;
	private Integer ntype;
	private Integer nitems;
	private String cunit;
	private String cbacklog;
	private String cobject;

	public CenOutSdMessage() {
	}

	public CenOutSdMessage(final long nsdMsgKey) {
		this.nsdMsgKey = nsdMsgKey;
	}

	public CenOutSdMessage(final long nsdMsgKey, final CenOut cenOut, final Long ntransaction, final Long nrowid, final Integer npage,
			final Integer nmsgtype, final Long nsdCartKey, final Integer nrow, final Integer ncolumn, final String cmessage,
			final String cgalley, final String cstowage, final String ccart, final String cloadinglist, final String ccomponent,
			final String ctext, final Integer ndistribution, final String cparameter, final String cpackinglist, final Integer ncounter,
			final Integer ntype, final Integer nitems, final String cunit, final String cbacklog, final String cobject) {
		this.nsdMsgKey = nsdMsgKey;
		this.cenOut = cenOut;
		this.ntransaction = ntransaction;
		this.nrowid = nrowid;
		this.npage = npage;
		this.nmsgtype = nmsgtype;
		this.nsdCartKey = nsdCartKey;
		this.nrow = nrow;
		this.ncolumn = ncolumn;
		this.cmessage = cmessage;
		this.cgalley = cgalley;
		this.cstowage = cstowage;
		this.ccart = ccart;
		this.cloadinglist = cloadinglist;
		this.ccomponent = ccomponent;
		this.ctext = ctext;
		this.ndistribution = ndistribution;
		this.cparameter = cparameter;
		this.cpackinglist = cpackinglist;
		this.ncounter = ncounter;
		this.ntype = ntype;
		this.nitems = nitems;
		this.cunit = cunit;
		this.cbacklog = cbacklog;
		this.cobject = cobject;
	}

	@Id

	@Column(name = "NSD_MSG_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsdMsgKey() {
		return this.nsdMsgKey;
	}

	public void setNsdMsgKey(final long nsdMsgKey) {
		this.nsdMsgKey = nsdMsgKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY")
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@Column(name = "NTRANSACTION", precision = 12, scale = 0)
	public Long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final Long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Column(name = "NROWID", precision = 12, scale = 0)
	public Long getNrowid() {
		return this.nrowid;
	}

	public void setNrowid(final Long nrowid) {
		this.nrowid = nrowid;
	}

	@Column(name = "NPAGE", precision = 6, scale = 0)
	public Integer getNpage() {
		return this.npage;
	}

	public void setNpage(final Integer npage) {
		this.npage = npage;
	}

	@Column(name = "NMSGTYPE", precision = 6, scale = 0)
	public Integer getNmsgtype() {
		return this.nmsgtype;
	}

	public void setNmsgtype(final Integer nmsgtype) {
		this.nmsgtype = nmsgtype;
	}

	@Column(name = "NSD_CART_KEY", precision = 12, scale = 0)
	public Long getNsdCartKey() {
		return this.nsdCartKey;
	}

	public void setNsdCartKey(final Long nsdCartKey) {
		this.nsdCartKey = nsdCartKey;
	}

	@Column(name = "NROW", precision = 6, scale = 0)
	public Integer getNrow() {
		return this.nrow;
	}

	public void setNrow(final Integer nrow) {
		this.nrow = nrow;
	}

	@Column(name = "NCOLUMN", precision = 6, scale = 0)
	public Integer getNcolumn() {
		return this.ncolumn;
	}

	public void setNcolumn(final Integer ncolumn) {
		this.ncolumn = ncolumn;
	}

	@Column(name = "CMESSAGE", length = 254)
	public String getCmessage() {
		return this.cmessage;
	}

	public void setCmessage(final String cmessage) {
		this.cmessage = cmessage;
	}

	@Column(name = "CGALLEY", length = 10)
	public String getCgalley() {
		return this.cgalley;
	}

	public void setCgalley(final String cgalley) {
		this.cgalley = cgalley;
	}

	@Column(name = "CSTOWAGE", length = 20)
	public String getCstowage() {
		return this.cstowage;
	}

	public void setCstowage(final String cstowage) {
		this.cstowage = cstowage;
	}

	@Column(name = "CCART", length = 20)
	public String getCcart() {
		return this.ccart;
	}

	public void setCcart(final String ccart) {
		this.ccart = ccart;
	}

	@Column(name = "CLOADINGLIST", length = 20)
	public String getCloadinglist() {
		return this.cloadinglist;
	}

	public void setCloadinglist(final String cloadinglist) {
		this.cloadinglist = cloadinglist;
	}

	@Column(name = "CCOMPONENT", length = 254)
	public String getCcomponent() {
		return this.ccomponent;
	}

	public void setCcomponent(final String ccomponent) {
		this.ccomponent = ccomponent;
	}

	@Column(name = "CTEXT", length = 254)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NDISTRIBUTION", precision = 1, scale = 0)
	public Integer getNdistribution() {
		return this.ndistribution;
	}

	public void setNdistribution(final Integer ndistribution) {
		this.ndistribution = ndistribution;
	}

	@Column(name = "CPARAMETER", length = 254)
	public String getCparameter() {
		return this.cparameter;
	}

	public void setCparameter(final String cparameter) {
		this.cparameter = cparameter;
	}

	@Column(name = "CPACKINGLIST", length = 100)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "NCOUNTER", precision = 6, scale = 0)
	public Integer getNcounter() {
		return this.ncounter;
	}

	public void setNcounter(final Integer ncounter) {
		this.ncounter = ncounter;
	}

	@Column(name = "NTYPE", precision = 6, scale = 0)
	public Integer getNtype() {
		return this.ntype;
	}

	public void setNtype(final Integer ntype) {
		this.ntype = ntype;
	}

	@Column(name = "NITEMS", precision = 6, scale = 0)
	public Integer getNitems() {
		return this.nitems;
	}

	public void setNitems(final Integer nitems) {
		this.nitems = nitems;
	}

	@Column(name = "CUNIT", length = 10)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CBACKLOG", length = 100)
	public String getCbacklog() {
		return this.cbacklog;
	}

	public void setCbacklog(final String cbacklog) {
		this.cbacklog = cbacklog;
	}

	@Column(name = "COBJECT")
	public String getCobject() {
		return this.cobject;
	}

	public void setCobject(final String cobject) {
		this.cobject = cobject;
	}

}
