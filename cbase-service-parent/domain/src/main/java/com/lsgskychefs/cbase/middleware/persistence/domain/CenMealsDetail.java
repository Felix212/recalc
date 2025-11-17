package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 25.08.2022 12:58:45 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.Date;

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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_MEALS_DETAIL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_MEALS_DETAIL")
public class CenMealsDetail implements DomainObject, java.io.Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

    private long nhandlingDetailKey;
    private CenMeals cenMeals;
    private CenPackinglistIndex cenPackinglistIndex;
    private CenRotationNames cenRotationNames;
    private long nrotationNameKey;
    private SysCalculator sysCalculator;
    private int nprio;
    private Date dvalidFrom;
    private Date dvalidTo;
    private String cmealControlCode;
    private String cproductionText;
    private int ncomponentGroup;
    private Long nforeignObject;
    private Integer nforeignGroup;
    private int npassengerGroup;
    private String cremark;
    private long naccountKey;
    private int nbillingStatus;
    private Long ncalcDetailKey;
    private int npercentage;
    private BigDecimal nvalue;
    private int nspmlDeduction;
    private int nacTransfer;
    private String careaHost;
    private String ceffortHost;
    private String cadditionalAccount;
    private Integer ndistribute;
    private Integer ndeliveryNote;
    private String cdeliverySnr;
    private String cdeliveryText;
    private Integer ncontrolling;
    private String cclasses;
    private Long nmopDetailKey;
    private Integer nmaxValue;
    private int nreplacetext;
    private String cupdatedBy;
    private Date dupdatedDate;
    private String cupdatedByPrev;
    private Date dupdatedDatePrev;
    private Long npackinglistIndexKeyL;
    private Integer nminValue;
    private Long npreorderKey;
    private Long ngridCategoryKey;
    private int ndynamicMeals;
    private String cdmCcustomerPl;
    private int ndmUseParent;
    private int npreorder;
    private BigDecimal ndmPercentage;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_MEALS_DETAIL")
    @SequenceGenerator(name = "SEQ_CEN_MEALS_DETAIL", sequenceName = "SEQ_CEN_MEALS_DETAIL", allocationSize = 1)
    @Column(name = "NHANDLING_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
    public long getNhandlingDetailKey() {
        return this.nhandlingDetailKey;
    }

    public void setNhandlingDetailKey(final long nhandlingDetailKey) {
        this.nhandlingDetailKey = nhandlingDetailKey;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NHANDLING_MEAL_KEY", nullable = false)
    public CenMeals getCenMeals() {
        return this.cenMeals;
    }

    public void setCenMeals(final CenMeals cenMeals) {
        this.cenMeals = cenMeals;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NPACKINGLIST_INDEX_KEY", nullable = false)
    public CenPackinglistIndex getCenPackinglistIndex() {
        return this.cenPackinglistIndex;
    }

    public void setCenPackinglistIndex(final CenPackinglistIndex cenPackinglistIndex) {
        this.cenPackinglistIndex = cenPackinglistIndex;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NROTATION_NAME_KEY", nullable = false)
    public CenRotationNames getCenRotationNames() {
        return this.cenRotationNames;
    }

    public void setCenRotationNames(final CenRotationNames cenRotationNames) {
        this.cenRotationNames = cenRotationNames;
    }

    
	@Column(name = "NROTATION_NAME_KEY", nullable = false, precision = 12, scale = 0, insertable = false, updatable = false)
	public long getNrotationNameKey() {
		return this.nrotationNameKey;
	}

	public void setNrotationNameKey(final long nrotationNameKey) {
		this.nrotationNameKey = nrotationNameKey;
	}

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NCALC_ID", nullable = false)
    public SysCalculator getSysCalculator() {
        return this.sysCalculator;
    }

    public void setSysCalculator(final SysCalculator sysCalculator) {
        this.sysCalculator = sysCalculator;
    }

    @Column(name = "NPRIO", nullable = false, precision = 6, scale = 0)
    public int getNprio() {
        return this.nprio;
    }

    public void setNprio(final int nprio) {
        this.nprio = nprio;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DVALID_FROM", nullable = false, length = 7)
    public Date getDvalidFrom() {
        return this.dvalidFrom;
    }

    public void setDvalidFrom(final Date dvalidFrom) {
        this.dvalidFrom = dvalidFrom;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DVALID_TO", nullable = false, length = 7)
    public Date getDvalidTo() {
        return this.dvalidTo;
    }

    public void setDvalidTo(final Date dvalidTo) {
        this.dvalidTo = dvalidTo;
    }

    @Column(name = "CMEAL_CONTROL_CODE", nullable = false, length = 4)
    public String getCmealControlCode() {
        return this.cmealControlCode;
    }

    public void setCmealControlCode(final String cmealControlCode) {
        this.cmealControlCode = cmealControlCode;
    }

    @Column(name = "CPRODUCTION_TEXT", nullable = false, length = 40)
    public String getCproductionText() {
        return this.cproductionText;
    }

    public void setCproductionText(final String cproductionText) {
        this.cproductionText = cproductionText;
    }

    @Column(name = "NCOMPONENT_GROUP", nullable = false, precision = 3, scale = 0)
    public int getNcomponentGroup() {
        return this.ncomponentGroup;
    }

    public void setNcomponentGroup(final int ncomponentGroup) {
        this.ncomponentGroup = ncomponentGroup;
    }

    @Column(name = "NFOREIGN_OBJECT", precision = 12, scale = 0)
    public Long getNforeignObject() {
        return this.nforeignObject;
    }

    public void setNforeignObject(final Long nforeignObject) {
        this.nforeignObject = nforeignObject;
    }

    @Column(name = "NFOREIGN_GROUP", precision = 3, scale = 0)
    public Integer getNforeignGroup() {
        return this.nforeignGroup;
    }

    public void setNforeignGroup(final Integer nforeignGroup) {
        this.nforeignGroup = nforeignGroup;
    }

    @Column(name = "NPASSENGER_GROUP", nullable = false, precision = 1, scale = 0)
    public int getNpassengerGroup() {
        return this.npassengerGroup;
    }

    public void setNpassengerGroup(final int npassengerGroup) {
        this.npassengerGroup = npassengerGroup;
    }

    @Column(name = "CREMARK", length = 40)
    public String getCremark() {
        return this.cremark;
    }

    public void setCremark(final String cremark) {
        this.cremark = cremark;
    }

    @Column(name = "NACCOUNT_KEY", nullable = false, precision = 12, scale = 0)
    public long getNaccountKey() {
        return this.naccountKey;
    }

    public void setNaccountKey(final long naccountKey) {
        this.naccountKey = naccountKey;
    }

    @Column(name = "NBILLING_STATUS", nullable = false, precision = 1, scale = 0)
    public int getNbillingStatus() {
        return this.nbillingStatus;
    }

    public void setNbillingStatus(final int nbillingStatus) {
        this.nbillingStatus = nbillingStatus;
    }

    @Column(name = "NCALC_DETAIL_KEY", precision = 12, scale = 0)
    public Long getNcalcDetailKey() {
        return this.ncalcDetailKey;
    }

    public void setNcalcDetailKey(final Long ncalcDetailKey) {
        this.ncalcDetailKey = ncalcDetailKey;
    }

    @Column(name = "NPERCENTAGE", nullable = false, precision = 3, scale = 0)
    public int getNpercentage() {
        return this.npercentage;
    }

    public void setNpercentage(final int npercentage) {
        this.npercentage = npercentage;
    }

    @Column(name = "NVALUE", nullable = false, precision = 12, scale = 3)
    public BigDecimal getNvalue() {
        return this.nvalue;
    }

    public void setNvalue(final BigDecimal nvalue) {
        this.nvalue = nvalue;
    }

    @Column(name = "NSPML_DEDUCTION", nullable = false, precision = 1, scale = 0)
    public int getNspmlDeduction() {
        return this.nspmlDeduction;
    }

    public void setNspmlDeduction(final int nspmlDeduction) {
        this.nspmlDeduction = nspmlDeduction;
    }

    @Column(name = "NAC_TRANSFER", nullable = false, precision = 1, scale = 0)
    public int getNacTransfer() {
        return this.nacTransfer;
    }

    public void setNacTransfer(final int nacTransfer) {
        this.nacTransfer = nacTransfer;
    }

    @Column(name = "CAREA_HOST", length = 3)
    public String getCareaHost() {
        return this.careaHost;
    }

    public void setCareaHost(final String careaHost) {
        this.careaHost = careaHost;
    }

    @Column(name = "CEFFORT_HOST", length = 2)
    public String getCeffortHost() {
        return this.ceffortHost;
    }

    public void setCeffortHost(final String ceffortHost) {
        this.ceffortHost = ceffortHost;
    }

    @Column(name = "CADDITIONAL_ACCOUNT", length = 18)
    public String getCadditionalAccount() {
        return this.cadditionalAccount;
    }

    public void setCadditionalAccount(final String cadditionalAccount) {
        this.cadditionalAccount = cadditionalAccount;
    }

    @Column(name = "NDISTRIBUTE", precision = 1, scale = 0)
    public Integer getNdistribute() {
        return this.ndistribute;
    }

    public void setNdistribute(final Integer ndistribute) {
        this.ndistribute = ndistribute;
    }

    @Column(name = "NDELIVERY_NOTE", precision = 1, scale = 0)
    public Integer getNdeliveryNote() {
        return this.ndeliveryNote;
    }

    public void setNdeliveryNote(final Integer ndeliveryNote) {
        this.ndeliveryNote = ndeliveryNote;
    }

    @Column(name = "CDELIVERY_SNR", length = 18)
    public String getCdeliverySnr() {
        return this.cdeliverySnr;
    }

    public void setCdeliverySnr(final String cdeliverySnr) {
        this.cdeliverySnr = cdeliverySnr;
    }

    @Column(name = "CDELIVERY_TEXT", length = 40)
    public String getCdeliveryText() {
        return this.cdeliveryText;
    }

    public void setCdeliveryText(final String cdeliveryText) {
        this.cdeliveryText = cdeliveryText;
    }

    @Column(name = "NCONTROLLING", precision = 1, scale = 0)
    public Integer getNcontrolling() {
        return this.ncontrolling;
    }

    public void setNcontrolling(final Integer ncontrolling) {
        this.ncontrolling = ncontrolling;
    }

    @Column(name = "CCLASSES", length = 40)
    public String getCclasses() {
        return this.cclasses;
    }

    public void setCclasses(final String cclasses) {
        this.cclasses = cclasses;
    }

    @Column(name = "NMOP_DETAIL_KEY", precision = 12, scale = 0)
    public Long getNmopDetailKey() {
        return this.nmopDetailKey;
    }

    public void setNmopDetailKey(final Long nmopDetailKey) {
        this.nmopDetailKey = nmopDetailKey;
    }

    @Column(name = "NMAX_VALUE", precision = 3, scale = 0)
    public Integer getNmaxValue() {
        return this.nmaxValue;
    }

    public void setNmaxValue(final Integer nmaxValue) {
        this.nmaxValue = nmaxValue;
    }

    @Column(name = "NREPLACETEXT", nullable = false, precision = 1, scale = 0)
    public int getNreplacetext() {
        return this.nreplacetext;
    }

    public void setNreplacetext(final int nreplacetext) {
        this.nreplacetext = nreplacetext;
    }

    @Column(name = "CUPDATED_BY", length = 40)
    public String getCupdatedBy() {
        return this.cupdatedBy;
    }

    public void setCupdatedBy(final String cupdatedBy) {
        this.cupdatedBy = cupdatedBy;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DUPDATED_DATE", length = 7)
    public Date getDupdatedDate() {
        return this.dupdatedDate;
    }

    public void setDupdatedDate(final Date dupdatedDate) {
        this.dupdatedDate = dupdatedDate;
    }

    @Column(name = "CUPDATED_BY_PREV", length = 40)
    public String getCupdatedByPrev() {
        return this.cupdatedByPrev;
    }

    public void setCupdatedByPrev(final String cupdatedByPrev) {
        this.cupdatedByPrev = cupdatedByPrev;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DUPDATED_DATE_PREV", length = 7)
    public Date getDupdatedDatePrev() {
        return this.dupdatedDatePrev;
    }

    public void setDupdatedDatePrev(final Date dupdatedDatePrev) {
        this.dupdatedDatePrev = dupdatedDatePrev;
    }

    @Column(name = "NPACKINGLIST_INDEX_KEY_L", precision = 12, scale = 0)
    public Long getNpackinglistIndexKeyL() {
        return this.npackinglistIndexKeyL;
    }

    public void setNpackinglistIndexKeyL(final Long npackinglistIndexKeyL) {
        this.npackinglistIndexKeyL = npackinglistIndexKeyL;
    }

    @Column(name = "NMIN_VALUE", precision = 3, scale = 0)
    public Integer getNminValue() {
        return this.nminValue;
    }

    public void setNminValue(final Integer nminValue) {
        this.nminValue = nminValue;
    }

    @Column(name = "NPREORDER_KEY", precision = 12, scale = 0)
    public Long getNpreorderKey() {
        return this.npreorderKey;
    }

    public void setNpreorderKey(final Long npreorderKey) {
        this.npreorderKey = npreorderKey;
    }

    @Column(name = "NGRID_CATEGORY_KEY", precision = 12, scale = 0)
    public Long getNgridCategoryKey() {
        return this.ngridCategoryKey;
    }

    public void setNgridCategoryKey(final Long ngridCategoryKey) {
        this.ngridCategoryKey = ngridCategoryKey;
    }

    @Column(name = "NDYNAMIC_MEALS", nullable = false, precision = 1, scale = 0)
    public int getNdynamicMeals() {
        return this.ndynamicMeals;
    }

    public void setNdynamicMeals(final int ndynamicMeals) {
        this.ndynamicMeals = ndynamicMeals;
    }

    @Column(name = "CDM_CCUSTOMER_PL", length = 36)
    public String getCdmCcustomerPl() {
        return this.cdmCcustomerPl;
    }

    public void setCdmCcustomerPl(final String cdmCcustomerPl) {
        this.cdmCcustomerPl = cdmCcustomerPl;
    }

    @Column(name = "NDM_USE_PARENT", nullable = false, precision = 1, scale = 0)
    public int getNdmUseParent() {
        return this.ndmUseParent;
    }

    public void setNdmUseParent(final int ndmUseParent) {
        this.ndmUseParent = ndmUseParent;
    }

    @Column(name = "NPREORDER", nullable = false, precision = 1, scale = 0)
    public int getNpreorder() {
        return this.npreorder;
    }

    public void setNpreorder(final int npreorder) {
        this.npreorder = npreorder;
    }

    @Column(name = "NDM_PERCENTAGE", precision = 12, scale = 3)
    public BigDecimal getNdmPercentage() {
        return this.ndmPercentage;
    }

    public void setNdmPercentage(final BigDecimal ndmPercentage) {
        this.ndmPercentage = ndmPercentage;
    }

}
