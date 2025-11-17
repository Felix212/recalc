package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Sep 15, 2017 7:52:18 AM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table SYS_HANDLING_ID
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_HANDLING_ID")
public class SysHandlingId extends AbstractDomainObjectPK
		implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nhandlingId;
	private String ctext;
	private int nprio;
	private String ctext1;
	private String ctext2;
	private String ctext3;
	private String ctext4;
	@JsonIgnore
	private Set<CenHandling> cenHandlings = new HashSet<>(0);

	public SysHandlingId() {
	}

	public SysHandlingId(final long nhandlingId, final String ctext, final int nprio, final String ctext1, final String ctext2,
			final String ctext3, final String ctext4) {
		this.nhandlingId = nhandlingId;
		this.ctext = ctext;
		this.nprio = nprio;
		this.ctext1 = ctext1;
		this.ctext2 = ctext2;
		this.ctext3 = ctext3;
		this.ctext4 = ctext4;
	}

	public SysHandlingId(final long nhandlingId, final String ctext, final int nprio, final String ctext1, final String ctext2,
			final String ctext3, final String ctext4, final Set<CenHandling> cenHandlings) {
		this.nhandlingId = nhandlingId;
		this.ctext = ctext;
		this.nprio = nprio;
		this.ctext1 = ctext1;
		this.ctext2 = ctext2;
		this.ctext3 = ctext3;
		this.ctext4 = ctext4;
		this.cenHandlings = cenHandlings;
	}

	@Id

	@Column(name = "NHANDLING_ID", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNhandlingId() {
		return this.nhandlingId;
	}

	public void setNhandlingId(final long nhandlingId) {
		this.nhandlingId = nhandlingId;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NPRIO", nullable = false, precision = 6, scale = 0)
	public int getNprio() {
		return this.nprio;
	}

	public void setNprio(final int nprio) {
		this.nprio = nprio;
	}

	@Column(name = "CTEXT1", nullable = false, length = 40)
	public String getCtext1() {
		return this.ctext1;
	}

	public void setCtext1(final String ctext1) {
		this.ctext1 = ctext1;
	}

	@Column(name = "CTEXT2", nullable = false, length = 40)
	public String getCtext2() {
		return this.ctext2;
	}

	public void setCtext2(final String ctext2) {
		this.ctext2 = ctext2;
	}

	@Column(name = "CTEXT3", nullable = false, length = 40)
	public String getCtext3() {
		return this.ctext3;
	}

	public void setCtext3(final String ctext3) {
		this.ctext3 = ctext3;
	}

	@Column(name = "CTEXT4", nullable = false, length = 40)
	public String getCtext4() {
		return this.ctext4;
	}

	public void setCtext4(final String ctext4) {
		this.ctext4 = ctext4;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysHandlingId")
	public Set<CenHandling> getCenHandlings() {
		return this.cenHandlings;
	}

	public void setCenHandlings(final Set<CenHandling> cenHandlings) {
		this.cenHandlings = cenHandlings;
	}

}
