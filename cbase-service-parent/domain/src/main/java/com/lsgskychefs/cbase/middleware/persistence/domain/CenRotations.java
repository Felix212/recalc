package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Oct 15, 2021 3:00:24 PM by Hibernate Tools 4.3.5.Final

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_ROTATIONS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_ROTATIONS", uniqueConstraints = @UniqueConstraint(columnNames = { "NCUSTOMER_KEY", "CTEXT" }))
public class CenRotations implements DomainObject, java.io.Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

    private long nrotationKey;
    private CenRotationCat cenRotationCat;
    private long ncustomerKey;
    private String ctext;
    private Date dtimestampModification;
    private Integer nownerId;
    private Date dstartDate;
    private int nrotationNumbers;
    private int nrotationType;
    private Long noldRotation;
    private List<CenMopMaster> cenMopMasters = new ArrayList<CenMopMaster>(0);
    private List<CenRotationNames> cenRotationNameses = new ArrayList<CenRotationNames>(0);
    private List<CenMeals> cenMealses = new ArrayList<CenMeals>(0);

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_ROTATIONS")
    @SequenceGenerator(name = "SEQ_CEN_ROTATIONS", sequenceName = "SEQ_CEN_ROTATIONS", allocationSize = 1)
    @Column(name = "NROTATION_KEY", unique = true, nullable = false, precision = 12, scale = 0)
    public long getNrotationKey() {
        return this.nrotationKey;
    }

    public void setNrotationKey(final long nrotationKey) {
        this.nrotationKey = nrotationKey;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NROTATION_CAT_KEY")
    public CenRotationCat getCenRotationCat() {
        return this.cenRotationCat;
    }

    public void setCenRotationCat(CenRotationCat cenRotationCat) {
        this.cenRotationCat = cenRotationCat;
    }

    @Column(name = "NCUSTOMER_KEY", nullable = false, precision = 12, scale = 0)
    public long getNcustomerKey() {
        return this.ncustomerKey;
    }

    public void setNcustomerKey(final long ncustomerKey) {
        this.ncustomerKey = ncustomerKey;
    }

    @Column(name = "CTEXT", nullable = false, length = 60)
    public String getCtext() {
        return this.ctext;
    }

    public void setCtext(final String ctext) {
        this.ctext = ctext;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DTIMESTAMP_MODIFICATION", length = 7)
    public Date getDtimestampModification() {
        return this.dtimestampModification;
    }

    public void setDtimestampModification(final Date dtimestampModification) {
        this.dtimestampModification = dtimestampModification;
    }

    @Column(name = "NOWNER_ID", precision = 5, scale = 0)
    public Integer getNownerId() {
        return this.nownerId;
    }

    public void setNownerId(final Integer nownerId) {
        this.nownerId = nownerId;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "DSTART_DATE", nullable = false, length = 7)
    public Date getDstartDate() {
        return this.dstartDate;
    }

    public void setDstartDate(final Date dstartDate) {
        this.dstartDate = dstartDate;
    }

    @Column(name = "NROTATION_NUMBERS", nullable = false, precision = 3, scale = 0)
    public int getNrotationNumbers() {
        return this.nrotationNumbers;
    }

    public void setNrotationNumbers(final int nrotationNumbers) {
        this.nrotationNumbers = nrotationNumbers;
    }

    @Column(name = "NROTATION_TYPE", nullable = false, precision = 3, scale = 0)
    public int getNrotationType() {
        return this.nrotationType;
    }

    public void setNrotationType(final int nrotationType) {
        this.nrotationType = nrotationType;
    }

    @Column(name = "NOLD_ROTATION", precision = 12, scale = 0)
    public Long getNoldRotation() {
        return this.noldRotation;
    }

    public void setNoldRotation(final Long noldRotation) {
        this.noldRotation = noldRotation;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "cenRotations")
    public List<CenMopMaster> getCenMopMasters() {
        return this.cenMopMasters;
    }

    public void setCenMopMasters(final List<CenMopMaster> cenMopMasters) {
        this.cenMopMasters = cenMopMasters;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "cenRotations", cascade = {CascadeType.ALL}, orphanRemoval = true)
    @OrderBy("nrotation ASC")
    public List<CenRotationNames> getCenRotationNameses() {
        return this.cenRotationNameses;
    }

    public void setCenRotationNameses(final List<CenRotationNames> cenRotationNameses) {
        this.cenRotationNameses = cenRotationNameses;
    }
    
    /**
     * Helper method to add a rotation name and maintain the bidirectional relationship
     * 
     * @param rotationName the rotation name to add
     * @return this object for method chaining
     */
    public CenRotations addRotationName(CenRotationNames rotationName) {
        // Replace the existing rotation name if it already exists
        if (cenRotationNameses.contains(rotationName)) {
            cenRotationNameses.remove(rotationName);
        }

        // Add the new rotation name
        cenRotationNameses.add(rotationName);

        rotationName.setCenRotations(this);
        return this;
    }
    
    /**
     * Helper method to remove a rotation name and maintain the bidirectional relationship
     * 
     * @param rotationName the rotation name to remove
     * @return this object for method chaining
     */
    public CenRotations removeRotationName(CenRotationNames rotationName) {
        cenRotationNameses.remove(rotationName);
        rotationName.setCenRotations(null);
        return this;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "cenRotations")
    public List<CenMeals> getCenMealses() {
        return this.cenMealses;
    }

    public void setCenMealses(final List<CenMeals> cenMealses) {
        this.cenMealses = cenMealses;
    }

}
