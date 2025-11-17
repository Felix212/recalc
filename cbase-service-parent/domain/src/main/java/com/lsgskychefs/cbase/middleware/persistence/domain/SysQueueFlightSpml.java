package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 09.06.2016 16:01:51 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_QUEUE_FLIGHT_SPML
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_QUEUE_FLIGHT_SPML")
public class SysQueueFlightSpml implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private SysQueueFlightSpmlId id;
	private SysQueueFlightCalc sysQueueFlightCalc;
	private String cspml;
	private String cname;
	private String caddText;
	private String cremark;
	private BigDecimal nquantity;
	private Integer ntopoff;
	private String cseat;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "njobNr", column = @Column(name = "NJOB_NR", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "cclass", column = @Column(name = "CCLASS", nullable = false, length = 10)),
			@AttributeOverride(name = "nprio", column = @Column(name = "NPRIO", nullable = false, precision = 6, scale = 0)) })
	public SysQueueFlightSpmlId getId() {
		return this.id;
	}

	public void setId(final SysQueueFlightSpmlId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NJOB_NR", nullable = false, insertable = false, updatable = false)
	public SysQueueFlightCalc getSysQueueFlightCalc() {
		return this.sysQueueFlightCalc;
	}

	public void setSysQueueFlightCalc(final SysQueueFlightCalc sysQueueFlightCalc) {
		this.sysQueueFlightCalc = sysQueueFlightCalc;
		sysQueueFlightCalc.getSysQueueFlightSpmls().add(this);
	}

	@Column(name = "CSPML", length = 10)
	public String getCspml() {
		return this.cspml;
	}

	public void setCspml(final String cspml) {
		this.cspml = cspml;
	}

	@Column(name = "CNAME", length = 40)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CADD_TEXT", length = 40)
	public String getCaddText() {
		return this.caddText;
	}

	public void setCaddText(final String caddText) {
		this.caddText = caddText;
	}

	@Column(name = "CREMARK", length = 40)
	public String getCremark() {
		return this.cremark;
	}

	public void setCremark(final String cremark) {
		this.cremark = cremark;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NTOPOFF", precision = 1, scale = 0)
	public Integer getNtopoff() {
		return this.ntopoff;
	}

	public void setNtopoff(final Integer ntopoff) {
		this.ntopoff = ntopoff;
	}

	@Column(name = "CSEAT", length = 40)
	public String getCseat() {
		return this.cseat;
	}

	public void setCseat(final String cseat) {
		this.cseat = cseat;
	}

}
