select  * from ENTRADAS_IMPOSTO
WHERE NF_ENTRADA='0006199' AND SERIE_NF_ENTRADA='57' AND ID_IMPOSTO=1 --AND ITEM_IMPRESSAO='0001'

select ID_IMPOSTO, ITEM_IMPRESSAO,  BASE_IMPOSTO_CALC,VALOR_IMPOSTO from ENTRADAS_IMPOSTO
WHERE NF_ENTRADA='0006199' AND SERIE_NF_ENTRADA='57' AND ID_IMPOSTO=1


EXEC LX_GERA_IMPOSTOS_ENTRADA 'LAZIANE CRISTINA PALHARES','0006199','57',1,1,1

SELECT * FROM CTB_LX_IMPOSTO_TIPO

UPDATE ENTRADAS_IMPOSTO
SET VALOR_IMPOSTO_CALC=VALOR_IMPOSTO, VALOR_IMPOSTO_ESPELHO=VALOR_IMPOSTO
WHERE NF_ENTRADA='0006199' AND SERIE_NF_ENTRADA='57' AND ID_IMPOSTO=1 --AND ITEM_IMPRESSAO='0009'


UPDATE ENTRADAS_IMPOSTO
SET VALOR_IMPOSTO=(TAXA_IMPOSTO*BASE_IMPOSTO_CALC)/100,VALOR_IMPOSTO_CALC=(TAXA_IMPOSTO*BASE_IMPOSTO_CALC)/100,VALOR_IMPOSTO_ESPELHO=(TAXA_IMPOSTO*BASE_IMPOSTO_CALC)/100
WHERE NF_ENTRADA='0006199' AND SERIE_NF_ENTRADA='57' AND ID_IMPOSTO=1 --AND ITEM_IMPRESSAO='0009'


