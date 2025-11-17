package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 29.03.2016 13:08:37 by Hibernate Tools 4.3.2-SNAPSHOT

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
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonView;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table SYS_AIRLINE_CAT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_AIRLINE_CAT", uniqueConstraints = { @UniqueConstraint(columnNames = "CCATSHORT"),
		@UniqueConstraint(columnNames = "CCATDESC") })
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nkey")
public class SysAirlineCat implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long nkey;

	@JsonView(View.Simple.class)
	private String ccatshort;

	@JsonView(View.Simple.class)
	private String ccatdesc;

	@JsonView(View.Simple.class)
	private Date dtimestamp;

	@JsonView(View.SimpleWithReferences.class)
	private Set<CenAirlCategories> cenAirlCategorieses = new HashSet<>(0);

	@Id
	@Column(name = "NKEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNkey() {
		return this.nkey;
	}

	public void setNkey(final long nkey) {
		this.nkey = nkey;
	}

	@Column(name = "CCATSHORT", unique = true, nullable = false, length = 14)
	public String getCcatshort() {
		return this.ccatshort;
	}

	public void setCcatshort(final String ccatshort) {
		this.ccatshort = ccatshort;
	}

	@Column(name = "CCATDESC", unique = true, nullable = false, length = 50)
	public String getCcatdesc() {
		return this.ccatdesc;
	}

	public void setCcatdesc(final String ccatdesc) {
		this.ccatdesc = ccatdesc;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysAirlineCat")
	public Set<CenAirlCategories> getCenAirlCategorieses() {
		return this.cenAirlCategorieses;
	}

	public void setCenAirlCategorieses(final Set<CenAirlCategories> cenAirlCategorieses) {
		this.cenAirlCategorieses = cenAirlCategorieses;
	}

}
