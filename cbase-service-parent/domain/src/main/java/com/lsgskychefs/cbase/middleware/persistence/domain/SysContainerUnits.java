package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 18 Nov 2024, 14:51:46 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table SYS_CONTAINER_UNITS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_CONTAINER_UNITS"
)
public class SysContainerUnits implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncontainerUnitsKey;
	private String cshort;
	private String ctext;
	private byte[] bpicture;
	private Set<CenStowage> cenStowages = new HashSet<>(0);

	@Id
	@Column(name = "NCONTAINER_UNITS_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcontainerUnitsKey() {
		return this.ncontainerUnitsKey;
	}

	public void setNcontainerUnitsKey(long ncontainerUnitsKey) {
		this.ncontainerUnitsKey = ncontainerUnitsKey;
	}

	@Column(name = "CSHORT", nullable = false, length = 20)
	public String getCshort() {
		return this.cshort;
	}

	public void setCshort(String cshort) {
		this.cshort = cshort;
	}

	@Column(name = "CTEXT", nullable = false, length = 100)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "BPICTURE")
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(byte[] bpicture) {
		this.bpicture = bpicture;
	}

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysContainerUnits")
	public Set<CenStowage> getCenStowages() {
		return this.cenStowages;
	}

	public void setCenStowages(Set<CenStowage> cenStowages) {
		this.cenStowages = cenStowages;
	}

}


