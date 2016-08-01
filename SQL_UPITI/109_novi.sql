SELECT 
               PAPF.EMPLOYEE_NUMBER BROJ_RADNIKA,
               --PAAF.ORGANIZATION_ID ORG_ID,
               PAPF.LAST_NAME || ' ' || PAPF.FIRST_NAME PREZIME_IME
               --,PAAF.ASS_ATTRIBUTE11  
               --,UPPER (SUBSTR (PAAF.ASS_ATTRIBUTE28,INSTR (PAAF.ASS_ATTRIBUTE28, '.') + 1)) DIREKCIJA               
               --,PCAK.SEGMENT1
               ,UPPER (FFVV2.DESCRIPTION) GRUPA_ZA_PLAN1,
               NVL (FFVV1.DESCRIPTION, '-') MJESTO_TROSKA,
               FFVV1.FLEX_VALUE_MEANING MJESTO_TROSKA_SI,
               --PCAF.COST_ALLOCATION_KEYFLEX_ID SIFRA_MT_LD,
               PAPF.EFFECTIVE_START_DATE DATUM_OD,
               DECODE (PAPF.EFFECTIVE_END_DATE,
                       TO_DATE ('31.12.4712', 'DD.MM.YYYY'), ' ',
                       PAPF.EFFECTIVE_END_DATE)
                  DATUM_DO
          FROM PER_ALL_PEOPLE_F PAPF
               LEFT OUTER JOIN PER_ALL_ASSIGNMENTS_F PAAF
                  ON PAPF.PERSON_ID = PAAF.PERSON_ID
               LEFT OUTER JOIN PER_PERSON_TYPES_TL PPT
                  ON PAPF.PERSON_TYPE_ID = PPT.PERSON_TYPE_ID
               LEFT OUTER JOIN PAY_COST_ALLOCATIONS_F PCAF
                  ON PAAF.ASSIGNMENT_ID = PCAF.ASSIGNMENT_ID
               LEFT OUTER JOIN PAY_COST_ALLOCATION_KEYFLE_KFV PCAK
                  ON PCAF.COST_ALLOCATION_KEYFLEX_ID = PCAK.COST_ALLOCATION_KEYFLEX_ID
               LEFT OUTER JOIN FND_FLEX_VALUES_VL FFVV1
                  ON PCAK.SEGMENT1 = FFVV1.FLEX_VALUE
               LEFT OUTER JOIN FND_FLEX_VALUES_VL FFVV2
                  ON PAAF.ASS_ATTRIBUTE11 = FFVV2.FLEX_VALUE
         WHERE     1 = 1
               --AND ASS_ATTRIBUTE28 IS NOT NULL
               AND :P_DATUM BETWEEN PAPF.EFFECTIVE_START_DATE
                                AND PAPF.EFFECTIVE_END_DATE
               AND :P_DATUM BETWEEN PAAF.EFFECTIVE_START_DATE
                                AND PAAF.EFFECTIVE_END_DATE
               AND PPT.USER_PERSON_TYPE = 'Radnik'
               AND ffvv1.FLEX_VALUE_SET_ID =
                      (SELECT FLEX_VALUE_SET_ID
                         FROM FND_FLEX_VALUE_SETS
                        WHERE FLEX_VALUE_SET_NAME LIKE '%MESTA%TROŠKA%')
               AND ffvv2.FLEX_VALUE_SET_ID =
                      (SELECT FLEX_VALUE_SET_ID
                         FROM FND_FLEX_VALUE_SETS
                        WHERE FLEX_VALUE_SET_NAME LIKE 'XXTS_GRUPA_ZA_PLAN')
              AND PAAF.ORGANIZATION_ID IN (select 
                                            ORGANIZATION_ID_CHILD ORG_ID
                                            from XXMT_HR_HIER_ORG_V
                                            start with ORGANIZATION_ID_CHILD=:P_ORG
                                            CONNECT by prior ORGANIZATION_ID_CHILD=ORGANIZATION_ID_PARENT)
              AND FFVV1.FLEX_VALUE_MEANING IN (:P_MT)
                                            ;