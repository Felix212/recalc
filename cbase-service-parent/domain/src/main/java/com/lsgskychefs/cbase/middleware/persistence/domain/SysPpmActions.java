package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

/**
 * Entity(DomainObject) for table SYS_PPM_ACTIONS
 *
 * @author Hibernate Tools
 */
@Entity
@NamedEntityGraph(name = "SysPpmActions.sysPpmGroups", attributeNodes = @NamedAttributeNode("sysPpmGroups"))
@Table(name = "SYS_PPM_ACTIONS")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysPpmActions implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private int nalertLevel;

	private String cdescription;

	private String cmessage;

	private int ninternal;

	private Set<SysPpmGroup> sysPpmGroups = new HashSet<>(0);

	@Id
	@Column(name = "NALERT_LEVEL", unique = true, nullable = false, precision = 6, scale = 0)
	public int getNalertLevel() {
		return this.nalertLevel;
	}

	public void setNalertLevel(final int nalertLevel) {
		this.nalertLevel = nalertLevel;
	}

	@Column(name = "CDESCRIPTION", nullable = false, length = 40)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CMESSAGE", length = 256)
	public String getCmessage() {
		return this.cmessage;
	}

	public void setCmessage(final String cmessage) {
		this.cmessage = cmessage;
	}

	@Column(name = "NINTERNAL", nullable = false, precision = 1, scale = 0)
	public int getNinternal() {
		return this.ninternal;
	}

	public void setNinternal(final int ninternal) {
		this.ninternal = ninternal;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysPpmActions")
	@JsonManagedReference
	public Set<SysPpmGroup> getSysPpmGroups() {
		return this.sysPpmGroups;
	}

	public void setSysPpmGroups(final Set<SysPpmGroup> sysPpmGroups) {
		this.sysPpmGroups = sysPpmGroups;
	}

}
