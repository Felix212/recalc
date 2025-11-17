package com.lsgskychefs.cbase.middleware.persistence.domain;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.NamedEntityGraphs;
import javax.persistence.NamedSubgraph;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "SYS_UNITS_CATERER")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@NamedEntityGraphs({
		@NamedEntityGraph(name = "outstationUnit", attributeNodes = {
				@NamedAttributeNode(value = "sysUnits", subgraph = "outstationUnit.details"),
				@NamedAttributeNode(value = "locUnitCatererDocumentUploads")
		}, subgraphs = {
				@NamedSubgraph(name = "outstationUnit.details", attributeNodes = {
						@NamedAttributeNode(value = "cenSupplier"),
						@NamedAttributeNode(value = "sysThreeLetterCodes")
				})
		})
})
public class SysUnitsCaterer implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private String cunit;
	private SysUnits sysUnits;
	private Long ncatererKey;
	/** Back reference not possible for now, this entity needs to move to main domain module than ... */
	@JsonIgnore
	private Set<LocUnitCatererdocumentUpload> locUnitCatererDocumentUploads = new HashSet<LocUnitCatererdocumentUpload>(0);

	//private int documentUploadCount = 0;

	@Id
	@GenericGenerator(name = "generator", strategy = "foreign", parameters = @Parameter(name = "property", value = "sysUnits"))
	@GeneratedValue(generator = "generator")
	@Column(name = "CUNIT", unique = true, nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(String cunit) {
		this.cunit = cunit;
	}

	@OneToOne(fetch = FetchType.LAZY) @PrimaryKeyJoinColumn
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@Column(name = "NCATERER_KEY", nullable = false, precision = 12)
	public Long getNcatererKey() {
		return ncatererKey;
	}

	public void setNcatererKey(final Long ncatererKey) {
		this.ncatererKey = ncatererKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysUnitsCaterer")
	public Set<LocUnitCatererdocumentUpload> getLocUnitCatererDocumentUploads() {
		return this.locUnitCatererDocumentUploads;
	}

	public void setLocUnitCatererDocumentUploads(Set<LocUnitCatererdocumentUpload> locUnitCatererDocumentUploads) {
		this.locUnitCatererDocumentUploads = locUnitCatererDocumentUploads;
	}
/*
	@Formula("("
			+ "SELECT count(*) "
			+ "FROM loc_unit_caterer_document_upload caterer_docs "
			+ "WHERE caterer_docs.cunit = cunit"
			+ ")")
	@Basic(fetch = FetchType.EAGER)
	public int getDocumentUploadCount() {
		return documentUploadCount;
	}

	public void setDocumentUploadCount(int documentUploadCount) {
		this.documentUploadCount = documentUploadCount;
	}*/
}
