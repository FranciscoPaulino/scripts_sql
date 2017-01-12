UPDATE faturamento set NOTA_CANCELADA = '1' where nf_saida = '042922' and serie_nf = '4'
UPDATE faturamento set MOTIVO_CANCELAMENTO_NFE = 'QUANTIDADE INCORRETA' where nf_saida = '042922' and serie_nf = '4'
UPDATE faturamento set status_nfe = '42' where nf_saida = '042922' and serie_nf = '4'
