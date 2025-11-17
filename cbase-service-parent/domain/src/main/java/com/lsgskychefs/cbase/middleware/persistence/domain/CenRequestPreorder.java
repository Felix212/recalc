package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Aug 6, 2020 9:25:20 AM by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
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

/**
 * Entity(DomainObject) for table CEN_REQUEST_PREORDER
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_REQUEST_PREORDER")
public class CenRequestPreorder
		implements com.lsgskychefs.cbase.middleware.persistence.domain.DomainObject, java.io.Serializable {

	private long nreqPreorderKey;
	private CenRequestFlight cenRequestFlight;
	private int nclassNumber;
	private String cclass;
	private String ccustomerPl;
	private BigDecimal nquantity;
	private Long npackinglistIndexKey;
	private Long npackinglistDetailKey;
	private String cpackinglist;

	@Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_REQUEST_PREORDER")
    @SequenceGenerator(name = "SEQ_CEN_REQUEST_PREORDER", sequenceName = "SEQ_CEN_REQUEST_PREORDER", allocationSize = 1)
	@Column(name = "NREQ_PREORDER_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNreqPreorderKey() {
		return this.nreqPreorderKey;
	}

	public void setNreqPreorderKey(long nreqPreorderKey) {
		this.nreqPreorderKey = nreqPreorderKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NREQ_FLIGHT_KEY", nullable = false)
	public CenRequestFlight getCenRequestFlight() {
		return this.cenRequestFlight;
	}

	public void setCenRequestFlight(CenRequestFlight cenRequestFlight) {
		this.cenRequestFlight = cenRequestFlight;
	}

	@Column(name = "NCLASS_NUMBER", nullable = false, precision = 6, scale = 0)
	public int getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(int nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "CCLASS", nullable = false, length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "CCUSTOMER_PL", nullable = false, length = 36)
	public String getCcustomerPl() {
		return this.ccustomerPl;
	}

	public void setCcustomerPl(String ccustomerPl) {
		this.ccustomerPl = ccustomerPl;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", precision = 12, scale = 0)
	public Long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(Long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "NPACKINGLIST_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNpackinglistDetailKey() {
		return this.npackinglistDetailKey;
	}

	public void setNpackinglistDetailKey(Long npackinglistDetailKey) {
		this.npackinglistDetailKey = npackinglistDetailKey;
	}

	@Column(name = "CPACKINGLIST", length = 18)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

}
