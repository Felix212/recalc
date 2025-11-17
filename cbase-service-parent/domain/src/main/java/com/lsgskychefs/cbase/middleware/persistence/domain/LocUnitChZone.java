package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Feb 28, 2019 9:57:38 AM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table LOC_UNIT_CH_ZONE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_CH_ZONE")
public class LocUnitChZone implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nzoneKey;
	@JsonIgnore
	private SysChillerEqType sysChillerEqType;
	@JsonIgnore
	private LocUnitChWarehouse locUnitChWarehouse;
	private String czone;
	private String cdescription;
	private Integer nquantity;
	private String locationType;
	private Set<LocUnitChStorageBin> locUnitChStorageBins = new HashSet<>(0);
	@JsonIgnore
	private Set<LocUnitChRule> locUnitChRules = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_UNIT_CH_ZONE")
	@SequenceGenerator(name = "SEQ_LOC_UNIT_CH_ZONE", sequenceName = "SEQ_LOC_UNIT_CH_ZONE", allocationSize = 1)
	@Column(name = "NZONE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNzoneKey() {
		return this.nzoneKey;
	}

	public void setNzoneKey(final long nzoneKey) {
		this.nzoneKey = nzoneKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NEQUIPMENT_KEY")
	public SysChillerEqType getSysChillerEqType() {
		return this.sysChillerEqType;
	}

	public void setSysChillerEqType(final SysChillerEqType sysChillerEqType) {
		this.sysChillerEqType = sysChillerEqType;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWAREHOUSE_KEY", nullable = false)
	public LocUnitChWarehouse getLocUnitChWarehouse() {
		return this.locUnitChWarehouse;
	}

	public void setLocUnitChWarehouse(final LocUnitChWarehouse locUnitChWarehouse) {
		this.locUnitChWarehouse = locUnitChWarehouse;
	}

	@Column(name = "CZONE", length = 50)
	public String getCzone() {
		return this.czone;
	}

	public void setCzone(final String czone) {
		this.czone = czone;
	}

	@Column(name = "CDESCRIPTION", length = 100)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NQUANTITY", precision = 5, scale = 0)
	public Integer getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final Integer nquantity) {
		this.nquantity = nquantity;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "LOC_UNIT_POS_2_ZONE", joinColumns = {
			@JoinColumn(name = "NZONE_KEY", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "NSTORAGE_BIN_KEY", nullable = false, updatable = false) })
	public Set<LocUnitChStorageBin> getLocUnitChStorageBins() {
		return this.locUnitChStorageBins;
	}

	public void setLocUnitChStorageBins(final Set<LocUnitChStorageBin> locUnitChStorageBins) {
		this.locUnitChStorageBins = locUnitChStorageBins;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitChZone")
	public Set<LocUnitChRule> getLocUnitChRules() {
		return this.locUnitChRules;
	}

	public void setLocUnitChRules(final Set<LocUnitChRule> locUnitChRules) {
		this.locUnitChRules = locUnitChRules;
	}

	@Transient
	public String getLocationType() {
		locationType = sysChillerEqType.getCtype();
		return locationType;
	}

}
