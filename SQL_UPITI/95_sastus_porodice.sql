SELECT
PAPF.EMPLOYEE_NUMBER BROJ_RADNIKA
,PAPF.LAST_NAME||' '||PAPF.FIRST_NAME IME_I_PREZIME
,SUBSTR(HAOU.NAME,INSTR(HAOU.NAME,'.')+1) ORGANIZACIJA
FROM PER_ALL_PEOPLE_F PAPF
LEFT OUTER JOIN PER_ALL_ASSIGNMENTS_F PAAF ON PAPF.PERSON_ID=PAAF.PERSON_ID
LEFT OUTER JOIN HR_ALL_ORGANIZATION_UNITS HAOU ON PAAF.ORGANIZATION_ID=HAOU.ORGANIZATION_ID
WHERE 
1=1
AND :P_DATE BETWEEN PAPF.EFFECTIVE_START_DATE AND PAPF.EFFECTIVE_END_DATE
AND :P_DATE BETWEEN PAAF.EFFECTIVE_START_DATE AND PAAF.EFFECTIVE_END_DATE
AND PAPF.PERSON_TYPE_ID=1126
AND  UPPER(PAPF.ATTRIBUTE4)=UPPER('Da');

--pomocni
SELECT * FROM PER_ALL_PEOPLE_F;
SELECT * FROM PER_PERSON_TYPES_TL;
SELECT * FROM HR_ALL_ORGANIZATION_UNITS WHERE NAME LIKE '%Direkcija%';