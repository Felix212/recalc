package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

/**
 * Entity(DomainObject) for table CEN_OUT_COMMENT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_COMMENT")
public class CenOutComment implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nresultKey;
	private CenOut cenOut;
	private long ntransaction;
	private String ctextinfo;
	private Date dtimestamp;

	@Id
	@GenericGenerator(name = "generator", strategy = "foreign", parameters = @Parameter(name = "property", value = "cenOut"))
	@GeneratedValue(generator = "generator")
	@Column(name = "NRESULT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
		if (cenOut.getCenOutComment() != this) {
			cenOut.setCenOutComment(this);
		}
	}

	@Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)
	public long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Column(name = "CTEXTINFO", length = 2048)
	public String getCtextinfo() {
		return this.ctextinfo;
	}

	public void setCtextinfo(final String ctextinfo) {
		this.ctextinfo = ctextinfo;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}
