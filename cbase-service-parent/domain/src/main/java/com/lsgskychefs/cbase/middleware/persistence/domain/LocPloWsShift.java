package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 18.01.2019 10:58:33 by Hibernate Tools 4.3.5.Final


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
 * Entity(DomainObject) for table LOC_PLO_WS_SHIFT
 * @author Hibernate Tools
 */
@Entity
@Table(name="LOC_PLO_WS_SHIFT"
)
public class LocPloWsShift  implements DomainObject,java.io.Serializable {
    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

     private LocPloWsShiftId id;
     private LocUnitWorkstation locUnitWorkstation;
     private LocPloShift locPloShift;
     private Long nworkscheduleIndex;

    public LocPloWsShift() {
    }

	
    public LocPloWsShift(LocPloWsShiftId id, LocUnitWorkstation locUnitWorkstation, LocPloShift locPloShift) {
        this.id = id;
        this.locUnitWorkstation = locUnitWorkstation;
        this.locPloShift = locPloShift;
    }
    public LocPloWsShift(LocPloWsShiftId id, LocUnitWorkstation locUnitWorkstation, LocPloShift locPloShift, Long nworkscheduleIndex) {
       this.id = id;
       this.locUnitWorkstation = locUnitWorkstation;
       this.locPloShift = locPloShift;
       this.nworkscheduleIndex = nworkscheduleIndex;
    }
   
     @EmbeddedId

    
    @AttributeOverrides( {
        @AttributeOverride(name="nworkstationKey", column=@Column(name="NWORKSTATION_KEY", nullable=false, precision=12, scale=0) ), 
        @AttributeOverride(name="nshiftKey", column=@Column(name="NSHIFT_KEY", nullable=false, precision=12, scale=0) ) } )
    public LocPloWsShiftId getId() {
        return this.id;
    }
    
    public void setId(LocPloWsShiftId id) {
        this.id = id;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NWORKSTATION_KEY", nullable=false, insertable=false, updatable=false)
    public LocUnitWorkstation getLocUnitWorkstation() {
        return this.locUnitWorkstation;
    }
    
    public void setLocUnitWorkstation(LocUnitWorkstation locUnitWorkstation) {
        this.locUnitWorkstation = locUnitWorkstation;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="NSHIFT_KEY", nullable=false, insertable=false, updatable=false)
    public LocPloShift getLocPloShift() {
        return this.locPloShift;
    }
    
    public void setLocPloShift(LocPloShift locPloShift) {
        this.locPloShift = locPloShift;
    }

    
    @Column(name="NWORKSCHEDULE_INDEX", precision=12, scale=0)
    public Long getNworkscheduleIndex() {
        return this.nworkscheduleIndex;
    }
    
    public void setNworkscheduleIndex(Long nworkscheduleIndex) {
        this.nworkscheduleIndex = nworkscheduleIndex;
    }




}


