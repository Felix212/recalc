package com.lsgskychefs.cbase.middleware.preorder.persistence;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestPreorder;

import javax.transaction.Transactional;

@Repository
@Transactional
public interface CenRequestPreorderRepository extends PagingAndSortingRepository<CenRequestPreorder, Long> {

}
