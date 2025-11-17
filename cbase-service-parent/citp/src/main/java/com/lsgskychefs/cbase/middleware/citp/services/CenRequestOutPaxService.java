package com.lsgskychefs.cbase.middleware.citp.services;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestOutPax;
import com.lsgskychefs.cbase.middleware.persistence.general.CenRequestOutPaxRepository;

@Service
public class CenRequestOutPaxService {

	private static final Logger LOGGER = LoggerFactory.getLogger(CenRequestOutPaxService.class);

	@Autowired
	private CenRequestOutPaxRepository cenRequestOutPaxRepository;

	public List<CenRequestOutPax> getCateringFiguresByJobNr(final long jobNr) {

		return cenRequestOutPaxRepository.findByNJobNrSorted(jobNr);
	}
}
