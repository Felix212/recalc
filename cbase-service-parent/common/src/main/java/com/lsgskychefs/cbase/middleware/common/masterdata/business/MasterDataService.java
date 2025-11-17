/*
 * MasterdataService.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.common.masterdata.business;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.StringWriter;
import java.io.Writer;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.swing.JEditorPane;
import javax.swing.text.BadLocationException;
import javax.swing.text.Document;
import javax.swing.text.EditorKit;
import javax.swing.text.rtf.RTFEditorKit;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;

import com.lsgskychefs.cbase.middleware.base.business.AbstractCbaseMiddlewareService;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException.CbaseMiddlewareTechnicalExceptionType;
import com.lsgskychefs.cbase.middleware.common.persistence.CommonRepository;
import com.lsgskychefs.cbase.middleware.common.pojo.ExplodedPackinglistEntry;
import com.lsgskychefs.cbase.middleware.common.pojo.PackinglistExplosionEntry;
import com.lsgskychefs.cbase.middleware.common.pojo.PackinglistExplosionParameter;
import com.lsgskychefs.cbase.middleware.persistence.constant.CenPictureResolutionType;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenAirlines;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistIndex;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistInstructions;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistTypes;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglists;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistsId;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPictureResolution;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRouting;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocOperations;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitAreas;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitCheckpt;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitLabelGroups;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitTrailpoint;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysAirlineCat;
import com.lsgskychefs.cbase.middleware.persistence.general.CenAirlinesRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenPackinglistIndexRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenPackinglistsRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenPictureResolutionRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenRoutingRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.LocOperationsRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.LocUnitAreasRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.LocUnitCheckptRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.LocUnitLabelGroupsRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.LocUnitTrailpointRepository;

/**
 * Service class for the masterdata part of the common component.
 *
 * @author Andreas Morgenstern
 */
@Service
public class MasterDataService extends AbstractCbaseMiddlewareService {

	/** Repository for <code>LocUnitAreas</code> entity. */
	@Autowired
	private LocUnitAreasRepository locUnitAreasRepository;

	/** Repository for {@link LocUnitCheckpt} entity */
	@Autowired
	private LocUnitCheckptRepository locUnitCheckptRepository;

	/** Repository for {@link CenPackinglists} entity. */
	@Autowired
	private CenPackinglistsRepository cenPackinglistsRepository;

	/** Repository for {@link CenPackinglistIndex} entity. */
	@Autowired
	private CenPackinglistIndexRepository cenPackinglistIndexRepository;

	/** Common repository for common native queries */
	@Autowired
	private CommonRepository commonRepository;

	/** Repository for {@link CenRouting} entities. */
	@Autowired
	private CenRoutingRepository cenRoutingRepository;

	/** Repository for {@link LocOperations} entities */
	@Autowired
	private LocOperationsRepository locOperationsRepository;

	/** Repository for {@link LocUnitTrailpoint} entities */
	@Autowired
	private LocUnitTrailpointRepository locUnitTrailpointRepository;

	/** Repository for {@link LocUnitLabelGroups} entities */
	@Autowired
	private LocUnitLabelGroupsRepository locUnitLabelGroupsRepository;

	/** Repository for CenPictureResolution entities */
	@Autowired
	private CenPictureResolutionRepository cenPictureResolutionRepository;

	@Autowired
	private CenAirlinesRepository cenAirlinesRepository;

	/**
	 * Finds and returns a <code>CenAirlines</code> object by primary key.
	 *
	 * @param nAirlineKey the primary key value.
	 * @return The <code>CenAirlines</code> object with the primary key.
	 * @throws CbaseMiddlewareBusinessException of type {@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID} if no {@link CenAirlines}
	 *             for given id is found
	 */
	@Transactional(readOnly = true)
	public CenAirlines getAirlineById(final Long nAirlineKey) throws CbaseMiddlewareBusinessException {
		return findOne(CenAirlines.class, nAirlineKey);
	}

	/**
	 * Finds and returns a <code>List</code> of <code>LocUnitAreas</code> objects by the <code>cunit</code> attribute.
	 *
	 * @param cunit the attribute value used as search parameter.
	 * @return The <code>List<LocUnitAreas></code> found using the given attribute vaule.
	 */
	@Transactional(readOnly = true)
	public List<LocUnitAreas> getAreasAndWorkstations(final String cunit) {
		return locUnitAreasRepository.findByCunitOrderByCareaAscCtextAsc(cunit);
	}

