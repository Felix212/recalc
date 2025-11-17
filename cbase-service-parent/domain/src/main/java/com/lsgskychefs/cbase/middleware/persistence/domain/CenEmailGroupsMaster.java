package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jul 1, 2019 4:59:26 PM by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_EMAIL_GROUPS_MASTER
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_EMAIL_GROUPS_MASTER")
public class CenEmailGroupsMaster implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long egmNkey;
	private String egmCtext;
	private String egmCdescription;

	@Id
	@Column(name = "EGM_NKEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getEgmNkey() {
		return this.egmNkey;
	}

	public void setEgmNkey(final long egmNkey) {
		this.egmNkey = egmNkey;
	}

	@Column(name = "EGM_CTEXT", nullable = false, length = 30)
	public String getEgmCtext() {
		return this.egmCtext;
	}

	public void setEgmCtext(final String egmCtext) {
		this.egmCtext = egmCtext;
	}

	@Column(name = "EGM_CDESCRIPTION", nullable = false, length = 100)
	public String getEgmCdescription() {
		return this.egmCdescription;
	}

	public void setEgmCdescription(final String egmCdescription) {
		this.egmCdescription = egmCdescription;
	}

}
