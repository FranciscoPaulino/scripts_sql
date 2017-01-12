--View para facilitar na integração da expedição.  
alter VIEW [dbo].WMS_INTEGRACAO_EXP_RESERVAS   
AS   
SELECT ltrim(rtrim(ROMANEIO)) RESERVA,   
CASE  
 WHEN [TAMANHO] = 'E1' THEN 'Tamanho_1'  
 WHEN [TAMANHO] = 'E2' THEN 'Tamanho_2'  
 WHEN [TAMANHO] = 'E3' THEN 'Tamanho_3'  
 WHEN [TAMANHO] = 'E4' THEN 'Tamanho_4'  
 WHEN [TAMANHO] = 'E5' THEN 'Tamanho_5'  
 WHEN [TAMANHO] = 'E6' THEN 'Tamanho_6'  
 WHEN [TAMANHO] = 'E7' THEN 'Tamanho_7'  
 WHEN [TAMANHO] = 'E8' THEN 'Tamanho_8'  
 WHEN [TAMANHO] = 'E9' THEN 'Tamanho_9'  
 WHEN [TAMANHO] = 'E10' THEN 'Tamanho_10'  
 WHEN [TAMANHO] = 'E11' THEN 'Tamanho_11'  
 WHEN [TAMANHO] = 'E12' THEN 'Tamanho_12'  
 WHEN [TAMANHO] = 'E13' THEN 'Tamanho_13'  
 WHEN [TAMANHO] = 'E14' THEN 'Tamanho_14'  
 WHEN [TAMANHO] = 'E15' THEN 'Tamanho_15'  
 WHEN [TAMANHO] = 'E16' THEN 'Tamanho_16'  
 WHEN [TAMANHO] = 'E17' THEN 'Tamanho_17'  
 WHEN [TAMANHO] = 'E18' THEN 'Tamanho_18'  
 WHEN [TAMANHO] = 'E19' THEN 'Tamanho_19'  
 WHEN [TAMANHO] = 'E20' THEN 'Tamanho_20'  
 WHEN [TAMANHO] = 'E21' THEN 'Tamanho_21'  
 WHEN [TAMANHO] = 'E22' THEN 'Tamanho_22'  
 WHEN [TAMANHO] = 'E23' THEN 'Tamanho_23'  
 WHEN [TAMANHO] = 'E24' THEN 'Tamanho_24'  
 WHEN [TAMANHO] = 'E25' THEN 'Tamanho_25'  
 WHEN [TAMANHO] = 'E26' THEN 'Tamanho_26'  
 WHEN [TAMANHO] = 'E27' THEN 'Tamanho_27'  
 WHEN [TAMANHO] = 'E28' THEN 'Tamanho_28'  
 WHEN [TAMANHO] = 'E29' THEN 'Tamanho_29'  
 WHEN [TAMANHO] = 'E30' THEN 'Tamanho_30'  
 WHEN [TAMANHO] = 'E31' THEN 'Tamanho_31'  
 WHEN [TAMANHO] = 'E32' THEN 'Tamanho_32'  
 WHEN [TAMANHO] = 'E33' THEN 'Tamanho_33'  
 WHEN [TAMANHO] = 'E34' THEN 'Tamanho_34'  
 WHEN [TAMANHO] = 'E35' THEN 'Tamanho_35'  
 WHEN [TAMANHO] = 'E36' THEN 'Tamanho_36'  
 WHEN [TAMANHO] = 'E37' THEN 'Tamanho_37'  
 WHEN [TAMANHO] = 'E38' THEN 'Tamanho_38'  
 WHEN [TAMANHO] = 'E39' THEN 'Tamanho_39'  
 WHEN [TAMANHO] = 'E40' THEN 'Tamanho_40'  
 WHEN [TAMANHO] = 'E41' THEN 'Tamanho_41'  
 WHEN [TAMANHO] = 'E42' THEN 'Tamanho_42'  
 WHEN [TAMANHO] = 'E43' THEN 'Tamanho_43'  
 WHEN [TAMANHO] = 'E44' THEN 'Tamanho_44'  
 WHEN [TAMANHO] = 'E45' THEN 'Tamanho_45'  
 WHEN [TAMANHO] = 'E46' THEN 'Tamanho_46'  
 WHEN [TAMANHO] = 'E47' THEN 'Tamanho_47'  
 WHEN [TAMANHO] = 'E48' THEN 'Tamanho_48'  
