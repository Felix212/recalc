package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Oct 15, 2021 3:00:24 PM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_ROTATION_NAMES
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_ROTATION_NAMES", uniqueConstraints = @UniqueConstraint(columnNames = { "NROTATION_KEY", "CTEXT" }))
public class CenRotationNames implements DomainObject, java.io.Serializable {

    private static final long serialVersionUID = 1L;
    private long nrotationNameKey;
    private CenRotations cenRotations;
    private int nrotation;
    private int nrotationDuration;
    private String ctext;
    private Long noldNameKey;
    private Set<CenMealsDetail> cenMealsDetails = new HashSet<CenMealsDetail>(0);

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_ROTATION_NAMES")
    @SequenceGenerator(name = "SEQ_CEN_ROTATION_NAMES", sequenceName = "SEQ_CEN_ROTATION_NAMES", allocationSize = 1)
    @Column(name = "NROTATION_NAME_KEY", unique = true, nullable = false, precision = 12, scale = 0)
    public long getNrotationNameKey() {
        return this.nrotationNameKey;
    }

    public void setNrotationNameKey(final long nrotationNameKey) {
        this.nrotationNameKey = nrotationNameKey;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NROTATION_KEY", nullable = false)
    public CenRotations getCenRotations() {
        return this.cenRotations;
    }

    public void setCenRotations(final CenRotations cenRotations) {
        this.cenRotations = cenRotations;
    }

    @Column(name = "NROTATION", nullable = false, precision = 3, scale = 0)
    public int getNrotation() {
        return this.nrotation;
    }

    public void setNrotation(final int nrotation) {
        this.nrotation = nrotation;
    }

    @Column(name = "NROTATION_DURATION", nullable = false, precision = 3, scale = 0)
    public int getNrotationDuration() {
        return this.nrotationDuration;
    }

    public void setNrotationDuration(final int nrotationDuration) {
        this.nrotationDuration = nrotationDuration;
    }

    @Column(name = "CTEXT", nullable = false, length = 10)
    public String getCtext() {
        return this.ctext;
    }

    public void setCtext(final String ctext) {
        this.ctext = ctext;
    }

    @Column(name = "NOLD_NAME_KEY", precision = 12, scale = 0)
    public Long getNoldNameKey() {
        return this.noldNameKey;
    }

    public void setNoldNameKey(final Long noldNameKey) {
        this.noldNameKey = noldNameKey;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "cenRotationNames")
    public Set<CenMealsDetail> getCenMealsDetails() {
        return this.cenMealsDetails;
    }

    public void setCenMealsDetails(final Set<CenMealsDetail> cenMealsDetails) {
        this.cenMealsDetails = cenMealsDetails;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        
        CenRotationNames that = (CenRotationNames) o;
        
        // If we have an ID, use it for comparison
        if (nrotationNameKey != 0 && that.nrotationNameKey != 0) {
            return nrotationNameKey == that.nrotationNameKey;
        }
        
        // Otherwise compare business key attributes
        return nrotation == that.nrotation &&
               Objects.equals(ctext, that.ctext);
    }

    @Override
    public int hashCode() {
        // If we have an ID, use it for hashCode
        if (nrotationNameKey != 0) {
            return Long.hashCode(nrotationNameKey);
        }
        
        // Otherwise use business key attributes
        return Objects.hash(nrotation, ctext);
    }
}
