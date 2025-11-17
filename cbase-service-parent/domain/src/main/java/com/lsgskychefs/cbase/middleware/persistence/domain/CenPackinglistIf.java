package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jun 2, 2025 3:31:31 PM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.Formula;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_PACKINGLIST_IF
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PACKINGLIST_IF"
)
public class CenPackinglistIf implements DomainObject, java.io.Serializable {

	private CenPackinglistsId id;
	@JsonIgnore
	private CenPackinglists cenPackinglists;
	private String corigin;
	private Long ncatererKey;
	@JsonIgnore
	private Set<CenPackinglistIfCharac> cenPackinglistIfCharacs = new HashSet<CenPackinglistIfCharac>(0);
	private String characteristics;
	private String ctextMenuLang2;
	private String ctextMenuLang3;
	private boolean nchilled;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "npackinglistIndexKey", column = @Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "npackinglistDetailKey", column = @Column(name = "NPACKINGLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenPackinglistsId getId() {
		return this.id;
	}

	public void setId(CenPackinglistsId id) {
		this.id = id;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	public CenPackinglists getCenPackinglists() {
		return this.cenPackinglists;
	}

	public void setCenPackinglists(CenPackinglists cenPackinglists) {
		this.cenPackinglists = cenPackinglists;
	}

	@Column(name = "CORIGIN", length = 256)
	public String getCorigin() {
		return this.corigin;
	}

	public void setCorigin(String corigin) {
		this.corigin = corigin;
	}

	@Column(name = "NCATERER_KEY", precision = 12, scale = 0)
	public Long getNcatererKey() {
		return this.ncatererKey;
	}

	public void setNcatererKey(Long ncatererKey) {
		this.ncatererKey = ncatererKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglistIf")
	public Set<CenPackinglistIfCharac> getCenPackinglistIfCharacs() {
		return this.cenPackinglistIfCharacs;
	}

	public void setCenPackinglistIfCharacs(Set<CenPackinglistIfCharac> cenPackinglistIfCharacs) {
		this.cenPackinglistIfCharacs = cenPackinglistIfCharacs;
	}

	@Formula("("
			+ "SELECT listagg(plcs.ncharacteristic_key, ',') "
			+ "FROM cen_packinglist_if_charac plcs "
			+ "WHERE plcs.npackinglist_index_key = npackinglist_index_key and plcs.npackinglist_detail_key = npackinglist_detail_key"
			+ ")")
	@Basic(fetch = FetchType.EAGER)
	public String getCharacteristics() {
		return characteristics;
	}

	public void setCharacteristics(String characteristics) {
		this.characteristics = characteristics;
	}

	@Column(name = "CTEXT_MENU_LANG2", length = 1000)
	public String getCtextMenuLang2() {
		return this.ctextMenuLang2;
	}

	public void setCtextMenuLang2(final String ctextMenuLang2) {
		this.ctextMenuLang2 = ctextMenuLang2;
	}

	@Column(name = "CTEXT_MENU_LANG3", length = 1000)
	public String getCtextMenuLang3() {
		return this.ctextMenuLang3;
	}

	public void setCtextMenuLang3(final String ctextMenuLang3) {
		this.ctextMenuLang3 = ctextMenuLang3;
	}

	@Column(name = "NCHILLED", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public boolean getNchilled() {
		return this.nchilled;
	}

	public void setNchilled(final boolean nchilled) {
		this.nchilled = nchilled;
	}

}


