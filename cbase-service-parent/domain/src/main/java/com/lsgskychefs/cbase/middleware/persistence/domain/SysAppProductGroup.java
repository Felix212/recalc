package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 18.03.2019 12:50:53 by Hibernate Tools 4.3.5.Final


import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_APP_PRODUCT_GROUP
 * @author Hibernate Tools
 */
@Entity
@Table(name="SYS_APP_PRODUCT_GROUP"
)
public class SysAppProductGroup  implements DomainObject,java.io.Serializable {

     /** serialVersionUID */
     private static final long serialVersionUID = 1L;
     
	 private SysAppProductGroupId id;

    @EmbeddedId

    
    @AttributeOverrides( {
        @AttributeOverride(name="capp", column=@Column(name="CAPP", nullable=false, length=40) ), 
        @AttributeOverride(name="nproctIndexKey", column=@Column(name="NPROCT_INDEX_KEY", nullable=false, precision=12, scale=0) ) } )
    public SysAppProductGroupId getId() {
        return this.id;
    }
    
    public void setId(SysAppProductGroupId id) {
        this.id = id;
    }




}


