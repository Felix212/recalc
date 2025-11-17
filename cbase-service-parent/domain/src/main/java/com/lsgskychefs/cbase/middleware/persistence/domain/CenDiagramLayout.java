package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Apr 24, 2019 2:37:55 PM by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_DIAGRAM_LAYOUT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_DIAGRAM_LAYOUT", uniqueConstraints = @UniqueConstraint(columnNames = { "NAIRLINE_KEY", "CLAYOUT_NAME" }))
public class CenDiagramLayout implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nlayoutKey;
	@JsonIgnore
	private CenAirlines cenAirlines;
	private String clayoutName;
	private int nweblayout;
	private int nlogo;

	@Id
	@Column(name = "NLAYOUT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNlayoutKey() {
		return this.nlayoutKey;
	}

	public void setNlayoutKey(final long nlayoutKey) {
		this.nlayoutKey = nlayoutKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "CLAYOUT_NAME", nullable = false, length = 40)
	public String getClayoutName() {
		return this.clayoutName;
	}

	public void setClayoutName(final String clayoutName) {
		this.clayoutName = clayoutName;
	}

	@Column(name = "NWEBLAYOUT", nullable = false, precision = 1, scale = 0)
	public int getNweblayout() {
		return this.nweblayout;
	}

	public void setNweblayout(final int nweblayout) {
		this.nweblayout = nweblayout;
	}

	@Column(name = "NLOGO", nullable = false, precision = 3, scale = 0)
	public int getNlogo() {
		return this.nlogo;
	}

	public void setNlogo(final int nlogo) {
		this.nlogo = nlogo;
	}

}
