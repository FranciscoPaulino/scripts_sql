exec SP_SFV_BUSCA_REPRESENTANTE_NEW '001416'

exec SP_SFV_BUSCA_CLIENTES_REPRESENTANTE 'ROBINSON CARDOSO LESSA'

exec SP_SFV_ITENS_PEDIDO_IMPORT '0039a.001347'

exec SP_SFV_PEDIDOS_IMPORT 'REGES DA DALT'


delete from vendas_lote_copia_pedido
where pedido_externo in (
'0039a.001347',
'0042a.001347',
'0034a.001347',
'0035a.001347',
'0036a.001347',
'0037a.001347',
'0039a.001347',
'0040a.001347',
'0041a.001347',
'0038a.001347',
'0012a.001347',
'0013a.001347',
'0019a.001347',
'0020a.001347',
'0021a.001347',
'0022a.001347',
'0018a.001347',
'0031a.001347',
'0032a.001347',
'0024a.001347',
'0025a.001347',
'0026a.001347',
'0027a.001347',
'0028a.001347',
'0016a.001347',
'0014a.001347',
'0011a.001347',
'0008a.001347',
'0010a.001347',
'0009a.001347',
'0004a.001347',
'0005a.001347',
'0006a.001347',
'0007a.001347',
'0029a.001347',
'0030a.001347',
'0033a.001347')



delete from vendas_lote_prod_copia_pedido
where pedido_externo in (
'0039a.001347',
'0042a.001347',
'0034a.001347',
'0035a.001347',
'0036a.001347',
'0037a.001347',
'0039a.001347',
'0040a.001347',
'0041a.001347',
'0038a.001347',
'0012a.001347',
'0013a.001347',
'0019a.001347',
'0020a.001347',
'0021a.001347',
'0022a.001347',
'0018a.001347',
'0031a.001347',
'0032a.001347',
'0024a.001347',
'0025a.001347',
'0026a.001347',
'0027a.001347',
'0028a.001347',
'0016a.001347',
'0014a.001347',
'0011a.001347',
'0008a.001347',
'0010a.001347',
'0009a.001347',
'0004a.001347',
'0005a.001347',
'0006a.001347',
'0007a.001347',
'0029a.001347',
'0030a.001347',
'0033a.001347')
