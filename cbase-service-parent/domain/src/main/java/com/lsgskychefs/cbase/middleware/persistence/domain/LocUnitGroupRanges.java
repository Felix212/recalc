package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Dec 19, 2018 2:28:25 PM by Hibernate Tools 4.3.5.Final

import java.io.Serializable;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table LOC_UNIT_GROUP_RANGES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_GROUP_RANGES")
public class LocUnitGroupRanges implements DomainObject, Serializable {
    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

    private LocUnitGroupRangesId id;
    private LocUnitProdRanges locUnitProdRanges;
    private LocUnitLabelGroups locUnitLabelGroups;
    private String ctimeFrom;
    private String ctimeTo;

    @EmbeddedId
    @AttributeOverrides({
            @AttributeOverride(name = "nrangeKey", column = @Column(name = "NRANGE_KEY", nullable = false, precision = 12, scale = 0)),
            @AttributeOverride(name = "nlabelGroupKey", column = @Column(name = "NLABEL_GROUP_KEY", nullable = false, precision = 12, scale = 0))})
    public LocUnitGroupRangesId getId() {
        return this.id;
    }

    public void setId(LocUnitGroupRangesId id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NRANGE_KEY", nullable = false, insertable = false, updatable = false)
    public LocUnitProdRanges getLocUnitProdRanges() {
        return this.locUnitProdRanges;
    }

    public void setLocUnitProdRanges(LocUnitProdRanges locUnitProdRanges) {
        this.locUnitProdRanges = locUnitProdRanges;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NLABEL_GROUP_KEY", nullable = false, insertable = false, updatable = false)
    public LocUnitLabelGroups getLocUnitLabelGroups() {
        return this.locUnitLabelGroups;
    }

    public void setLocUnitLabelGroups(LocUnitLabelGroups locUnitLabelGroups) {
        this.locUnitLabelGroups = locUnitLabelGroups;
    }


    @Column(name = "CTIME_FROM", nullable = false, length = 5)
    public String getCtimeFrom() {
        return this.ctimeFrom;
    }

    public void setCtimeFrom(String ctimeFrom) {
        this.ctimeFrom = ctimeFrom;
    }


    @Column(name = "CTIME_TO", nullable = false, length = 5)
    public String getCtimeTo() {
        return this.ctimeTo;
    }

    public void setCtimeTo(String ctimeTo) {
        this.ctimeTo = ctimeTo;
    }
}


