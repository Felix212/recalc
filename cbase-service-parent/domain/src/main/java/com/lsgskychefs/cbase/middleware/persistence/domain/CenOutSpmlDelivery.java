package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 15.10.2024 19:04:31 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_SPML_DELIVERY
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_SPML_DELIVERY")
public class CenOutSpmlDelivery implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nspmlDeliveryKey;
	private CenOutDeliveryNote cenOutDeliveryNote;
	private long nspmlKey;
	private String cclass;
	private String cspml;
	private String cname;
	private String caddText;
	private String cremark;
	private BigDecimal nquantity;
	private BigDecimal nquantityReceived;
	private long nmasterKey;
	private int nprio;
	private long nclassNumber;
	private Set<CenOutSpmlDetailDelivery> cenOutSpmlDetailDeliveries = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_SPML_DELIVERY")
	@SequenceGenerator(name = "SEQ_CEN_OUT_SPML_DELIVERY", sequenceName = "SEQ_CEN_OUT_SPML_DELIVERY", allocationSize = 1)
	@Column(name = "NSPML_DELIVERY_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNspmlDeliveryKey() {
		return this.nspmlDeliveryKey;
	}

	public void setNspmlDeliveryKey(long nspmlDeliveryKey) {
		this.nspmlDeliveryKey = nspmlDeliveryKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NRESULT_KEY", referencedColumnName = "NRESULT_KEY", nullable = false),
			@JoinColumn(name = "NTRANSACTION", referencedColumnName = "NTRANSACTION", nullable = false),
			@JoinColumn(name = "NNUMBER", referencedColumnName = "NNUMBER", nullable = false) })
	public CenOutDeliveryNote getCenOutDeliveryNote() {
		return this.cenOutDeliveryNote;
	}

	public void setCenOutDeliveryNote(CenOutDeliveryNote cenOutDeliveryNote) {
		this.cenOutDeliveryNote = cenOutDeliveryNote;
	}

	@Column(name = "NSPML_KEY", nullable = false, precision = 12, scale = 0)
	public long getNspmlKey() {
		return this.nspmlKey;
	}

	public void setNspmlKey(long nspmlKey) {
		this.nspmlKey = nspmlKey;
	}

	@Column(name = "CCLASS", nullable = false, length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "CSPML", nullable = false, length = 10)
	public String getCspml() {
		return this.cspml;
	}

	public void setCspml(String cspml) {
		this.cspml = cspml;
	}

	@Column(name = "CNAME", length = 40)
	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	@Column(name = "CADD_TEXT", nullable = false, length = 40)
	public String getCaddText() {
		return this.caddText;
	}

	public void setCaddText(String caddText) {
		this.caddText = caddText;
	}

	@Column(name = "CREMARK", nullable = false, length = 40)
	public String getCremark() {
		return this.cremark;
	}

	public void setCremark(String cremark) {
		this.cremark = cremark;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NQUANTITY_RECEIVED", precision = 12, scale = 3)
	public BigDecimal getNquantityReceived() {
		return this.nquantityReceived;
	}

	public void setNquantityReceived(BigDecimal nquantityReceived) {
		this.nquantityReceived = nquantityReceived;
	}

	@Column(name = "NMASTER_KEY", nullable = false, precision = 12, scale = 0)
	public long getNmasterKey() {
		return this.nmasterKey;
	}

	public void setNmasterKey(long nmasterKey) {
		this.nmasterKey = nmasterKey;
	}

	@Column(name = "NPRIO", nullable = false, precision = 6, scale = 0)
	public int getNprio() {
		return this.nprio;
	}

	public void setNprio(final int nprio) {
		this.nprio = nprio;
	}

	@Column(name = "NCLASS_NUMBER", nullable = false, precision = 12, scale = 0)
	public long getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final long nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutSpmlDelivery", cascade = CascadeType.ALL)
	public Set<CenOutSpmlDetailDelivery> getCenOutSpmlDetailDeliveries() {
		return this.cenOutSpmlDetailDeliveries;
	}

	public void setCenOutSpmlDetailDeliveries(Set<CenOutSpmlDetailDelivery> cenOutSpmlDetailDeliveries) {
		this.cenOutSpmlDetailDeliveries = cenOutSpmlDetailDeliveries;
	}

}


