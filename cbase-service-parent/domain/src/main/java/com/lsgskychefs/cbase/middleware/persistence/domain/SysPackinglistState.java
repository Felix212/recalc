package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Dec 15, 2023 11:53:21 AM by Hibernate Tools 4.3.5.Final


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_PACKINGLIST_STATE
 * @author Hibernate Tools
 */
@Entity
@Table(name="SYS_PACKINGLIST_STATE"
)
public class SysPackinglistState  implements DomainObject,java.io.Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

     private long npackinglistStateKey;
     private int npackinglistState;
     private int nactiv;
     private String cpackinglistState;
     private int nstatemarkedfordeletion;
     private int nstatedeletionfailed;
     private int ndefault;
     private int nstatemarkedfortermination;
     private int nstateterminationfailed;
     private int nstateterminated;

    public SysPackinglistState() {
    }

	
    public SysPackinglistState(long npackinglistStateKey, int npackinglistState, int nactiv, int nstatemarkedfordeletion, int nstatedeletionfailed, int ndefault, int nstatemarkedfortermination, int nstateterminationfailed, int nstateterminated) {
        this.npackinglistStateKey = npackinglistStateKey;
        this.npackinglistState = npackinglistState;
        this.nactiv = nactiv;
        this.nstatemarkedfordeletion = nstatemarkedfordeletion;
        this.nstatedeletionfailed = nstatedeletionfailed;
        this.ndefault = ndefault;
        this.nstatemarkedfortermination = nstatemarkedfortermination;
        this.nstateterminationfailed = nstateterminationfailed;
        this.nstateterminated = nstateterminated;
    }
    public SysPackinglistState(long npackinglistStateKey, int npackinglistState, int nactiv, String cpackinglistState, int nstatemarkedfordeletion, int nstatedeletionfailed, int ndefault, int nstatemarkedfortermination, int nstateterminationfailed, int nstateterminated) {
       this.npackinglistStateKey = npackinglistStateKey;
       this.npackinglistState = npackinglistState;
       this.nactiv = nactiv;
       this.cpackinglistState = cpackinglistState;
       this.nstatemarkedfordeletion = nstatemarkedfordeletion;
       this.nstatedeletionfailed = nstatedeletionfailed;
       this.ndefault = ndefault;
       this.nstatemarkedfortermination = nstatemarkedfortermination;
       this.nstateterminationfailed = nstateterminationfailed;
       this.nstateterminated = nstateterminated;
    }
   
     @Id 

    
    @Column(name="NPACKINGLIST_STATE_KEY", unique=true, nullable=false, precision=13, scale=0)
    public long getNpackinglistStateKey() {
        return this.npackinglistStateKey;
    }
    
    public void setNpackinglistStateKey(long npackinglistStateKey) {
        this.npackinglistStateKey = npackinglistStateKey;
    }

    
    @Column(name="NPACKINGLIST_STATE", nullable=false, precision=2, scale=0)
    public int getNpackinglistState() {
        return this.npackinglistState;
    }
    
    public void setNpackinglistState(int npackinglistState) {
        this.npackinglistState = npackinglistState;
    }

    
    @Column(name="NACTIV", nullable=false, precision=1, scale=0)
    public int getNactiv() {
        return this.nactiv;
    }
    
    public void setNactiv(int nactiv) {
        this.nactiv = nactiv;
    }

    
    @Column(name="CPACKINGLIST_STATE", length=40)
    public String getCpackinglistState() {
        return this.cpackinglistState;
    }
    
    public void setCpackinglistState(String cpackinglistState) {
        this.cpackinglistState = cpackinglistState;
    }

    
    @Column(name="NSTATEMARKEDFORDELETION", nullable=false, precision=1, scale=0)
    public int getNstatemarkedfordeletion() {
        return this.nstatemarkedfordeletion;
    }
    
    public void setNstatemarkedfordeletion(int nstatemarkedfordeletion) {
        this.nstatemarkedfordeletion = nstatemarkedfordeletion;
    }

    
    @Column(name="NSTATEDELETIONFAILED", nullable=false, precision=1, scale=0)
    public int getNstatedeletionfailed() {
        return this.nstatedeletionfailed;
    }
    
    public void setNstatedeletionfailed(int nstatedeletionfailed) {
        this.nstatedeletionfailed = nstatedeletionfailed;
    }

    
    @Column(name="NDEFAULT", nullable=false, precision=1, scale=0)
    public int getNdefault() {
        return this.ndefault;
    }
    
    public void setNdefault(int ndefault) {
        this.ndefault = ndefault;
    }

    
    @Column(name="NSTATEMARKEDFORTERMINATION", nullable=false, precision=1, scale=0)
    public int getNstatemarkedfortermination() {
        return this.nstatemarkedfortermination;
    }
    
    public void setNstatemarkedfortermination(int nstatemarkedfortermination) {
        this.nstatemarkedfortermination = nstatemarkedfortermination;
    }

    
    @Column(name="NSTATETERMINATIONFAILED", nullable=false, precision=1, scale=0)
    public int getNstateterminationfailed() {
        return this.nstateterminationfailed;
    }
    
    public void setNstateterminationfailed(int nstateterminationfailed) {
        this.nstateterminationfailed = nstateterminationfailed;
    }

    
    @Column(name="NSTATETERMINATED", nullable=false, precision=1, scale=0)
    public int getNstateterminated() {
        return this.nstateterminated;
    }
    
    public void setNstateterminated(int nstateterminated) {
        this.nstateterminated = nstateterminated;
    }




}


