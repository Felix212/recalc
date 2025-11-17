package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jun 2, 2025 3:31:31 PM by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_PACKINGLIST_IF_CHARAC
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PACKINGLIST_IF_CHARAC"
)
public class CenPackinglistIfCharac implements DomainObject, java.io.Serializable {

	private long npackinglistCharacKey;
	private CenPackinglistIf cenPackinglistIf;
	private long ncharacteristicKey;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_PACKINGLIST_IF_CHARAC")
	@SequenceGenerator(name = "SEQ_CEN_PACKINGLIST_IF_CHARAC", sequenceName = "SEQ_CEN_PACKINGLIST_IF_CHARAC", allocationSize = 1)
	@Column(name = "NPACKINGLIST_CHARAC_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNpackinglistCharacKey() {
		return this.npackinglistCharacKey;
	}

	public void setNpackinglistCharacKey(long npackinglistCharacKey) {
		this.npackinglistCharacKey = npackinglistCharacKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", referencedColumnName = "NPACKINGLIST_INDEX_KEY", nullable = false),
			@JoinColumn(name = "NPACKINGLIST_DETAIL_KEY", referencedColumnName = "NPACKINGLIST_DETAIL_KEY", nullable = false) })
	public CenPackinglistIf getCenPackinglistIf() {
		return this.cenPackinglistIf;
	}

	public void setCenPackinglistIf(CenPackinglistIf cenPackinglistIf) {
		this.cenPackinglistIf = cenPackinglistIf;
	}

	@Column(name = "NCHARACTERISTIC_KEY", nullable = false, precision = 12, scale = 0)
	public long getNcharacteristicKey() {
		return this.ncharacteristicKey;
	}

	public void setNcharacteristicKey(long ncharacteristicKey) {
		this.ncharacteristicKey = ncharacteristicKey;
	}

}


