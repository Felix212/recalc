package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Aug 19, 2025 11:49:43 AM by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table SYS_MP_DESIGN_ITEMLIST_STATUS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_MP_DESIGN_ITEMLIST_STATUS"
)
public class SysMpDesignItemlistStatus implements DomainObject, java.io.Serializable {

	private long ndesignItemlistStatusKey;
	private String cstatus;
	private Date dtimestamp;
	@JsonIgnore
	private Set<CenMpDesignItemlist> cenMpDesignItemlists = new HashSet<CenMpDesignItemlist>(0);

	public SysMpDesignItemlistStatus() {
	}

	@Id
	@Column(name = "NDESIGN_ITEMLIST_STATUS_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdesignItemlistStatusKey() {
		return this.ndesignItemlistStatusKey;
	}

	public void setNdesignItemlistStatusKey(long ndesignItemlistStatusKey) {
		this.ndesignItemlistStatusKey = ndesignItemlistStatusKey;
	}

	@Column(name = "CSTATUS", nullable = false, length = 40)
	public String getCstatus() {
		return this.cstatus;
	}

	public void setCstatus(String cstatus) {
		this.cstatus = cstatus;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysMpDesignItemlistStatus")
	public Set<CenMpDesignItemlist> getCenMpDesignItemlists() {
		return this.cenMpDesignItemlists;
	}

	public void setCenMpDesignItemlists(Set<CenMpDesignItemlist> cenMpDesignItemlists) {
		this.cenMpDesignItemlists = cenMpDesignItemlists;
	}

}


