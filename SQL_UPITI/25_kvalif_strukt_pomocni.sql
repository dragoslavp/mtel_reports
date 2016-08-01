with a as (
select 
q1.person_id person_id
,q1.name name
,q1.rank rank
,row_number() over (partition by q1.person_id order by q1.rank desc) rank2
from 
(
select 
pq.person_id
,pqt.name
,pqt.rank
from 
PER_QUALIFICATIONS pq 
left outer join 
PER_QUALIFICATION_types pqt on PQ.QUALIFICATION_TYPE_ID=PQT.QUALIFICATION_TYPE_ID
) q1)
select 
person_id
,name
,rank
from a
where a.rank2=1;




select * from PER_QUALIFICATION_types;
,max(rank) OVER (partition by person_id) max_rank
SELECT *  FROM HR.PER_ALL_ASSIGNMENTS_F WHERE ASS_ATTRIBUTE5 IS NOT NULL;

SELECT *  FROM PER_QUALIFICATION_TYPES_V;

select
qt.NAME||' '||pq.ESTABLISHMENT from
PER_QUALIFICATIONS_V pq, PER_QUALIFICATION_TYPES_V qt
where pq.qualification_type_id = qt.qualification_type_id
AND pq.person_id = 65;

select employee_number from HR.PER_ALL_PEOPLE_F where person_id=65;


select 
q1.person_id
,q1.sprema
from
(SELECT PQ.PERSON_ID person_id
,PQT.NAME sprema
,PQT.RANK rank
FROM HR.PER_QUALIFICATIONS PQ
LEFT OUTER JOIN HR.PER_QUALIFICATION_TYPES PQT ON PQ.QUALIFICATION_TYPE_ID=PQT.QUALIFICATION_TYPE_ID
WHERE 
1=1
--AND pq.PERSON_ID=2430
order by PQT.RANK desc) q1
where rownum=1;

select * from PER_QUALIFICATIONS WHERE PERSON_ID=1129;
SELECT * FROM HR.PER_QUALIFICATION_TYPES;



