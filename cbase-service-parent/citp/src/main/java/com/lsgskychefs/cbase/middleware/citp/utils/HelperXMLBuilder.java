package com.lsgskychefs.cbase.middleware.citp.utils;

import com.dlh.zambas.mw.client.exception.ClientAPIException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * HelperXMLBuilder class which cannot be instantiated. Contains some useful functions
 *
 * @author U185502
 */
public class HelperXMLBuilder {

    private static final Logger LOGGER = LoggerFactory.getLogger(HelperXMLBuilder.class);
    // pattern package of CAPI
    private static Pattern patternCAPI = Pattern.compile("^com\\.dlh\\.zambas\\.capi\\.data\\.([^.]*)\\.messages\\.([^.]*)$");

    /**
     * Private constructor
     */
    private HelperXMLBuilder() {
    }

    /**
     * Generates a string from a CXF object. The resulting string is readable by a user, as it
     * contains a pretty printed XML version (i.e. with newlines). So ideal for testing purposes.
     *
     * @param object -
     *               the object to be converted to a string
     * @return stringified version of object in XML syntax.
     */
    public static String objectToXmlBuilder(Object object) {
        String stringXML = null;
        try {
            stringXML = objectToXmlString(object);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
        }

        try {
            StringBuilder bld = new StringBuilder(Objects.requireNonNull(stringXML).length());

            int startPos = 0;
            int idx;
            idx = stringXML.indexOf('<', startPos);
            int indent = 0;
            String emptyString = "                                                                                                       ";
            while (idx >= 0) {
                // search the end
                int end = stringXML.indexOf('>', idx + 1);
                String xmlToken = stringXML.substring(idx, end + 1);

                if (xmlToken.startsWith("</")) {
                    // end node
                    if (xmlToken.startsWith("</local")) {
                        xmlToken = "</" + xmlToken.substring(7);
                    }
                    if (!xmlToken.endsWith("Tracker>")) {
                        bld.append("\n").append(emptyString, 0, (indent - 1) * 3).append(xmlToken);
                        indent--;
                    }
                } else {
                    String xmlTokenOutput = xmlToken;
                    if (xmlTokenOutput.startsWith("<local")) {
                        xmlTokenOutput = "<" + xmlTokenOutput.substring(6);
                    }
                    if (!xmlTokenOutput.endsWith("Tracker>")) {
                        indent++;
                        bld.append("\n").append(emptyString, 0, (indent - 1) * 3).append(xmlTokenOutput);
                    }
                }

                startPos = end + 1;
                idx = stringXML.indexOf('<', startPos);
                if (idx > startPos) {
                    // comes to the end of the node
                    String endToken = "</" + xmlToken.substring(1);
                    if (stringXML.startsWith(endToken, idx) && !endToken.endsWith("Tracker>")) {
                        if (endToken.startsWith("</local")) {
                            endToken = "</" + endToken.substring(7);
                        }
                        bld.append(stringXML, startPos, idx);
                        bld.append(endToken);
                        startPos = idx;
                        startPos += endToken.length();
                        idx = stringXML.indexOf('<', startPos);
                        indent--;
                    } else if (!endToken.endsWith("Tracker>")) {
                        bld.append("\n").append(emptyString, 0, indent * 3).append(stringXML, startPos, idx);
                    }
                }
            }
            return bld.toString();
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return stringXML;
        }
    }

    public static String objectToXmlString(Object obj) throws ClientAPIException {
        StringWriter writer = new StringWriter();
        objectToXml(obj, writer);
        return writer.toString();
    }

    public static void objectToXml(Object obj, Writer writer) throws ClientAPIException {
        try {
            XMLStreamWriter xmlwriter = XMLOutputFactory.newInstance().createXMLStreamWriter(writer);
            String name = obj.getClass().getName();
            Matcher m = patternCAPI.matcher(name);
            if (m.matches())
                name = m.group(1) + "_" + m.group(2);
            writeXml(xmlwriter, obj, name);
            xmlwriter.close();
        } catch (Exception e) {
            LOGGER.error("Internal error: can't convert object to XML stream" + e, e);
            throw new ClientAPIException("Internal error: can't convert object to XML stream", e);
        }
    }

