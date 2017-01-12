select * from VENDAS_LOTE_COPIA_PEDIDO
WHERE PEDIDO_EXTERNO='0097F.001435'


select * from USERS_MODULOS
where modulo='PROD'


select * from USERS_TRANSACOES
where --USUARIO='dirlene' and 
COD_TRANSACAO='PRODUCAO_ORDENS_021' and IMPRIMIR=1


INSERT INTO USERS_TRANSACOES (USUARIO,COD_TRANSACAO,ACESSO_BLOQUEADO,INCLUIR,EXCLUIR,ALTERAR,PESQUISAR,PESQUISA_ESPECIAL,IMPRIMIR,CRIAR_RELATORIO,ITEM_EXCLUIR,ITEM_INCLUIR) 
select usuario,'PRODUCAO_ORDENS_021','0','1','1','1','1','1','0','0','1','1' from USERS_MODULOS
where modulo='PROD' and USUARIO not in (
select USUARIO from USERS_TRANSACOES
where --USUARIO='dirlene' and 
COD_TRANSACAO='PRODUCAO_ORDENS_021')



VALUES (@P1 ,@P2 ,@P3 ,@P4 ,@P5 ,@P6 ,@P7 ,@P8 ,@P9 ,@P10 ,@P11 )


exec sp_executesql N'INSERT INTO USERS_TRANSACOES (USUARIO,COD_TRANSACAO,INCLUIR,EXCLUIR,ALTERAR,PESQUISAR,PESQUISA_ESPECIAL,IMPRIMIR,CRIAR_RELATORIO,ITEM_EXCLUIR,ITEM_INCLUIR) VALUES (@P1 ,@P2 ,@P3 ,@P4 ,@P5 ,@P6 ,@P7 ,@P8 ,@P9 ,@P10 ,@P11 )',N'@P1 varchar(25),@P2 varchar(23),@P3 bit,@P4 bit,@P5 bit,@P6 bit,@P7 bit,@P8 bit,@P9 bit,@P10 bit,@P11 bit','DIRLENE                  ','PRODUCAO_ORDENS_021    ',1,1,1,1,1,0,0,1,1





update USERS_MODULOS
set IMPRIMIR=0
where modulo='PROD'




JOSE ROBERTO             
WALTER WANDERSON         
DIRLENE                  
CHARLES                  
DEA                      
DOCARMO                  
EDSON                    
GERMANA                  
ZE CARLOS                
JESSICA                  
LEILAD                   