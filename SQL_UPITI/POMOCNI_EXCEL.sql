select * from per_all_people_f where CURRENT_EMPLOYEE_FLAG is null;

select * from HR.PER_PERIODS_OF_SERVICE where ACCEPTED_TERMINATION_DATE is not null;

SELECT * FROM HR.PER_PERSON_TYPES_TL where language='LSR';

select * from per_all_people_f where PERSON_TYPE_ID=1130;


select * from per_all_people_f where person_id=28735;

select * from APPLSYS.FND_LOOKUP_TYPES where lookup_type like '%LEAV%';
select * from FND_LOOKUP_VALUES where lookup_type like 'LEAV_REAS' and language ='LSR' and lookup_code like 'BA%';