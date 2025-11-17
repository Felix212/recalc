/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpm;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmCo;

/**
 * Repository class.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenOutPpmCoRepository extends PagingAndSortingRepository<CenOutPpmCo, Long> {

	/**
	 * Load the {@link CenOutPpmCo}s by
	 *
	 * @param nppmDetailKey the key
	 * @return the list of {@link CenOutPpmCo}s
	 */
	@Query("SELECT co FROM CenOutPpmCo co "
			+ "JOIN co.cenOutPpm cenOut  "
			+ "WHERE cenOut.nppmDetailKey = :nppmDetailKey "
			+ "AND co.nphfFlag = 1 "
			+ "AND cenOut.nphfFlag = 1")
			List<CenOutPpmCo> findByDetailKey(@Param("nppmDetailKey") long nppmDetailKey);

	/**
	 * Find CenOutPpmCo by CenOutPpm-Object.
	 *
	 * @param cenOutPpm the cenOutPpm-Object
	 * @return List of CenOutPpmCo Entries
	 */
	List<CenOutPpmCo> findByCenOutPpm(CenOutPpm cenOutPpm);

	/**
	 * Find CenOutPpmCo by nbatchSeq Key.
	 *
	 * @param nbatchSeq the nbatchSeq Key
	 * @return List of CenOutPpmCo Entries
	 */
	List<CenOutPpmCo> findByNbatchSeq(Long nbatchSeq);

	/**
	 * Find CenOutPpmCo by nbatchSeq Key and Clasification.
	 * 
	 * @param nbatchSeq
	 * @param nclassification
	 * @return List of CenOutPpmCo Entries
	 */
	List<CenOutPpmCo> findByNbatchSeqAndNclassification(Long nbatchSeq, int nclassification);

	/**
	 * Find CenOutPpmCo with Weight Entries by nbatchSeq Key .
	 *
	 * @param nbatchSeq the nbatchSeq Key
	 * @return List of CenOutPpmCo Entries
	 */
	@Query("SELECT co FROM CenOutPpmCo co "
			+ "JOIN co.cenOutPpmCoWeights cenOut  "
			+ "WHERE co.nbatchSeq = :nbatchSeq")
			List<CenOutPpmCo> findCoWithWeightByNbatchSeq(@Param("nbatchSeq") Long nbatchSeq);

	/**
	 * Find COs from meal distribution
	 * 
	 * @param cenOutPpm
	 * @param nmdco
	 * @return List of CenOutPpmCo Entries
	 */
	List<CenOutPpmCo> findByCenOutPpmAndNmdco(CenOutPpm cenOutPpm, boolean nmdco);

	/**
	 * Find COs by nbatchSeq and meal distribution flag
	 * 
	 * @param nbatchSeq
	 * @param nmdco
	 * @return List of CenOutPpmCo Entries
	 */
	List<CenOutPpmCo> findByNbatchSeqAndNmdco(Long nbatchSeq, boolean nmdco);

}
