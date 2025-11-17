package com.lsgskychefs.cbase.middleware.persistence.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_LOADINGLISTS_DYNLOAD
 *
 * @author Hibernate Tools
 */
@Entity
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@Table(name = "CEN_LOADINGLISTS_DYNLOAD")
public class CenLoadinglistsDynload implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nloadinglistDynloadKey;
	@JsonIgnore
	private CenLoadinglists cenLoadinglists;
	private Long npackinglistIndexKey;
	private int npaxFrom;
	private int npaxTo;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_LOADINGLISTS_DYNLOAD")
	@SequenceGenerator(name = "SEQ_CEN_LOADINGLISTS_DYNLOAD", sequenceName = "SEQ_CEN_LOADINGLISTS_DYNLOAD", allocationSize = 1)
	@Column(name = "NLOADINGLIST_DYNLOAD_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNloadinglistDynloadKey() {
		return this.nloadinglistDynloadKey;
	}

	public void setNloadinglistDynloadKey(long nloadinglistDynloadKey) {
		this.nloadinglistDynloadKey = nloadinglistDynloadKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLOADINGLIST_DETAIL_KEY", nullable = false)
	public CenLoadinglists getCenLoadinglists() {
		return this.cenLoadinglists;
	}

	public void setCenLoadinglists(CenLoadinglists cenLoadinglists) {
		this.cenLoadinglists = cenLoadinglists;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public Long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(Long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "NPAX_FROM", nullable = false, precision = 4, scale = 0)
	public int getNpaxFrom() {
		return this.npaxFrom;
	}

	public void setNpaxFrom(int npaxFrom) {
		this.npaxFrom = npaxFrom;
	}

	@Column(name = "NPAX_TO", nullable = false, precision = 4, scale = 0)
	public int getNpaxTo() {
		return this.npaxTo;
	}

	public void setNpaxTo(int npaxTo) {
		this.npaxTo = npaxTo;
	}
}