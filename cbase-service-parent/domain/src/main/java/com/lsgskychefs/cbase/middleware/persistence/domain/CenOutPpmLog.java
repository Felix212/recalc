package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 13, 2020 3:50:45 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_LOG
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_LOG")
public class CenOutPpmLog implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutPpmLogId id;
	private String ctext;

	public CenOutPpmLog() {
	}

	/**
	 * @param id
	 * @param ctext
	 * @param dtimestamp
	 */
	public CenOutPpmLog(CenOutPpmLogId id, String ctext, Date dtimestamp) {
		this.id = id;
		this.ctext = ctext;
	}

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nlogKey", column = @Column(name = "NLOG_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "npos", column = @Column(name = "NPOS", nullable = false, precision = 12, scale = 0)) })
	public CenOutPpmLogId getId() {
		return this.id;
	}

	public void setId(CenOutPpmLogId id) {
		this.id = id;
	}

	@Column(name = "CTEXT", nullable = false, length = 1000)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(String ctext) {
		this.ctext = ctext;
	}

}
