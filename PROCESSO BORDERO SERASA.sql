--- CRIAR UM TIPO DE DOCUMENTO PARA IDENTIFICAR O TITULO ENVIADO PARA O SERASA
--- NA TELA 009002SPK EX: 99 - NEGATIVADO NO SERASA    


--- CAMPOS PARA O BORDERÔ
SELECT 'INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA) 
VALUES('+RTRIM(cast(ID_COMANDO as CHAR(10)))+','''
+RTRIM(LX_TIPO_BORDERO)+''','''+RTRIM(DESC_COMANDO)+''','''+RTRIM(ISNULL(DESC_PARAMS,''))+''','''+RTRIM(COMANDO)+''','''+RTRIM(LX_TIPO_DADO)+''','''
+RTRIM(LX_TIPO_CONTEUDO)+''','''+RTRIM(CAST(INDICA_PARAMETRO AS CHAR(1)))+''','''+CONVERT(CHAR(10),GETDATE(),112)+''''+')'
 
FROM CTB_BORDERO_LAYOUT_CMD
WHERE LX_TIPO_BORDERO=16
ORDER BY ID_COMANDO


--- INSERT DOS NOVOS CAMPOS PARA O BORDERÔ
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(2509,'16','LIVRE','Campo livre para digitação','','C','L','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(2510,'16','IDENTIFICAÇÃO DO REGISTRO','','0','N','X','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(2511,'16','IDENTIFICAÇÃO DO ARQUIVO REMESSA','','1','N','X','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(2536,'16','DUPLICATA','Número da fatura e parcela do sistema Linx no banco.','alltrim(FATURA)+'/'+alltrim(ID_PARCELA)','C','F','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(2550,'16','NOME DO SACADO','Razão Social ou Nome completo do Terceiro.','RAZAO_SOCIAL','C','F','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(2551,'16','ENDEREÇO DO SACADO','Endereço de cobrança do Terceiro.','COBRANCA_ENDERECO','C','F','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(2552,'16','CEP DO SACADO','CEP do endereço de cobrança do Terceiro.','strt(strt(strt(COBRANCA_CEP, "-", ""), ".", "")," ","")','C','F','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(2579,'16','DDD DO SACADO','DDD de cobrança do sadaco','strtran(strtran(strtran(cobranca_ddd,'-',''),'.',''),' ','')','C','F','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(2595,'16','INSCRIÇÃO DA EMPRESA','','00000000000000','C','X','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(2609,'16','BAIRRO DO SACADO','Bairro do endereço de cobrança do Terceiro.','f_tira_acento(COBRANCA_BAIRRO)','C','F','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(2611,'16','UF DO SACADO','UF. do endereço de cobrança do Terceiro.','f_tira_acento(COBRANCA_UF)','C','F','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(4693,'16','MUNICIPIO DO SACADO','CIDADE do endereço de cobrança do Terceiro.','F_TIRA_ACENTO(COBRANCA_CIDADE)','C','F','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(4703,'16','DATA DA OCORRENCIA','','DTOS(VENCIMENTO_REAL)','C','F','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(4704,'16','VALOR TOTAL','','PADL(LTRIM(STRTRAN(SUBSTR(STR(VALOR_A_RECEBER,15,2),1,15),'.','')),15,'0')','C','F','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(4705,'16','SEQUENCIAL DE REMESSA','','v_ctb_lancamento_01_bordero.sequencial_layout_bordero','C','F','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(4706,'16','DATA GERACAO DO ARQUIVO','','DTOS(DATE())','C','F','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(4707,'16','PRIMEIRO DOCUMENTO DO PRINCIPAL','','PADL(ALLT(CGC_CPF),15,'0')','C','F','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(4708,'16','SEQUENCIAL DO REGISTRO SERASA','','PADL(f_sequenciais('CTB_BORDERO.SEQUENCIAL_REGISTRO', .T.),7,'0')','C','F','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(4709,'16','SEQUENCIAL DO RODAPE SERASA','','PADL(f_sequenciais('CTB_BORDERO.SEQUENCIAL_REGISTRO', .T.),7,'0')','C','F','0','20141120  ')
INSERT INTO CTB_BORDERO_LAYOUT_CMD (ID_COMANDO,LX_TIPO_BORDERO,DESC_COMANDO,DESC_PARAMS,COMANDO,LX_TIPO_DADO,LX_TIPO_CONTEUDO,INDICA_PARAMETRO,DATA_PARA_TRANSFERENCIA)   VALUES(4710,'16','SEQUENCIAL DO CABEÇALHO SERASA','Sequencial da primeira linha do arquivo. Seu valor sempre sera 1 (Um).','PADL(f_sequenciais('CTB_BORDERO.SEQUENCIAL_REGISTRO', .T., '0000001'),7,'0')','C','F','0','20141120  ')


-- OU 

--2508,16,LIVRE                                   ,Campo livre para digitação                                                                                                                                                                                                                                ,                                                                                                                                                                                                                                                          ,C,L,False,
--2510,16,IDENTIFICAÇÃO DO REGISTRO               ,,0                                                                                                                                                                                                                                                         ,N,X,False,
--2511,16,IDENTIFICAÇÃO DO ARQUIVO REMESSA        ,,1                                                                                                                                                                                                                                                         ,N,X,False,
--2536,16,DUPLICATA                               ,Número da fatura e parcela do sistema Linx no banco.                                                                                                                                                                                                      ,alltrim(FATURA)+'/'+alltrim(ID_PARCELA)                                                                                                                                                                                                                   ,C,F,False,
--2550,16,NOME DO SACADO                          ,Razão Social ou Nome completo do Terceiro.                                                                                                                                                                                                                ,RAZAO_SOCIAL                                                                                                                                                                                                                                              ,C,F,False,
--2551,16,ENDEREÇO DO SACADO                      ,Endereço de cobrança do Terceiro.                                                                                                                                                                                                                         ,COBRANCA_ENDERECO                                                                                                                                                                                                                                         ,C,F,False,
--2552,16,CEP DO SACADO                           ,CEP do endereço de cobrança do Terceiro.                                                                                                                                                                                                                  ,strt(strt(strt(COBRANCA_CEP, "-", ""), ".", "")," ","")                                                                                                                                                                                                   ,C,F,False,
--2579,16,DDD DO SACADO                           ,DDD de cobrança do sadaco                                                                                                                                                                                                                                 ,strtran(strtran(strtran(cobranca_ddd,'-',''),'.',''),' ','')                                                                                                                                                                                              ,C,F,False,
--2595,16,INSCRIÇÃO DA EMPRESA                    ,,00000000000000                                                                                                                                                                                                                                            ,C,X,False,
--2609,16,BAIRRO DO SACADO                        ,Bairro do endereço de cobrança do Terceiro.                                                                                                                                                                                                               ,f_tira_acento(COBRANCA_BAIRRO)                                                                                                                                                                                                                            ,C,F,False,
--2611,16,UF DO SACADO                            ,UF. do endereço de cobrança do Terceiro.                                                                                                                                                                                                                  ,f_tira_acento(COBRANCA_UF)                                                                                                                                                                                                                                ,C,F,False,
--4693,16,MUNICIPIO DO SACADO                     ,CIDADE do endereço de cobrança do Terceiro.                                                                                                                                                                                                               ,F_TIRA_ACENTO(COBRANCA_CIDADE)                                                                                                                                                                                                                            ,C,F,False,2014-02-17 14:53:20.320000000
--4703,16,DATA DA OCORRENCIA                      ,,DTOS(VENCIMENTO_REAL)                                                                                                                                                                                                                                     ,C,F,False,2014-09-03 14:23:47.880000000
--4704,16,VALOR TOTAL                             ,,PADL(LTRIM(STRTRAN(SUBSTR(STR(VALOR_A_RECEBER,15,2),1,15),'.','')),15,'0')                                                                                                                                                                                ,C,F,False,2014-09-03 14:24:33.040000000
--4705,16,SEQUENCIAL DE REMESSA                   ,,v_ctb_lancamento_01_bordero.sequencial_layout_bordero                                                                                                                                                                                                     ,C,F,False,2014-09-05 10:21:38.730000000
--4706,16,DATA GERACAO DO ARQUIVO                 ,,DTOS(DATE())                                                                                                                                                                                                                                              ,C,F,False,2014-09-08 10:49:52.977000000
--4707,16,PRIMEIRO DOCUMENTO DO PRINCIPAL         ,,PADL(ALLT(CGC_CPF),15,'0')                                                                                                                                                                                                                                ,C,F,False,2014-09-08 10:58:35.133000000
--4708,16,SEQUENCIAL DO REGISTRO SERASA           ,,PADL(f_sequenciais('CTB_BORDERO.SEQUENCIAL_REGISTRO', .T.),7,'0')                                                                                                                                                                                         ,C,F,False,2014-09-08 11:11:29.107000000
--4709,16,SEQUENCIAL DO RODAPE SERASA             ,,PADL(f_sequenciais('CTB_BORDERO.SEQUENCIAL_REGISTRO', .T.),7,'0')                                                                                                                                                                                         ,C,F,False,2014-09-08 11:13:41.120000000
--4710,16,SEQUENCIAL DO CABEÇALHO SERASA          ,Sequencial da primeira linha do arquivo. Seu valor sempre sera 1 (Um).                                                                                                                                                                                    ,PADL(f_sequenciais('CTB_BORDERO.SEQUENCIAL_REGISTRO', .T., '0000001'),7,'0')                                                                                                                                                                              ,C,F,False,2014-09-08 13:53:44.283000000


--- TRIGGERS PARA AS TABELAS ENVOLVIDAS NO PROCESSO

USE [BANCO]
GO
/****** Object:  Trigger [dbo].[TI_CTB_BORDERO]    Script Date: 11/20/2014 11:04:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER trigger [dbo].[TI_CTB_BORDERO] 
on [dbo].[CTB_BORDERO] 
AFTER INSERT NOT FOR REPLICATION
as
/* INSERT trigger on CTB_BORDERO */
begin
  declare  @numrows int,
           @nullcnt char(4),
           @validcnt0155 int,
           @validcnt0156 int,
           @insEMPRESA int, 
           @insLANCAMENTO int,
           @insSEQUENCIAL varchar(6),
           @delEMPRESA int, 
           @delLANCAMENTO int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount

  /* REMESSA DE INCLUSAO/EXCLUSAO DA SERASA */
  if
    update(LAYOUT)
  begin
    select @validcnt0155 = count(*)
      from inserted,CTB_BORDERO_LAYOUT
     where
           inserted.LAYOUT = CTB_BORDERO_LAYOUT.LAYOUT 
           AND CTB_BORDERO_LAYOUT.LAYOUT = '0155' 

    select @validcnt0156 = count(*)
      from inserted,CTB_BORDERO_LAYOUT
     where
           inserted.LAYOUT = CTB_BORDERO_LAYOUT.LAYOUT 
           AND CTB_BORDERO_LAYOUT.LAYOUT = '0156' 
           
    select @insLANCAMENTO = LTRIM(RTRIM(CTB_BORDERO.LANCAMENTO))
      from inserted,CTB_BORDERO
     where inserted.LAYOUT IN ('0155','0156') AND CTB_BORDERO.LANCAMENTO = inserted.LANCAMENTO
    
    select @insSEQUENCIAL = CTB_BORDERO_LAYOUT.SEQUENCIAL_LAYOUT
      from CTB_BORDERO_LAYOUT
     where CTB_BORDERO_LAYOUT.LAYOUT = '0155'

    /* REMESSA DE INCLUSAO SERASA */
    if @validcnt0155 > 0
    begin
		UPDATE CTB_BORDERO
		set SEQUENCIAL_LAYOUT=@insSEQUENCIAL
		where LAYOUT='0155' and LANCAMENTO=@insLANCAMENTO

        UPDATE CTB_BORDERO_LAYOUT
        SET SEQUENCIAL_LAYOUT=REPLICATE('0',(6-LEN(Sequencial_layout+1)))+CAST(SEQUENCIAL_LAYOUT+1 AS VARCHAR(6))
        WHERE LAYOUT = '0155'
    end
    
    /* REMESSA DE EXCLUSAO SERASA */
    if @validcnt0156 > 0
    begin
		UPDATE CTB_BORDERO
		set SEQUENCIAL_LAYOUT=@insSEQUENCIAL
		where LAYOUT='0156' and LANCAMENTO=@insLANCAMENTO

        --- ATUALIZA APENAS O SEQUENCIAL DO LAYOUT DE ENVIO 0155, POIS É PRECISO PEGAR O ÚLTIMO ENVIO, SEJA I OU E.
        UPDATE CTB_BORDERO_LAYOUT
        SET SEQUENCIAL_LAYOUT=REPLICATE('0',(6-LEN(Sequencial_layout+1)))+CAST(SEQUENCIAL_LAYOUT+1 AS VARCHAR(6))
        WHERE LAYOUT = '0155'
    end

  end

  return
error:
    raiserror @errno @errmsg
    rollback transaction
end




USE [BANCO]
GO
/****** Object:  Trigger [dbo].[TI_CTB_BORDERO_PARCELA_CMD]    Script Date: 11/20/2014 11:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE trigger [dbo].[TI_CTB_BORDERO_PARCELA_CMD]
on [dbo].[CTB_BORDERO_PARCELA_CMD]
  AFTER INSERT NOT FOR REPLICATION
  as

/* INSERT trigger on CTB_BORDERO_PARCELA_CMD */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insEMPRESA int, 
           @insLANCAMENTO_MOV int, 
           @insLANCAMENTO int, 
           @insITEM_MOV smallint, 
           @insID_PARCELA char(2), 
           @insLAYOUT char(4), 
           @insOCORRENCIA varchar(10),
           @delEMPRESA int, 
           @delLANCAMENTO_MOV int, 
           @delLANCAMENTO int, 
           @delITEM_MOV smallint, 
           @delID_PARCELA char(2), 
           @delLX_TIPO_OCORRENCIA char(3), 
           @delOCORRENCIA varchar(10),
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
/* CTB_LX_BORDERO_OCORRENCIA R/271 CTB_BORDERO_PARCELA_CMD ON CHILD INSERT RESTRICT */
  select @nullcnt = 0

  --- BUSCAR LANÇAMENTO E LAYOUT 
  select @insLANCAMENTO = inserted.LANCAMENTO, @insLAYOUT = LTRIM(RTRIM(CTB_BORDERO.LAYOUT))
  from inserted, CTB_BORDERO
  where inserted.LANCAMENTO = CTB_BORDERO.LANCAMENTO

  IF @insLAYOUT = '0155'   
  BEGIN
     UPDATE FATURA
     SET FATURA.LX_TIPO_DOCUMENTO='34' 
     FROM CTB_A_RECEBER_FATURA FATURA
     JOIN (SELECT * FROM (SELECT DISTINCT LANCAMENTO_MOV,ITEM_MOV,LANCAMENTO FROM CTB_BORDERO_PARCELA_CMD ) AS CTB_BORDERO_PARCELA_CMD) BORD ON BORD.LANCAMENTO_MOV=FATURA.LANCAMENTO AND BORD.ITEM_MOV=FATURA.ITEM
     WHERE BORD.LANCAMENTO=@insLANCAMENTO 
		
     UPDATE PARC
     SET PARC.DATA_ENVIO_SERASA=CONVERT(CHAR(10),GETDATE(),103),PARC.INDICA_PROTESTO=1
     FROM CTB_A_RECEBER_PARCELA PARC
     JOIN CTB_BORDERO_PARCELA_CMD B ON B.LANCAMENTO_MOV=PARC.LANCAMENTO AND B.ITEM_MOV=PARC.ITEM AND B.ID_PARCELA=PARC.ID_PARCELA
     WHERE B.LANCAMENTO=@insLANCAMENTO
  END   

  IF @insLAYOUT = '0156'   
  BEGIN
     UPDATE PARC
     SET PARC.DATA_BAIXA_SERASA=CONVERT(CHAR(10),GETDATE(),103),PARC.INDICA_PROTESTO=0
     FROM CTB_A_RECEBER_PARCELA PARC
     JOIN CTB_BORDERO_PARCELA_CMD B ON B.LANCAMENTO_MOV=PARC.LANCAMENTO AND B.ITEM_MOV=PARC.ITEM AND B.ID_PARCELA=PARC.ID_PARCELA
     WHERE B.LANCAMENTO=@insLANCAMENTO
  END   

  return
error:
    raiserror (@errmsg, 16, 1)
    rollback transaction
end
