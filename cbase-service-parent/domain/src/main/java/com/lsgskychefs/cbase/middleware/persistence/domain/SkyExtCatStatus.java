package com.lsgskychefs.cbase.middleware.persistence.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name = "SKY_EXT_CAT_STATUS")
public class SkyExtCatStatus implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "NSTATUS", nullable = false)
	private Long id;

	@Size(max = 40)
	@NotNull
	@Column(name = "CSTATUS", nullable = false, length = 40)
	private String cstatus;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCstatus() {
		return cstatus;
	}

	public void setCstatus(String cstatus) {
		this.cstatus = cstatus;
	}

}
