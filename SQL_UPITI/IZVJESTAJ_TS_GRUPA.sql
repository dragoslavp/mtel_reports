WITH A AS (
SELECT
PAPF.PERSON_ID PERSON_ID,
PAPF.EMPLOYEE_NUMBER EMPLOYEE_NUMBER,
PAPF.DATE_OF_BIRTH DOB,
trunc((to_date(:P_DATUM,'dd.mm.yyyy')-PAPF.DATE_OF_BIRTH)/365.25,0) STAROST,
PAPF.LAST_NAME||' '||PAPF.FIRST_NAME IME,
PAAF.JOB_ID,
PJ.NAME JOB,
PJ.JOB_INFORMATION1,
PP.NAME POSITION
FROM
PER_ALL_PEOPLE_F PAPF
LEFT OUTER JOIN PER_ALL_ASSIGNMENTS_F PAAF ON PAPF.PERSON_ID=PAAF.PERSON_ID
LEFT OUTER JOIN PER_PERSON_TYPES_TL PPTL ON PAPF.PERSON_TYPE_ID=PPTL.PERSON_TYPE_ID
LEFT OUTER JOIN PER_JOBS PJ ON PAAF.JOB_ID=PJ.JOB_ID
LEFT OUTER JOIN PER_POSITIONS PP ON PAAF.POSITION_ID=PP.POSITION_ID
WHERE
1=1
AND PAAF.ASSIGNMENT_STATUS_TYPE_ID=1
AND (PAAF.EMPLOYEE_CATEGORY IS NOT NULL OR PAAF.EMPLOYMENT_CATEGORY IS NOT NULL)
AND :P_DATUM BETWEEN PAPF.EFFECTIVE_START_DATE AND PAPF.EFFECTIVE_END_DATE
AND :P_DATUM BETWEEN PAAF.EFFECTIVE_START_DATE AND PAAF.EFFECTIVE_END_DATE
AND PPTL.LANGUAGE = 'LSR'
AND UPPER(PPTL.USER_PERSON_TYPE)=UPPER('Radnik')
ORDER BY 1),
B AS (
SELECT
description NIVO_BR,
FLEX_VALUE_MEANING NIVO_OPIS
from 
APPLSYS.FND_FLEX_VALUES_tl 
where 
1=1
and FLEX_VALUE_ID in (select flex_value_id from FND_FLEX_VALUES where FLEX_VALUE_SET_ID=(select FLEX_VALUE_SET_ID from FND_FLEX_VALUE_SETS where FLEX_VALUE_SET_NAME like '%NIVO%'))
and language='LSR'
ORDER BY DESCRIPTION
)
SELECT
A.*,
B.NIVO_BR
FROM A LEFT OUTER JOIN B ON A.JOB_INFORMATION1=B.NIVO_OPIS
WHERE
1=1
AND B.NIVO_BR IN (15,6)
--AND B.NIVO_BR NOT IN (15,6)
--AND JOB LIKE '%Pomo%'
--AND NIVO_OPIS='Radnik'
;