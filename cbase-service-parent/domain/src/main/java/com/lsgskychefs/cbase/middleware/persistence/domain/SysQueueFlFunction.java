package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 09.12.2020 13:49:12 by Hibernate Tools 4.3.5.Final


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_QUEUE_FL_FUNCTION
 * @author Hibernate Tools
 */
@Entity
@Table(name="SYS_QUEUE_FL_FUNCTION")
public class SysQueueFlFunction implements DomainObject,java.io.Serializable {

    /** serialVersionUID */
    private static final long serialVersionUID = 1L;

     private int nfunction;
     private String ctext;
     private String cprotocolText;
     private Integer ninternalFunction;
     private Integer nqueuedReleaseInterface;
     private Integer nreadFromHistory;
     private Integer npaxType;
     private Integer nuseAsPaxType;
     private Integer nstatusAfterProcess;
     private Integer nstatusToProcess;
     private Integer nactype;
     private Integer nuseAsActype;

    public SysQueueFlFunction() {
    }


    public SysQueueFlFunction(int nfunction, String ctext) {
        this.nfunction = nfunction;
        this.ctext = ctext;
    }
    public SysQueueFlFunction(int nfunction, String ctext, String cprotocolText, Integer ninternalFunction, Integer nqueuedReleaseInterface, Integer nreadFromHistory, Integer npaxType, Integer nuseAsPaxType, Integer nstatusAfterProcess, Integer nstatusToProcess, Integer nactype, Integer nuseAsActype) {
       this.nfunction = nfunction;
       this.ctext = ctext;
       this.cprotocolText = cprotocolText;
       this.ninternalFunction = ninternalFunction;
       this.nqueuedReleaseInterface = nqueuedReleaseInterface;
       this.nreadFromHistory = nreadFromHistory;
       this.npaxType = npaxType;
       this.nuseAsPaxType = nuseAsPaxType;
       this.nstatusAfterProcess = nstatusAfterProcess;
       this.nstatusToProcess = nstatusToProcess;
       this.nactype = nactype;
       this.nuseAsActype = nuseAsActype;
    }

     @Id


    @Column(name="NFUNCTION", unique=true, nullable=false, precision=6, scale=0)
    public int getNfunction() {
        return this.nfunction;
    }

    public void setNfunction(int nfunction) {
        this.nfunction = nfunction;
    }


    @Column(name="CTEXT", nullable=false, length=60)
    public String getCtext() {
        return this.ctext;
    }

    public void setCtext(String ctext) {
        this.ctext = ctext;
    }


    @Column(name="CPROTOCOL_TEXT", length=15)
    public String getCprotocolText() {
        return this.cprotocolText;
    }

    public void setCprotocolText(String cprotocolText) {
        this.cprotocolText = cprotocolText;
    }


    @Column(name="NINTERNAL_FUNCTION", precision=2, scale=0)
    public Integer getNinternalFunction() {
        return this.ninternalFunction;
    }

    public void setNinternalFunction(Integer ninternalFunction) {
        this.ninternalFunction = ninternalFunction;
    }


    @Column(name="NQUEUED_RELEASE_INTERFACE", precision=2, scale=0)
    public Integer getNqueuedReleaseInterface() {
        return this.nqueuedReleaseInterface;
    }

    public void setNqueuedReleaseInterface(Integer nqueuedReleaseInterface) {
        this.nqueuedReleaseInterface = nqueuedReleaseInterface;
    }


    @Column(name="NREAD_FROM_HISTORY", precision=1, scale=0)
    public Integer getNreadFromHistory() {
        return this.nreadFromHistory;
    }

    public void setNreadFromHistory(Integer nreadFromHistory) {
        this.nreadFromHistory = nreadFromHistory;
    }


    @Column(name="NPAX_TYPE", precision=2, scale=0)
    public Integer getNpaxType() {
        return this.npaxType;
    }

    public void setNpaxType(Integer npaxType) {
        this.npaxType = npaxType;
    }


    @Column(name="NUSE_AS_PAX_TYPE", precision=2, scale=0)
    public Integer getNuseAsPaxType() {
        return this.nuseAsPaxType;
    }

    public void setNuseAsPaxType(Integer nuseAsPaxType) {
        this.nuseAsPaxType = nuseAsPaxType;
    }


    @Column(name="NSTATUS_AFTER_PROCESS", precision=6, scale=0)
    public Integer getNstatusAfterProcess() {
        return this.nstatusAfterProcess;
    }

    public void setNstatusAfterProcess(Integer nstatusAfterProcess) {
        this.nstatusAfterProcess = nstatusAfterProcess;
    }


    @Column(name="NSTATUS_TO_PROCESS", precision=6, scale=0)
    public Integer getNstatusToProcess() {
        return this.nstatusToProcess;
    }

    public void setNstatusToProcess(Integer nstatusToProcess) {
        this.nstatusToProcess = nstatusToProcess;
    }


    @Column(name="NACTYPE", precision=2, scale=0)
    public Integer getNactype() {
        return this.nactype;
    }

    public void setNactype(Integer nactype) {
        this.nactype = nactype;
    }


    @Column(name="NUSE_AS_ACTYPE", precision=2, scale=0)
    public Integer getNuseAsActype() {
        return this.nuseAsActype;
    }

    public void setNuseAsActype(Integer nuseAsActype) {
        this.nuseAsActype = nuseAsActype;
    }




}


