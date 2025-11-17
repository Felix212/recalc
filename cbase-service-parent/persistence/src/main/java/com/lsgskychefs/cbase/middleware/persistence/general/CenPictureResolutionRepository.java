/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.constant.CenPictureResolutionType;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistIndex;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglists;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPictureResolution;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPictureResolutionId;

/**
 * Repository class.
 *
 * @author Alex Schaab - U524036
 */
public interface CenPictureResolutionRepository extends PagingAndSortingRepository<CenPictureResolution, CenPictureResolutionId> {

	/**
	 * Get the Thumbnail picture for a given picture index
	 * 
	 * @param npackinglistIndexKey key for {@link CenPackinglistIndex}
	 * @param npackinglistDetailKey key for {@link CenPackinglists}
	 * @param nresolution the resolution type {@link CenPictureResolutionType}
	 * @return {@link CenPictureResolution} or null if not found
	 */
	@Query("SELECT pictureThumbnail FROM CenPictureResolution pictureThumbnail "
			+ "JOIN pictureThumbnail.cenPictures picture "
			+ "JOIN picture.cenPackinglistPictureses packinglistPicture "
			+ "WHERE packinglistPicture.id.npackinglistIndexKey = :npackinglistIndexKey "
			+ "AND packinglistPicture.id.npackinglistDetailKey = :npackinglistDetailKey "
			+ "AND pictureThumbnail.id.nresolution = :nresolution")
	CenPictureResolution findPackingListThumbnailPicture(@Param("npackinglistIndexKey") final long npackinglistIndexKey,
			@Param("npackinglistDetailKey") final long npackinglistDetailKey, @Param("nresolution") final int nresolution);
}
