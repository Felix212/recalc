package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 24.05.2016 09:45:22 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedStoredProcedureQueries;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.ParameterMode;
import javax.persistence.StoredProcedureParameter;
import javax.persistence.Table;

import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpBulkPickingPrint;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpWorkOrderPrint;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpWorkOrderPrintIncreases;

/**
 * Entity(DomainObject) for table CEN_LABEL_DETAIL
 *
 * @author Hibernate Tools
 */
@NamedStoredProcedureQueries({
		@NamedStoredProcedureQuery(name = PpWorkOrderPrint.PP_WORKORDER_PRINT, procedureName = "CBASE_LABEL."
				+ PpWorkOrderPrint.PP_WORKORDER_PRINT, parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpWorkOrderPrint.P_CALLER, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpWorkOrderPrint.P_RESULT_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpWorkOrderPrint.P_BATCH_SEQ, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpWorkOrderPrint.P_FORCE_NEW, type = Integer.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpWorkOrderPrint.P_SHOW_ONLY, type = Integer.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpWorkOrderPrint.P_LABEL_PRINTING_GROUP, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpWorkOrderPrint.P_RET_VALUE, type = Integer.class)
		}),
		@NamedStoredProcedureQuery(name = PpWorkOrderPrintIncreases.PP_WORKORDER_PRINT_INCREASES, procedureName = "CBASE_LABEL."
				+ PpWorkOrderPrintIncreases.PP_WORKORDER_PRINT_INCREASES, parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpWorkOrderPrintIncreases.P_CALLER, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpWorkOrderPrintIncreases.P_PPM_SCHED_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpWorkOrderPrintIncreases.P_LABEL_PRINTING_GROUP, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpWorkOrderPrintIncreases.P_RET_VALUE, type = Integer.class)
		}),
		@NamedStoredProcedureQuery(name = PpBulkPickingPrint.PP_BULK_PICKING_PRINT, procedureName = "CBASE_LABEL."
				+ PpBulkPickingPrint.PP_BULK_PICKING_PRINT, parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpBulkPickingPrint.P_RESULT_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpBulkPickingPrint.P_PL_INDEX_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpBulkPickingPrint.P_RET_MSG, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpBulkPickingPrint.P_RET_VALUE, type = Integer.class)
		})
})
@Entity
@Table(name = "CEN_LABEL_DETAIL")
public class CenLabelDetail implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenLabelDetailId id;

	private CenLabelTypeDetail cenLabelTypeDetail;

	private int nobjectType;

	private String cobjectName;

	private int nheight;

	private int nwidth;

	private int nxpos;

	private int nypos;

	private int nobjectPos;

	private Integer nborderstyle;

	private Integer ntextalign;

	private String cfontname;

	private Integer nfontitalic;

	private Integer nfontunderline;

	private Long nfontcolor;

	private Integer nfontweight;

	private Integer nfontsize;

	private String cvalue;

	private Integer nbackgroundmode;

	private Long nbackgroundcolor;

	private Long nbrushcolor;

	private Long npencolor;

	private Integer npenwidth;

	private Integer nbrushhatch;

	private String ccolumn;

	private Integer nresizeable;

	private Integer nmoveable;

	private byte[] bbitmap;

	private Integer nwrap;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nlabelTypeKey", column = @Column(name = "NLABEL_TYPE_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "dvalidFrom", column = @Column(name = "DVALID_FROM", nullable = false, length = 7)),
			@AttributeOverride(name = "nlabelDetailKey", column = @Column(name = "NLABEL_DETAIL_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenLabelDetailId getId() {
		return this.id;
	}

	public void setId(final CenLabelDetailId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NLABEL_TYPE_KEY", referencedColumnName = "NLABEL_TYPE_KEY", nullable = false, insertable = false, updatable = false),
			@JoinColumn(name = "DVALID_FROM", referencedColumnName = "DVALID_FROM", nullable = false, insertable = false, updatable = false) })
	public CenLabelTypeDetail getCenLabelTypeDetail() {
		return this.cenLabelTypeDetail;
	}

	public void setCenLabelTypeDetail(final CenLabelTypeDetail cenLabelTypeDetail) {
		this.cenLabelTypeDetail = cenLabelTypeDetail;
	}

	@Column(name = "NOBJECT_TYPE", nullable = false, precision = 3, scale = 0)
	public int getNobjectType() {
		return this.nobjectType;
	}

	public void setNobjectType(final int nobjectType) {
		this.nobjectType = nobjectType;
	}

	@Column(name = "COBJECT_NAME", nullable = false, length = 20)
	public String getCobjectName() {
		return this.cobjectName;
	}

	public void setCobjectName(final String cobjectName) {
		this.cobjectName = cobjectName;
	}

	@Column(name = "NHEIGHT", nullable = false, precision = 6, scale = 0)
	public int getNheight() {
		return this.nheight;
	}

	public void setNheight(final int nheight) {
		this.nheight = nheight;
	}

	@Column(name = "NWIDTH", nullable = false, precision = 6, scale = 0)
	public int getNwidth() {
		return this.nwidth;
	}

	public void setNwidth(final int nwidth) {
		this.nwidth = nwidth;
	}

	@Column(name = "NXPOS", nullable = false, precision = 6, scale = 0)
	public int getNxpos() {
		return this.nxpos;
	}

	public void setNxpos(final int nxpos) {
		this.nxpos = nxpos;
	}

	@Column(name = "NYPOS", nullable = false, precision = 6, scale = 0)
	public int getNypos() {
		return this.nypos;
	}

	public void setNypos(final int nypos) {
		this.nypos = nypos;
	}

	@Column(name = "NOBJECT_POS", nullable = false, precision = 4, scale = 0)
	public int getNobjectPos() {
		return this.nobjectPos;
	}

	public void setNobjectPos(final int nobjectPos) {
		this.nobjectPos = nobjectPos;
	}

	@Column(name = "NBORDERSTYLE", precision = 2, scale = 0)
	public Integer getNborderstyle() {
		return this.nborderstyle;
	}

	public void setNborderstyle(final Integer nborderstyle) {
		this.nborderstyle = nborderstyle;
	}

	@Column(name = "NTEXTALIGN", precision = 2, scale = 0)
	public Integer getNtextalign() {
		return this.ntextalign;
	}

	public void setNtextalign(final Integer ntextalign) {
		this.ntextalign = ntextalign;
	}

	@Column(name = "CFONTNAME", length = 20)
	public String getCfontname() {
		return this.cfontname;
	}

	public void setCfontname(final String cfontname) {
		this.cfontname = cfontname;
	}

	@Column(name = "NFONTITALIC", precision = 2, scale = 0)
	public Integer getNfontitalic() {
		return this.nfontitalic;
	}

	public void setNfontitalic(final Integer nfontitalic) {
		this.nfontitalic = nfontitalic;
	}

	@Column(name = "NFONTUNDERLINE", precision = 2, scale = 0)
	public Integer getNfontunderline() {
		return this.nfontunderline;
	}

	public void setNfontunderline(final Integer nfontunderline) {
		this.nfontunderline = nfontunderline;
	}

	@Column(name = "NFONTCOLOR", precision = 12, scale = 0)
	public Long getNfontcolor() {
		return this.nfontcolor;
	}

	public void setNfontcolor(final Long nfontcolor) {
		this.nfontcolor = nfontcolor;
	}

	@Column(name = "NFONTWEIGHT", precision = 3, scale = 0)
	public Integer getNfontweight() {
		return this.nfontweight;
	}

	public void setNfontweight(final Integer nfontweight) {
		this.nfontweight = nfontweight;
	}

	@Column(name = "NFONTSIZE", precision = 3, scale = 0)
	public Integer getNfontsize() {
		return this.nfontsize;
	}

	public void setNfontsize(final Integer nfontsize) {
		this.nfontsize = nfontsize;
	}

	@Column(name = "CVALUE", length = 200)
	public String getCvalue() {
		return this.cvalue;
	}

	public void setCvalue(final String cvalue) {
		this.cvalue = cvalue;
	}

	@Column(name = "NBACKGROUNDMODE", precision = 2, scale = 0)
	public Integer getNbackgroundmode() {
		return this.nbackgroundmode;
	}

	public void setNbackgroundmode(final Integer nbackgroundmode) {
		this.nbackgroundmode = nbackgroundmode;
	}

	@Column(name = "NBACKGROUNDCOLOR", precision = 12, scale = 0)
	public Long getNbackgroundcolor() {
		return this.nbackgroundcolor;
	}

	public void setNbackgroundcolor(final Long nbackgroundcolor) {
		this.nbackgroundcolor = nbackgroundcolor;
	}

	@Column(name = "NBRUSHCOLOR", precision = 12, scale = 0)
	public Long getNbrushcolor() {
		return this.nbrushcolor;
	}

	public void setNbrushcolor(final Long nbrushcolor) {
		this.nbrushcolor = nbrushcolor;
	}

	@Column(name = "NPENCOLOR", precision = 12, scale = 0)
	public Long getNpencolor() {
		return this.npencolor;
	}

	public void setNpencolor(final Long npencolor) {
		this.npencolor = npencolor;
	}

	@Column(name = "NPENWIDTH", precision = 3, scale = 0)
	public Integer getNpenwidth() {
		return this.npenwidth;
	}

	public void setNpenwidth(final Integer npenwidth) {
		this.npenwidth = npenwidth;
	}

	@Column(name = "NBRUSHHATCH", precision = 3, scale = 0)
	public Integer getNbrushhatch() {
		return this.nbrushhatch;
	}

	public void setNbrushhatch(final Integer nbrushhatch) {
		this.nbrushhatch = nbrushhatch;
	}

	@Column(name = "CCOLUMN", length = 50)
	public String getCcolumn() {
		return this.ccolumn;
	}

	public void setCcolumn(final String ccolumn) {
		this.ccolumn = ccolumn;
	}

	@Column(name = "NRESIZEABLE", precision = 1, scale = 0)
	public Integer getNresizeable() {
		return this.nresizeable;
	}

	public void setNresizeable(final Integer nresizeable) {
		this.nresizeable = nresizeable;
	}

	@Column(name = "NMOVEABLE", precision = 1, scale = 0)
	public Integer getNmoveable() {
		return this.nmoveable;
	}

	public void setNmoveable(final Integer nmoveable) {
		this.nmoveable = nmoveable;
	}

	@Column(name = "BBITMAP")
	public byte[] getBbitmap() {
		return this.bbitmap;
	}

	public void setBbitmap(final byte[] bbitmap) {
		this.bbitmap = bbitmap;
	}

	@Column(name = "NWRAP", precision = 1, scale = 0)
	public Integer getNwrap() {
		return this.nwrap;
	}

	public void setNwrap(final Integer nwrap) {
		this.nwrap = nwrap;
	}

}
