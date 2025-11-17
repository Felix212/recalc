/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.masterdata.business;

import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.imageio.ImageIO;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BadPdfFormatException;
import com.itextpdf.text.pdf.PRStream;
import com.itextpdf.text.pdf.PdfCopy;
import com.itextpdf.text.pdf.PdfImportedPage;
import com.itextpdf.text.pdf.PdfName;
import com.itextpdf.text.pdf.PdfNumber;
import com.itextpdf.text.pdf.PdfObject;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfSmartCopy;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.PdfStream;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.draw.LineSeparator;
import com.itextpdf.text.pdf.parser.PdfImageObject;
import com.lsgskychefs.cbase.middleware.base.business.AbstractCbaseMiddlewareService;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException.CbaseMiddlewareTechnicalExceptionType;
import com.lsgskychefs.cbase.middleware.common.masterdata.pojo.FlightStowageDocsEntry;
import com.lsgskychefs.cbase.middleware.common.masterdata.pojo.GalleyResponse;
import com.lsgskychefs.cbase.middleware.common.masterdata.pojo.StowageItemListEntry;
import com.lsgskychefs.cbase.middleware.common.masterdata.pojo.StowageResponse;
import com.lsgskychefs.cbase.middleware.common.persistence.CommonRepository;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenCateringUoPdf;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenGalley;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenObjectEquipment;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOut;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMeals;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutSpmlDetail;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistPictures;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglists;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPictures;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenStowage;
import com.lsgskychefs.cbase.middleware.persistence.general.CenCateringUoPdfRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutMealsRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutSpmlDetailRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenStowageRepository;

/**
 * Service class for the flight stowage 'masterdata' part of the common component.
 *
 * @author Ingo Rietzschel - U125742
 */
@Service
public class MasterDataFlightStowageService extends AbstractCbaseMiddlewareService {

	/** Common repository for common native queries */
	@Autowired
	private CommonRepository commonRepository;

	/** Repository for {@link CenStowage} entities. */
	@Autowired
	private CenStowageRepository cenStowageRepository;

	/** Repository for {@link CenOutMeals} entities. */
	@Autowired
	private CenOutMealsRepository cenOutMealsRepository;

	/** Repository for {@link CenOutSpmlDetail} entities. */
	@Autowired
	private CenOutSpmlDetailRepository cenOutSpmlDetailRepository;

	/** Repository for {@link CenCateringUoPdf} entities. */
	@Autowired
	private CenCateringUoPdfRepository cenCateringUoPdfRepository;

	/** LSG defined color */
	private static final BaseColor PANTONE_306C = new BaseColor(0, 181, 226);

	/**
	 * Load all {@link CenObjectEquipment}
	 *
	 * @return all objectEquipments
	 */
	@Transactional(readOnly = true)
	public List<CenObjectEquipment> getObjectEquipments() {
		return findAll(CenObjectEquipment.class);
	}

	/**
	 * Loads all {@link CenStowage} from Masterdata
	 *
	 * @param cairline the Airline
	 * @param cactype the Aircraft Type
	 * @param cgalleyversion the Version for Aircraft type
	 * @return all storages
	 */
	public List<CenStowage> getStowages(
			final String cairline,
			final String cactype,
			final String cgalleyversion) {
		return cenStowageRepository.findStowagesByAirlineAndAircraft(cairline, cactype, cgalleyversion);
	}

