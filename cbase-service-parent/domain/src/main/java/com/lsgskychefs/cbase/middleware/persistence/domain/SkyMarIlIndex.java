package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Dec 16, 2021 3:22:02 PM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table SKY_MAR_IL_INDEX
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SKY_MAR_IL_INDEX")
public class SkyMarIlIndex implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long npackinglistIndexKey;

	@JsonView(View.Simple.class)
	private String cpackinglist;

	@JsonView(View.Simple.class)
	private Long nplKindKey;

	@JsonView(View.Simple.class)
	private SysPackinglistKinds sysPackinglistKinds;

	@JsonView(View.Simple.class)
	private Boolean ntransferred;

	@JsonView(View.Simple.class)
	private String cparsingError;

	@JsonView(View.SimpleWithReferences.class)
	private Set<SkyMarIl> skyMarIls = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SKY_MAR_IL_INDEX")
	@SequenceGenerator(name = "SEQ_SKY_MAR_IL_INDEX", sequenceName = "SEQ_SKY_MAR_IL_INDEX", allocationSize = 1)
	@Column(name = "NPACKINGLIST_INDEX_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 18)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "NPL_KIND_KEY", precision = 12, scale = 0)
	public Long getNplKindKey() {
		return this.nplKindKey;
	}

	public void setNplKindKey(final Long nplKindKey) {
		this.nplKindKey = nplKindKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPL_KIND_KEY", nullable = false, insertable = false, updatable = false)
	public SysPackinglistKinds getSysPackinglistKinds() {
		return sysPackinglistKinds;
	}

	public void setSysPackinglistKinds(final SysPackinglistKinds sysPackinglistKinds) {
		this.sysPackinglistKinds = sysPackinglistKinds;
	}

	@Column(name = "NTRANSFERRED", precision = 1, scale = 0)
	public Boolean getNtransferred() {
		return ntransferred;
	}

	public void setNtransferred(final Boolean ntransferred) {
		this.ntransferred = ntransferred;
	}

	@Column(name = "CPARSING_ERROR", length = 400)
	public String getCparsingError() {
		return cparsingError;
	}

	public void setCparsingError(final String cparsingError) {
		this.cparsingError = cparsingError;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "skyMarIlIndex")
	@OrderBy("dvalidFrom DESC")
	public Set<SkyMarIl> getSkyMarIls() {
		return this.skyMarIls;
	}

	public void setSkyMarIls(final Set<SkyMarIl> skyMarIls) {
		this.skyMarIls = skyMarIls;
	}

}
