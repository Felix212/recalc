package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated May 3, 2023 5:04:56 PM by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

/**
 * Entity(DomainObject) for table CEN_DIAGRAM_PAGES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_DIAGRAM_PAGES"
)
public class CenDiagramPages implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long npageKey;
	private long naircraftKey;
	private int npage;
	private byte[] bbitmap;
	private String ctext;
	private int nxpos;
	private int nypos;
	private int nobjecttype;
	private Integer ntextalign;
	private Integer nwidth;
	private Integer nheight;
	private String cfontname;
	private Integer nfontbold;
	private Integer nfontsize;
	private Long nfontcolor;
	private Long nobjectbackgroundcolor;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_DIAGRAM_PAGES")
	@SequenceGenerator(name = "SEQ_CEN_DIAGRAM_PAGES", sequenceName = "SEQ_CEN_DIAGRAM_PAGES", allocationSize = 1)
	@Column(name = "NPAGE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNpageKey() {
		return this.npageKey;
	}

	public void setNpageKey(long npageKey) {
		this.npageKey = npageKey;
	}

	@Column(name = "NAIRCRAFT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNaircraftKey() {
		return this.naircraftKey;
	}

	public void setNaircraftKey(long naircraftKey) {
		this.naircraftKey = naircraftKey;
	}

	@Column(name = "NPAGE", nullable = false, precision = 2, scale = 0)
	public int getNpage() {
		return this.npage;
	}

	public void setNpage(int npage) {
		this.npage = npage;
	}

	@Column(name = "BBITMAP")
	@Type(type = "org.hibernate.type.BinaryType")
	public byte[] getBbitmap() {
		return this.bbitmap;
	}

	public void setBbitmap(byte[] bbitmap) {
		this.bbitmap = bbitmap;
	}

	@Column(name = "CTEXT", nullable = false)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NXPOS", nullable = false, precision = 7, scale = 0)
	public int getNxpos() {
		return this.nxpos;
	}

	public void setNxpos(int nxpos) {
		this.nxpos = nxpos;
	}

	@Column(name = "NYPOS", nullable = false, precision = 7, scale = 0)
	public int getNypos() {
		return this.nypos;
	}

	public void setNypos(int nypos) {
		this.nypos = nypos;
	}

	@Column(name = "NOBJECTTYPE", nullable = false, precision = 1, scale = 0)
	public int getNobjecttype() {
		return this.nobjecttype;
	}

	public void setNobjecttype(int nobjecttype) {
		this.nobjecttype = nobjecttype;
	}

	@Column(name = "NTEXTALIGN", precision = 1, scale = 0)
	public Integer getNtextalign() {
		return this.ntextalign;
	}

	public void setNtextalign(Integer ntextalign) {
		this.ntextalign = ntextalign;
	}

	@Column(name = "NWIDTH", precision = 7, scale = 0)
	public Integer getNwidth() {
		return this.nwidth;
	}

	public void setNwidth(Integer nwidth) {
		this.nwidth = nwidth;
	}

	@Column(name = "NHEIGHT", precision = 7, scale = 0)
	public Integer getNheight() {
		return this.nheight;
	}

	public void setNheight(Integer nheight) {
		this.nheight = nheight;
	}

	@Column(name = "CFONTNAME", length = 40)
	public String getCfontname() {
		return this.cfontname;
	}

	public void setCfontname(String cfontname) {
		this.cfontname = cfontname;
	}

	@Column(name = "NFONTBOLD", precision = 1, scale = 0)
	public Integer getNfontbold() {
		return this.nfontbold;
	}

	public void setNfontbold(Integer nfontbold) {
		this.nfontbold = nfontbold;
	}

	@Column(name = "NFONTSIZE", precision = 2, scale = 0)
	public Integer getNfontsize() {
		return this.nfontsize;
	}

	public void setNfontsize(Integer nfontsize) {
		this.nfontsize = nfontsize;
	}

	@Column(name = "NFONTCOLOR", precision = 12, scale = 0)
	public Long getNfontcolor() {
		return this.nfontcolor;
	}

	public void setNfontcolor(Long nfontcolor) {
		this.nfontcolor = nfontcolor;
	}

	@Column(name = "NOBJECTBACKGROUNDCOLOR", precision = 12, scale = 0)
	public Long getNobjectbackgroundcolor() {
		return this.nobjectbackgroundcolor;
	}

	public void setNobjectbackgroundcolor(Long nobjectbackgroundcolor) {
		this.nobjectbackgroundcolor = nobjectbackgroundcolor;
	}

}


