--- gera consumo da op pela ficha técnica 
exec sp_executesql N'
/* VISUALLINX Execute(Alias:xCur_FT)  */
EXECUTE lx_gera_cursor_ft @XXORDEM_PRODUCAO=@P1,@XMOSTRA_PARTE = 1',N'@P1 varchar(6)','52252'
-- saída da procedure
-- material,cor_material,ordem_producao,reserva_original,reserva,diferenca_previsao


-- estoque
exec sp_executesql N'
/* VISUALLINX Execute(Alias:xcur_mat)  */
select sum(qtde_estoque) as estoque from  estoque_materiais 				 where material=@P1 				 and cor_material=@P2',N'@P1 varchar(10),@P2 varchar(3)','01.02.0130','214'


-- produção outras reservas
exec sp_executesql N'
/* VISUALLINX Execute(Alias:xcur_res)  */
select sum(reserva) as reserva from producao_reserva where ordem_producao<> @P1 				    and material=@P2 				    and cor_material=@P3',N'@P1 varchar(5),@P2 varchar(10),@P3 varchar(3)','52252','01.02.0130','214'

-- qtde_entregar
exec sp_executesql N'
/* VISUALLINX Execute(Alias:xcur_com)  */
select  SUM(QTDE_ENTREGAR) as QTDE_ENTREGAR,min(ENTREGA) as entrega 		            from compras_material where QTDE_ENTREGAR>0 				    and material=@P1 				    and cor_material=@P2 ',N'@P1 varchar(10),@P2 varchar(3)','01.02.0130','214'


-- VERIFICAÇÃO DE ESTOQUE DOS MATERIAIS DA OP 
SELECT MATERIAIS.DESC_MATERIAL,PR.MATERIAL,PR.COR_MATERIAL,PR.ORDEM_PRODUCAO,
       PR.RESERVA_ORIGINAL,PR.RESERVA,ESTOQUE_MATERIAIS.QTDE_ESTOQUE,
       OUTRAS_RESERVAS=( select sum(reserva) as reserva from producao_reserva where ordem_producao <> PR.ORDEM_PRODUCAO
        				    and material=PR.MATERIAL  and cor_material=PR.COR_MATERIAL ) 
  FROM PRODUCAO_RESERVA PR
  JOIN ESTOQUE_MATERIAIS ON ESTOQUE_MATERIAIS.MATERIAL=PR.MATERIAL AND ESTOQUE_MATERIAIS.COR_MATERIAL=PR.COR_MATERIAL
  JOIN MATERIAIS ON MATERIAIS.MATERIAL=ESTOQUE_MATERIAIS.MATERIAL  
 WHERE RESERVA>0 AND 
       ESTOQUE_MATERIAIS.QTDE_ESTOQUE<=0 AND 
       ESTOQUE_MATERIAIS.FILIAL='DR VAREJO' AND 
       PR.ORDEM_PRODUCAO='52252'
       

SELECT * FROM (
SELECT MATERIAIS.DESC_MATERIAL,PR.MATERIAL,PR.COR_MATERIAL,PR.ORDEM_PRODUCAO,
       PR.RESERVA_ORIGINAL,PR.RESERVA,ESTOQUE_MATERIAIS.QTDE_ESTOQUE,
       OUTRAS_RESERVAS=( select sum(reserva) as reserva from producao_reserva where ordem_producao <> PR.ORDEM_PRODUCAO
        				    and material=PR.MATERIAL  and cor_material=PR.COR_MATERIAL ) 
  FROM PRODUCAO_RESERVA PR
  JOIN ESTOQUE_MATERIAIS ON ESTOQUE_MATERIAIS.MATERIAL=PR.MATERIAL AND ESTOQUE_MATERIAIS.COR_MATERIAL=PR.COR_MATERIAL
  JOIN MATERIAIS ON MATERIAIS.MATERIAL=ESTOQUE_MATERIAIS.MATERIAL
 WHERE RESERVA>0 AND 
       ESTOQUE_MATERIAIS.FILIAL='DR VAREJO' AND 
       PR.ORDEM_PRODUCAO='52252'
) AS RESERVA_FINAL
WHERE (OUTRAS_RESERVAS+RESERVA) > QTDE_ESTOQUE      
