/* VISUALLINX Execute(Alias:CURNCM)  */
SELECT * FROM DBO.LCF_LX_NCM (NOLOCK)
where COD_NCM='87091900'

INSERT INTO DBO.LCF_LX_NCM (COD_NCM,DESC_NCM)
VALUES('84907114','DIGITALIZADORAS DE IMAGENS')
SELECT REPLACE(CLASSIF_FISCAL,'.',''),A.DESC_CLASSIFICACAO FROM CLASSIF_FISCAL A
where NOT EXISTS (SELECT COD_NCM FROM LCF_LX_NCM B WHERE B.COD_NCM=REPLACE(A.CLASSIF_FISCAL,'.',''))


/* lx012997spk  CursorAdapter: CursorV_VALIDACAO_ITEM_FISCAL_00(Alias: v_validacao_item_fiscal_00)  */
SELECT CADASTRO_ITEM_FISCAL.CODIGO_ITEM, CADASTRO_ITEM_FISCAL.ITEM_DESCRICAO, CADASTRO_ITEM_FISCAL.TIPO_ITEM_SPED, LCF_LX_ITEM_TIPO.DESC_TIPO_ITEM, CADASTRO_ITEM_FISCAL.CLASSIF_FISCAL, LCF_LX_NCM.COD_NCM   FROM CADASTRO_ITEM_FISCAL  INNER JOIN CLASSIF_FISCAL ON CLASSIF_FISCAL.CLASSIF_FISCAL = CADASTRO_ITEM_FISCAL.CLASSIF_FISCAL   INNER JOIN LCF_LX_ITEM_TIPO ON CADASTRO_ITEM_FISCAL.TIPO_ITEM_SPED = LCF_LX_ITEM_TIPO.COD_TIPO_SPED  LEFT JOIN LCF_LX_NCM LCF_LX_NCM ON LCF_LX_NCM.COD_NCM = REPLACE(CLASSIF_FISCAL.CLASSIF_FISCAL, '.', '')  WHERE  LCF_LX_NCM.COD_NCM IS NULL
