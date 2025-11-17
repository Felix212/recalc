package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequest;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestFlight;

@Repository
public interface CenRequestFlightRepository extends PagingAndSortingRepository<CenRequestFlight, Long> {

	List<CenRequestFlight> findByCenRequest(CenRequest cenRequest);
}