END TAMANHO, [QTD], PRODUTO, COR_PRODUTO, PEDIDO,ROMANEIO FROM VENDAS_PROD_EMBALADO  
UNPIVOT   
(  
 [QTD] FOR [TAMANHO]   
 IN (E1, E2, E3, E4, E5, E6, E7, E8, E9, E10, E11, E12, E13, E14, E15, E16, E17, E18,  
  E19, E20, E21, E22,  
  E23, E24, E25, E26, E27, E28, E29, E30, E31, E32, E33, E34, E35, E36, E37, E38, E39  
  , E40, E41, E42, E43, E44, E45, E46, E47, E48)  
)AS INTERNACAO_ITEM  
WHERE QTD > 0;  
  
  
  
  
go
      --Variáveis do pedido;
      DECLARE @ISN_PED INT, @ISN_PRO INT, @TAMPROD VARCHAR(60), @ISN_CLI INT, @PEDOBS VARCHAR(MAX);
      --Variáveis da reserva;
      DECLARE @ISN_RES INT;
      --Variáveis do insert
      DECLARE @RESERVA VARCHAR(20),@COR_PROD VARCHAR(60), @COD_PROD VARCHAR(60), @PEDIDO VARCHAR(20);      
      
      --Variávei da tabela de integração
      DECLARE @TAMCLN VARCHAR(20), @QTD INT;
      
      --SELECT @COR_PROD = INS.COR_PRODUTO, @COD_PROD = INS.PRODUTO, @RESERVA = LTRIM(RTRIM(INS.ROMANEIO)),
      --@PEDIDO = LTRIM(RTRIM(INS.PEDIDO))
      --FROM vendas_prod_embalado INS;
      
      --Curso para percorre os itens
      DECLARE cINTEGRACAO CURSOR
      FAST_FORWARD
      FOR 
      --Seleciona os itens da nota de entrada.
      SELECT I.TAMANHO, I.QTD,I.COR_PRODUTO, I.PRODUTO, I.ROMANEIO, LTRIM(RTRIM(I.PEDIDO)) FROM WMS_INTEGRACAO_EXP_RESERVAS I
            
      --Abre o cursor
      OPEN cINTEGRACAO;
      --Define os valores da primeira interação
      FETCH NEXT FROM cINTEGRACAO INTO @TAMCLN, @QTD,@COR_PROD,@COD_PROD,@RESERVA,@PEDIDO
      --
      WHILE @@FETCH_STATUS = 0
      BEGIN
            --Verifica se a nota fiscal já existe na base de dados
            IF NOT EXISTS(SELECT P.ISN_PEDIDO FROM WMS_PEDIDO P 
                  WHERE P.PEDCN_PEDIDO = @PEDIDO)
            BEGIN
                  SELECT @ISN_CLI = C.ISN_CLIENTE, @PEDOBS = V.OBS FROM CADASTRO_CLI_FOR C
                  JOIN VENDAS V ON (V.CLIENTE_ATACADO = C.NOME_CLIFOR);
                  
                  INSERT INTO WMS_PEDIDO(PEDCN_PEDIDO, PEDDT_PEDIDO, ISN_CLIENTE, PEDDS_OBSERVACAO) 
                  VALUES (@PEDIDO,GETDATE(), @ISN_CLI, @PEDOBS);
            END
            --RECUPERA O ID DO PEDIDO
            SELECT @ISN_PED = ISN_PEDIDO FROM WMS_PEDIDO
            WHERE PEDCN_PEDIDO = @PEDIDO;
            
            IF NOT EXISTS(SELECT RP.ISN_RESERVA_PEDIDO FROM WMS_RESERVAS_PEDIDO RP                  
                  WHERE RP.REPCN_RESERVA = @RESERVA AND RP.ISN_PEDIDO = @ISN_PED)
            BEGIN
                  INSERT INTO WMS_RESERVAS_PEDIDO(ISN_PEDIDO, REPCN_RESERVA, REPFG_STATUS_RESERVA) 
                  VALUES (@ISN_PED,@RESERVA, 'Pendente');
            END         
            --Recupera o id da reserva
            SELECT @ISN_RES = RP.ISN_RESERVA_PEDIDO FROM WMS_RESERVAS_PEDIDO RP
            WHERE REPCN_RESERVA = @RESERVA AND ISN_PEDIDO = @ISN_PED;        
            
            --Construção dinamica do select
            DECLARE @sql NVARCHAR(MAX), @params NVARCHAR(MAX), @tamanho varchar(50);
            --Define a clausula para a consulta dinamica.
            set @sql = N'SELECT @tamOUT = '+ @TAMCLN +' FROM PRODUTOS LP
            JOIN PRODUTOS_TAMANHOS LT ON (LP.GRADE = LT.GRADE)
            WHERE LP.PRODUTO = @codprod'
            --Define os parametros do sql dinamico
            set @params = N'@tamOUT varchar(15) output, @codprod varchar(50)';
            --Executa o sql feito dinamicamente
            EXECUTE SP_EXECUTESQL @sql, @params, @tamOUT = @tamanho output, @codprod = @COD_PROD;              
            --Recupera o isn do produto baseado na cor, tamanho e codigo do produto.
            SELECT @ISN_PRO = P.ISN_PRODUTO FROM WMS_PRODUTO P
            JOIN WMS_CORES C ON (P.PRONR_COR = C.ISN_COR)
            WHERE P.PRODS_TAM = @tamanho and C.CORNR_COR = @COR_PROD and p.PROCC_PRODUTO = @COD_PROD;
            --insere os itens da nota de entrada.          
            IF NOT EXISTS(SELECT IRP.ISN_RESERVA_PEDIDO FROM WMS_ITEM_RESERVAS_PEDIDO IRP               
                  WHERE IRP.ISN_PRODUTO = @ISN_PRO AND IRP.ISN_RESERVA_PEDIDO = @ISN_RES)
            BEGIN 
                  INSERT INTO WMS_ITEM_RESERVAS_PEDIDO(ISN_RESERVA_PEDIDO, ISN_PRODUTO, IRPQT_QUANTIDADE)
                  VALUES(@ISN_RES, @ISN_PRO, @QTD);
            END;
            --Próximo regitro da interação
            FETCH NEXT FROM cINTEGRACAO INTO @TAMCLN, @QTD,@COR_PROD,@COD_PROD,@RESERVA,@PEDIDO 
      END
      --Finaliza o cursor
      CLOSE cINTEGRACAO;      
      DEALLOCATE cINTEGRACAO;
