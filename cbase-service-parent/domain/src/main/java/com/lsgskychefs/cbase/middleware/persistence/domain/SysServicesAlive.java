package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 05.05.2020 10:58:44 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table SYS_SERVICES_ALIVE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SERVICES_ALIVE")
public class SysServicesAlive implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private SysServicesAliveId id;

	private String cversion;

	private int npause;

	private Long nsleeptimer;

	private String csvcTerminal;

	private Date dlifesign;

	private int nfunction1;

	private int nfunction2;

	private int nfunction3;

	private int nfunction4;

	private int ninstance;

	private int nmaster;

	private int nfunction5;

	private int nfunction6;

	private int nfunction7;

	private int nfunction8;

	private int nfunction9;

	private int nfunction10;

	private int nfunction11;

	private int nfunction12;

	private int nfunction13;

	private int nfunction14;

	private int nfunction15;

	private int nfunction16;

	private int nfunction17;

	private int nfunction18;

	private int nfunction19;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "cservice", column = @Column(name = "CSERVICE", nullable = false, length = 100)),
			@AttributeOverride(name = "cinstance", column = @Column(name = "CINSTANCE", nullable = false, length = 50)) })
	public SysServicesAliveId getId() {
		return this.id;
	}

	public void setId(final SysServicesAliveId id) {
		this.id = id;
	}

	@Column(name = "CVERSION", nullable = false, length = 20)
	public String getCversion() {
		return this.cversion;
	}

	public void setCversion(final String cversion) {
		this.cversion = cversion;
	}

	@Column(name = "NPAUSE", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public int getNpause() {
		return this.npause;
	}

	public void setNpause(final int npause) {
		this.npause = npause;
	}

	@Column(name = "NSLEEPTIMER", precision = 12, scale = 0)
	public Long getNsleeptimer() {
		return this.nsleeptimer;
	}

	public void setNsleeptimer(final Long nsleeptimer) {
		this.nsleeptimer = nsleeptimer;
	}

	@Column(name = "CSVC_TERMINAL", length = 20)
	public String getCsvcTerminal() {
		return this.csvcTerminal;
	}

	public void setCsvcTerminal(final String csvcTerminal) {
		this.csvcTerminal = csvcTerminal;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DLIFESIGN", length = 7)
	public Date getDlifesign() {
		return this.dlifesign;
	}

	public void setDlifesign(final Date dlifesign) {
		this.dlifesign = dlifesign;
	}

	@Column(name = "NFUNCTION1", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction1() {
		return this.nfunction1;
	}

	public void setNfunction1(final int nfunction1) {
		this.nfunction1 = nfunction1;
	}

	@Column(name = "NFUNCTION2", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction2() {
		return this.nfunction2;
	}

	public void setNfunction2(final int nfunction2) {
		this.nfunction2 = nfunction2;
	}

	@Column(name = "NFUNCTION3", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction3() {
		return this.nfunction3;
	}

	public void setNfunction3(final int nfunction3) {
		this.nfunction3 = nfunction3;
	}

	@Column(name = "NFUNCTION4", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction4() {
		return this.nfunction4;
	}

	public void setNfunction4(final int nfunction4) {
		this.nfunction4 = nfunction4;
	}

	@Column(name = "NINSTANCE", nullable = false, precision = 2, scale = 0, columnDefinition = "number(2) default 0")
	public int getNinstance() {
		return this.ninstance;
	}

	public void setNinstance(final int ninstance) {
		this.ninstance = ninstance;
	}

	@Column(name = "NMASTER", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public int getNmaster() {
		return this.nmaster;
	}

	public void setNmaster(final int nmaster) {
		this.nmaster = nmaster;
	}

	@Column(name = "NFUNCTION5", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction5() {
		return this.nfunction5;
	}

	public void setNfunction5(final int nfunction5) {
		this.nfunction5 = nfunction5;
	}

	@Column(name = "NFUNCTION6", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction6() {
		return this.nfunction6;
	}

	public void setNfunction6(final int nfunction6) {
		this.nfunction6 = nfunction6;
	}

	@Column(name = "NFUNCTION7", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction7() {
		return this.nfunction7;
	}

	public void setNfunction7(final int nfunction7) {
		this.nfunction7 = nfunction7;
	}

	@Column(name = "NFUNCTION8", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction8() {
		return this.nfunction8;
	}

	public void setNfunction8(final int nfunction8) {
		this.nfunction8 = nfunction8;
	}

	@Column(name = "NFUNCTION9", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction9() {
		return this.nfunction9;
	}

	public void setNfunction9(final int nfunction9) {
		this.nfunction9 = nfunction9;
	}

	@Column(name = "NFUNCTION10", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction10() {
		return this.nfunction10;
	}

	public void setNfunction10(final int nfunction10) {
		this.nfunction10 = nfunction10;
	}

	@Column(name = "NFUNCTION11", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction11() {
		return this.nfunction11;
	}

	public void setNfunction11(final int nfunction11) {
		this.nfunction11 = nfunction11;
	}

	@Column(name = "NFUNCTION12", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction12() {
		return this.nfunction12;
	}

	public void setNfunction12(final int nfunction12) {
		this.nfunction12 = nfunction12;
	}

	@Column(name = "NFUNCTION13", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction13() {
		return this.nfunction13;
	}

	public void setNfunction13(final int nfunction13) {
		this.nfunction13 = nfunction13;
	}

	@Column(name = "NFUNCTION14", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction14() {
		return this.nfunction14;
	}

	public void setNfunction14(final int nfunction14) {
		this.nfunction14 = nfunction14;
	}

	@Column(name = "NFUNCTION15", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction15() {
		return this.nfunction15;
	}

	public void setNfunction15(final int nfunction15) {
		this.nfunction15 = nfunction15;
	}

	@Column(name = "NFUNCTION16", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction16() {
		return this.nfunction16;
	}

	public void setNfunction16(final int nfunction16) {
		this.nfunction16 = nfunction16;
	}

	@Column(name = "NFUNCTION17", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction17() {
		return this.nfunction17;
	}

	public void setNfunction17(final int nfunction17) {
		this.nfunction17 = nfunction17;
	}

	@Column(name = "NFUNCTION18", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction18() {
		return this.nfunction18;
	}

	public void setNfunction18(final int nfunction18) {
		this.nfunction18 = nfunction18;
	}

	@Column(name = "NFUNCTION19", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 1")
	public int getNfunction19() {
		return this.nfunction19;
	}

	public void setNfunction19(final int nfunction19) {
		this.nfunction19 = nfunction19;
	}

}
