package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.03.2017 10:38:49 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

/**
 * Entity(DomainObject) for table SYS_SLS_PROJ_KW
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SLS_PROJ_KW")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nprojKwKey")
public class SysSlsProjKw implements DomainObject, java.io.Serializable {
	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nprojKwKey;
	private SysSlsProjKwCat sysSlsProjKwCat;
	private long nkeywordKey;
	private String ckeyword;
	private String cdescription;
	private int nsort;
	private byte[] bpicture;
	private Set<CenSlsProject> cenSlsProjects = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_SLS_PROJ_KW")
	@SequenceGenerator(name = "SEQ_SYS_SLS_PROJ_KW", sequenceName = "SEQ_SYS_SLS_PROJ_KW", allocationSize = 1)
	@Column(name = "NPROJ_KW_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNprojKwKey() {
		return this.nprojKwKey;
	}

	public void setNprojKwKey(final long nprojKwKey) {
		this.nprojKwKey = nprojKwKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROJ_KW_CAT_KEY", nullable = false)
	@JsonIgnore
	public SysSlsProjKwCat getSysSlsProjKwCat() {
		return this.sysSlsProjKwCat;
	}

	public void setSysSlsProjKwCat(final SysSlsProjKwCat sysSlsProjKwCat) {
		this.sysSlsProjKwCat = sysSlsProjKwCat;
	}

	// Soft reference to original SysSlsKeyword where it was copied from
	@JsonIgnore
	@Column(name = "NKEYWORD_KEY", nullable = false, precision = 12, scale = 0)
	public long getNkeywordKey() {
		return this.nkeywordKey;
	}

	public void setNkeywordKey(final long nkeywordKey) {
		this.nkeywordKey = nkeywordKey;
	}

	@Column(name = "CKEYWORD", nullable = false, length = 40)
	public String getCkeyword() {
		return this.ckeyword;
	}

	public void setCkeyword(final String ckeyword) {
		this.ckeyword = ckeyword;
	}

	@Column(name = "CDESCRIPTION", length = 256)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NSORT", nullable = false, precision = 3, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@Column(name = "BPICTURE")
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(final byte[] bpicture) {
		this.bpicture = bpicture;
	}

	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "sysSlsProjKws")
	@JsonIgnore
	public Set<CenSlsProject> getCenSlsProjects() {
		return this.cenSlsProjects;
	}

	public void setCenSlsProjects(final Set<CenSlsProject> cenSlsProjects) {
		this.cenSlsProjects = cenSlsProjects;
	}

}
