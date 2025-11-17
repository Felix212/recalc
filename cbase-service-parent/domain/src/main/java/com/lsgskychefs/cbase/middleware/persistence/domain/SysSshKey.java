package com.lsgskychefs.cbase.middleware.persistence.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 * Entity(DomainObject) for table SYS_SSH_KEYS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SSH_KEYS")
public class SysSshKey implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private SysSshKeyId id;

	@Size(max = 4000)
	@NotNull
	@Column(name = "CPRIVATE_KEY", nullable = false, length = 4000)
	private String cprivateKey;

	@Size(max = 4000)
	@Column(name = "CPUBLIC_KEY", length = 4000)
	private String cpublicKey;

	@Size(max = 100)
	@Column(name = "CREMARKS", length = 100)
	private String cremarks;

	public SysSshKeyId getId() {
		return id;
	}

	public void setId(SysSshKeyId id) {
		this.id = id;
	}

	public String getCprivateKey() {
		return cprivateKey;
	}

	public void setCprivateKey(String cprivateKey) {
		this.cprivateKey = cprivateKey;
	}

	public String getCpublicKey() {
		return cpublicKey;
	}

	public void setCpublicKey(String cpublicKey) {
		this.cpublicKey = cpublicKey;
	}

	public String getCremarks() {
		return cremarks;
	}

	public void setCremarks(String cremarks) {
		this.cremarks = cremarks;
	}

}
