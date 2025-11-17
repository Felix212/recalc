package com.lsgskychefs.cbase.middleware.persistence.domain;

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
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "CEN_OUT_PPM_BOB_RC_DETAIL")
public class CenOutPpmBobRcDetail implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_BOB_RC_DETAIL")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_BOB_RC_DETAIL", sequenceName = "SEQ_CEN_OUT_PPM_BOB_RC_DETAIL", allocationSize = 1)
	@Column(name = "NCOP_BOB_RC_DETAIL_KEY", nullable = false)
	private Long ncopBobRcDetailKey;

	@NotNull
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@OnDelete(action = OnDeleteAction.CASCADE)
	@JoinColumn(name = "NCOP_BOB_RC_KEY", nullable = false)
	private CenOutPpmBobRc cenOutPpmBobRc;

	@NotNull
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@OnDelete(action = OnDeleteAction.CASCADE)
	@JoinColumn(name = "NCOP_BOB_CONTAINER_KEY", nullable = false)
	private CenOutPpmBobContainer cenOutPpmBobContainer;

	@NotNull
	@Column(name = "NSORT", nullable = false)
	private int nsort;

	public CenOutPpmBobRcDetail() {

	}

	public CenOutPpmBobRcDetail(final CenOutPpmBobRc cenOutPpmBobRc, final CenOutPpmBobContainer cenOutPpmBobContainer) {
		this.cenOutPpmBobRc = cenOutPpmBobRc;
		this.cenOutPpmBobContainer = cenOutPpmBobContainer;
		this.nsort = cenOutPpmBobRc.getCenOutPpmBobRcDetails().size() + 1;
	}

	public Long getNcopBobRcDetailKey() {
		return ncopBobRcDetailKey;
	}

	public void setNcopBobRcDetailKey(Long ncopBobRcDetailKey) {
		this.ncopBobRcDetailKey = ncopBobRcDetailKey;
	}

	public CenOutPpmBobRc getCenOutPpmBobRc() {
		return cenOutPpmBobRc;
	}

	public void setCenOutPpmBobRc(CenOutPpmBobRc cenOutPpmBobRc) {
		this.cenOutPpmBobRc = cenOutPpmBobRc;
	}

	public CenOutPpmBobContainer getCenOutPpmBobContainer() {
		return cenOutPpmBobContainer;
	}

	public void setCenOutPpmBobContainer(CenOutPpmBobContainer cenOutPpmBobContainer) {
		this.cenOutPpmBobContainer = cenOutPpmBobContainer;
	}

	public int getNsort() {
		return nsort;
	}

	public void setNsort(int nsort) {
		this.nsort = nsort;
	}
}
