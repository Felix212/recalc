package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Dec 26, 2024 3:00:30 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table SYS_MP_PROJECT_TYPE
 * @author Hibernate Tools
 */
@Entity
@Table(name="SYS_MP_PROJECT_TYPE")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@EntityListeners(AuditingEntityListener.class)
public class SysMpProjectType  implements DomainObject,java.io.Serializable {
	private long nmpProjectTypeKey;
	private String ctype;
	private Date dtimestamp;
	@JsonIgnore
	private Set<CenMpProject> cenMpProjects = new HashSet<CenMpProject>(0);

	public SysMpProjectType() {
	}

	@Id
	@Column(name="NMP_PROJECT_TYPE_KEY", unique=true, nullable=false, precision=12, scale=0)
	public long getNmpProjectTypeKey() {
		return this.nmpProjectTypeKey;
	}

	public void setNmpProjectTypeKey(long nmpProjectTypeKey) {
		this.nmpProjectTypeKey = nmpProjectTypeKey;
	}


	@Column(name="CTYPE", nullable=false, length=40)
	public String getCtype() {
		return this.ctype;
	}

	public void setCtype(String ctype) {
		this.ctype = ctype;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="DTIMESTAMP", length=7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@OneToMany(fetch=FetchType.LAZY, mappedBy="sysMpProjectType")
	public Set<CenMpProject> getCenMpProjects() {
		return this.cenMpProjects;
	}

	public void setCenMpProjects(Set<CenMpProject> cenMpProjects) {
		this.cenMpProjects = cenMpProjects;
	}

}
