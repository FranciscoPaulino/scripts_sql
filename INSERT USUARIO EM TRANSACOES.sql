SELECT * FROM USERS_TRANSACOES
where COD_TRANSACAO='entrada_produto_103' AND USUARIO='SA'



INSERT INTO USERS_TRANSACOES (USUARIO,COD_TRANSACAO,ACESSO_BLOQUEADO,INCLUIR,ALTERAR,EXCLUIR,PESQUISAR,PESQUISA_ESPECIAL,IMPRIMIR,CRIAR_RELATORIO,ITEM_EXCLUIR,ITEM_INCLUIR)
SELECT DISTINCT USUARIO,'ENTRADA_PRODUTO_103',1,0,0,0,1,0,1,0,0,0 FROM USERS_TRANSACOES
WHERE USUARIO NOT IN (SELECT USUARIO FROM USERS_TRANSACOES where COD_TRANSACAO='entrada_produto_103' )


SELECT * FROM USERS_MODULOS
WHERE MODULO='ESTPA'
