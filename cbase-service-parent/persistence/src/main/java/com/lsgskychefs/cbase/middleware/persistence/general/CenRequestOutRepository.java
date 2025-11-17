package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestOut;

@Repository
@Transactional
public interface CenRequestOutRepository extends CrudRepository<CenRequestOut, Long> {

	List<CenRequestOut> getByNstatusAndNrequestTypeIsInOrderByNjobNrAsc(Integer nstatus, List<Long> nrequestType,
			Pageable pageable);

	List<CenRequestOut> getByCairlineAndNstatusAndNrequestTypeIsInOrderByNjobNrAsc(String cairline, Integer nstatus,
			List<Long> nrequestType, Pageable pageable);
}
