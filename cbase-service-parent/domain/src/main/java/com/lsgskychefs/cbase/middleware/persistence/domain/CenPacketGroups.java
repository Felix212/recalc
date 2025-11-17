package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 23, 2019 2:41:41 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_PACKET_GROUPS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PACKET_GROUPS")
public class CenPacketGroups implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** npacketGroupKey */
	private long npacketGroupKey;

	/** cenAirlines */
	private CenAirlines cenAirlines;

	/** cpacketGroup */
	private String cpacketGroup;

	/** ctext */
	private String ctext;

	/** dtimestamp */
	private Date dtimestamp;

	@Id
	@Column(name = "NPACKET_GROUP_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNpacketGroupKey() {
		return this.npacketGroupKey;
	}

	public void setNpacketGroupKey(final long npacketGroupKey) {
		this.npacketGroupKey = npacketGroupKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "CPACKET_GROUP", nullable = false, length = 10)
	public String getCpacketGroup() {
		return this.cpacketGroup;
	}

	public void setCpacketGroup(final String cpacketGroup) {
		this.cpacketGroup = cpacketGroup;
	}

	@Column(name = "CTEXT", length = 80)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
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
