package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 18.03.2019 12:31:25 by Hibernate Tools 4.3.5.Final


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_PRODUCT_GROUP
 * @author Hibernate Tools
 */
@Entity
@Table(name="CEN_PRODUCT_GROUP"
    , uniqueConstraints = {@UniqueConstraint(columnNames={"CCLIENT", "CPRODUCT_GROUP"}), @UniqueConstraint(columnNames={"CTEXT", "CCLIENT"}), @UniqueConstraint(columnNames={"CTEXT4", "CCLIENT"}), @UniqueConstraint(columnNames={"CTEXT1", "CCLIENT"}), @UniqueConstraint(columnNames={"CTEXT3", "CCLIENT"}), @UniqueConstraint(columnNames={"CTEXT2", "CCLIENT"})} 
)
public class CenProductGroup  implements DomainObject,java.io.Serializable {

     /** serialVersionUID */
     private static final long serialVersionUID = 1L;
     
	 private long nproductIndexKey;
     private String cclient;
     private String cproductGroup;
     private String ctext;
     private String ctext1;
     private String ctext2;
     private String ctext3;
     private String ctext4;
     private String cdescription;
     private String cdescription1;
     private String cdescription2;
     private String cdescription3;
     private String cdescription4;
     private Integer nownerId;
     private int nproductionRelevant;
     private Long nmaterialCategoryKey;

     @Id 

    
    @Column(name="NPRODUCT_INDEX_KEY", unique=true, nullable=false, precision=12, scale=0)
    public long getNproductIndexKey() {
        return this.nproductIndexKey;
    }
    
    public void setNproductIndexKey(long nproductIndexKey) {
        this.nproductIndexKey = nproductIndexKey;
    }

    
    @Column(name="CCLIENT", nullable=false, length=3)
    public String getCclient() {
        return this.cclient;
    }
    
    public void setCclient(String cclient) {
        this.cclient = cclient;
    }

    
    @Column(name="CPRODUCT_GROUP", nullable=false, length=18)
    public String getCproductGroup() {
        return this.cproductGroup;
    }
    
    public void setCproductGroup(String cproductGroup) {
        this.cproductGroup = cproductGroup;
    }

    
    @Column(name="CTEXT", nullable=false, length=40)
    public String getCtext() {
        return this.ctext;
    }
    
    public void setCtext(String ctext) {
        this.ctext = ctext;
    }

    
    @Column(name="CTEXT1", nullable=false, length=40)
    public String getCtext1() {
        return this.ctext1;
    }
    
    public void setCtext1(String ctext1) {
        this.ctext1 = ctext1;
    }

    
    @Column(name="CTEXT2", nullable=false, length=40)
    public String getCtext2() {
        return this.ctext2;
    }
    
    public void setCtext2(String ctext2) {
        this.ctext2 = ctext2;
    }

    
    @Column(name="CTEXT3", nullable=false, length=40)
    public String getCtext3() {
        return this.ctext3;
    }
    
    public void setCtext3(String ctext3) {
        this.ctext3 = ctext3;
    }

    
    @Column(name="CTEXT4", nullable=false, length=40)
    public String getCtext4() {
        return this.ctext4;
    }
    
    public void setCtext4(String ctext4) {
        this.ctext4 = ctext4;
    }

    
    @Column(name="CDESCRIPTION", length=256)
    public String getCdescription() {
        return this.cdescription;
    }
    
    public void setCdescription(String cdescription) {
        this.cdescription = cdescription;
    }

    
    @Column(name="CDESCRIPTION1", length=256)
    public String getCdescription1() {
        return this.cdescription1;
    }
    
    public void setCdescription1(String cdescription1) {
        this.cdescription1 = cdescription1;
    }

    
    @Column(name="CDESCRIPTION2", length=256)
    public String getCdescription2() {
        return this.cdescription2;
    }
    
    public void setCdescription2(String cdescription2) {
        this.cdescription2 = cdescription2;
    }

    
    @Column(name="CDESCRIPTION3", length=256)
    public String getCdescription3() {
        return this.cdescription3;
    }
    
    public void setCdescription3(String cdescription3) {
        this.cdescription3 = cdescription3;
    }

    
    @Column(name="CDESCRIPTION4", length=256)
    public String getCdescription4() {
        return this.cdescription4;
    }
    
    public void setCdescription4(String cdescription4) {
        this.cdescription4 = cdescription4;
    }

    
    @Column(name="NOWNER_ID", precision=5, scale=0)
    public Integer getNownerId() {
        return this.nownerId;
    }
    
    public void setNownerId(Integer nownerId) {
        this.nownerId = nownerId;
    }

    
    @Column(name="NPRODUCTION_RELEVANT", nullable=false, precision=1, scale=0)
    public int getNproductionRelevant() {
        return this.nproductionRelevant;
    }
    
    public void setNproductionRelevant(int nproductionRelevant) {
        this.nproductionRelevant = nproductionRelevant;
    }

    
    @Column(name="NMATERIAL_CATEGORY_KEY", precision=12, scale=0)
    public Long getNmaterialCategoryKey() {
        return this.nmaterialCategoryKey;
    }
    
    public void setNmaterialCategoryKey(Long nmaterialCategoryKey) {
        this.nmaterialCategoryKey = nmaterialCategoryKey;
    }




}


