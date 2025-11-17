package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.10.2016 11:20:34 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_SLS_SUPPLIER
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SLS_SUPPLIER")
public class SysSlsSupplier implements DomainObject, java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private long nsupplierKey;
	private String cname;
	private byte[] bpicture;
	private Set<CenSlsConcept> cenSlsConceptses = new HashSet<>(0);

	@Id

	@Column(name = "NSUPPLIER_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNsupplierKey() {
		return this.nsupplierKey;
	}

	public void setNsupplierKey(final long nsupplierKey) {
		this.nsupplierKey = nsupplierKey;
	}

	@Column(name = "CNAME", nullable = false, length = 40)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "BPICTURE")
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(final byte[] bpicture) {
		this.bpicture = bpicture;
	}

	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "sysSlsSuppliers")
	public Set<CenSlsConcept> getCenSlsConceptses() {
		return this.cenSlsConceptses;
	}

	public void setCenSlsConceptses(final Set<CenSlsConcept> cenSlsConceptses) {
		this.cenSlsConceptses = cenSlsConceptses;
	}

}
