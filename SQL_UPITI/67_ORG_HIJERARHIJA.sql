select * from XXMT_HR_HIER_ORG_V;

select 
substr(child_org,1,instr(child_org,'.')-1) ORG_ID
,lpad(' ',2*level,' ')||substr(child_org,instr(child_org,'.')+1) ORG_NAME
,' ' ID_OS
from XXMT_HR_HIER_ORG_V
start with ORGANIZATION_ID_PARENT is null
CONNECT by prior ORGANIZATION_ID_CHILD=ORGANIZATION_ID_PARENT;

