SELECT LOG_ALTERACOES.COLUNA, LOG_ALTERACOES.SEQUENCIAL,  LOG_ALTERACOES.VALOR_NOVO, LOG_ALTERACOES.VALOR_ANTIGO,  
LOG_ALTERACOES.TABELA FROM DBO.LOG_ALTERACOES LOG_ALTERACOES 
WHERE coluna='pedido' AND VALOR_ANTIGO='590005' 
order by sequencial



201662     