SP_SFV_PEDIDOS_CONFIRMADOS 'HEULER CORREA NETTO','20130220'

SP_SFV_ITENS_PEDIDOS_CONFIRMADOS '549587','20130220'

CREATE PROCEDURE [dbo].[SP_SFV_PEDIDOS_CONFIRMADOS]    
@REPRESENTANTE varchar(25), @DATA_ULTIMA_ATUALIZACAO DATETIME    
AS  
SELECT * FROM VENDAS
where VENDAS.REPRESENTANTE=@REPRESENTANTE AND VENDAS.DATA_PARA_TRANSFERENCIA > @DATA_ULTIMA_ATUALIZACAO


CREATE PROCEDURE [dbo].[SP_SFV_ITENS_PEDIDOS_CONFIRMADOS]    
@REPRESENTANTE varchar(12), @DATA_ULTIMA_ATUALIZACAO DATETIME    
AS  
SELECT * FROM VENDAS_PRODUTO
where VENDAS_PRODUTO.PEDIDO=@REPRESENTANTE AND VENDAS_PRODUTO.DATA_PARA_TRANSFERENCIA > @DATA_ULTIMA_ATUALIZACAO

