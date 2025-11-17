package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 23, 2019 2:41:41 PM by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_CR_BROWSER_ADD_OBJ
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_CR_BROWSER_ADD_OBJ")
public class CenCrBrowserAddObj implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** naddObjectKey */
	private long naddObjectKey;

	/** nreportKey */
	private Long nreportKey;

	/** nobjectType */
	private int nobjectType;

	/** cobjectName */
	private String cobjectName;

	/** nheight */
	private int nheight;

	/** nwidth */
	private int nwidth;

	/** nxpos */
	private int nxpos;

	/** nypos */
	private int nypos;

	/** nborderstyle */
	private Integer nborderstyle;

	/** ntextalign */
	private Integer ntextalign;

	/** cfontname */
	private String cfontname;

	/** nfontitalic */
	private Integer nfontitalic;

	/** nfontunderline */
	private Integer nfontunderline;

	/** nfontcolor */
	private Long nfontcolor;

	/** nfontweight */
	private Integer nfontweight;

	/** nfontsize */
	private Integer nfontsize;

	/** cvalue */
	private String cvalue;

	/** nbackgroundmode */
	private Integer nbackgroundmode;

	/** nbackgroundcolor */
	private Long nbackgroundcolor;

	/** nbrushcolor */
	private Long nbrushcolor;

	/** npencolor */
	private Long npencolor;

	/** npenwidth */
	private Integer npenwidth;

	/** nbrushhatch */
	private Integer nbrushhatch;

	/** nresizeable */
	private Integer nresizeable;

	/** nmoveable */
	private Integer nmoveable;

	/** bbitmap */
	private byte[] bbitmap;

	/** nlayer */
	private Integer nlayer;

	@Id
	@Column(name = "NADD_OBJECT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNaddObjectKey() {
		return this.naddObjectKey;
	}

	public void setNaddObjectKey(final long naddObjectKey) {
		this.naddObjectKey = naddObjectKey;
	}

	@Column(name = "NREPORT_KEY", precision = 12, scale = 0)
	public Long getNreportKey() {
		return this.nreportKey;
	}

	public void setNreportKey(final Long nreportKey) {
		this.nreportKey = nreportKey;
	}

	@Column(name = "NOBJECT_TYPE", nullable = false, precision = 3, scale = 0)
	public int getNobjectType() {
		return this.nobjectType;
	}

	public void setNobjectType(final int nobjectType) {
		this.nobjectType = nobjectType;
	}

	@Column(name = "COBJECT_NAME", nullable = false, length = 20)
	public String getCobjectName() {
		return this.cobjectName;
	}

	public void setCobjectName(final String cobjectName) {
		this.cobjectName = cobjectName;
	}

	@Column(name = "NHEIGHT", nullable = false, precision = 6, scale = 0)
	public int getNheight() {
		return this.nheight;
	}

	public void setNheight(final int nheight) {
		this.nheight = nheight;
	}

	@Column(name = "NWIDTH", nullable = false, precision = 6, scale = 0)
	public int getNwidth() {
		return this.nwidth;
	}

	public void setNwidth(final int nwidth) {
		this.nwidth = nwidth;
	}

	@Column(name = "NXPOS", nullable = false, precision = 6, scale = 0)
	public int getNxpos() {
		return this.nxpos;
	}

	public void setNxpos(final int nxpos) {
		this.nxpos = nxpos;
	}

	@Column(name = "NYPOS", nullable = false, precision = 6, scale = 0)
	public int getNypos() {
		return this.nypos;
	}

	public void setNypos(final int nypos) {
		this.nypos = nypos;
	}

	@Column(name = "NBORDERSTYLE", precision = 2, scale = 0)
	public Integer getNborderstyle() {
		return this.nborderstyle;
	}

	public void setNborderstyle(final Integer nborderstyle) {
		this.nborderstyle = nborderstyle;
	}

	@Column(name = "NTEXTALIGN", precision = 2, scale = 0)
	public Integer getNtextalign() {
		return this.ntextalign;
	}

	public void setNtextalign(final Integer ntextalign) {
		this.ntextalign = ntextalign;
	}

	@Column(name = "CFONTNAME", length = 20)
	public String getCfontname() {
		return this.cfontname;
	}

	public void setCfontname(final String cfontname) {
		this.cfontname = cfontname;
	}

	@Column(name = "NFONTITALIC", precision = 2, scale = 0)
	public Integer getNfontitalic() {
		return this.nfontitalic;
	}

	public void setNfontitalic(final Integer nfontitalic) {
		this.nfontitalic = nfontitalic;
	}

	@Column(name = "NFONTUNDERLINE", precision = 2, scale = 0)
	public Integer getNfontunderline() {
		return this.nfontunderline;
	}

	public void setNfontunderline(final Integer nfontunderline) {
		this.nfontunderline = nfontunderline;
	}

	@Column(name = "NFONTCOLOR", precision = 12, scale = 0)
	public Long getNfontcolor() {
		return this.nfontcolor;
	}

	public void setNfontcolor(final Long nfontcolor) {
		this.nfontcolor = nfontcolor;
	}

	@Column(name = "NFONTWEIGHT", precision = 3, scale = 0)
	public Integer getNfontweight() {
		return this.nfontweight;
	}

	public void setNfontweight(final Integer nfontweight) {
		this.nfontweight = nfontweight;
	}

	@Column(name = "NFONTSIZE", precision = 3, scale = 0)
	public Integer getNfontsize() {
		return this.nfontsize;
	}

	public void setNfontsize(final Integer nfontsize) {
		this.nfontsize = nfontsize;
	}

	@Column(name = "CVALUE", length = 2000)
	public String getCvalue() {
		return this.cvalue;
	}

	public void setCvalue(final String cvalue) {
		this.cvalue = cvalue;
	}

	@Column(name = "NBACKGROUNDMODE", precision = 2, scale = 0)
	public Integer getNbackgroundmode() {
		return this.nbackgroundmode;
	}

	public void setNbackgroundmode(final Integer nbackgroundmode) {
		this.nbackgroundmode = nbackgroundmode;
	}

	@Column(name = "NBACKGROUNDCOLOR", precision = 12, scale = 0)
	public Long getNbackgroundcolor() {
		return this.nbackgroundcolor;
	}

	public void setNbackgroundcolor(final Long nbackgroundcolor) {
		this.nbackgroundcolor = nbackgroundcolor;
	}

	@Column(name = "NBRUSHCOLOR", precision = 12, scale = 0)
	public Long getNbrushcolor() {
		return this.nbrushcolor;
	}

	public void setNbrushcolor(final Long nbrushcolor) {
		this.nbrushcolor = nbrushcolor;
	}

	@Column(name = "NPENCOLOR", precision = 12, scale = 0)
	public Long getNpencolor() {
		return this.npencolor;
	}

	public void setNpencolor(final Long npencolor) {
		this.npencolor = npencolor;
	}

	@Column(name = "NPENWIDTH", precision = 3, scale = 0)
	public Integer getNpenwidth() {
		return this.npenwidth;
	}

	public void setNpenwidth(final Integer npenwidth) {
		this.npenwidth = npenwidth;
	}

	@Column(name = "NBRUSHHATCH", precision = 3, scale = 0)
	public Integer getNbrushhatch() {
		return this.nbrushhatch;
	}

	public void setNbrushhatch(final Integer nbrushhatch) {
		this.nbrushhatch = nbrushhatch;
	}

	@Column(name = "NRESIZEABLE", precision = 1, scale = 0)
	public Integer getNresizeable() {
		return this.nresizeable;
	}

	public void setNresizeable(final Integer nresizeable) {
		this.nresizeable = nresizeable;
	}

	@Column(name = "NMOVEABLE", precision = 1, scale = 0)
	public Integer getNmoveable() {
		return this.nmoveable;
	}

	public void setNmoveable(final Integer nmoveable) {
		this.nmoveable = nmoveable;
	}

	@Lob
	@Column(name = "BBITMAP", length = 4000)
	public byte[] getBbitmap() {
		return this.bbitmap;
	}

	public void setBbitmap(final byte[] bbitmap) {
		this.bbitmap = bbitmap;
	}

	@Column(name = "NLAYER", precision = 3, scale = 0)
	public Integer getNlayer() {
		return this.nlayer;
	}

	public void setNlayer(final Integer nlayer) {
		this.nlayer = nlayer;
	}

}
