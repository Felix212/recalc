package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestOutPax;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestOutPaxId;

@Repository
@Transactional
public interface CenRequestOutPaxRepository extends JpaRepository<CenRequestOutPax, CenRequestOutPaxId> {

	@Query("select crop from CenRequestOutPax crop where crop.id.njobNr = :njobNr order by crop.id.nclassNumber asc")
	List<CenRequestOutPax> findByNJobNrSorted(@Param("njobNr") long njobNr);
}
