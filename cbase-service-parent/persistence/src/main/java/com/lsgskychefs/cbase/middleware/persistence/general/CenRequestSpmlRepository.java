package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestFlight;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestSpml;

@Repository
@Transactional
public interface CenRequestSpmlRepository extends JpaRepository<CenRequestSpml, Long> {

	@Query("select crs from CenRequestSpml crs left join crs.cenRequestFlight crf where crf = :cenRequestFlight and crs.cclass = :cclass")
	List<CenRequestSpml> getByCenRequestFlightAndClass(@Param("cenRequestFlight") CenRequestFlight cenRequestFlight,
			@Param("cclass") String cclass);
}
