package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 22.06.2016 17:02:58 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table SYS_PPS_OBJECT_STATE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_PPS_OBJECT_STATE", uniqueConstraints = @UniqueConstraint(columnNames = { "CTEXT", "NOBJECT_KIND_KEY" }))
public class SysPpsObjectState implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nobjectStateKey;
	private long nobjectKindKey;
	private String ctext;
	private String cdescription;
	private Integer ncolorR;
	private Integer ncolorG;
	private Integer ncolorB;
	private String ctext2;
	private String ctext3;
	private String ctext4;
	private String ctext5;
	private Integer nfont;
	private int nlifecycle;
	private Set<CenPpsContainer> cenPpsContainers = new HashSet<>(0);
	private Set<CenPpsFlightSlot> cenPpsFlightSlots = new HashSet<>(0);

	@Id
	@Column(name = "NOBJECT_STATE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNobjectStateKey() {
		return this.nobjectStateKey;
	}

	public void setNobjectStateKey(final long nobjectStateKey) {
		this.nobjectStateKey = nobjectStateKey;
	}

	@Column(name = "NOBJECT_KIND_KEY", nullable = false, precision = 12, scale = 0)
	public long getNobjectKindKey() {
		return this.nobjectKindKey;
	}

	public void setNobjectKindKey(final long nobjectKindKey) {
		this.nobjectKindKey = nobjectKindKey;
	}

	@Column(name = "CTEXT", nullable = false, length = 20)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CDESCRIPTION")
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NCOLOR_R", precision = 3, scale = 0)
	public Integer getNcolorR() {
		return this.ncolorR;
	}

	public void setNcolorR(final Integer ncolorR) {
		this.ncolorR = ncolorR;
	}

	@Column(name = "NCOLOR_G", precision = 3, scale = 0)
	public Integer getNcolorG() {
		return this.ncolorG;
	}

	public void setNcolorG(final Integer ncolorG) {
		this.ncolorG = ncolorG;
	}

	@Column(name = "NCOLOR_B", precision = 3, scale = 0)
	public Integer getNcolorB() {
		return this.ncolorB;
	}

	public void setNcolorB(final Integer ncolorB) {
		this.ncolorB = ncolorB;
	}

	@Column(name = "CTEXT2", length = 20)
	public String getCtext2() {
		return this.ctext2;
	}

	public void setCtext2(final String ctext2) {
		this.ctext2 = ctext2;
	}

	@Column(name = "CTEXT3", length = 20)
	public String getCtext3() {
		return this.ctext3;
	}

	public void setCtext3(final String ctext3) {
		this.ctext3 = ctext3;
	}

	@Column(name = "CTEXT4", length = 20)
	public String getCtext4() {
		return this.ctext4;
	}

	public void setCtext4(final String ctext4) {
		this.ctext4 = ctext4;
	}

	@Column(name = "CTEXT5", length = 20)
	public String getCtext5() {
		return this.ctext5;
	}

	public void setCtext5(final String ctext5) {
		this.ctext5 = ctext5;
	}

	@Column(name = "NFONT", precision = 1, scale = 0)
	public Integer getNfont() {
		return this.nfont;
	}

	public void setNfont(final Integer nfont) {
		this.nfont = nfont;
	}

	@Column(name = "NLIFECYCLE", nullable = false, precision = 3, scale = 0)
	public int getNlifecycle() {
		return this.nlifecycle;
	}

	public void setNlifecycle(final int nlifecycle) {
		this.nlifecycle = nlifecycle;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysPpsObjectState")
	public Set<CenPpsContainer> getCenPpsContainers() {
		return this.cenPpsContainers;
	}

	public void setCenPpsContainers(final Set<CenPpsContainer> cenPpsContainers) {
		this.cenPpsContainers = cenPpsContainers;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysPpsObjectState")
	public Set<CenPpsFlightSlot> getCenPpsFlightSlots() {
		return this.cenPpsFlightSlots;
	}

	public void setCenPpsFlightSlots(final Set<CenPpsFlightSlot> cenPpsFlightSlots) {
		this.cenPpsFlightSlots = cenPpsFlightSlots;
	}

}
