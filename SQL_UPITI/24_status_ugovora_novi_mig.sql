select
STATUS,
count(*) STATUS_UGOVORA
from(
select
decode(EMPLOYMENT_CATEGORY,1,'N',2,'O','Z') STATUS
from
PER_ALL_ASSIGNMENTS_F
where
1=1
AND (EMPLOYEE_CATEGORY IS NOT NULL OR EMPLOYMENT_CATEGORY IS NOT NULL))
group by status;

and to_date('31-12-2015','dd-mm-yyyy') <= effective_start_date and effective_end_date>sysdate
--and sysdate between effective_start_date and effective_end_date
)


XXTS_MESTO_TROSKA




select trunc(6.6,0) from dual;
