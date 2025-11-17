package com.lsgskychefs.cbase.middleware.persistence.domain;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.Hibernate;

@Embeddable
public class SysSshKeyId extends AbstractDomainObjectPK implements Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	public SysSshKeyId() {}

	public SysSshKeyId(String cusername, String chostname) {
		this.cusername = cusername;
		this.chostname = chostname;
	}

	@Size(max = 40)
	@NotNull
	@Column(name = "CUSERNAME", nullable = false, length = 40)
	private String cusername;

	@Size(max = 40)
	@NotNull
	@Column(name = "CHOSTNAME", nullable = false, length = 40)
	private String chostname;

	public String getCusername() {
		return cusername;
	}

	public void setCusername(String cusername) {
		this.cusername = cusername;
	}

	public String getChostname() {
		return chostname;
	}

	public void setChostname(String chostname) {
		this.chostname = chostname;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o)
			return true;
		if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o))
			return false;
		SysSshKeyId entity = (SysSshKeyId) o;
		return Objects.equals(this.cusername, entity.cusername) &&
				Objects.equals(this.chostname, entity.chostname);
	}

	@Override
	public int hashCode() {
		return Objects.hash(cusername, chostname);
	}

}
