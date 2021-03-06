WITH A AS (SELECT
PAPF.PERSON_ID PERSON_ID,
PAPF.EMPLOYEE_NUMBER EMPLOYEE_NUMBER,
PAPF.LAST_NAME||' '||PAPF.FIRST_NAME IME,
PPEI.PEI_INFORMATION1 GRAD
FROM
PER_ALL_PEOPLE_F PAPF
LEFT OUTER JOIN PER_ALL_ASSIGNMENTS_F PAAF ON PAPF.PERSON_ID=PAAF.PERSON_ID
LEFT OUTER JOIN PER_PERSON_TYPES_TL PPTL ON PAPF.PERSON_TYPE_ID=PPTL.PERSON_TYPE_ID
LEFT OUTER JOIN PER_PEOPLE_EXTRA_INFO PPEI ON PAPF.PERSON_ID=PPEI.PERSON_ID
WHERE
1=1
AND PAAF.ASSIGNMENT_STATUS_TYPE_ID=1
AND (PAAF.EMPLOYEE_CATEGORY IS NOT NULL OR PAAF.EMPLOYMENT_CATEGORY IS NOT NULL)
AND :P_DATUM BETWEEN PAPF.EFFECTIVE_START_DATE AND PAPF.EFFECTIVE_END_DATE
AND :P_DATUM BETWEEN PAAF.EFFECTIVE_START_DATE AND PAAF.EFFECTIVE_END_DATE
AND :P_DATUM BETWEEN TO_DATE(PPEI.PEI_INFORMATION3,'YYYY/MM/DD HH24:MI:SS') AND NVL(TO_DATE(PPEI.PEI_INFORMATION4,'YYYY/MM/DD HH24:MI:SS'),TO_DATE('31.12.4712','DD.MM.YYYY'))
--AND PAAF.EMPLOYMENT_CATEGORY=1
AND PPTL.LANGUAGE = 'LSR'
AND UPPER(PPTL.USER_PERSON_TYPE) = UPPER('Radnik')
AND PPEI.INFORMATION_TYPE='XXTS_OPSTINA_POREZA'
ORDER BY 1),
B AS
(
SELECT
DISTINCT
PERSON_ID,
SPREMA,
SPREMA_RANK,
SPREMA_M_RANK
FROM
(SELECT 
Q.PERSON_ID PERSON_ID,
Q.NAME SPREMA,
QT.RANK SPREMA_RANK,
MAX(QT.RANK) OVER (PARTITION BY Q.PERSON_ID) SPREMA_M_RANK
FROM 
PER_QUALIFICATIONS_V Q LEFT OUTER JOIN PER_QUALIFICATION_TYPES QT ON Q.QUALIFICATION_TYPE_ID=QT.QUALIFICATION_TYPE_ID)
WHERE SPREMA_RANK=SPREMA_M_RANK
)
SELECT 
A.GRAD,
B.SPREMA,
B.SPREMA_RANK,
COUNT(*)
FROM
A LEFT OUTER JOIN B ON A.PERSON_ID=B.PERSON_ID
GROUP BY 
A.GRAD,
B.SPREMA,
B.SPREMA_RANK

ORDER BY 
A.GRAD,
B.SPREMA;






select instr(description,' ',-1) from hr_locations_all;




select * from per_all_people_f where last_name like '%CVIJANOVI?%' and FIRST_NAME like '%MILENKO%';

select * from PER_ALL_ASSIGNMENTS_F where person_id=16769;