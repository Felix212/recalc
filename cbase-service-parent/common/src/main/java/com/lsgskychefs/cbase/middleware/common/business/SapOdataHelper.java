/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.business;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;
import java.security.cert.X509Certificate;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TimeZone;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.commons.codec.binary.Base64;
import org.apache.olingo.odata2.api.commons.HttpStatusCodes;
import org.apache.olingo.odata2.api.edm.Edm;
import org.apache.olingo.odata2.api.edm.EdmEntityContainer;
import org.apache.olingo.odata2.api.edm.EdmEntitySet;
import org.apache.olingo.odata2.api.edm.EdmFunctionImport;
import org.apache.olingo.odata2.api.ep.EntityProvider;
import org.apache.olingo.odata2.api.ep.EntityProviderReadProperties;
import org.apache.olingo.odata2.api.ep.EntityProviderWriteProperties;
import org.apache.olingo.odata2.api.ep.entry.ODataEntry;
import org.apache.olingo.odata2.api.ep.feed.ODataFeed;
import org.apache.olingo.odata2.api.exception.ODataException;
import org.apache.olingo.odata2.api.processor.ODataResponse;
import org.apache.olingo.odata2.core.commons.ContentType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.lsgskychefs.cbase.middleware.base.business.AbstractCbaseMiddlewareService;
import com.lsgskychefs.cbase.middleware.base.business.SapOdataLogin;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.base.util.SearchAndReplaceInputStream;

/**
 * @author Heiko Rothenbach - U009907
 * @author Dirk Bunk - U200035
 */
@Service
public class SapOdataHelper extends AbstractCbaseMiddlewareService {
	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(SapOdataHelper.class);

	/** configurable url for odata connection */
	@Value("${sap.odata.url}")
	private String sapOdataUrl;

	private static final String HTTP_METHOD_POST = "POST";

	private static final String HTTP_METHOD_PUT = "PUT";

	private static final String HTTP_METHOD_GET = "GET";

	private static final String X_CSRF_TOKEN = "X-CSRF-Token";

	private static final String SEPARATOR = "/";

	private static final String ODATA_SAP_24H = "PT24H00M00S";

	private static final String ODATA_JAVA_24H = "PT23H59M59S";

	/** trust manager that does not validate certificate chains */
	private static final TrustManager[] TRUST_ALL_CERTS = new TrustManager[] {
			new X509TrustManager() {
				@Override()
				public X509Certificate[] getAcceptedIssuers() {
					return new X509Certificate[0];
				}

				@Override()
				public void checkClientTrusted(final X509Certificate[] certs, final String authType) {
					// No check needed
				}

				@Override()
				public void checkServerTrusted(final X509Certificate[] certs, final String authType) {
					// No check needed
				}
			}
	};

	@Value("#{fileHelper.getFile('no-picture-base64.txt')}")
	private String noPictureBase64;

	private HttpsURLConnection initializeConnection(
			final String absolutUri,
			final ContentType contentType,
			final String httpMethod,
			final Map<String, String> additionalHeaders) throws IOException {
		final URL url = new URL(absolutUri);
		final HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
		final SapOdataLogin sapOdataLogin = getLoginUser().getSapLogin();

		connection.setRequestMethod(httpMethod);

		connection.setRequestProperty(X_CSRF_TOKEN, sapOdataLogin.getToken());
		connection.setRequestProperty("Cookie", sapOdataLogin.getCookie());
		connection.setRequestProperty("Accept", contentType.toString());

		if (HTTP_METHOD_POST.equals(httpMethod) || HTTP_METHOD_PUT.equals(httpMethod)) {
			connection.setDoOutput(true);
			connection.setRequestProperty("Content-Type", contentType.toString());
		}

		if (additionalHeaders != null) {
			final Iterator<Map.Entry<String, String>> it = additionalHeaders.entrySet().iterator();
			while (it.hasNext()) {
				final Entry<String, String> pair = it.next();
				connection.setRequestProperty(pair.getKey(), pair.getValue());
			}
		}

		try {
			final SSLContext sc = SSLContext.getInstance("SSL");
			sc.init(null, TRUST_ALL_CERTS, new java.security.SecureRandom());
			connection.setSSLSocketFactory(sc.getSocketFactory());
		} catch (final GeneralSecurityException e) {
			LOGGER.error("A security exception occured!", e);
		}

		return connection;
	}

