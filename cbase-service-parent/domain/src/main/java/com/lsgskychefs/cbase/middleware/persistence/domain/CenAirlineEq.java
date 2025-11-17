package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Aug 23, 2023 3:57:49 PM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_AIRLINE_EQ
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRLINE_EQ"
		, uniqueConstraints = @UniqueConstraint(columnNames = { "NAIRLINE_KEY", "CUNIT" })
)
public class CenAirlineEq implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nequipmentKey;
	private long nairlineKey;
	private String cunit;
	private String ctext;
	private int ncolumns;
	private int nrows;
	private int ntype;
	private Integer ntripticket;
	private Integer nforcePrint;
	private Set<CenPackinglistLayout> cenPackinglistLayouts = new HashSet<>(0);

	@Id
	@Column(name = "NEQUIPMENT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNequipmentKey() {
		return this.nequipmentKey;
	}

	public void setNequipmentKey(long nequipmentKey) {
		this.nequipmentKey = nequipmentKey;
	}

	@Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNairlineKey() {
		return this.nairlineKey;
	}

	public void setNairlineKey(long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	@Column(name = "CUNIT", nullable = false, length = 5)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NCOLUMNS", nullable = false, precision = 6, scale = 0)
	public int getNcolumns() {
		return this.ncolumns;
	}

	public void setNcolumns(int ncolumns) {
		this.ncolumns = ncolumns;
	}

	@Column(name = "NROWS", nullable = false, precision = 6, scale = 0)
	public int getNrows() {
		return this.nrows;
	}

	public void setNrows(int nrows) {
		this.nrows = nrows;
	}

	@Column(name = "NTYPE", nullable = false, precision = 1, scale = 0)
	public int getNtype() {
		return this.ntype;
	}

	public void setNtype(int ntype) {
		this.ntype = ntype;
	}

	@Column(name = "NTRIPTICKET", precision = 1, scale = 0)
	public Integer getNtripticket() {
		return this.ntripticket;
	}

	public void setNtripticket(Integer ntripticket) {
		this.ntripticket = ntripticket;
	}

	@Column(name = "NFORCE_PRINT", precision = 1, scale = 0)
	public Integer getNforcePrint() {
		return this.nforcePrint;
	}

	public void setNforcePrint(Integer nforcePrint) {
		this.nforcePrint = nforcePrint;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlineEq")
	public Set<CenPackinglistLayout> getCenPackinglistLayouts() {
		return this.cenPackinglistLayouts;
	}

	public void setCenPackinglistLayouts(Set<CenPackinglistLayout> cenPackinglistLayouts) {
		this.cenPackinglistLayouts = cenPackinglistLayouts;
	}

}


