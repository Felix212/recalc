SELECT
    cen_handling_doc_detail.nprio,
    cen_catering_userobject.ccatering_uo_name,
    cen_catering_userobject.ncatering_userobject_id
FROM
    cen_out,
    cen_handling,
    cen_routingplan_handling,
    cen_handling_doc_detail,
    cen_catering_userobject
WHERE
    cen_routingplan_handling.nhandling_key = cen_handling.nhandling_key
AND cen_handling.nhandling_key = cen_handling_doc_detail.nhandling_key
AND cen_handling_doc_detail.ncatering_userobject_id =
    cen_catering_userobject.ncatering_userobject_id
AND (
        cen_routingplan_handling.nroutingdetail_key = cen_out.nroutingdetail_key
    AND cen_routingplan_handling.dvalid_from <= cen_out.ddeparture
    AND cen_routingplan_handling.dvalid_to >= cen_out.ddeparture
    AND cen_handling_doc_detail.dvalid_from <= cen_out.ddeparture
    AND cen_handling_doc_detail.dvalid_to >= cen_out.ddeparture
    AND cen_handling_doc_detail.ctime_from <= cen_out.cdeparture_time
    AND cen_handling_doc_detail.ctime_to >= cen_out.cdeparture_time
    AND CEN_ROUTINGPLAN_HANDLING.CUNIT = cen_out.cunit )
AND cen_out.nresult_key= :arg_result_key
UNION
SELECT
    cen_handling_acdoc_detail.nprio,
    cen_catering_userobject.ccatering_uo_name,
    cen_catering_userobject.ncatering_userobject_id
FROM
    cen_out,
    cen_handling,
    cen_routingplan_handling,
    cen_catering_userobject,
    cen_handling_acdoc_detail
WHERE
    cen_routingplan_handling.nhandling_key = cen_handling.nhandling_key
AND cen_handling_acdoc_detail.nhandling_key = cen_handling.nhandling_key
AND cen_handling_acdoc_detail.ncatering_userobject_id =
    cen_catering_userobject.ncatering_userobject_id
AND (
        cen_routingplan_handling.nroutingdetail_key = cen_out.nroutingdetail_key
    AND cen_routingplan_handling.dvalid_from <= cen_out.ddeparture
    AND cen_routingplan_handling.dvalid_to >= cen_out.ddeparture
    AND cen_handling_acdoc_detail.dvalid_from <= cen_out.ddeparture
    AND cen_handling_acdoc_detail.dvalid_to >= cen_out.ddeparture
    AND cen_handling_acdoc_detail.ctime_from <= cen_out.cdeparture_time
    AND cen_handling_acdoc_detail.ctime_to >= cen_out.cdeparture_time
    AND CEN_ROUTINGPLAN_HANDLING.CUNIT = cen_out.cunit )
AND (
        cen_handling_acdoc_detail.naircraft_key = cen_out.naircraft_key
    OR  cen_handling_acdoc_detail.ndefault = 1)
AND cen_out.nresult_key= :arg_result_key
ORDER BY
    NPRIO