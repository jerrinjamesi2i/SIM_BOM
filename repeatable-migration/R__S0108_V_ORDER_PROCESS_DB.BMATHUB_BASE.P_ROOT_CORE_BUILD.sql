CREATE OR REPLACE PROCEDURE INTEL_TEST_DB.BMATHUB_BASE.P_ROOT_CORE_BUILD()
RETURNS STRING
LANGUAGE SQL
AS
BEGIN
    INSERT INTO INTEL_TEST_DB.BMATHUB_BASE.T_COMPRESS_BOM_CORE (ITEM, ITEM_CLASS_NM, ANCHOR_ITEM_ID, BOM_NUM,LOC,CREATE_DTM, CREATE_USER)
    SELECT  t1.INPUT_ITEM_ID,t1.ITEM_CLASS_NM,t3.INPUT_ITEM_ID AS ANCHOR_ITEM_ID,INTEL_TEST_DB.BMATHUB_BASE.bom_num_seq.NEXTVAL AS BOM_NUM,t4.LOCATION_ID AS LOC,CURRENT_DATE(),CURRENT_USER()
    FROM INTEL_TEST_DB.BMATHUB_XFRM.V_ORIG_BOM AS t1
    JOIN INTEL_TEST_DB.BMATHUB_XFRM.V_ORIG_BOM AS t2 
    ON ( t1.INPUT_ITEM_ID = t2.OUTPUT_ITEM_ID AND t1.ITEM_CLASS_NM = 'IC' AND t2.ITEM_CLASS_NM = 'UPI_DIE_PREP')
    JOIN INTEL_TEST_DB.BMATHUB_XFRM.V_ORIG_BOM AS t3 ON  ( t2.INPUT_ITEM_ID = t3.OUTPUT_ITEM_ID AND t3.ITEM_CLASS_NM = 'UPI_SORT')   
    JOIN INTEL_TEST_DB.BMATHUB_XFRM.V_METADATA_RULES AS t4 ON (t1.ITEM_CLASS_NM = t4.ITEM_CLASS_NM);

    RETURN 'Data inserted successfully.';
END;

CALL INTEL_TEST_DB.BMATHUB_BASE.P_ROOT_CORE_BUILD()