	private HttpStatusCodes checkStatus(final HttpURLConnection connection) throws CbaseMiddlewareBusinessException, IOException {
		final HttpStatusCodes httpStatusCode = HttpStatusCodes.fromStatusCode(connection.getResponseCode());

		if (httpStatusCode.getStatusCode() >= HttpURLConnection.HTTP_BAD_REQUEST) {
			switch (httpStatusCode.getStatusCode()) {
			case HttpURLConnection.HTTP_UNAUTHORIZED:
				throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.WRONG_PWD,
						"User or Password is wrong");

			case HttpURLConnection.HTTP_FORBIDDEN:
				throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.SPECIAL_AUTHORIZATION,
						"User is missing the needed authorization");

			case HttpURLConnection.HTTP_NOT_FOUND:
				throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.NOT_FOUND, "Odata entry not found");

			default:
				throw new IOException(
						"Http Connection failed with status " + httpStatusCode.getStatusCode() + " " + httpStatusCode.toString());
			}
		}

		return httpStatusCode;
	}

	private HttpURLConnection connect(
			final String relativeUri,
			final ContentType contentType,
			final String httpMethod) throws CbaseMiddlewareBusinessException, IOException {
		final HttpsURLConnection connection = initializeConnection(relativeUri, contentType, httpMethod, null);
		connection.connect();
		checkStatus(connection);
		return connection;
	}

	private String createUri(final String serviceUri, final String entitySetName, final String entityId, final String entityProperty,
			final String urlParameters) {
		String absolutUri = sapOdataUrl + serviceUri + SEPARATOR + entitySetName;

		if (entityId != null) {
			absolutUri += "(" + entityId + ")";
		}

		if (entityProperty != null) {
			absolutUri += "/" + entityProperty;
		}

		if (urlParameters != null) {
			absolutUri += "?" + urlParameters.replaceAll(" ", "%20");
		}

		return absolutUri;
	}

	/**
	 * Reads the Entity Data Model of an OData service
	 * 
	 * @param serviceUri
	 * @return <Code>Edm</Code>
	 * @throws CbaseMiddlewareBusinessException
	 * @throws IOException
	 * @throws ODataException
	 */
	public Edm readEdm(final String serviceUri)
			throws CbaseMiddlewareBusinessException, IOException, ODataException {
		final HttpURLConnection connection = connect(sapOdataUrl + serviceUri + SEPARATOR + "$metadata",
				ContentType.APPLICATION_XML, HTTP_METHOD_GET);

		final InputStream content = connection.getInputStream();
		final Edm edm = EntityProvider.readMetadata(content, false);

		connection.disconnect();
		return edm;
	}

	/**
	 * @param serviceUri
	 * @param username
	 * @param password
	 * @return a new SapOdataLogin entity
	 * @throws CbaseMiddlewareBusinessException
	 * @throws IOException
	 */
	public SapOdataLogin startSession(final String serviceUri, final String username, final String password)
			throws CbaseMiddlewareBusinessException, IOException {
		final URL url = new URL(sapOdataUrl + serviceUri + SEPARATOR + "$metadata");
		final HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
		final String userpass = username + ":" + password;
		final String basicAuth = "Basic " + new String(new Base64().encode(userpass.getBytes(StandardCharsets.UTF_8)));

		connection.setRequestMethod(HTTP_METHOD_GET);
		connection.setRequestProperty("Authorization", basicAuth);
		connection.setRequestProperty(X_CSRF_TOKEN, "Fetch");
		connection.setRequestProperty("Accept", ContentType.APPLICATION_XML.toString());

		try {
			final SSLContext sc = SSLContext.getInstance("SSL");
			sc.init(null, TRUST_ALL_CERTS, new java.security.SecureRandom());
			connection.setSSLSocketFactory(sc.getSocketFactory());
		} catch (final GeneralSecurityException e) {
			LOGGER.error("A security exception occured!", e);
		}

		final HttpStatusCodes connectionStatus = checkStatus(connection);
		if (connectionStatus.getStatusCode() == HttpURLConnection.HTTP_OK) {
			final String cookie = connection.getHeaderField("Set-Cookie");
			final String token = connection.getHeaderField("X-CSRF-TOKEN");
			connection.disconnect();
			return new SapOdataLogin(username, cookie, token);
		} else {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.UNKNOWN, connectionStatus.getInfo());
		}
	}

	/**
	 * Reads a Picture from a URL and converts it to a Base64 string
	 * 
	 * @param pictureUrl
	 * @param pictureType
	 * @return
	 * @throws IOException
	 */
	public String getBase64PictureFromUrl(final String pictureUrl) throws IOException {
		String base64Picture = noPictureBase64;

		if (!pictureUrl.isEmpty()) {
			try {
				final URL url = new URL(pictureUrl);
				final HttpURLConnection connection = (HttpURLConnection) url.openConnection();

				connection.connect();
				final byte[] buffer = streamToArray(connection.getInputStream());
				final byte[] encodedBuffer = Base64.encodeBase64(buffer);
				base64Picture =
						"data:image/" + guessImageMime(encodedBuffer) + ";base64," + new String(encodedBuffer, StandardCharsets.UTF_8);
				connection.disconnect();
			} catch (final IOException e) {
				LOGGER.error("Failed to retrieve picture from server", e);
			}
		}

		return base64Picture;
	}

	/**
	 * Reads the feed of an OData service
	 * 
	 * @param serviceUrl
	 * @param entitySetName
	 * @param urlParameters
	 * @return <Code>ODataFeed</Code>
	 * @throws CbaseMiddlewareBusinessException
	 * @throws IOException
	 * @throws ODataException
	 */
	public ODataFeed readFeed(
			final String serviceUrl,
			final String entitySetName,
			final String urlParameters)
			throws CbaseMiddlewareBusinessException, IOException, ODataException {
		return readFeed(serviceUrl, entitySetName, null, null, entitySetName, urlParameters);
	}

	/**
	 * Reads the feed of an OData service
	 * 
	 * @param serviceUrl
	 * @param entitySetName
	 * @param entityId
	 * @param entityProperty
	 * @param entityPropertySetName
	 * @param urlParameters
	 * @return <Code>ODataFeed</Code>
	 * @throws CbaseMiddlewareBusinessException
	 * @throws IOException
	 * @throws ODataException
	 */
	public ODataFeed readFeed(
			final String serviceUrl,
			final String entitySetName,
			final String entityId,
			final String entityProperty,
			final String entityPropertySetName,
			final String urlParameters)
			throws CbaseMiddlewareBusinessException, IOException, ODataException {
		final ContentType contentType = ContentType.APPLICATION_JSON;
		final Edm edm = readEdm(serviceUrl);
		final EdmEntityContainer entityContainer = edm.getDefaultEntityContainer();
		final String absolutUri = createUri(serviceUrl, entitySetName, entityId, entityProperty, urlParameters);
		final HttpURLConnection connection = connect(absolutUri, contentType, HTTP_METHOD_GET);
		final InputStream contentSap = connection.getInputStream();
		final InputStream content = new SearchAndReplaceInputStream(contentSap, ODATA_SAP_24H, ODATA_JAVA_24H);
		final EdmEntitySet ees = entityContainer.getEntitySet(entityPropertySetName);

		if (ees == null) {
			content.close();
			throw new ODataException("EdmEntitySet for " + entitySetName + " not found");
		}

		final ODataFeed feed = EntityProvider.readFeed(contentType.toString(), ees, content, EntityProviderReadProperties.init().build());
		connection.disconnect();

		return feed;
	}

	/**
	 * Reads one entry of an OData service
	 * 
	 * @param serviceUri
	 * @param entitySetName
	 * @param entityId
	 * @param urlParameters
	 * @return <Code>ODataEntry</Code>
	 * @throws CbaseMiddlewareBusinessException
	 * @throws IOException
	 * @throws ODataException
	 */
	public ODataEntry readEntry(
			final String serviceUri,
			final String entitySetName,
			final String entityId,
			final String urlParameters)
			throws CbaseMiddlewareBusinessException, IOException, ODataException {
		ODataEntry entry = null;

		final ContentType contentType = ContentType.APPLICATION_JSON;
		final Edm edm = readEdm(serviceUri);
		final EdmEntityContainer entityContainer = edm.getDefaultEntityContainer();
		final String absolutUri = createUri(serviceUri, entitySetName, entityId, null, urlParameters);
		final HttpURLConnection connection = connect(absolutUri, contentType, HTTP_METHOD_GET);
		final InputStream contentSap = connection.getInputStream();
		final InputStream content = new SearchAndReplaceInputStream(contentSap, ODATA_SAP_24H, ODATA_JAVA_24H);

		entry = EntityProvider.readEntry(contentType.toString(),
				entityContainer.getEntitySet(entitySetName), content,
				EntityProviderReadProperties.init().build());
		connection.disconnect();

		return entry;
	}

	/**
	 * Creates an OData entry by POSTing data to an OData service
	 * 
	 * @param serviceUri
	 * @param entitySetName
	 * @param data
	 * @return
	 * @throws CbaseMiddlewareBusinessException
	 * @throws IOException
	 * @throws ODataException
	 * @throws URISyntaxException
	 */

	public ODataEntry createEntry(
			final String serviceUri,
			final String entitySetName,
			final Map<String, Object> data)
			throws CbaseMiddlewareBusinessException, IOException, ODataException, URISyntaxException {
		return writeEntry(serviceUri, entitySetName, null, HTTP_METHOD_POST, data, null);
	}

	/**
	 * Replaces an OData entry by PUTing data to an OData service
	 * 
	 * @param serviceUri
	 * @param entitySetName
	 * @param entityId
	 * @param data
	 * @param additionalHeaders
	 * @return
	 * @throws CbaseMiddlewareBusinessException
	 * @throws IOException
	 * @throws ODataException
	 * @throws URISyntaxException
	 */
	public ODataEntry replaceEntry(
			final String serviceUri,
			final String entitySetName,
			final String entityId,
			final Map<String, Object> data,
			final Map<String, String> additionalHeaders)
			throws CbaseMiddlewareBusinessException, IOException, ODataException, URISyntaxException {
		return writeEntry(serviceUri, entitySetName, entityId, HTTP_METHOD_PUT, data, additionalHeaders);
	}

	/**
	 * Invokes an Odata ImportFunction
	 * 
	 * @param serviceUri
	 * @param functionName
	 * @param parameters
	 * @return
	 * @throws CbaseMiddlewareBusinessException
	 * @throws IOException
	 * @throws ODataException
	 * @throws URISyntaxException
	 */
	public ODataEntry invokeFunction(
			final String serviceUri,
			final String functionName,
			final Map<String, Object> parameters)
			throws CbaseMiddlewareBusinessException, IOException, ODataException, URISyntaxException {
		ODataEntry entry = null;

		final ContentType contentType = ContentType.APPLICATION_JSON;
		final Edm edm = readEdm(serviceUri);
		final EdmEntityContainer entityContainer = edm.getDefaultEntityContainer();
		final EdmFunctionImport functionImport = entityContainer.getFunctionImport(functionName);
		final EntityProviderReadProperties properties = EntityProviderReadProperties.init().build();
		final String absolutUri = createUri(serviceUri, functionName, null, null, getParameterString(parameters));
		final HttpURLConnection connection = connect(absolutUri, contentType, HTTP_METHOD_POST);
		final InputStream contentSap = connection.getInputStream();
		final InputStream content = new SearchAndReplaceInputStream(contentSap, ODATA_SAP_24H, ODATA_JAVA_24H);

		entry = EntityProvider.readEntry(contentType.toString(), functionImport.getEntitySet(), content, properties);
		connection.disconnect();

		return entry;
	}

	/**
	 * Writes an OData entry by posting data to an OData service
	 * 
	 * @param serviceUri
	 * @param entitySetName
	 * @param entityId
	 * @param httpMethod
	 * @param data
	 * @return
	 * @throws CbaseMiddlewareBusinessException
	 * @throws IOException
	 * @throws ODataException
	 * @throws URISyntaxException
	 */
	private ODataEntry writeEntry(
			final String serviceUri,
			final String entitySetName,
			final String entityId,
			final String httpMethod,
			final Map<String, Object> data,
			final Map<String, String> additionalHeaders)
			throws CbaseMiddlewareBusinessException, IOException, ODataException, URISyntaxException {
		final ContentType contentType = ContentType.APPLICATION_JSON;
		final Edm edm = readEdm(serviceUri);
		final String absolutUri = createUri(serviceUri, entitySetName, entityId, null, null);
		final HttpURLConnection connection =
				initializeConnection(absolutUri, contentType, httpMethod, additionalHeaders);
		final EdmEntityContainer entityContainer = edm.getDefaultEntityContainer();
		final EdmEntitySet entitySet = entityContainer.getEntitySet(entitySetName);
		final URI rootUri = new URI(entitySetName);
		final EntityProviderWriteProperties properties = EntityProviderWriteProperties.serviceRoot(rootUri).build();
		final ODataResponse response = EntityProvider.writeEntry(contentType.toString(), entitySet, data, properties);
		final InputStream entity = (InputStream) response.getEntity();
		final byte[] buffer = streamToArray(entity);

		// debug logging
		LOGGER.debug(httpMethod + " request on uri '" + absolutUri + "' with content:\n "
				+ new String(buffer, StandardCharsets.UTF_8) + "\n");

		// set data content
		connection.getOutputStream().write(buffer);

		// debug logging
		LOGGER.debug("ResponseMessage: " + connection.getResponseMessage() + " ResponseCode: " + connection.getResponseCode());

		// if a entity is created (via POST request) the response body contains the new created entity
		ODataEntry entry = null;
		final HttpStatusCodes statusCode = HttpStatusCodes.fromStatusCode(connection.getResponseCode());
		if (statusCode == HttpStatusCodes.CREATED) {
			// get the content as InputStream and de-serialize it into an ODataEntry object
			final InputStream content = new SearchAndReplaceInputStream(connection.getInputStream(), ODATA_SAP_24H, ODATA_JAVA_24H);
			entry = EntityProvider.readEntry(contentType.toString(), entitySet, content, EntityProviderReadProperties.init().build());
		} else if (statusCode.getStatusCode() >= HttpStatusCodes.BAD_REQUEST.getStatusCode()) {
			final InputStream errorStream = connection.getErrorStream();
			final String errorJson = new String(streamToArray(errorStream), StandardCharsets.UTF_8);
			final String errorMessage = parseErrorMessageFromJson(errorJson);

			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.FUNCTIONAL_VIOLATION, errorMessage);
		}

		connection.disconnect();

		return entry;
	}

	private String parseErrorMessageFromJson(final String errorJson) {
		final Pattern commentPattern = Pattern.compile("(?:\"error\":.*\"message\":.*\"value\":)(?:\")(.*?)(?:\")");
		final Matcher commentMatcher = commentPattern.matcher(errorJson);
		String errorMessage = "Unknown error";

		while (commentMatcher.find()) {
			for (int groupNo = 1; groupNo <= commentMatcher.groupCount(); groupNo++) {
				errorMessage = commentMatcher.group(groupNo);
			}
		}

		return errorMessage;
	}

	private String getParameterString(final Map<String, Object> parameters) {
		String parameterString = "";

		for (final Map.Entry<String, Object> parameter : parameters.entrySet()) {
			final String value;

			if (parameter.getValue() instanceof String) {
				value = "'" + parameter.getValue() + "'";
			} else if (parameter.getValue() instanceof BigDecimal || parameter.getValue() instanceof Double) {
				value = String.valueOf(parameter.getValue()) + "m";
			} else {
				value = String.valueOf(parameter.getValue());
			}

			if (parameterString.isEmpty()) {
				parameterString = parameter.getKey() + "=" + value;
			} else {
				parameterString = String.join("&", parameterString, parameter.getKey() + "=" + value);
			}
		}

		return parameterString;
	}

	private String guessImageMime(final byte[] data) {
		switch ((char) data[0]) {
		case 'R':
			return "gif";
		case 'i':
			return "png";
		case '/':
		default:
			return "jpeg";
		}
	}

	private byte[] streamToArray(final InputStream stream) throws IOException {
		byte[] result = new byte[0];
		final byte[] tmp = new byte[8192];
		int readCount = stream.read(tmp);
		while (readCount >= 0) {
			final byte[] innerTmp = new byte[result.length + readCount];
			System.arraycopy(result, 0, innerTmp, 0, result.length);
			System.arraycopy(tmp, 0, innerTmp, result.length, readCount);
			result = innerTmp;
			readCount = stream.read(tmp);
		}
		stream.close();
		return result;
	}

	/**
	 * Converts a GregorianCalendar to Date
	 * 
	 * @param calendar
	 * @return
	 */
	public static Date convertToDate(final GregorianCalendar calendar) {
		if (calendar == null) {
			return null;
		} else {
			final Calendar now = Calendar.getInstance();
			final TimeZone currentTimeZone = now.getTimeZone();
			final int offset = currentTimeZone.getOffset(calendar.getTimeInMillis());

			// adjust date using offset of the server's timezone if it is not in the same timezone
			if (!calendar.getTimeZone().getID().equals(currentTimeZone.getID())) {
				calendar.setTimeZone(currentTimeZone);
				calendar.setTimeInMillis(calendar.getTimeInMillis() - offset);
			}

			return calendar.getTime();
		}
	}
}
