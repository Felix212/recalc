package com.lsgskychefs.cbase.middleware.persistence.domain;

import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.NamedEntityGraphs;
import javax.persistence.NamedSubgraph;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import com.lsgskychefs.cbase.middleware.persistence.constant.mypa.ReturnCountingScanOrder;
import com.lsgskychefs.cbase.middleware.persistence.constant.mypa.ReturnCountingStatus;

@Entity
@Table(name = "CEN_OUT_PPM_BOB_RC")
@NamedEntityGraphs({
		@NamedEntityGraph(name = "rc.detail", attributeNodes = {
				@NamedAttributeNode(value = "cenOutPpmBobRcDetails", subgraph = "rc.detail.ppmcontainer")
		}, subgraphs = {
				@NamedSubgraph(name = "rc.detail.ppmcontainer", attributeNodes = {
						@NamedAttributeNode(value = "cenOutPpmBobContainer", subgraph = "rc.detail.ppmcontainer.details")
				}),
				@NamedSubgraph(name = "rc.detail.ppmcontainer.details", attributeNodes = {
						@NamedAttributeNode(value = "cenBobContainerStatus"),
						@NamedAttributeNode(value = "cenBobContainer", subgraph = "rc.detail.ppmcontainer.details.recursive"),
						@NamedAttributeNode(value = "cenPackinglistIndex")
				}),
				@NamedSubgraph(name = "rc.detail.ppmcontainer.details.recursive", attributeNodes = {
						@NamedAttributeNode(value = "cenBobContainerStatus"),
						@NamedAttributeNode(value = "cenBobContainer"),
						@NamedAttributeNode(value = "cenPackinglistIndex")

				})
		})
})
public class CenOutPpmBobRc implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_BOB_RC")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_BOB_RC", sequenceName = "SEQ_CEN_OUT_PPM_BOB_RC", allocationSize = 1)
	@Column(name = "NCOP_BOB_RC_KEY", nullable = false)
	private Long ncopBobRcKey;

	@NotNull
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@OnDelete(action = OnDeleteAction.CASCADE)
	@JoinColumn(name = "NWORKSTATION_KEY", nullable = false)
	private LocUnitWorkstation workstation;

	@NotNull
	@Column(name = "NSCAN_ORDER", nullable = false, columnDefinition = "NUMBER(1) DEFAULT 0")
	private int nscanOrder;

	@NotNull
	@Column(name = "NSTATUS", nullable = false, columnDefinition = "NUMBER(1) DEFAULT 0")
	private int nstatus;

	@Size(max = 40)
	@NotNull
	@Column(name = "CUSER", nullable = false, length = 40)
	private String cuser;

	@NotNull
	@Column(name = "DTIMESTAMP", nullable = false)
	private Date dtimestamp;

	@OneToMany(mappedBy = "cenOutPpmBobRc")
	private Set<CenOutPpmBobRcDetail> cenOutPpmBobRcDetails = new LinkedHashSet<>();

	public CenOutPpmBobRc() {

	}

	public CenOutPpmBobRc(final LocUnitWorkstation workstation, final ReturnCountingScanOrder scanOrder, final String username,
			final Date timestamp) {
		this.workstation = workstation;
		this.nscanOrder = scanOrder.getScanOrderValue();
		this.cuser = username;
		this.dtimestamp = timestamp;
		this.nstatus = ReturnCountingStatus.NEW.getStatusValue();
	}

	public Long getNcopBobRcKey() {
		return ncopBobRcKey;
	}

	public void setNcopBobRcKey(Long ncopBobRcKey) {
		this.ncopBobRcKey = ncopBobRcKey;
	}

	public LocUnitWorkstation getWorkstation() {
		return workstation;
	}

	public void setWorkstation(LocUnitWorkstation workstation) {
		this.workstation = workstation;
	}

	public int getNscanOrder() {
		return nscanOrder;
	}

	public void setNscanOrder(int nscanOrder) {
		this.nscanOrder = nscanOrder;
	}

	public int getNstatus() {
		return nstatus;
	}

	public void setNstatus(int nstatus) {
		this.nstatus = nstatus;
	}

	public String getCuser() {
		return cuser;
	}

	public void setCuser(String cuser) {
		this.cuser = cuser;
	}

	public Date getDtimestamp() {
		return dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	public Set<CenOutPpmBobRcDetail> getCenOutPpmBobRcDetails() {
		return cenOutPpmBobRcDetails;
	}

	public void setCenOutPpmBobRcDetails(
			Set<CenOutPpmBobRcDetail> cenOutPpmBobRcDetails) {
		this.cenOutPpmBobRcDetails = cenOutPpmBobRcDetails;
	}

}
