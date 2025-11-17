package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 03.09.2019 12:54:15 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
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
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_AIRLINE_ACCOUNTS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRLINE_ACCOUNTS", uniqueConstraints = @UniqueConstraint(columnNames = { "NAIRLINE_KEY", "CACCOUNT" }))
public class CenAirlineAccounts implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long naccountKey;

	private CenAirlines cenAirlines;

	private String caccount;

	private String ctext;

	private Integer ndefault;

	private Integer nnoArisPriceTransfer;

	private String csapCode;

	private Integer nceckAc2;

	private Integer nnoAc2;

	private int nsalesBomRelevant;

	private Set<CenPackinglists> cenPackinglistses = new HashSet<>(0);

	private Set<CenHandling> cenHandlings = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_AIRLINE_ACCOUNTS")
	@SequenceGenerator(name = "SEQ_CEN_AIRLINE_ACCOUNTS", sequenceName = "SEQ_CEN_AIRLINE_ACCOUNTS", allocationSize = 1)
	@Column(name = "NACCOUNT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNaccountKey() {
		return this.naccountKey;
	}

	public void setNaccountKey(final long naccountKey) {
		this.naccountKey = naccountKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "CACCOUNT", nullable = false, length = 18)
	public String getCaccount() {
		return this.caccount;
	}

	public void setCaccount(final String caccount) {
		this.caccount = caccount;
	}

	@Column(name = "CTEXT", nullable = false, length = 84)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NDEFAULT", precision = 1, scale = 0)
	public Integer getNdefault() {
		return this.ndefault;
	}

	public void setNdefault(final Integer ndefault) {
		this.ndefault = ndefault;
	}

	@Column(name = "NNO_ARIS_PRICE_TRANSFER", precision = 2, scale = 0)
	public Integer getNnoArisPriceTransfer() {
		return this.nnoArisPriceTransfer;
	}

	public void setNnoArisPriceTransfer(final Integer nnoArisPriceTransfer) {
		this.nnoArisPriceTransfer = nnoArisPriceTransfer;
	}

	@Column(name = "CSAP_CODE", length = 40)
	public String getCsapCode() {
		return this.csapCode;
	}

	public void setCsapCode(final String csapCode) {
		this.csapCode = csapCode;
	}

	@Column(name = "NCECK_AC_2", precision = 1, scale = 0)
	public Integer getNceckAc2() {
		return this.nceckAc2;
	}

	public void setNceckAc2(final Integer nceckAc2) {
		this.nceckAc2 = nceckAc2;
	}

	@Column(name = "NNO_AC_2", precision = 1, scale = 0)
	public Integer getNnoAc2() {
		return this.nnoAc2;
	}

	public void setNnoAc2(final Integer nnoAc2) {
		this.nnoAc2 = nnoAc2;
	}

	@Column(name = "NSALES_BOM_RELEVANT", nullable = false, precision = 1, scale = 0)
	public int getNsalesBomRelevant() {
		return this.nsalesBomRelevant;
	}

	public void setNsalesBomRelevant(final int nsalesBomRelevant) {
		this.nsalesBomRelevant = nsalesBomRelevant;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlineAccounts")
	public Set<CenPackinglists> getCenPackinglistses() {
		return this.cenPackinglistses;
	}

	public void setCenPackinglistses(final Set<CenPackinglists> cenPackinglistses) {
		this.cenPackinglistses = cenPackinglistses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAirlineAccounts")
	public Set<CenHandling> getCenHandlings() {
		return this.cenHandlings;
	}

	public void setCenHandlings(final Set<CenHandling> cenHandlings) {
		this.cenHandlings = cenHandlings;
	}

}
