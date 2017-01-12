-- marcus carioca
SELECT w_prazo_medio.emissao, gerente=rtrim(w_prazo_medio.gerente), representante=rtrim(w_prazo_medio.representante), w_prazo_medio.condicao_pgto, w_prazo_medio.media_dias_parcela, w_prazo_medio.porc_desconto, w_prazo_medio.pedido, w_prazo_medio.item_produto
FROM w_prazo_medio w_prazo_medio
WHERE (w_prazo_medio.gerente In ('MARCUS ROBERTO','MARCUS CARIOCA'))
union all
SELECT w_prazo_medio.emissao, gerente=rtrim(w_prazo_medio.gerente), representante=rtrim(w_prazo_medio.representante), w_prazo_medio.condicao_pgto, w_prazo_medio.media_dias_parcela, w_prazo_medio.porc_desconto, w_prazo_medio.pedido, w_prazo_medio.item_produto
FROM ldr.drvarejo.dbo.w_prazo_medio w_prazo_medio
WHERE (w_prazo_medio.gerente In ('MARCUS ROBERTO','MARCUS CARIOCA'))


--- jose mario
SELECT w_prazo_medio.emissao, gerente=rtrim(w_prazo_medio.gerente), representante=rtrim(w_prazo_medio.representante), w_prazo_medio.condicao_pgto, w_prazo_medio.media_dias_parcela, w_prazo_medio.porc_desconto, w_prazo_medio.pedido, w_prazo_medio.item_produto
FROM w_prazo_medio w_prazo_medio
WHERE (w_prazo_medio.gerente In ('CELSO MACHADO','JOSE MARIO ARRUDA'))
union all
SELECT w_prazo_medio.emissao, gerente=rtrim(w_prazo_medio.gerente), representante=rtrim(w_prazo_medio.representante), w_prazo_medio.condicao_pgto, w_prazo_medio.media_dias_parcela, w_prazo_medio.porc_desconto, w_prazo_medio.pedido, w_prazo_medio.item_produto
FROM ldr.drvarejo.dbo.w_prazo_medio w_prazo_medio
WHERE (w_prazo_medio.gerente In ('CELSO MACHADO','JOSE MARIO ARRUDA'))

--- sergio pires
SELECT w_prazo_medio.emissao, gerente=rtrim(w_prazo_medio.gerente), 
representante=rtrim(w_prazo_medio.representante), 
w_prazo_medio.condicao_pgto, w_prazo_medio.media_dias_parcela, 
w_prazo_medio.porc_desconto, w_prazo_medio.pedido, 
w_prazo_medio.item_produto
FROM w_prazo_medio w_prazo_medio
WHERE (w_prazo_medio.gerente LIKE 'SERGIO PIRES%' OR w_prazo_medio.gerente LIKE 'MAURILIO%')
UNION ALL
SELECT w_prazo_medio.emissao, gerente=rtrim(w_prazo_medio.gerente), 
representante=rtrim(w_prazo_medio.representante), 
w_prazo_medio.condicao_pgto, w_prazo_medio.media_dias_parcela, 
w_prazo_medio.porc_desconto, w_prazo_medio.pedido, 
w_prazo_medio.item_produto
FROM ldr.drvarejo.dbo.w_prazo_medio w_prazo_medio
WHERE (w_prazo_medio.gerente LIKE 'SERGIO PIRES%' OR w_prazo_medio.gerente LIKE 'MAURILIO%')


--- SARMENTO
SELECT w_prazo_medio.emissao, gerente=rtrim(w_prazo_medio.gerente), representante=rtrim(w_prazo_medio.representante), w_prazo_medio.condicao_pgto, w_prazo_medio.media_dias_parcela, w_prazo_medio.porc_desconto, w_prazo_medio.pedido, w_prazo_medio.item_produto
FROM w_prazo_medio w_prazo_medio
WHERE (w_prazo_medio.gerente LIKE 'SARMENTO%') or (w_prazo_medio.gerente = 'JOSE ANTONIO SARMENTO')
UNION ALL
SELECT w_prazo_medio.emissao, gerente=rtrim(w_prazo_medio.gerente), representante=rtrim(w_prazo_medio.representante), w_prazo_medio.condicao_pgto, w_prazo_medio.media_dias_parcela, w_prazo_medio.porc_desconto, w_prazo_medio.pedido, w_prazo_medio.item_produto
FROM ldr.drvarejo.dbo.w_prazo_medio w_prazo_medio
WHERE (w_prazo_medio.gerente LIKE 'SARMENTO%') or (w_prazo_medio.gerente = 'JOSE ANTONIO SARMENTO')
