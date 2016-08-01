SELECT
BROJ_RADNIKA
,PRIZNATA_SS
,POTREBNA_SS
,CASE
WHEN (PRIZNATA_SS=POTREBNA_SS OR PRIZNATA_SS=SUBSTR(POTREBNA_SS,INSTR(POTREBNA_SS,'/')+1) OR PRIZNATA_SS=SUBSTR(POTREBNA_SS,1,INSTR(POTREBNA_SS,'/')-1) ) THEN 1
ELSE 0
END STATUS
FROM
(SELECT 
PAPF.EMPLOYEE_NUMBER BROJ_RADNIKA
,NVL(SUBSTR(PAAF.ASS_ATTRIBUTE5,1,(INSTR(PAAF.ASS_ATTRIBUTE5,' ',1))-1),'NDP-X') PRIZNATA_SS
,FFVL.DESCRIPTION POTREBNA_SS
FROM 
PER_ALL_PEOPLE_F PAPF
LEFT OUTER JOIN PER_ALL_ASSIGNMENTS_F PAAF ON PAPF.PERSON_ID=PAAF.PERSON_ID
LEFT OUTER JOIN PER_PERSON_TYPES_TL PPT ON PAPF.PERSON_TYPE_ID=PPT.PERSON_TYPE_ID
LEFT OUTER JOIN PER_POSITION_EXTRA_INFO PPEI ON PAAF.POSITION_ID=PPEI.POSITION_ID
LEFT OUTER JOIN FND_FLEX_VALUES_VL FFVL ON PPEI.POEI_INFORMATION1=FFVL.FLEX_VALUE
WHERE 
1=1
AND :P_DATUM BETWEEN PAPF.EFFECTIVE_START_DATE AND PAPF.EFFECTIVE_END_DATE
AND :P_DATUM BETWEEN PAAF.EFFECTIVE_START_DATE AND PAAF.EFFECTIVE_END_DATE
AND PPT.USER_PERSON_TYPE='Radnik'
AND PPT.LANGUAGE='LSR'
AND PPEI.INFORMATION_TYPE='XXTS_OBRAZOVANJE_ISKUSTVO'
AND FLEX_VALUE_SET_ID=(select FLEX_VALUE_SET_ID from FND_FLEX_VALUE_SETS where FLEX_VALUE_SET_NAME like 'XXTS_STRUCNA_SPREMA')
AND PAAF.POSITION_ID IS NOT NULL
AND PAAF.ASS_ATTRIBUTE5 IS NOT NULL) Q1;
