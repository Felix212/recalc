package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequest;

@Repository
public interface CenRequestRepository extends JpaRepository<CenRequest, Long> {

	List<CenRequest> findByCairlineAndNairlineQpKeyAndNstatusAndCenRequestTypesNrequestTypeIsInOrderByNjobNrAsc(
			String cairline, Long nairlineQpKey, Integer nstatus, List<Long> nrequestType, Pageable pageable);

	List<CenRequest> findByCairlineAndNstatusAndCenRequestTypesNrequestTypeIsInOrderByNjobNrAsc(String cairline,
			Integer nstatus, List<Long> nrequestType, Pageable pageable);

	List<CenRequest> findByCenRequestTypesNrequestTypeIsInAndNstatus(List<Long> nrequestType, Integer nstatus,
			Pageable pageable);

}
