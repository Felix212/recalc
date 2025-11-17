package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 31.08.2022 14:50:48 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table SYS_PL_RATING_TYPE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_PL_RATING_TYPE")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysPlRatingType implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nplRatingTypeKey;
	private String cname;
	private String cdescription;
	@JsonIgnore
	private Set<CenPlRatingType> cenPlRatingTypes = new HashSet<>(0);

	@Id
	@Column(name = "NPL_RATING_TYPE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNplRatingTypeKey() {
		return this.nplRatingTypeKey;
	}

	public void setNplRatingTypeKey(final long nplRatingTypeKey) {
		this.nplRatingTypeKey = nplRatingTypeKey;
	}

	@Column(name = "CNAME", length = 256)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CDESCRIPTION", length = 512)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysPlRatingType")
	public Set<CenPlRatingType> getCenPlRatingTypes() {
		return this.cenPlRatingTypes;
	}

	public void setCenPlRatingTypes(final Set<CenPlRatingType> cenPlRatingTypes) {
		this.cenPlRatingTypes = cenPlRatingTypes;
	}

}


