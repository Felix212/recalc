package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 28.02.2025 13:10:30 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_ARCHIVE_DOCTYPES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_ARCHIVE_DOCTYPES"
)
public class SysArchiveDoctypes implements DomainObject, java.io.Serializable {

	private long ndoctypeKey;
	private String ctype;
	private String ctext;
	private Integer ndefault;
	private Integer ndeliveryNote;

	@Id
	@Column(name = "NDOCTYPE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdoctypeKey() {
		return this.ndoctypeKey;
	}

	public void setNdoctypeKey(long ndoctypeKey) {
		this.ndoctypeKey = ndoctypeKey;
	}

	@Column(name = "CTYPE", length = 10)
	public String getCtype() {
		return this.ctype;
	}

	public void setCtype(String ctype) {
		this.ctype = ctype;
	}

	@Column(name = "CTEXT", length = 80)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NDEFAULT", precision = 1, scale = 0)
	public Integer getNdefault() {
		return this.ndefault;
	}

	public void setNdefault(Integer ndefault) {
		this.ndefault = ndefault;
	}

	@Column(name = "NDELIVERY_NOTE", precision = 1, scale = 0)
	public Integer getNdeliveryNote() {
		return this.ndeliveryNote;
	}

	public void setNdeliveryNote(Integer ndeliveryNote) {
		this.ndeliveryNote = ndeliveryNote;
	}

}


