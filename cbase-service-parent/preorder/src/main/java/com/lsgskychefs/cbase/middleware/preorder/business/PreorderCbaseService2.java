package com.lsgskychefs.cbase.middleware.preorder.business;

import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.TimeZone;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnNotWebApplication;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import com.lsgskychefs.cbase.middleware.base.business.AbstractRequestService;
import com.lsgskychefs.cbase.middleware.base.business.CenRequestType;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.persistence.constant.CenRequestTypes;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenAirlines;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenClassName;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOut;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglists;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequest;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestFlight;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestPreorder;
import com.lsgskychefs.cbase.middleware.persistence.general.CenAirlinesRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenClassNameRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenPackinglistsRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenRequestFlightRepository;
import com.lsgskychefs.cbase.middleware.preorder.persistence.CenRequestPreorderRepository;
import com.lsgskychefs.cbase.middleware.preorder.pojo.PreorderItem;
import com.lsgskychefs.cbase.middleware.preorder.pojo.PreorderSearchRequest;

import reactor.core.publisher.Mono;

@Service
@ConditionalOnNotWebApplication
@CenRequestType(types = { CenRequestTypes.PREORDER })
public class PreorderCbaseService2 extends AbstractRequestService {
	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(PreorderCbaseService2.class);

	@Autowired
	private WebClient webClient;

	@Autowired
	private CenRequestPreorderRepository cenRequestPreorderRepository;

	@Autowired
	private CenPackinglistsRepository cenPackinglistsRepository;

	@Autowired
	private CenAirlinesRepository cenAirlinesRepository;

	@Autowired
	protected CenRequestFlightRepository cenRequestFlightRepository;

	@Autowired
	protected CenOutRepository cenOutRepository;

	@Autowired
	protected CenClassNameRepository cenClassNameRepository;

	@Autowired
	protected PreorderService preorderService;

	@Override
	protected void init() {
		setServiceName("cbase_preorder_rim");
	}

	@Override
	protected Logger getLogger() {
		return LOGGER;
	}

	@Override
	public Boolean process(final CenRequest jobEntity) {
		LOGGER.info("requesting preorder data from RIM for flight {}", jobEntity.getCflightKey());

		try {
			// TimeUnit.SECONDS.sleep(ThreadLocalRandom.current().nextInt(5, 15 + 1));

			final TimeZone tz = TimeZone.getTimeZone("UTC");
			final DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm'Z'"); // Quoted "Z" to indicate UTC, no
																					// timezone offset
			df.setTimeZone(tz);
			final String departureAsISO = df.format(jobEntity.getDdeparture());

			final PreorderSearchRequest search = new PreorderSearchRequest();
			search.setFromAirportCode(jobEntity.getCtlcFrom());
			search.setFlightDate(departureAsISO);
			search.setFlightNumber(String.valueOf(jobEntity.getNflightNumber()));

			final Mono<PreorderItem[]> result = webClient.post()
					.uri(uriBuilder -> uriBuilder.path("/preorder/api/v1/PreOrder/search/item")
							// .queryParam("TenantCode", "ASA")
							.build())
					.headers(h -> h.add("TenantCode", "ASA")).body(Mono.just(search), PreorderSearchRequest.class)
					.retrieve().bodyToMono(PreorderItem[].class);

			final PreorderItem[] items = result.block();

			final CenRequestFlight cenRequestFlight = addCenRequestFlight(jobEntity);
			final CenAirlines airline = cenAirlinesRepository.findByCairline(jobEntity.getCairline());

			final List<CenRequestPreorder> preorderItems = new ArrayList<>();
			for (final PreorderItem item : items) {

				CenPackinglists cbasePackinglist = cenPackinglistsRepository.findAirlineSpecificByCcustomerPl(
						item.getExternalProductCode(), airline.getNairlineKey(), jobEntity.getDdeparture());

				if (cbasePackinglist == null) {
					cbasePackinglist = cenPackinglistsRepository.findNoneAirlineSpecificByCcustomerPl(
							item.getExternalProductCode(), jobEntity.getDdeparture());
				}

				final CenRequestPreorder preorder = new CenRequestPreorder();
				final String passengertClass = item.getPassengerClass() != null ? item.getPassengerClass() : " ";
				final CenClassName cenClassName = cenClassNameRepository
						.findByIdNairlineKeyAndIdCclass(airline.getNairlineKey(), passengertClass);
				preorder.setCclass(passengertClass);
				preorder.setNclassNumber(cenClassName != null ? (int) cenClassName.getNclassNumber() : 0);
				preorder.setCenRequestFlight(cenRequestFlight);
				preorder.setCcustomerPl(item.getExternalProductCode());
				preorder.setNquantity(new BigDecimal(item.getQuantity()));
				if (cbasePackinglist != null) {
					preorder.setCpackinglist(cbasePackinglist.getCenPackinglistIndex().getCpackinglist());
					preorder.setNpackinglistIndexKey(cbasePackinglist.getId().getNpackinglistIndexKey());
					preorder.setNpackinglistDetailKey(cbasePackinglist.getId().getNpackinglistDetailKey());
				}
				preorderItems.add(preorder);
			}

			cenRequestPreorderRepository.saveAll(preorderItems);

			LOGGER.info("received {} preorders from RIM", items.length);
			return true;

		} catch (final Exception e) {
			jobEntity.setCerrorText(e.getMessage());
			LOGGER.error("Failed to request data from RIM-Preorder Platform", e);
			return false;
		}

//		final CompletableFuture<Boolean> process = preorderService.process(jobEntity);
//
//		try {
//			return process.get();
//		} catch (InterruptedException | ExecutionException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			return false;
//		}
	}