    private static void writeXml(XMLStreamWriter writer, Object obj, String name) throws Exception {
        if (obj != null) {
            writer.writeStartElement(name);
            if (obj.getClass().equals(java.lang.String.class))
                writer.writeCharacters((String) obj);
            else if (obj.getClass().equals(java.math.BigInteger.class))
                writer.writeCharacters(obj.toString());
            else if (obj.getClass().equals(java.math.BigDecimal.class))
                writer.writeCharacters(obj.toString());
            else if (obj.getClass().equals(java.lang.Integer.class))
                writer.writeCharacters(obj.toString());
            else if (obj.getClass().equals(java.lang.Long.class))
                writer.writeCharacters(obj.toString());
            else if (obj.getClass().equals(java.lang.Boolean.class)) {
                writer.writeCharacters(obj.toString());
            } else {
                Field[] fields = obj.getClass().getDeclaredFields();
                for (Field field : fields) {
                    if (field.getName().startsWith("__") || Modifier.isStatic(field.getModifiers()))
                        continue;
                    field.setAccessible(true);
                    Class fieldType = field.getType();

                    if (compareIntegerType(writer, obj, field, fieldType)) continue;

                    if (compareLongType(writer, obj, field, fieldType)) continue;

                    if (compareShortType(writer, obj, field, fieldType)) continue;

                    if (compareByteType(writer, obj, field, fieldType)) continue;

                    if (compareFloatType(writer, obj, field, fieldType)) continue;

                    if (compareDoubleType(writer, obj, field, fieldType)) continue;

                    if (compareBooleanType(writer, obj, field, fieldType)) continue;

                    if (compareByteArrayType(writer, obj, field, fieldType)) continue;

                    if (fieldType.isArray()) {
                        switch (fieldType.getComponentType().getName()) {
                            case "int": {
                                int[] arr = (int[]) field.get(obj);
                                if (arr == null)
                                    continue;
                                for (int i : arr) {
                                    writeXml(writer, i, field.getName());
                                }
                                break;
                            }
                            case "short": {
                                short[] arr = (short[]) field.get(obj);
                                if (arr == null)
                                    continue;
                                for (short i : arr) {
                                    writeXml(writer, i, field.getName());
                                }
                                break;
                            }
                            case "byte": {
                                byte[] arr = (byte[]) field.get(obj);
                                if (arr == null)
                                    continue;
                                for (byte b : arr) {
                                    writeXml(writer, b, field.getName());
                                }
                                break;
                            }
                            case "float": {
                                float[] arr = (float[]) field.get(obj);
                                if (arr == null)
                                    continue;
                                for (float v : arr) {
                                    writeXml(writer, v, field.getName());
                                }
                                break;
                            }
                            case "double": {
                                double[] arr = (double[]) field.get(obj);
                                if (arr == null)
                                    continue;
                                for (double v : arr) {
                                    writeXml(writer, v, field.getName());
                                }
                                break;
                            }
                            case "long": {
                                long[] arr = (long[]) field.get(obj);
                                if (arr == null)
                                    continue;
                                for (long l : arr) {
                                    writeXml(writer, l, field.getName());
                                }
                                break;
                            }
                            case "boolean": {
                                boolean[] arr = (boolean[]) field.get(obj);
                                if (arr == null)
                                    continue;
                                for (boolean b : arr) {
                                    writeXml(writer, b, field.getName());
                                }
                                break;
                            }
                            default: {
                                Object[] arr = (Object[]) field.get(obj);
                                if (arr == null)
                                    continue;
                                for (Object o : arr) {
                                    writeXml(writer, o, field.getName());
                                }
                                break;
                            }
                        }
                    } else {
                        writeXml(writer, field.get(obj), field.getName());
                    }
                }

            }
            writer.writeEndElement();
        }
    }

    /**
     * Compare the type of the value at the node
     *
     * @param writer    set the initialized writer
     * @param obj
     * @param field
     * @param fieldType
     * @return true if Byte Array type
     * @throws IllegalAccessException
     * @throws XMLStreamException
     */
    private static boolean compareByteArrayType(XMLStreamWriter writer, Object obj, Field field, Class fieldType) throws IllegalAccessException, XMLStreamException {
        if (fieldType.equals(byte[].class)) {
            if (field.get(obj) != null) {
                writer.writeStartElement(field.getName());
                writer.writeCharacters(bin2hex((byte[]) field.get(obj)));
                writer.writeEndElement();
            }
            return true;
        }
        return false;
    }

    /**
     * Compare the type of the value at the node
     *
     * @param writer
     * @param obj
     * @param field
     * @param fieldType
     * @return true if Integer type
     * @throws XMLStreamException
     * @throws IllegalAccessException
     */
    private static boolean compareIntegerType(XMLStreamWriter writer, Object obj, Field field, Class fieldType) throws XMLStreamException, IllegalAccessException {
        if (fieldType.equals(Integer.TYPE)) {
            writer.writeStartElement(field.getName());
            writer.writeCharacters(Integer.toString(field.getInt(obj)));
            writer.writeEndElement();
            return true;
        }
        return false;
    }

