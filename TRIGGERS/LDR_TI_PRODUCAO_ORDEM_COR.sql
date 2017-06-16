CREATE trigger [dbo].[LDR_TI_PRODUCAO_ORDEM_COR] 
on [dbo].[PRODUCAO_ORDEM_COR]
  for INSERT NOT FOR REPLICATION
  as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insORDEM_PRODUCAO char(8), 
           @insPRODUTO char(12), 
           @insCOR_PRODUTO char(10),
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
/* PRODUCAO_ORDEM R/1140 PRODUCAO_ORDEM_COR ON CHILD INSERT RESTRICT */
  if 
     update(ORDEM_PRODUCAO)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted, PRODUCAO_ORDEM with (nolock), PRODUCAO_ORDEM_COR with (nolock), (SELECT A.ORDEM_PRODUCAO,A.INICIO_REAL FROM PRODUCAO_TAREFAS A with (nolock) WHERE A.FASE_PRODUCAO='006') AS W_PRODUCAO_TAREFAS 
     where 
	       W_PRODUCAO_TAREFAS.ORDEM_PRODUCAO = PRODUCAO_ORDEM.ORDEM_PRODUCAO and 
           PRODUCAO_ORDEM_COR.PRODUTO=inserted.PRODUTO and
           PRODUCAO_ORDEM_COR.COR_PRODUTO = inserted.COR_PRODUTO and
           PRODUCAO_ORDEM.ORDEM_PRODUCAO = PRODUCAO_ORDEM_COR.ORDEM_PRODUCAO and
           DATEDIFF(DAY, W_PRODUCAO_TAREFAS.INICIO_REAL, GETDATE())>30 and 
           PRODUCAO_ORDEM_COR.QTDE_P>0 AND PRODUCAO_ORDEM.FILIAL='DR VAREJO'

    --- SELEÇÃO APENAS DA ORDEM DE PRODUÇÃO
    select @insORDEM_PRODUCAO=PRODUCAO_ORDEM_COR.ORDEM_PRODUCAO
      from inserted, PRODUCAO_ORDEM with (nolock), PRODUCAO_ORDEM_COR with (nolock), (SELECT A.ORDEM_PRODUCAO,A.INICIO_REAL FROM PRODUCAO_TAREFAS A with (nolock) WHERE A.FASE_PRODUCAO='006') AS W_PRODUCAO_TAREFAS 
     where 
	       W_PRODUCAO_TAREFAS.ORDEM_PRODUCAO = PRODUCAO_ORDEM.ORDEM_PRODUCAO and 
           PRODUCAO_ORDEM_COR.PRODUTO=inserted.PRODUTO and
           PRODUCAO_ORDEM_COR.COR_PRODUTO = inserted.COR_PRODUTO and
           PRODUCAO_ORDEM.ORDEM_PRODUCAO = PRODUCAO_ORDEM_COR.ORDEM_PRODUCAO and
           DATEDIFF(DAY, W_PRODUCAO_TAREFAS.INICIO_REAL, GETDATE())>30 and 
           PRODUCAO_ORDEM_COR.QTDE_P>0 AND PRODUCAO_ORDEM.FILIAL='DR VAREJO'  
           
    if @validcnt > 0
    begin
      select @errno  = 30002,
             @errmsg = 'Impossível Incluir #PRODUCAO_ORDEM_COR #porque existe #ORDEM DE PRODUÇÃO# '+RTRIM(@insORDEM_PRODUCAO)+' aberta por mais de 30 dias.'
      goto error
    end

	-- vefirica se qtde digitada é maior que qtde programada 
	if (SELECT count(*) FROM inserted A
		JOIN PRODUCAO_ORDEM B with (nolock) ON B.ORDEM_PRODUCAO=A.ORDEM_PRODUCAO
		JOIN PRODUCAO_PROG_PROD C with (nolock) ON C.PROGRAMACAO=B.PROGRAMACAO AND C.PRODUTO=A.PRODUTO AND C.COR_PRODUTO=A.COR_PRODUTO
		WHERE B.ORDEM_PRODUCAO=A.ORDEM_PRODUCAO AND B.PROGRAMACAO=C.PROGRAMACAO AND 
		A.O1<=C.P1 AND A.O2<=C.P2 AND A.O3<=C.P3 AND A.O4<=C.P4 AND A.O5<=C.P5 AND A.O6<=C.P6 AND A.O7<=C.P7 AND
		A.O8<=C.P8 AND A.O9<=C.P9 AND A.O10<=C.P10 AND A.O11<=C.P11 AND A.O12<=C.P12 AND A.O13<=C.P13 AND A.O14<=C.P14 AND 
		A.O15<=C.P15 AND A.O16<=C.P16 AND A.O17<=C.P17 AND A.O18<=C.P18 AND A.O19<=C.P19 AND A.O20<=C.P20 AND A.O21<=C.P21
	) = 0
    begin
      select @errno  = 30002,
             @errmsg = 'Impossível Incluir #PRODUCAO_ORDEM_COR# porque existe diferença de Quantidade entre Digitado x Programado, verifique'
      goto error
    end
  end

  return
error:
    raiserror @errno @errmsg
    rollback transaction
end

