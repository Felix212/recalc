package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Apr 3, 2025 9:40:21 AM by Hibernate Tools 4.3.5.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_AIRL_FLAGS_VALUES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRL_FLAGS_VALUES"
)
public class CenAirlFlagsValues implements DomainObject, java.io.Serializable {

    private CenAirlFlagsValuesId id;
    private CenAirlFlags cenAirlFlags;
    private int ndefault;
    private String csapKey;

    @EmbeddedId
    @AttributeOverrides({
            @AttributeOverride(name = "nflagId", column = @Column(name = "NFLAG_ID", nullable = false, precision = 12, scale = 0)),
            @AttributeOverride(name = "nairlineKey", column = @Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)),
            @AttributeOverride(name = "nplKindKey", column = @Column(name = "NPL_KIND_KEY", nullable = false, precision = 12, scale = 0)),
            @AttributeOverride(name = "cflagvalue", column = @Column(name = "CFLAGVALUE", nullable = false, length = 40)) })
    public CenAirlFlagsValuesId getId() {
        return this.id;
    }

    public void setId(CenAirlFlagsValuesId id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumns({
            @JoinColumn(name = "NFLAG_ID", referencedColumnName = "NFLAG_ID", nullable = false, insertable = false, updatable = false),
            @JoinColumn(name = "NAIRLINE_KEY", referencedColumnName = "NAIRLINE_KEY", nullable = false, insertable = false, updatable = false),
            @JoinColumn(name = "NPL_KIND_KEY", referencedColumnName = "NPL_KIND_KEY", nullable = false, insertable = false, updatable = false) })
    public CenAirlFlags getCenAirlFlags() {
        return this.cenAirlFlags;
    }

    public void setCenAirlFlags(CenAirlFlags cenAirlFlags) {
        this.cenAirlFlags = cenAirlFlags;
    }

    @Column(name = "NDEFAULT", nullable = false, precision = 1, scale = 0)
    public int getNdefault() {
        return this.ndefault;
    }

    public void setNdefault(int ndefault) {
        this.ndefault = ndefault;
    }

    @Column(name = "CSAP_KEY", length = 3)
    public String getCsapKey() {
        return this.csapKey;
    }

    public void setCsapKey(String csapKey) {
        this.csapKey = csapKey;
    }

}


