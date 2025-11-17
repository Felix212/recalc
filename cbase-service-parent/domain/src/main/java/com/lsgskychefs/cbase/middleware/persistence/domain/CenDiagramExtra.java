package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated May 3, 2023 5:04:56 PM by Hibernate Tools 4.3.5.Final

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
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_DIAGRAM_EXTRA
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_DIAGRAM_EXTRA"
		, uniqueConstraints = @UniqueConstraint(columnNames = "NGALLEY_KEY")
)
public class CenDiagramExtra implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonIgnore
	private CenGalley cenGalley;
	private long nextraKey;
	private long nequipmentKey;
	private int nxpos;
	private int nypos;
	private int npage;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_DIAGRAM_EXTRA")
	@SequenceGenerator(name = "SEQ_CEN_DIAGRAM_EXTRA", sequenceName = "SEQ_CEN_DIAGRAM_EXTRA", allocationSize = 1)
	@Column(name = "NEXTRA_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNextraKey() {
		return this.nextraKey;
	}

	public void setNextraKey(long nextraKey) {
		this.nextraKey = nextraKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NGALLEY_KEY", nullable = false)
	public CenGalley getCenGalley() {
		return this.cenGalley;
	}

	public void setCenGalley(final CenGalley cenGalley) {
		this.cenGalley = cenGalley;
	}

	@Column(name = "NEQUIPMENT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNequipmentKey() {
		return this.nequipmentKey;
	}

	public void setNequipmentKey(long nequipmentKey) {
		this.nequipmentKey = nequipmentKey;
	}

	@Column(name = "NXPOS", nullable = false, precision = 7, scale = 0)
	public int getNxpos() {
		return this.nxpos;
	}

	public void setNxpos(int nxpos) {
		this.nxpos = nxpos;
	}

	@Column(name = "NYPOS", nullable = false, precision = 7, scale = 0)
	public int getNypos() {
		return this.nypos;
	}

	public void setNypos(int nypos) {
		this.nypos = nypos;
	}

	@Column(name = "NPAGE", nullable = false, precision = 2, scale = 0)
	public int getNpage() {
		return this.npage;
	}

	public void setNpage(int npage) {
		this.npage = npage;
	}

}


