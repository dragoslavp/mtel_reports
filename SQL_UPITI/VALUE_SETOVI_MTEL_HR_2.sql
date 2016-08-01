SELECT * FROM FND_DESCRIPTIVE_FLEXS;

SELECT 
FDF.DESCRIPTIVE_FLEXFIELD_NAME,
FDF.DESCRIPTIVE_FLEX_CONTEXT_CODE,
FDF.APPLICATION_COLUMN_NAME,
FDF.END_USER_COLUMN_NAME,
--FDF.FLEX_VALUE_SET_ID,
FFVS.FLEX_VALUE_SET_NAME
FROM fnd_descr_flex_col_usage_vl FDF
LEFT OUTER JOIN FND_FLEX_VALUE_SETS FFVS ON FDF.FLEX_VALUE_SET_ID=FFVS.FLEX_VALUE_SET_ID
WHERE 
1=1
AND FDF.FLEX_VALUE_SET_ID IN (select FDF2.FLEX_VALUE_SET_ID from FND_FLEX_VALUE_SETS FDF2 where FDF2.FLEX_VALUE_SET_NAME like '%XXTS%')
ORDER BY 1
;


select * from all_tables where table_name like '%KEY%';


select * from FND_ID_FLEXS;

select * from FND_ID_FLEX_SEGMENTS;


select 
FIF.ID_FLEX_NAME,
FIFS.APPLICATION_COLUMN_NAME,
FIFS.SEGMENT_NAME,
FFVS.FLEX_VALUE_SET_NAME
from FND_ID_FLEX_SEGMENTS FIFS 
LEFT OUTER JOIN FND_ID_FLEXS FIF ON FIFS.ID_FLEX_CODE=FIF.ID_FLEX_CODE
LEFT OUTER JOIN FND_FLEX_VALUE_SETS FFVS ON FIFS.FLEX_VALUE_SET_ID=FFVS.FLEX_VALUE_SET_ID
WHERE 
1=1
AND FIFS.FLEX_VALUE_SET_ID IN (select FDF2.FLEX_VALUE_SET_ID from FND_FLEX_VALUE_SETS FDF2 where FDF2.FLEX_VALUE_SET_NAME like '%XXTS%');