	/**
	 * Get defined checkpoint definitions, for given unit.
	 *
	 * @param cunit company of the region
	 * @return checkpoint definitions
	 */
	public List<LocUnitCheckpt> findCheckpointDefinitions(final String cunit) {
		return locUnitCheckptRepository.findByCunitOrderByNsort(cunit);
	}

	/**
	 * Get the packinglists for given workstation id
	 *
	 * @param nworkstationKey id of workstation
	 * @param date filter date for validFrom <-> validTo
	 * @return packinglists
	 */
	public List<CenPackinglists> getPackinglistByWorkstation(
			final long nworkstationKey,
			final Date date) {
		return cenPackinglistsRepository.findPackinglistByWorkstation(nworkstationKey, date);
	}

	/**
	 * Get {@link CenPackinglistIndex} by cpackinglist.
	 *
	 * @param cpackinglist the packinglist identifier
	 * @return the packinglist index
	 */
	public CenPackinglistIndex getPackinglistIndex(final String cpackinglist) {
		return cenPackinglistIndexRepository.findByCpackinglist(cpackinglist);
	}

	/**
	 * Checks if an instruction text exists for the given {@link CenPackinglists}. The function checks the length of the document also!
	 *
	 * @param npackinglistIndexKey the first part of the PK
	 * @param npackinglistDetailKey the second part of the PK
	 * @return true or false
	 * @throws CbaseMiddlewareBusinessException if no CenPackinglist is found {@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID}
	 */
	public boolean hasPackinglistInstruction(
			@PathVariable final Long npackinglistIndexKey,
			@PathVariable final Long npackinglistDetailKey) throws CbaseMiddlewareBusinessException {

		final CenPackinglistsId pk = new CenPackinglistsId(npackinglistIndexKey, npackinglistDetailKey);
		final CenPackinglists packinglist = getCenPackinglist(pk);
		final CenPackinglistInstructions packinglistInstruction = packinglist.getCenPackinglistInstructions();
		if (packinglistInstruction == null) {
			return false;
		}

		final RTFEditorKit rtfParser = new RTFEditorKit();
		final Document document = rtfParser.createDefaultDocument();
		try {
			boolean reallyContentInside = true;
			final String carriageReturn = "\n";
			InputStream binaryStream;
			binaryStream = packinglistInstruction.getBrichtext().getBinaryStream();
			rtfParser.read(binaryStream, document, 0);
			final int length = document.getLength();
			// How this is checked in CBASEclassic
			// if this.ole_rich.LineCount() = 1 and this.ole_rich.LineLength() = 0 then LEER
			if (length == 0) {
				reallyContentInside = false;
			} else if (length <= 2) {
				final String content = document.getText(0, length);
				if (carriageReturn.equals(content)) {
					reallyContentInside = false;
				}
			}
			return reallyContentInside;
		} catch (final IOException | BadLocationException | SQLException e) {
			throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.UNKNOWN, "Error reading rtf from database.",
					e);
		}
	}

	/**
	 * Load the exlposion entries.
	 *
	 * @param param the parameter values
	 * @return the explosion entries
	 */
	public List<PackinglistExplosionEntry> getPackinglistExplosionData(final PackinglistExplosionParameter param) {
		return commonRepository.findPackinglistExplosionData(param);
	}

	/**
	 * Get the explosion of an packinglist in object hierarchy. Contains itself at first level.
	 * 
	 * @param param the parameter values
	 * @return {@link ExplodedPackinglistEntry}
	 */
	public ExplodedPackinglistEntry explodePackinglist(final PackinglistExplosionParameter param) {
		ExplodedPackinglistEntry parent = null;
		final List<ExplodedPackinglistEntry> flatList = commonRepository.explodePackinglist(param);
		if (!flatList.isEmpty()) {
			parent = flatList.get(0);
			final List<ExplodedPackinglistEntry> allChildren = new ArrayList<>(flatList.subList(1, flatList.size()));
			addChildsRecursively(allChildren, parent);
		}

		return parent;
	}

	/**
	 * Parses a Flat list and brings it in object oriented format
	 * 
	 * @param children List with entries nlevel > parent!
	 * @param parent the parent where to add the given children
	 */
	private void addChildsRecursively(final List<ExplodedPackinglistEntry> children, final ExplodedPackinglistEntry parent) {
		ExplodedPackinglistEntry current;
		int i;
		int x;

		for (i = 0; i < children.size(); i++) {
			current = children.get(i);
			if (current.getNlevel() == parent.getNlevel() + 1) {
				parent.getChildren().add(current);
			} else if (current.getNlevel() > parent.getNlevel() + 1) {
				// Find the next row with nlevel == parent's + 1 which is the next child of this parent
				for (x = i + 1; x < children.size(); x++) {
					if (children.get(x).getNlevel() == parent.getNlevel() + 1) {
						break;
					}
				}
				// Extract all children which belong to the current
				final List<ExplodedPackinglistEntry> nextLevelChilds = new ArrayList<>(children.subList(i, x));

				// next outer loop must be the one we found with the same nLevel belonging to our parent (so -1 cause loop will increment)
				i = x - 1;

				// These records belong to the last child of the parent
				final ExplodedPackinglistEntry lastChild = parent.getChildren().get(parent.getChildren().size() - 1);

				// and go recursive
				addChildsRecursively(nextLevelChilds, lastChild);
			} else {
				throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.INVALID_ARGUMENT,
						"The List contains an item with unexpected nlevel at this point");
			}
		}

	}

	/**
	 * Load the exlposion entries with original unit.
	 *
	 * @param param the parameter values
	 * @return the explosion entries
	 */
	public List<PackinglistExplosionEntry> getPackinglistExplosionWOUData(final PackinglistExplosionParameter param) {
		return commonRepository.findPackinglistExplosionWOUData(param);
	}

	/**
	 * Get the CenPackinglists for given index key
	 *
	 * @param npackinglistIndexKey the index key
	 * @return the list of CenPackinglists
	 */
	public List<CenPackinglists> getPackinglists(final long npackinglistIndexKey) {
		return cenPackinglistsRepository.findByIdNpackinglistIndexKey(npackinglistIndexKey);
	}

	/**
	 * Get the packinglist which is valid for the given date
	 * 
	 * @param npackinglistIndexKey
	 * @param date
	 * @return {@link CenPackinglists}
	 */
	public CenPackinglists getPackinglist(final long npackinglistIndexKey, final Date date) {
		return cenPackinglistsRepository.findPackinglistByNpackinglistIndexKeyAndDdate(npackinglistIndexKey, date);
	}

	/**
	 * Get the packinglist which is valid for the given date
	 * 
	 * @param cpackinglist
	 * @param date
	 * @return {@link CenPackinglists}
	 */
	public CenPackinglists getPackinglist(final String cpackinglist, final Date date) {
		return cenPackinglistsRepository.findPackinglistByCpackinglistAndDdate(cpackinglist, date);
	}

	/**
	 * Get the Thumbnail picture for a given picture index
	 * 
	 * @param npackinglistIndexKey key for {@link CenPackinglistIndex}
	 * @param npackinglistDetailKey key for {@link CenPackinglists}
	 * @param nresolution the resolution type {@link CenPictureResolutionType}
	 * @return {@link CenPictureResolution} or null if not found
	 */
	public CenPictureResolution getPackinglistPictureThumbnail(final Long npackinglistIndexKey, final Long npackinglistDetailKey,
			final Integer nresolution) {
		return cenPictureResolutionRepository.findPackingListThumbnailPicture(npackinglistIndexKey, npackinglistDetailKey, nresolution);
	}

	/**
	 * Load the {@link CenPackinglists} by id.
	 *
	 * @param id the primary key
	 * @return the {@link CenPackinglists}
	 * @throws CbaseMiddlewareBusinessException if no CenPackinglists is found {@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID}
	 */
	public CenPackinglists getCenPackinglist(final CenPackinglistsId id) throws CbaseMiddlewareBusinessException {
		return findOne(CenPackinglists.class, id);
	}

	/**
	 * Load all {@link CenAirlines}
	 *
	 * @return all airlines
	 */
	public List<CenAirlines> getAirlines() {
		return findAll(CenAirlines.class);
	}

	/**
	 * Load all active airlines
	 * 
	 * @return list of active {@link CenAirlines}
	 * @throws CbaseMiddlewareBusinessException
	 */
	public List<CenAirlines> getActiveAirlines() throws CbaseMiddlewareBusinessException {
		final List<CenAirlines> activeAirlines = new ArrayList<>();
		final List<Long> activeAirlineKeys = cenAirlinesRepository.findActiveAirlines();

		for (final Long activeAirlineKey : activeAirlineKeys) {
			final CenAirlines activeAirline = findOne(CenAirlines.class, activeAirlineKey);
			activeAirlines.add(activeAirline);
		}
		return activeAirlines;
	}

	/**
	 * Finds and returns a <code>List</code> of <code>CenRouting</code> objects.
	 *
	 * @return The <code> List<CenRouting></code> found using the given attribute value.
	 */
	@Transactional(readOnly = true)
	public List<CenRouting> getCenRouting() {
		return cenRoutingRepository.findByCclient(getClient());
	}

	/**
	 * All Operation Times for the given unit
	 * 
	 * @param cunit the unit
	 * @return The <code> List<LocOperations></code>.
	 */
	@Transactional(readOnly = true)
	public List<LocOperations> getOps(final String cunit) {
		return locOperationsRepository.findByIdCclientAndIdCunitOrderByNsort(getClient(), cunit);
	}

	/**
	 * All Trailpoints for given Unit
	 * 
	 * @param cunit the unit
	 * @return list of {@link LocUnitTrailpoint}
	 */
	public List<LocUnitTrailpoint> getTrailpoints(final String cunit) {
		return locUnitTrailpointRepository.findBySysUnitsCunitOrderByNsort(cunit);
	}

	/**
	 * All Airline-Categories
	 * 
	 * @return List<SysAirlineCat>
	 */
	public List<SysAirlineCat> getAirlineCategories() {
		return findAll(SysAirlineCat.class);
	}

	/**
	 * Converts RTF to HTML
	 * 
	 * @param rtf
	 * @return
	 * @throws IOException
	 * @throws BadLocationException
	 */
	public static String rtfToHtml(final Reader rtf) throws IOException, BadLocationException {
		final JEditorPane p = new JEditorPane();
		p.setContentType("text/rtf");
		EditorKit kitRtf = p.getEditorKitForContentType("text/rtf");

		kitRtf.read(rtf, p.getDocument(), 0);
		kitRtf = null;
		final EditorKit kitHtml = p.getEditorKitForContentType("text/html");
		final Writer writer = new StringWriter();
		kitHtml.write(writer, p.getDocument(), 0, p.getDocument().getLength());
		return writer.toString();

	}

	/**
	 * Get the Instruction for a Packinglist as HTML Text
	 * 
	 * @param npackinglistIndexKey
	 * @param npackinglistDetailKey
	 * @return Instruction in HTML Text
	 * @throws IOException
	 * @throws CbaseMiddlewareBusinessException
	 * @throws SQLException
	 * @throws BadLocationException
	 */
	public String getPackinglistInstructionsHtml(final long npackinglistIndexKey, final long npackinglistDetailKey)
			throws SQLException, IOException, CbaseMiddlewareBusinessException, BadLocationException {
		final CenPackinglistsId cpiId = new CenPackinglistsId(npackinglistIndexKey, npackinglistDetailKey);
		CenPackinglistInstructions cpi = null;
		cpi = findOne(CenPackinglistInstructions.class, cpiId);
		final InputStreamReader inStreamReader = new InputStreamReader(cpi.getBrichtext().getBinaryStream(), StandardCharsets.UTF_8);
		return MasterDataService.rtfToHtml(inStreamReader);
	}

	/**
	 * List of Label Groups for given Unit
	 * 
	 * @param cunit the unit
	 * @return List of {@link LocUnitLabelGroups}
	 */
	public List<LocUnitLabelGroups> getLabelGroups(final String cunit) {
		return locUnitLabelGroupsRepository.findByCunitAndCclientOrderByCtext(cunit, getLoginUser().getLogin().getCclient());
	}

	/**
	 * List of PackinglistTypes
	 * 
	 * @return List<CenPackinglistTypes>
	 */
	public List<CenPackinglistTypes> getPackinglistTypes() {
		return findAll(CenPackinglistTypes.class);
	}

}
