SELECT
ROWNUM RB
,Q2.*
FROM
(select 
COUNT(Q1.BR_RADNIKA) BROJ
,STATUS
from
(SELECT 
PAPF.EMPLOYEE_NUMBER BR_RADNIKA
,PCF.TYPE SIFRA_UGOVORA
,FLV.MEANING NAZIV_UGOVORA
,CASE
WHEN PCF.TYPE IN(SELECT LOOKUP_CODE FROM FND_LOOKUP_VALUES WHERE LOOKUP_TYPE = 'CONTRACT_TYPE' AND LANGUAGE='LSR' AND MEANING IN ('Ugovor o radu na odredjeno','Ugovor o radu na odre?eno','Ugovor o radu sa navedenim periodom'))  THEN 'Odre?eno'
WHEN PCF.TYPE IN (SELECT LOOKUP_CODE FROM FND_LOOKUP_VALUES WHERE LOOKUP_TYPE = 'CONTRACT_TYPE' AND LANGUAGE='LSR' AND MEANING IN ('Ugovor o radu na neodredjeno','Ugovor o radu bez navedenog perioda')) THEN 'Neodre?eno'
END STATUS
FROM PER_ALL_PEOPLE_F PAPF
LEFT OUTER JOIN PER_CONTRACTS_F PCF ON PAPF.PERSON_ID=PCF.PERSON_ID
LEFT OUTER JOIN FND_LOOKUP_VALUES FLV ON PCF.TYPE=FLV.LOOKUP_CODE
LEFT OUTER JOIN PER_ALL_ASSIGNMENTS_F  PAAF ON PAPF.PERSON_ID=PAAF.PERSON_ID
LEFT OUTER JOIN PER_PERSON_TYPES_TL PPT ON PAPF.PERSON_TYPE_ID=PPT.PERSON_TYPE_ID
WHERE 
1=1
AND :P_DATUM BETWEEN PAPF.EFFECTIVE_START_DATE AND PAPF.EFFECTIVE_END_DATE
AND :P_DATUM BETWEEN PAAF.EFFECTIVE_START_DATE AND PAAF.EFFECTIVE_END_DATE
AND PPT.USER_PERSON_TYPE='Radnik'
AND PPT.LANGUAGE='LSR'
AND FLV.LOOKUP_TYPE = 'CONTRACT_TYPE' AND FLV.LANGUAGE='LSR'
) Q1
GROUP BY STATUS) Q2
WHERE Q2.STATUS IS NOT NULL
ORDER BY 2 DESC;


SELECT * FROM PER_CONTRACTS_F;
select * from per_all_assignments_f;
SELECT * FROM FND_LOOKUP_VALUES WHERE LOOKUP_TYPE = 'CONTRACT_TYPE' AND LANGUAGE='LSR'; 