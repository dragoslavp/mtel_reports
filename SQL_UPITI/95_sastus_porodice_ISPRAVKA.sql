SELECT
PAPF.EMPLOYEE_NUMBER BROJ_RADNIKA
,PAPF.LAST_NAME||' '||PAPF.FIRST_NAME IME_I_PREZIME
,FFVV.DESCRIPTION GRUPA_ZA_PLAN
FROM PER_ALL_PEOPLE_F PAPF
LEFT OUTER JOIN PER_ALL_ASSIGNMENTS_F PAAF ON PAPF.PERSON_ID=PAAF.PERSON_ID
LEFT OUTER JOIN fnd_flex_values_vl FFVV ON PAAF.ASS_ATTRIBUTE11=FFVV.FLEX_VALUE
LEFT OUTER JOIN PER_PERSON_TYPES_TL PPT ON PAPF.PERSON_TYPE_ID=PPT.PERSON_TYPE_ID
WHERE 
1=1
AND to_date(:P_DATE,'dd.mm.yyyy') BETWEEN PAPF.EFFECTIVE_START_DATE AND PAPF.EFFECTIVE_END_DATE
AND to_date(:P_DATE,'dd.mm.yyyy') BETWEEN PAAF.EFFECTIVE_START_DATE AND PAAF.EFFECTIVE_END_DATE
AND PPT.USER_PERSON_TYPE='Radnik'
AND PPT.LANGUAGE='LSR'
and ffvv.FLEX_VALUE_SET_ID=(select FLEX_VALUE_SET_ID from FND_FLEX_VALUE_SETS where FLEX_VALUE_SET_NAME like 'XXTS_GRUPA_ZA_PLAN')
AND  UPPER(PAPF.ATTRIBUTE4)=UPPER('Da')
order by
GRUPA_ZA_PLAN
,IME_I_PREZIME;

--pomocni
SELECT * FROM PER_ALL_PEOPLE_F;
SELECT * FROM PER_PERSON_TYPES_TL;
SELECT * FROM HR_ALL_ORGANIZATION_UNITS WHERE NAME LIKE '%Direkcija%';