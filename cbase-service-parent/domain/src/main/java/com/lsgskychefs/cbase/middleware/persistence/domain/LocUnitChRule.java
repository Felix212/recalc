package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Feb 28, 2019 9:57:38 AM by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedStoredProcedureQueries;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.ParameterMode;
import javax.persistence.StoredProcedureParameter;
import javax.persistence.Table;

import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpGetPositionByRule;

/**
 * Entity(DomainObject) for table LOC_UNIT_CH_RULE
 * 
 * @author Hibernate Tools
 */
@NamedStoredProcedureQueries({
		@NamedStoredProcedureQuery(name = PpGetPositionByRule.PP_GET_POSITION_BY_RULE, procedureName = "CBASE_CHILLER."
				+ PpGetPositionByRule.PP_GET_POSITION_BY_RULE, parameters = {
						@StoredProcedureParameter(mode = ParameterMode.IN, name = PpGetPositionByRule.P_WAREHOUSE_KEY, type = Long.class),
						@StoredProcedureParameter(mode = ParameterMode.IN, name = PpGetPositionByRule.P_SCANNED_KEY, type = Long.class),
						@StoredProcedureParameter(mode = ParameterMode.IN, name = PpGetPositionByRule.P_LABEL_TYPE, type = Integer.class),
						@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpGetPositionByRule.P_STORAGE_BIN_KEY, type = Long.class)
				})

})

@Entity
@Table(name = "LOC_UNIT_CH_RULE")
public class LocUnitChRule implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nrulesKey;
	private LocUnitChWarehouse locUnitChWarehouse;
	private LocUnitChZone locUnitChZone;
	private String cunit;
	private long nairlineKey;
	private Long nclassNumber;
	private String ctimeFrom;
	private String ctimeTo;
	private Long npackinglistIndexKey;
	private Integer ncolumn;
	private Integer nrow;
	private String cplace;
	private Long nstorageBinKey;

	@Id
	@Column(name = "NRULES_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNrulesKey() {
		return this.nrulesKey;
	}

	public void setNrulesKey(final long nrulesKey) {
		this.nrulesKey = nrulesKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWAREHOUSE_KEY", nullable = false)
	public LocUnitChWarehouse getLocUnitChWarehouse() {
		return this.locUnitChWarehouse;
	}

	public void setLocUnitChWarehouse(final LocUnitChWarehouse locUnitChWarehouse) {
		this.locUnitChWarehouse = locUnitChWarehouse;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NZONE_KEY")
	public LocUnitChZone getLocUnitChZone() {
		return this.locUnitChZone;
	}

	public void setLocUnitChZone(final LocUnitChZone locUnitChZone) {
		this.locUnitChZone = locUnitChZone;
	}

	@Column(name = "CUNIT", length = 10)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNairlineKey() {
		return this.nairlineKey;
	}

	public void setNairlineKey(final long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	@Column(name = "NCLASS_NUMBER", precision = 12, scale = 0)
	public Long getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final Long nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "CTIME_FROM", length = 5)
	public String getCtimeFrom() {
		return this.ctimeFrom;
	}

	public void setCtimeFrom(final String ctimeFrom) {
		this.ctimeFrom = ctimeFrom;
	}

	@Column(name = "CTIME_TO", length = 5)
	public String getCtimeTo() {
		return this.ctimeTo;
	}

	public void setCtimeTo(final String ctimeTo) {
		this.ctimeTo = ctimeTo;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", precision = 12, scale = 0)
	public Long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final Long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "NCOLUMN", precision = 5, scale = 0)
	public Integer getNcolumn() {
		return this.ncolumn;
	}

	public void setNcolumn(final Integer ncolumn) {
		this.ncolumn = ncolumn;
	}

	@Column(name = "NROW", precision = 5, scale = 0)
	public Integer getNrow() {
		return this.nrow;
	}

	public void setNrow(final Integer nrow) {
		this.nrow = nrow;
	}

	@Column(name = "CPLACE", length = 10)
	public String getCplace() {
		return this.cplace;
	}

	public void setCplace(final String cplace) {
		this.cplace = cplace;
	}

	@Column(name = "NSTORAGE_BIN_KEY", precision = 12, scale = 0)
	public Long getNstorageBinKey() {
		return this.nstorageBinKey;
	}

	public void setNstorageBinKey(final Long nstorageBinKey) {
		this.nstorageBinKey = nstorageBinKey;
	}

}
