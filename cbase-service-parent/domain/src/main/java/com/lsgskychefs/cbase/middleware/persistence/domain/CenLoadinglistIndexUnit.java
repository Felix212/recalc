package com.lsgskychefs.cbase.middleware.persistence.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_LOADINGLIST_INDEX_UNIT
 *
 */
@Entity
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@Table(name = "CEN_LOADINGLIST_INDEX_UNIT")
public class CenLoadinglistIndexUnit implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nloadinglistIndexUnitKey;
	private long nloadinglistIndexKey;
	private String cunit;
	

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_LOADINGLIST_INDEX_UNIT")
	@SequenceGenerator(name = "SEQ_CEN_LOADINGLIST_INDEX_UNIT", sequenceName = "SEQ_CEN_LOADINGLIST_INDEX_UNIT", allocationSize = 1)
	@Column(name = "NLOADINGLIST_INDEX_UNIT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNloadinglistIndexUnitKey() {
		return this.nloadinglistIndexUnitKey;
	}

	public void setNloadinglistIndexUnitKey(final long nloadinglistIndexUnitKey) {
		this.nloadinglistIndexUnitKey = nloadinglistIndexUnitKey;
	}

	@Column(name = "NLOADINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNloadinglistIndexKey() {
		return this.nloadinglistIndexKey;
	}
	
	public void setNloadinglistIndexKey(final long nloadinglistIndexKey) {
		this.nloadinglistIndexKey = nloadinglistIndexKey;
	}
	
	@Column(name = "CUNIT", nullable = false, length = 5)
	public String getCunit() {
		return this.cunit;
	}
	
	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

}