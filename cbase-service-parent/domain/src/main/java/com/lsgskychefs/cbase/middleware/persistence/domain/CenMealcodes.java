package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Oct 13, 2025 11:15:15 AM by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_MEALCODES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_MEALCODES"
)
public class CenMealcodes implements DomainObject, java.io.Serializable {

    private String cmealControlCode;
    private String ctext;
    private Integer nownerId;

    public CenMealcodes() {
    }

    @Id
    @Column(name = "CMEAL_CONTROL_CODE", unique = true, nullable = false, length = 4)
    public String getCmealControlCode() {
        return this.cmealControlCode;
    }

    public void setCmealControlCode(String cmealControlCode) {
        this.cmealControlCode = cmealControlCode;
    }

    @Column(name = "CTEXT", nullable = false, length = 40)
    public String getCtext() {
        return this.ctext;
    }

    public void setCtext(String ctext) {
        this.ctext = ctext;
    }

    @Column(name = "NOWNER_ID", precision = 5, scale = 0)
    public Integer getNownerId() {
        return this.nownerId;
    }

    public void setNownerId(Integer nownerId) {
        this.nownerId = nownerId;
    }
}


