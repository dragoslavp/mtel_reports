SELECT
decode(FFVV.DESCRIPTION,'Funkcija eksploatacije i održavanja','Direkcija za tehniku', 'Funkcija informacionih tehnologija','Direkcija za tehniku','Funkcija planiranja i izgradnje','Direkcija za tehniku', FFVV.DESCRIPTION) GRUPA_ZA_PLAN
,decode(papf.sex,'M','Muški','Ženski') POL
,COUNT(*)
FROM 
PER_ALL_PEOPLE_F PAPF  
LEFT OUTER JOIN PER_ALL_ASSIGNMENTS_F PAAF ON PAPF.PERSON_ID=PAAF.PERSON_ID
LEFT OUTER JOIN PER_PERSON_TYPES_TL PPT ON PAPF.PERSON_TYPE_ID=PPT.PERSON_TYPE_ID
LEFT OUTER JOIN fnd_flex_values_vl FFVV ON PAAF.ASS_ATTRIBUTE11=FFVV.FLEX_VALUE
WHERE
1=1
AND (EMPLOYEE_CATEGORY IS NOT NULL OR EMPLOYMENT_CATEGORY IS NOT NULL)
AND :P_DATE BETWEEN PAPF.EFFECTIVE_START_DATE AND PAPF.EFFECTIVE_END_DATE
AND :P_DATE BETWEEN PAAF.EFFECTIVE_START_DATE AND PAAF.EFFECTIVE_END_DATE
AND PPT.USER_PERSON_TYPE='Radnik'
AND PPT.LANGUAGE='LSR'
AND ffvv.FLEX_VALUE_SET_ID=(select FLEX_VALUE_SET_ID from FND_FLEX_VALUE_SETS where FLEX_VALUE_SET_NAME like 'XXTS_GRUPA_ZA_PLAN')
GROUP BY 
decode(FFVV.DESCRIPTION,'Funkcija eksploatacije i održavanja','Direkcija za tehniku', 'Funkcija informacionih tehnologija','Direkcija za tehniku','Funkcija planiranja i izgradnje','Direkcija za tehniku', FFVV.DESCRIPTION)
,decode(papf.sex,'M','Muški','Ženski'); 


