package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 31.08.2018 08:21:00 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table ROB_LANGUAGE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "ROB_LANGUAGE")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class RobLanguage implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private int nlanguage;

	private String cshort;

	private String clong;

	private String cnative;

	private boolean ndefault;

	private byte[] bpicture;

	private boolean translated;

	private Set<RobProductCategoryTrans> robProductCategoryTranses = new HashSet<>(0);

	private Set<RobProductTrans> robProductTranses = new HashSet<>(0);

	@Id
	@Column(name = "NLANGUAGE", unique = true, nullable = false, precision = 2, scale = 0)
	public int getNlanguage() {
		return this.nlanguage;
	}

	public void setNlanguage(final int nlanguage) {
		this.nlanguage = nlanguage;
	}

	@Column(name = "CSHORT", nullable = false, length = 3)
	public String getCshort() {
		return this.cshort;
	}

	public void setCshort(final String cshort) {
		this.cshort = cshort;
	}

	@Column(name = "CLONG", nullable = false, length = 40)
	public String getClong() {
		return this.clong;
	}

	public void setClong(final String clong) {
		this.clong = clong;
	}

	@Column(name = "CNATIVE", nullable = false, length = 40)
	public String getCnative() {
		return this.cnative;
	}

	public void setCnative(final String cnative) {
		this.cnative = cnative;
	}

	@Column(name = "NDEFAULT", nullable = false, precision = 1, scale = 0)
	public boolean isNdefault() {
		return ndefault;
	}

	public void setNdefault(final boolean ndefault) {
		this.ndefault = ndefault;
	}

	@Column(name = "BPICTURE")
	@JsonView(View.Full.class)
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(final byte[] bpicture) {
		this.bpicture = bpicture;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "robLanguage")
	@JsonIgnore
	public Set<RobProductCategoryTrans> getRobProductCategoryTranses() {
		return this.robProductCategoryTranses;
	}

	public void setRobProductCategoryTranses(final Set<RobProductCategoryTrans> robProductCategoryTranses) {
		this.robProductCategoryTranses = robProductCategoryTranses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "robLanguage")
	@JsonIgnore
	public Set<RobProductTrans> getRobProductTranses() {
		return this.robProductTranses;
	}

	public void setRobProductTranses(final Set<RobProductTrans> robProductTranses) {
		this.robProductTranses = robProductTranses;
	}

	/**
	 * Get translated
	 *
	 * @return the translated
	 */
	@Transient
	@JsonView(View.SpecialRelation.class)
	public boolean isTranslated() {
		return translated;
	}

	public void setTranslated(final boolean translated) {
		this.translated = translated;
	}

}
