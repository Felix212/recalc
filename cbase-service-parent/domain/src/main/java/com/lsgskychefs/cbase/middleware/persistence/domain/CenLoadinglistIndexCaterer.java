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
 * Entity(DomainObject) for table CEN_LOADINGLIST_INDEX_CATERER
 *
 * @author Hibernate Tools
 */
@Entity
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@Table(name = "CEN_LOADINGLIST_INDEX_CATERER")
public class CenLoadinglistIndexCaterer implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nloadinglistIndexCatererKey;
	private long nloadinglistIndexKey;
	private long ncatererKey;
	

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_LOADINGLIST_INDEX_CATERER")
	@SequenceGenerator(name = "SEQ_CEN_LOADINGLIST_INDEX_CATERER", sequenceName = "SEQ_CEN_LOADINGLIST_INDEX_CATERER", allocationSize = 1)
	@Column(name = "NLOADINGLIST_INDEX_CATERER_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNloadinglistIndexCatererKey() {
		return this.nloadinglistIndexCatererKey;
	}

	public void setNloadinglistIndexCatererKey(long nloadinglistIndexCatererKey) {
		this.nloadinglistIndexCatererKey = nloadinglistIndexCatererKey;
	}

	@Column(name = "NLOADINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNloadinglistIndexKey() {
		return this.nloadinglistIndexKey;
	}
	
	public void setNloadinglistIndexKey(long nloadinglistIndexKey) {
		this.nloadinglistIndexKey = nloadinglistIndexKey;
	}
	
	@Column(name = "NCATERER_KEY", nullable = false, precision = 12, scale = 0)
	public long getNcatererKey() {
		return this.ncatererKey;
	}
	
	public void setNcatererKey(long ncatererKey) {
		this.ncatererKey = ncatererKey;
	}

}
