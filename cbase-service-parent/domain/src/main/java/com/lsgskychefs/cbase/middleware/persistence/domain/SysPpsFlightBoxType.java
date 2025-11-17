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
 * Entity(DomainObject) for table SYS_PPS_FLIGHT_BOX_TYPE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_PPS_FLIGHT_BOX_TYPE", uniqueConstraints = @UniqueConstraint(columnNames = { "CTYPE", "CUNIT" }))
public class SysPpsFlightBoxType implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nflightBoxTypeKey;
	private String ctype;
	private String ckind;
	private String cdescription;
	private Integer nld3Flag;
	private String cunit;
	private Long nflightBoxTypesKey;
	private Set<CenPpsCateringOrder> cenPpsCateringOrders = new HashSet<>(0);

	@Id
	@Column(name = "NFLIGHT_BOX_TYPE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNflightBoxTypeKey() {
		return this.nflightBoxTypeKey;
	}

	public void setNflightBoxTypeKey(final long nflightBoxTypeKey) {
		this.nflightBoxTypeKey = nflightBoxTypeKey;
	}

	@Column(name = "CTYPE", nullable = false, length = 20)
	public String getCtype() {
		return this.ctype;
	}

	public void setCtype(final String ctype) {
		this.ctype = ctype;
	}

	@Column(name = "CKIND", nullable = false, length = 12)
	public String getCkind() {
		return this.ckind;
	}

	public void setCkind(final String ckind) {
		this.ckind = ckind;
	}

	@Column(name = "CDESCRIPTION", length = 34)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NLD3_FLAG", precision = 1, scale = 0)
	public Integer getNld3Flag() {
		return this.nld3Flag;
	}

	public void setNld3Flag(final Integer nld3Flag) {
		this.nld3Flag = nld3Flag;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NFLIGHT_BOX_TYPES_KEY", precision = 13, scale = 0)
	public Long getNflightBoxTypesKey() {
		return this.nflightBoxTypesKey;
	}

	public void setNflightBoxTypesKey(final Long nflightBoxTypesKey) {
		this.nflightBoxTypesKey = nflightBoxTypesKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysPpsFlightBoxType")
	public Set<CenPpsCateringOrder> getCenPpsCateringOrders() {
		return this.cenPpsCateringOrders;
	}

	public void setCenPpsCateringOrders(final Set<CenPpsCateringOrder> cenPpsCateringOrders) {
		this.cenPpsCateringOrders = cenPpsCateringOrders;
	}

}
