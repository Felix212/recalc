package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 18.08.2016 09:42:20 by Hibernate Tools 4.3.2-SNAPSHOT

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_CATERINGOBJECT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_CATERINGOBJECT")
public class SysCateringobject implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncateringobjectId;
	private String ccateringobjectName;
	private int ncateringobjectType;
	private String cclassName;
	private int nwebuse;
	private Set<CenCateringUserobject> cenCateringUserobjects = new HashSet<>(0);

	@Id
	@Column(name = "NCATERINGOBJECT_ID", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcateringobjectId() {
		return this.ncateringobjectId;
	}

	public void setNcateringobjectId(final long ncateringobjectId) {
		this.ncateringobjectId = ncateringobjectId;
	}

	@Column(name = "CCATERINGOBJECT_NAME", nullable = false, length = 40)
	public String getCcateringobjectName() {
		return this.ccateringobjectName;
	}

	public void setCcateringobjectName(final String ccateringobjectName) {
		this.ccateringobjectName = ccateringobjectName;
	}

	@Column(name = "NCATERINGOBJECT_TYPE", nullable = false, precision = 5, scale = 0)
	public int getNcateringobjectType() {
		return this.ncateringobjectType;
	}

	public void setNcateringobjectType(final int ncateringobjectType) {
		this.ncateringobjectType = ncateringobjectType;
	}

	@Column(name = "CCLASS_NAME", nullable = false, length = 50)
	public String getCclassName() {
		return this.cclassName;
	}

	public void setCclassName(final String cclassName) {
		this.cclassName = cclassName;
	}

	@Column(name = "NWEBUSE", nullable = false, precision = 1, scale = 0)
	public int getNwebuse() {
		return this.nwebuse;
	}

	public void setNwebuse(final int nwebuse) {
		this.nwebuse = nwebuse;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysCateringobject")
	public Set<CenCateringUserobject> getCenCateringUserobjects() {
		return this.cenCateringUserobjects;
	}

	public void setCenCateringUserobjects(final Set<CenCateringUserobject> cenCateringUserobjects) {
		this.cenCateringUserobjects = cenCateringUserobjects;
	}

}
