package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table SYS_QUEUE_BATCH_DETAIL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_QUEUE_BATCH_DETAIL")
public class SysQueueBatchDetail implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long ndetailKey;
	private SysQueueBatch sysQueueBatch;
	private Long nsourceKey1;
	private Long nsourceKey2;
	private Long nsourceKey3;
	private Long nsourceKey4;
	private Long nsourceKey5;
	private Long nsourceKey6;
	private Long nsourceKey7;
	private Long nsourceKey8;
	private Long nsourceKey9;
	private String csourceText1;
	private String csourceText2;
	private String csourceText3;
	private String csourceText4;
	private String csourceText5;
	private String csourceText6;
	private String csourceText7;
	private String csourceText8;
	private String csourceText9;
	private Date dsourceDate1;
	private Date dsourceDate2;
	private Date dsourceDate3;
	private Date dsourceDate4;
	private Date dsourceDate5;
	private BigDecimal nsourceNumber1;
	private BigDecimal nsourceNumber2;
	private BigDecimal nsourceNumber3;
	private Set<SysQueueBatchSubdetail> sysQueueBatchSubdetails = new HashSet<>(0);

	public SysQueueBatchDetail() {
	}

	public SysQueueBatchDetail(final long ndetailKey, final SysQueueBatch sysQueueBatch) {
		this.ndetailKey = ndetailKey;
		this.sysQueueBatch = sysQueueBatch;
	}

	public SysQueueBatchDetail(final long ndetailKey, final SysQueueBatch sysQueueBatch, final Long nsourceKey1, final Long nsourceKey2,
			final Long nsourceKey3, final Long nsourceKey4, final Long nsourceKey5, final Long nsourceKey6, final Long nsourceKey7,
			final Long nsourceKey8, final Long nsourceKey9, final String csourceText1, final String csourceText2, final String csourceText3,
			final String csourceText4, final String csourceText5, final String csourceText6, final String csourceText7,
			final String csourceText8, final String csourceText9, final Date dsourceDate1, final Date dsourceDate2, final Date dsourceDate3,
			final Date dsourceDate4, final Date dsourceDate5, final BigDecimal nsourceNumber1, final BigDecimal nsourceNumber2,
			final BigDecimal nsourceNumber3, final Set<SysQueueBatchSubdetail> sysQueueBatchSubdetails) {
		this.ndetailKey = ndetailKey;
		this.sysQueueBatch = sysQueueBatch;
		this.nsourceKey1 = nsourceKey1;
		this.nsourceKey2 = nsourceKey2;
		this.nsourceKey3 = nsourceKey3;
		this.nsourceKey4 = nsourceKey4;
		this.nsourceKey5 = nsourceKey5;
		this.nsourceKey6 = nsourceKey6;
		this.nsourceKey7 = nsourceKey7;
		this.nsourceKey8 = nsourceKey8;
		this.nsourceKey9 = nsourceKey9;
		this.csourceText1 = csourceText1;
		this.csourceText2 = csourceText2;
		this.csourceText3 = csourceText3;
		this.csourceText4 = csourceText4;
		this.csourceText5 = csourceText5;
		this.csourceText6 = csourceText6;
		this.csourceText7 = csourceText7;
		this.csourceText8 = csourceText8;
		this.csourceText9 = csourceText9;
		this.dsourceDate1 = dsourceDate1;
		this.dsourceDate2 = dsourceDate2;
		this.dsourceDate3 = dsourceDate3;
		this.dsourceDate4 = dsourceDate4;
		this.dsourceDate5 = dsourceDate5;
		this.nsourceNumber1 = nsourceNumber1;
		this.nsourceNumber2 = nsourceNumber2;
		this.nsourceNumber3 = nsourceNumber3;
		this.sysQueueBatchSubdetails = sysQueueBatchSubdetails;
	}

	@Id

	@Column(name = "NDETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdetailKey() {
		return this.ndetailKey;
	}

	public void setNdetailKey(final long ndetailKey) {
		this.ndetailKey = ndetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NJOB_NR", nullable = false)
	public SysQueueBatch getSysQueueBatch() {
		return this.sysQueueBatch;
	}

	public void setSysQueueBatch(final SysQueueBatch sysQueueBatch) {
		this.sysQueueBatch = sysQueueBatch;
	}

	@Column(name = "NSOURCE_KEY1", precision = 12, scale = 0)
	public Long getNsourceKey1() {
		return this.nsourceKey1;
	}

	public void setNsourceKey1(final Long nsourceKey1) {
		this.nsourceKey1 = nsourceKey1;
	}

	@Column(name = "NSOURCE_KEY2", precision = 12, scale = 0)
	public Long getNsourceKey2() {
		return this.nsourceKey2;
	}

	public void setNsourceKey2(final Long nsourceKey2) {
		this.nsourceKey2 = nsourceKey2;
	}

	@Column(name = "NSOURCE_KEY3", precision = 12, scale = 0)
	public Long getNsourceKey3() {
		return this.nsourceKey3;
	}

	public void setNsourceKey3(final Long nsourceKey3) {
		this.nsourceKey3 = nsourceKey3;
	}

	@Column(name = "NSOURCE_KEY4", precision = 12, scale = 0)
	public Long getNsourceKey4() {
		return this.nsourceKey4;
	}

	public void setNsourceKey4(final Long nsourceKey4) {
		this.nsourceKey4 = nsourceKey4;
	}

	@Column(name = "NSOURCE_KEY5", precision = 12, scale = 0)
	public Long getNsourceKey5() {
		return this.nsourceKey5;
	}

	public void setNsourceKey5(final Long nsourceKey5) {
		this.nsourceKey5 = nsourceKey5;
	}

	@Column(name = "NSOURCE_KEY6", precision = 12, scale = 0)
	public Long getNsourceKey6() {
		return this.nsourceKey6;
	}

	public void setNsourceKey6(final Long nsourceKey6) {
		this.nsourceKey6 = nsourceKey6;
	}

	@Column(name = "NSOURCE_KEY7", precision = 12, scale = 0)
	public Long getNsourceKey7() {
		return this.nsourceKey7;
	}

	public void setNsourceKey7(final Long nsourceKey7) {
		this.nsourceKey7 = nsourceKey7;
	}

	@Column(name = "NSOURCE_KEY8", precision = 12, scale = 0)
	public Long getNsourceKey8() {
		return this.nsourceKey8;
	}

	public void setNsourceKey8(final Long nsourceKey8) {
		this.nsourceKey8 = nsourceKey8;
	}

	@Column(name = "NSOURCE_KEY9", precision = 12, scale = 0)
	public Long getNsourceKey9() {
		return this.nsourceKey9;
	}

	public void setNsourceKey9(final Long nsourceKey9) {
		this.nsourceKey9 = nsourceKey9;
	}

	@Column(name = "CSOURCE_TEXT1", length = 80)
	public String getCsourceText1() {
		return this.csourceText1;
	}

	public void setCsourceText1(final String csourceText1) {
		this.csourceText1 = csourceText1;
	}

	@Column(name = "CSOURCE_TEXT2", length = 80)
	public String getCsourceText2() {
		return this.csourceText2;
	}

	public void setCsourceText2(final String csourceText2) {
		this.csourceText2 = csourceText2;
	}

	@Column(name = "CSOURCE_TEXT3", length = 80)
	public String getCsourceText3() {
		return this.csourceText3;
	}

	public void setCsourceText3(final String csourceText3) {
		this.csourceText3 = csourceText3;
	}

	@Column(name = "CSOURCE_TEXT4", length = 80)
	public String getCsourceText4() {
		return this.csourceText4;
	}

	public void setCsourceText4(final String csourceText4) {
		this.csourceText4 = csourceText4;
	}

	@Column(name = "CSOURCE_TEXT5", length = 80)
	public String getCsourceText5() {
		return this.csourceText5;
	}

	public void setCsourceText5(final String csourceText5) {
		this.csourceText5 = csourceText5;
	}

	@Column(name = "CSOURCE_TEXT6", length = 80)
	public String getCsourceText6() {
		return this.csourceText6;
	}

	public void setCsourceText6(final String csourceText6) {
		this.csourceText6 = csourceText6;
	}

	@Column(name = "CSOURCE_TEXT7", length = 80)
	public String getCsourceText7() {
		return this.csourceText7;
	}

	public void setCsourceText7(final String csourceText7) {
		this.csourceText7 = csourceText7;
	}

	@Column(name = "CSOURCE_TEXT8", length = 80)
	public String getCsourceText8() {
		return this.csourceText8;
	}

	public void setCsourceText8(final String csourceText8) {
		this.csourceText8 = csourceText8;
	}

	@Column(name = "CSOURCE_TEXT9", length = 80)
	public String getCsourceText9() {
		return this.csourceText9;
	}

	public void setCsourceText9(final String csourceText9) {
		this.csourceText9 = csourceText9;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSOURCE_DATE1", length = 7)
	public Date getDsourceDate1() {
		return this.dsourceDate1;
	}

	public void setDsourceDate1(final Date dsourceDate1) {
		this.dsourceDate1 = dsourceDate1;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSOURCE_DATE2", length = 7)
	public Date getDsourceDate2() {
		return this.dsourceDate2;
	}

	public void setDsourceDate2(final Date dsourceDate2) {
		this.dsourceDate2 = dsourceDate2;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSOURCE_DATE3", length = 7)
	public Date getDsourceDate3() {
		return this.dsourceDate3;
	}

	public void setDsourceDate3(final Date dsourceDate3) {
		this.dsourceDate3 = dsourceDate3;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSOURCE_DATE4", length = 7)
	public Date getDsourceDate4() {
		return this.dsourceDate4;
	}

	public void setDsourceDate4(final Date dsourceDate4) {
		this.dsourceDate4 = dsourceDate4;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSOURCE_DATE5", length = 7)
	public Date getDsourceDate5() {
		return this.dsourceDate5;
	}

	public void setDsourceDate5(final Date dsourceDate5) {
		this.dsourceDate5 = dsourceDate5;
	}

	@Column(name = "NSOURCE_NUMBER1", precision = 12, scale = 3)
	public BigDecimal getNsourceNumber1() {
		return this.nsourceNumber1;
	}

	public void setNsourceNumber1(final BigDecimal nsourceNumber1) {
		this.nsourceNumber1 = nsourceNumber1;
	}

	@Column(name = "NSOURCE_NUMBER2", precision = 12, scale = 3)
	public BigDecimal getNsourceNumber2() {
		return this.nsourceNumber2;
	}

	public void setNsourceNumber2(final BigDecimal nsourceNumber2) {
		this.nsourceNumber2 = nsourceNumber2;
	}

	@Column(name = "NSOURCE_NUMBER3", precision = 12, scale = 3)
	public BigDecimal getNsourceNumber3() {
		return this.nsourceNumber3;
	}

	public void setNsourceNumber3(final BigDecimal nsourceNumber3) {
		this.nsourceNumber3 = nsourceNumber3;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysQueueBatchDetail")
	public Set<SysQueueBatchSubdetail> getSysQueueBatchSubdetails() {
		return this.sysQueueBatchSubdetails;
	}

	public void setSysQueueBatchSubdetails(final Set<SysQueueBatchSubdetail> sysQueueBatchSubdetails) {
		this.sysQueueBatchSubdetails = sysQueueBatchSubdetails;
	}

}
