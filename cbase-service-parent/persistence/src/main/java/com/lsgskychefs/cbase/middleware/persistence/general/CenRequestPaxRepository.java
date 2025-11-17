package com.lsgskychefs.cbase.middleware.persistence.general;

import javax.transaction.Transactional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestPax;

@Repository
@Transactional
public interface CenRequestPaxRepository extends CrudRepository<CenRequestPax, Long> {
}
