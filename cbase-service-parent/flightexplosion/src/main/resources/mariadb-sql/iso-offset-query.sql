--select to_number(to_char(sysdate, 'D')) - (1 + trunc(sysdate) - trunc(sysdate, 'IW')) as iso_offset from dual
SELECT 0 AS ISO_OFFSET