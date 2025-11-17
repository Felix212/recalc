package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Feb 25, 2019 4:02:09 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_AIRLINE_OPCODES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRLINE_OPCODES")
public class CenAirlineOpcodes implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	@JsonView(View.Simple.class)
	private long nopcodeKey;
	@JsonIgnore
	private CenAirlines cenAirlines;
	@JsonView(View.Simple.class)
	private String copcode;
	@JsonView(View.Simple.class)
	private String ctext;
	@JsonView(View.Simple.class)
	private Integer ndefault;
	@JsonView(View.Simple.class)
	private Date dtimestampModification;
	@JsonView(View.Simple.class)
	private int nnotuse4textfile;

	@Id
	@Column(name = "NOPCODE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNopcodeKey() {
		return this.nopcodeKey;
	}

	public void setNopcodeKey(final long nopcodeKey) {
		this.nopcodeKey = nopcodeKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "COPCODE", nullable = false, length = 18)
	public String getCopcode() {
		return this.copcode;
	}

	public void setCopcode(final String copcode) {
		this.copcode = copcode;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NDEFAULT", precision = 1, scale = 0)
	public Integer getNdefault() {
		return this.ndefault;
	}

	public void setNdefault(final Integer ndefault) {
		this.ndefault = ndefault;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_MODIFICATION", length = 7)
	public Date getDtimestampModification() {
		return this.dtimestampModification;
	}

	public void setDtimestampModification(final Date dtimestampModification) {
		this.dtimestampModification = dtimestampModification;
	}

	@Column(name = "NNOTUSE4TEXTFILE", nullable = false, precision = 1, scale = 0)
	public int getNnotuse4textfile() {
		return this.nnotuse4textfile;
	}

	public void setNnotuse4textfile(final int nnotuse4textfile) {
		this.nnotuse4textfile = nnotuse4textfile;
	}

}
