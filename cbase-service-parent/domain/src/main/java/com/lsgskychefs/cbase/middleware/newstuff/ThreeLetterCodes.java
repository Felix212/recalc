package com.lsgskychefs.cbase.middleware.newstuff;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table SYS_THREE_LETTER_CODES<br>
 * IATA-Flughafencode (engl. IATA airport code oder IATA station code, manchmal auch IATA (Airport) Three Letter Code, (AP)3LC)
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "THREE_LETTER_CODES", uniqueConstraints = @UniqueConstraint(columnNames = "CTLC"))
public class ThreeLetterCodes implements com.lsgskychefs.cbase.middleware.persistence.domain.DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ntlcKey;
	private String ctlc;
	private String cdestination;
	private BigDecimal ngmt;
	private Integer nloadPrio;

	@Id
	@Column(name = "NTLC_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNtlcKey() {
		return this.ntlcKey;
	}

	public void setNtlcKey(final long ntlcKey) {
		this.ntlcKey = ntlcKey;
	}

	@Column(name = "CTLC", unique = true, nullable = false, length = 3)
	public String getCtlc() {
		return this.ctlc;
	}

	public void setCtlc(final String ctlc) {
		this.ctlc = ctlc;
	}

	@Column(name = "CDESTINATION", nullable = false, length = 50)
	public String getCdestination() {
		return this.cdestination;
	}

	public void setCdestination(final String cdestination) {
		this.cdestination = cdestination;
	}

	@Column(name = "NGMT", nullable = false, precision = 5)
	public BigDecimal getNgmt() {
		return this.ngmt;
	}

	public void setNgmt(final BigDecimal ngmt) {
		this.ngmt = ngmt;
	}

	@Column(name = "NLOAD_PRIO", precision = 1, scale = 0)
	public Integer getNloadPrio() {
		return this.nloadPrio;
	}

	public void setNloadPrio(final Integer nloadPrio) {
		this.nloadPrio = nloadPrio;
	}

}
