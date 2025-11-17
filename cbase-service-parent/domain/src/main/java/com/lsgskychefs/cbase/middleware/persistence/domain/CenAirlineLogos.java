package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 22.12.2021 12:22:25 by Hibernate Tools 4.3.5.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_AIRLINE_LOGOS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRLINE_LOGOS")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenAirlineLogos implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private CenAirlineLogosId id;
	@JsonIgnore
	private CenAirlines cenAirlines;
	@JsonView(View.Simple.class)
	private String cname;
	@JsonView(View.Simple.class)
	private byte[] blogo;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nairlineKey", column = @Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntyp", column = @Column(name = "NTYP", nullable = false, precision = 1, scale = 0)) })
	public CenAirlineLogosId getId() {
		return this.id;
	}

	public void setId(CenAirlineLogosId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false, insertable = false, updatable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "CNAME")
	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	@Column(name = "BLOGO")
	public byte[] getBlogo() {
		return this.blogo;
	}

	public void setBlogo(byte[] blogo) {
		this.blogo = blogo;
	}

}
