package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_PACKETS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PACKETS")
public class CenOutPackets implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long npacketsKey;
	private CenOut cenOut;
	private long nresultKeyGroup;
	private int nlegNumber;
	private String cpacketClass;
	private String cpacket;
	private String cpacketVar;
	private String cpacketGroupCode;
	private String cpacketDescription;
	private long nairlinePackagesKey;
	private int npax;

	public CenOutPackets() {
	}

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PACKETS")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PACKETS", sequenceName = "SEQ_CEN_OUT_PACKETS", allocationSize = 1)
	@Column(name = "NPACKETS_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNpacketsKey() {
		return this.npacketsKey;
	}

	public void setNpacketsKey(final long npacketsKey) {
		this.npacketsKey = npacketsKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@Column(name = "NRESULT_KEY_GROUP", nullable = false, precision = 12, scale = 0)
	public long getNresultKeyGroup() {
		return this.nresultKeyGroup;
	}

	public void setNresultKeyGroup(final long nresultKeyGroup) {
		this.nresultKeyGroup = nresultKeyGroup;
	}

	@Column(name = "NLEG_NUMBER", nullable = false, precision = 6, scale = 0)
	public int getNlegNumber() {
		return this.nlegNumber;
	}

	public void setNlegNumber(final int nlegNumber) {
		this.nlegNumber = nlegNumber;
	}

	@Column(name = "CPACKET_CLASS", nullable = false, length = 6)
	public String getCpacketClass() {
		return this.cpacketClass;
	}

	public void setCpacketClass(final String cpacketClass) {
		this.cpacketClass = cpacketClass;
	}

	@Column(name = "CPACKET", nullable = false, length = 40)
	public String getCpacket() {
		return this.cpacket;
	}

	public void setCpacket(final String cpacket) {
		this.cpacket = cpacket;
	}

	@Column(name = "CPACKET_VAR", length = 40)
	public String getCpacketVar() {
		return this.cpacketVar;
	}

	public void setCpacketVar(final String cpacketVar) {
		this.cpacketVar = cpacketVar;
	}

	@Column(name = "CPACKET_GROUP_CODE", length = 10)
	public String getCpacketGroupCode() {
		return this.cpacketGroupCode;
	}

	public void setCpacketGroupCode(final String cpacketGroupCode) {
		this.cpacketGroupCode = cpacketGroupCode;
	}

	@Column(name = "CPACKET_DESCRIPTION", length = 40)
	public String getCpacketDescription() {
		return this.cpacketDescription;
	}

	public void setCpacketDescription(final String cpacketDescription) {
		this.cpacketDescription = cpacketDescription;
	}

	@Column(name = "NAIRLINE_PACKAGES_KEY", nullable = false, precision = 12, scale = 0)
	public long getNairlinePackagesKey() {
		return this.nairlinePackagesKey;
	}

	public void setNairlinePackagesKey(final long nairlinePackagesKey) {
		this.nairlinePackagesKey = nairlinePackagesKey;
	}

	@Column(name = "NPAX", nullable = false, precision = 4, scale = 0)
	public int getNpax() {
		return this.npax;
	}

	public void setNpax(final int npax) {
		this.npax = npax;
	}

}