	/**
	 * Get a Galley > Stowage structure for an aircraft with size information - a.k.a. Galley Graphic
	 * 
	 * @param cairlineOwner the Airline owner
	 * @param cactype the Aircraft Type
	 * @param cgalleyversion the Version for Aircraft
	 * @return list of {@link GalleyResponse}
	 */
	public List<GalleyResponse> getStowagesWithSizeInformation(@RequestParam final String cairlineOwner,
			@RequestParam final String cactype,
			@RequestParam final String cgalleyversion) {

		final List<CenStowage> cenStowages = this.getStowages(cairlineOwner, cactype, cgalleyversion);

		final List<CenObjectEquipment> objectEquipments = this.getObjectEquipments();
		final Map<Long, CenObjectEquipment> objectEquipementMap = new HashMap<>();
		for (final CenObjectEquipment object : objectEquipments) {
			objectEquipementMap.put(object.getNequipmentKey(), object);
		}

		final Map<CenGalley, List<CenStowage>> stowageMap = new HashMap<>();
		for (final CenStowage stowage : cenStowages) {
			final CenGalley galley = stowage.getCenGalley();

			List<CenStowage> stowageList = stowageMap.get(galley);
			if (stowageList == null) {
				stowageList = new ArrayList<>();
				stowageMap.put(galley, stowageList);
			}
			stowageList.add(stowage);

		}

		try {
			// galley -> stowages -> objectEquipment
			final List<GalleyResponse> galleys = new ArrayList<>();
			for (final Entry<CenGalley, List<CenStowage>> stowageEntry : stowageMap.entrySet()) {

				final GalleyResponse galleyR = new GalleyResponse();
				BeanUtils.copyProperties(galleyR, stowageEntry.getKey());
				galleys.add(galleyR);

				final List<StowageResponse> stowages = new ArrayList<>();
				galleyR.setStowages(stowages);

				for (final CenStowage stowage : stowageEntry.getValue()) {
					final StowageResponse stowageR = new StowageResponse();
					BeanUtils.copyProperties(stowageR, stowage);
					stowageR.setObjectEquipment(objectEquipementMap.get(stowage.getNequipmentKey()));
					stowages.add(stowageR);

				}
			}

			return galleys;
		} catch (final IllegalAccessException | InvocationTargetException e) {
			throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.UNKNOWN,
					"Error on copy property to response object", e);
		}
	}

	/**
	 * Gets the flight stowage item list data.<br>
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @return the flight stowage item list data
	 */
	public List<StowageItemListEntry> getStowageItemList(@RequestParam final long nresultKey) {
		return commonRepository.findStowageItemList(nresultKey);
	}

	/**
	 * Load all pictures for given flight (stowage -> packinglists)
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @return the pictures as map with cpackinglist as key
	 */
	public Map<String, CenPictures> getStowagePackinglistsPictures(final long nresultKey) {
		final Map<String, CenPictures> packinglistPictureMap = new HashMap<>();

		final List<CenOutMeals> meals = cenOutMealsRepository.findByMealsWithPictures(nresultKey);
		for (final CenOutMeals meal : meals) {
			final CenPackinglists packinglist = meal.getCenPackinglists();
			final CenPackinglistPictures packinglistPicture = packinglist.getCenPackinglistPictures();
			if (packinglistPicture != null) {
				packinglistPictureMap.put(meal.getCpackinglist(), packinglistPicture.getCenPictures());
			}
		}

		final List<CenOutSpmlDetail> spmlDetails = cenOutSpmlDetailRepository.findBySpmlsWithPictures(nresultKey);
		for (final CenOutSpmlDetail spmlDetail : spmlDetails) {
			final CenPackinglists packinglist = spmlDetail.getCenPackinglists();
			final CenPackinglistPictures packinglistPicture = packinglist.getCenPackinglistPictures();
			if (packinglistPicture != null) {
				packinglistPictureMap.put(spmlDetail.getCpackinglist(), packinglistPicture.getCenPictures());
			}
		}

		return packinglistPictureMap;
	}

	/**
	 * Load all documents for flight.
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @param out the output stream to write the created report
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>CbaseMiddlewareBusinessExceptionType.UNKNOWN_ID - if no flight is found
	 *             <li>CbaseMiddlewareBusinessExceptionType.NOT_FOUND - No documents(FlightStowageDocsEntry) or documents
	 *             data(CenCateringUoPdf) for this flight event
	 *             <li>CbaseMiddlewareBusinessExceptionType.UNKNOWN - Error to merge PDF the files.
	 *             </ul>
	 * @throws IOException on any error on response handling
	 */
	public void getFlightStowagePdf(final long nresultKey, final OutputStream out) throws CbaseMiddlewareBusinessException, IOException {
		final CenOut flight = findOne(CenOut.class, nresultKey);
		final String cflightKey = flight.getCflightKey();
		final List<FlightStowageDocsEntry> pdfDocs = loadRelevantPdfs(flight);

		final Document mergedDoc = new Document();
		try {
			final List<HashMap<String, Object>> outlines = new ArrayList<>();
			final PdfCopy copy = new PdfSmartCopy(mergedDoc, out);

			// meta data
			mergedDoc.open();
			mergedDoc.addTitle("FlightStowageDocuments " + cflightKey);
			mergedDoc.addAuthor(configService.getApplicationName() + " " + configService.getVersion());
			mergedDoc.addKeywords("flight, documents, pdf");

			// merge documents
			int pageNo = 1;
			int docNo = 1;
			for (final FlightStowageDocsEntry pdfDoc : pdfDocs) {
				final String ccateringUoName = pdfDoc.getCcateringUoName();

				// create and add subtitle inclusive bookmark
				addOutline(outlines, docNo + ". " + ccateringUoName, pageNo);
				final List<Phrase> content = createContentForDocumentSeparatorPage(cflightKey, pageNo, ccateringUoName);
				final ByteArrayOutputStream subtitle = createPdf(content.toArray(new Phrase[content.size()]));
				pageNo += addPdf(copy, subtitle.toByteArray());
				pageNo += addPdf(copy, pdfDoc.getPdf().getBpdfBlob());
				docNo++;
			}

			// add bookmarks
			copy.setOutlines(outlines);

			out.flush();

		} catch (final DocumentException | IOException e) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.UNKNOWN, "Error to merge PDF the files.", e);
		} finally {
			if (mergedDoc.isOpen()) {
				mergedDoc.close();
			}

			out.close();
		}
	}

	/**
	 * Create content for separator page between different PDF-Documents.
	 *
	 * @param cflightKey the flightKey from handled flight
	 * @param pageNo the current page id
	 * @param ccateringUoName the Title
	 * @return the content as List of {@link Phrase}
	 */
	private List<Phrase> createContentForDocumentSeparatorPage(final String cflightKey, final int pageNo, final String ccateringUoName) {
		final List<Phrase> list = new ArrayList<>();
		if (pageNo == 1) { // extra text on first page
			list.add(new Phrase("All Documents for the flight.\n"));
			list.add(new Phrase(cflightKey + "\n"));
			final LineSeparator lineSeparator = new LineSeparator(1, 100, PANTONE_306C, Element.ALIGN_CENTER, 0);
			list.add(new Phrase(new Chunk(lineSeparator)));
			list.add(new Phrase("\n" + ccateringUoName));
		} else {
			list.add(new Phrase(ccateringUoName));
		}
		return list;
	}

	/**
	 * Load relevant PDFs.
	 *
	 * @param flight handled flight
	 * @return the list of relevant PDF documents
	 * @throws CbaseMiddlewareBusinessException CbaseMiddlewareBusinessExceptionType.NOT_FOUND - No documents(FlightStowageDocsEntry) or
	 *             documents data(CenCateringUoPdf) for this flight event
	 */
	private List<FlightStowageDocsEntry> loadRelevantPdfs(final CenOut flight) throws CbaseMiddlewareBusinessException {
		final List<FlightStowageDocsEntry> docs = commonRepository.findFlightStowageDocs(flight.getNresultKey());
		if (docs.isEmpty()) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.NOT_FOUND,
					"No documents(FlightStowageDocsEntry) for this flight event! nresultKey=" + flight.getNresultKey());
		}
		final Map<Long, FlightStowageDocsEntry> docMap = new LinkedHashMap<>();
		for (final FlightStowageDocsEntry flightStowageDocsEntry : docs) {
			docMap.put(flightStowageDocsEntry.getNcateringUserobjectId(), flightStowageDocsEntry);
		}
		final List<CenCateringUoPdf> docData = cenCateringUoPdfRepository.findByIdAndDate(docMap.keySet(), flight.getDdeparture());
		final List<FlightStowageDocsEntry> docList = new ArrayList<>();
		for (final CenCateringUoPdf pdf : docData) {
			final FlightStowageDocsEntry docEntry = docMap.get(pdf.getId().getNcateringUserobjectId());
			docEntry.setPdf(pdf);
			docList.add(docEntry);
		}
		if (docList.isEmpty()) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.NOT_FOUND,
					"No documents data(CenCateringUoPdf) for this flight event! nresultKey=" + flight.getNresultKey());
		}
		return docList;
	}

	/**
	 * Create the Outline/Bookmark and add to the given list of outlines
	 *
	 * @param outlines the bookmark list
	 * @param title the title for new Bookmark
	 * @param pageNo the page numbers referenced
	 */
	private void addOutline(final List<HashMap<String, Object>> outlines, final String title, final int pageNo) {
		final HashMap<String, Object> outline = new HashMap<>();
		outline.put("Title", title);
		outline.put("Action", "GoTo");
		outline.put("Page", String.format("%d Fit", pageNo));
		outlines.add(outline);
	}

	/**
	 * Create a new PDF page with given text and return as output stream
	 *
	 * @param txt the content for created PDF page
	 * @return the created PDF page as output stream
	 * @throws DocumentException Error to create PDF
	 */
	private ByteArrayOutputStream createPdf(final Phrase... txt) throws DocumentException {
		final ByteArrayOutputStream baos = new ByteArrayOutputStream();
		final Document doc = new Document();
		try {
			final float fontSize = 30f;
			final float spacing = 250f;
			final double factor = 1.5;
			PdfWriter.getInstance(doc, baos);
			doc.open();
			final Paragraph paragraph = new Paragraph();
			final Paragraph p = new Paragraph(" ");
			doc.add(p);
			final Font font = new Font(FontFamily.HELVETICA, fontSize, Font.BOLD);
			font.setColor(PANTONE_306C);
			paragraph.setFont(font);
			paragraph.setSpacingBefore(spacing);
			paragraph.addAll(new ArrayList<>(Arrays.asList(txt)));
			paragraph.setAlignment(Element.ALIGN_CENTER);
			paragraph.setLeading(BigDecimal.valueOf(fontSize).multiply(BigDecimal.valueOf(factor)).floatValue());
			doc.add(paragraph);

			return baos;
		} finally {
			if (doc.isOpen()) {
				doc.close();
			}
		}
	}

	/**
	 * Add the given pdf byte[] to given PdfCopy.
	 *
	 * @param copy PDF copy
	 * @param pdf the PDF to merge into mergedDoc
	 * @return number of pages for given pdf
	 * @throws IOException Error to read the given byte[] as PDF.
	 * @throws BadPdfFormatException
	 */
	private int addPdf(final PdfCopy copy, final byte[] pdf) throws IOException, BadPdfFormatException {
		final PdfReader pdfReader = new PdfReader(pdf);
		final int numberOfPages = pdfReader.getNumberOfPages();
		for (int i = 1; i <= numberOfPages; i++) {
			final PdfImportedPage page = copy.getImportedPage(pdfReader, i);
			copy.addPage(page);
		}
		return numberOfPages;
	}

	/**
	 * Gets the most out of iText's out of the box pdf compression + scales all images inside a PDF to 50%
	 * 
	 * @param in InputStream
	 * @param out OutputStream
	 * @throws IOException
	 * @throws com.itextpdf.text.DocumentException
	 */
	public void compressPdf(final InputStream in, final OutputStream out) throws IOException, com.itextpdf.text.DocumentException {
		final float factor = 0.5f;
		final com.itextpdf.text.pdf.PdfReader reader = new com.itextpdf.text.pdf.PdfReader(in);
		final int n = reader.getXrefSize();

		boolean skipProcessing = false;

		reader.removeFields();
		reader.removeUnusedObjects();

		// Look for image and manipulate image stream
		for (int i = 0; i < n; i++) {
			PdfObject object = reader.getPdfObject(i);
			skipProcessing = object == null || !object.isStream();

			PRStream stream = null;
			if (!skipProcessing) {
				stream = (PRStream) object;
				skipProcessing = !PdfName.IMAGE.equals(stream.getAsName(PdfName.SUBTYPE))
						|| !PdfName.DCTDECODE.equals(stream.getAsName(PdfName.FILTER));
			}

			PdfImageObject image = null;
			BufferedImage bi = null;
			if (!skipProcessing) {
				image = new PdfImageObject(stream);
				bi = image.getBufferedImage();
				skipProcessing = bi == null;
			}

			int width = 0;
			int height = 0;
			if (!skipProcessing && bi != null) {
				width = (int) ((double) bi.getWidth() * factor);
				height = (int) ((double) bi.getHeight() * factor);
				skipProcessing = width <= 0 || height <= 0;
			}

			if (!skipProcessing) {
				final BufferedImage img = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
				final AffineTransform at = AffineTransform.getScaleInstance(factor, factor);
				final Graphics2D g = img.createGraphics();
				g.drawRenderedImage(bi, at);
				final ByteArrayOutputStream imgBytes = new ByteArrayOutputStream();
				ImageIO.write(img, "JPG", imgBytes);

				if (stream != null) {
					stream.clear();
					stream.setData(imgBytes.toByteArray(), false, PdfStream.BEST_COMPRESSION);
					stream.put(PdfName.TYPE, PdfName.XOBJECT);
					stream.put(PdfName.SUBTYPE, PdfName.IMAGE);
					stream.put(PdfName.FILTER, PdfName.DCTDECODE);
					stream.put(PdfName.WIDTH, new PdfNumber(width));
					stream.put(PdfName.HEIGHT, new PdfNumber(height));
					stream.put(PdfName.BITSPERCOMPONENT, new PdfNumber(8));
					stream.put(PdfName.COLORSPACE, PdfName.DEVICERGB);
				}
			}
		}
		reader.removeUnusedObjects();
		// Save altered PDF
		final PdfStamper stamper = new PdfStamper(reader, out);
		stamper.getWriter().setCompressionLevel(PdfStream.BEST_COMPRESSION);
		stamper.getWriter().setFullCompression();
		stamper.setFullCompression();
		stamper.close();
		reader.close();
	}

}
