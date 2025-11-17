package com.lsgskychefs.cbase.middleware.persistence.domain;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

import org.hibernate.Hibernate;

@Embeddable
public class CenOutChangesReadId extends AbstractDomainObjectPK implements Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@NotNull
	@Column(name = "NRESULT_KEY", nullable = false)
	private Long nresultKey;

	@NotNull
	@Column(name = "NTRANSACTION", nullable = false)
	private Long ntransaction;

	@NotNull
	@Column(name = "NUSER_ID", nullable = false)
	private Long nuserId;

	public CenOutChangesReadId() {

	}

	public CenOutChangesReadId(final Long nresultKey, final Long ntransaction, final Long nuserId) {
		this.nresultKey = nresultKey;
		this.ntransaction = ntransaction;
		this.nuserId = nuserId;
	}

	public Long getNresultKey() {
		return nresultKey;
	}

	public void setNresultKey(Long nresultKey) {
		this.nresultKey = nresultKey;
	}

	public Long getNtransaction() {
		return ntransaction;
	}

	public void setNtransaction(Long ntransaction) {
		this.ntransaction = ntransaction;
	}

	public Long getNuserId() {
		return nuserId;
	}

	public void setNuserId(Long nuserId) {
		this.nuserId = nuserId;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o)
			return true;
		if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o))
			return false;
		CenOutChangesReadId entity = (CenOutChangesReadId) o;
		return Objects.equals(this.ntransaction, entity.ntransaction) &&
				Objects.equals(this.nuserId, entity.nuserId) &&
				Objects.equals(this.nresultKey, entity.nresultKey);
	}

	@Override
	public int hashCode() {
		return Objects.hash(ntransaction, nuserId, nresultKey);
	}

}