    /**
     * Compare the type of the value at the node
     *
     * @param writer
     * @param obj
     * @param field
     * @param fieldType
     * @return true if Long type
     * @throws XMLStreamException
     * @throws IllegalAccessException
     */
    private static boolean compareLongType(XMLStreamWriter writer, Object obj, Field field, Class fieldType) throws XMLStreamException, IllegalAccessException {
        if (fieldType.equals(Long.TYPE)) {
            writer.writeStartElement(field.getName());
            writer.writeCharacters(Long.toString(field.getLong(obj)));
            writer.writeEndElement();
            return true;
        }
        return false;
    }

    /**
     * Compare the type of the value at the node
     *
     * @param writer
     * @param obj
     * @param field
     * @param fieldType
     * @return true if Short type
     * @throws XMLStreamException
     * @throws IllegalAccessException
     */
    private static boolean compareShortType(XMLStreamWriter writer, Object obj, Field field, Class fieldType) throws XMLStreamException, IllegalAccessException {
        if (fieldType.equals(Short.TYPE)) {
            writer.writeStartElement(field.getName());
            writer.writeCharacters(Short.toString(field.getShort(obj)));
            writer.writeEndElement();
            return true;
        }
        return false;
    }

    /**
     * Compare the type of the value at the node
     *
     * @param writer
     * @param obj
     * @param field
     * @param fieldType
     * @return true if Byte type
     * @throws XMLStreamException
     * @throws IllegalAccessException
     */
    private static boolean compareByteType(XMLStreamWriter writer, Object obj, Field field, Class fieldType) throws XMLStreamException, IllegalAccessException {
        if (fieldType.equals(Byte.TYPE)) {
            writer.writeStartElement(field.getName());
            writer.writeCharacters(Byte.toString(field.getByte(obj)));
            writer.writeEndElement();
            return true;
        }
        return false;
    }

    /**
     * Compare the type of the value at the node
     *
     * @param writer
     * @param obj
     * @param field
     * @param fieldType
     * @return true if Float type
     * @throws XMLStreamException
     * @throws IllegalAccessException
     */
    private static boolean compareFloatType(XMLStreamWriter writer, Object obj, Field field, Class fieldType) throws XMLStreamException, IllegalAccessException {
        if (fieldType.equals(Float.TYPE)) {
            writer.writeStartElement(field.getName());
            writer.writeCharacters(Float.toString(field.getFloat(obj)));
            writer.writeEndElement();
            return true;
        }
        return false;
    }

    /**
     * Compare the type of the value at the node
     *
     * @param writer
     * @param obj
     * @param field
     * @param fieldType
     * @return true if Double type
     * @throws XMLStreamException
     * @throws IllegalAccessException
     */
    private static boolean compareDoubleType(XMLStreamWriter writer, Object obj, Field field, Class fieldType) throws XMLStreamException, IllegalAccessException {
        if (fieldType.equals(Double.TYPE)) {
            writer.writeStartElement(field.getName());
            writer.writeCharacters(Double.toString(field.getDouble(obj)));
            writer.writeEndElement();
            return true;
        }
        return false;
    }

    /**
     * Compare the type of the value at the node
     *
     * @param writer
     * @param obj
     * @param field
     * @param fieldType
     * @return true if Boolean type
     * @throws XMLStreamException
     * @throws IllegalAccessException
     */
    private static boolean compareBooleanType(XMLStreamWriter writer, Object obj, Field field, Class fieldType) throws XMLStreamException, IllegalAccessException {
        if (fieldType.equals(Boolean.TYPE)) {
            writer.writeStartElement(field.getName());
            writer.writeCharacters(Boolean.toString(field.getBoolean(obj)));
            writer.writeEndElement();
            return true;
        }
        return false;
    }

    /**
     * @param data
     * @return return string value of byte array
     */
    private static String bin2hex(byte[] data) {
        StringBuilder sb = new StringBuilder(data.length * 2);
        for (byte datum : data) {
            int b = (datum & 0xf0) >> 4;
            sb.append((char) (b < 10 ? 48 + b : (65 + b) - 10));
            b = datum & 0xf;
            sb.append((char) (b < 10 ? 48 + b : (65 + b) - 10));
        }

        return sb.toString();
    }
}