	protected CenRequestFlight addCenRequestFlight(final CenRequest jobEntity)
			throws CbaseMiddlewareBusinessException, IllegalAccessException, InvocationTargetException {
		CenRequestFlight crf;

		final Optional<CenOut> flight = cenOutRepository.findById(jobEntity.getNresultKey());

		if (flight.isPresent()) {
			final CenOut cenOut = flight.get();
			crf = new CenRequestFlight();
			BeanUtils.copyProperties(crf, jobEntity);
			crf.setCenRequest(jobEntity);
			crf.setCairlineOwner(cenOut.getCairlineOwner());
			crf.setCactype(cenOut.getCactype());
			crf.setCconfiguration(cenOut.getCconfiguration());
			crf.setDarrivalDateLocal(cenOut.getDarrivalTimeLoc());
			crf.setCarrivalTimeLocal(cenOut.getCarrivalTime());
			crf.setNaircraftKey(cenOut.getNaircraftKey());
			cenRequestFlightRepository.save(crf);
		} else {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.NOT_FOUND,
					String.format("Could not find flight with nresultKey %s in CenOut!", jobEntity.getNresultKey()));
		}

		return crf;
	}

	private void manuellAccessToken() {
		// final String encodedClientData = Base64Utils
		// .encodeToString("asa-uat-preorder.lsg.client:KHFP9dN4XYPydgs4EbLt".getBytes());

		// final FormInserter<String> fromFormData =
		// BodyInserters.fromFormData("grant_type", "password");
		// fromFormData.with("username", "michael.ortwein");
		// fromFormData.with("password", "an2br3cL!8H");

		// final Mono<PreorderItem[]> result =
		// webClient.post().uri("/identity/connect/token")
		// .header("Authorization", "Basic " +
		// encodedClientData).body(fromFormData).retrieve()
		// .bodyToMono(JsonNode.class).flatMap(tokenResponse -> {
		// final String accessTokenValue =
		// tokenResponse.get("access_token").textValue();
		// return webClient.post()
		// .uri(uriBuilder -> uriBuilder.path("/preorder/api/v1/PreOrder/search/item")
		// // .queryParam("TenantCode", "ASA")
		// .build())
		// .headers(h -> h.setBearerAuth(accessTokenValue))
		// .headers(h -> h.add("TenantCode", "ASA"))
		// .body(Mono.just(search), PreorderSearchRequest.class).retrieve()
		// .bodyToMono(PreorderItem[].class);
		// });
	}

}
