CREATE trigger [dbo].[LDR_TI_CTB_BORDERO] 
on [dbo].[CTB_BORDERO] 
AFTER INSERT NOT FOR REPLICATION
as
/* INSERT trigger on CTB_BORDERO */
begin
  declare  @numrows int,
           @nullcnt char(4),
           @validcnt0255 int,
           @validcnt0256 int,
           @insEMPRESA int, 
           @insLANCAMENTO int,
           @insSEQUENCIAL varchar(6),
           @delEMPRESA int, 
           @delLANCAMENTO int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount

  /* REMESSA DE INCLUSAO/EXCLUSAO DA SERASA */
  if
    update(LAYOUT)
  begin
    select @validcnt0255 = count(*)
      from inserted,CTB_BORDERO_LAYOUT
     where
           inserted.LAYOUT = CTB_BORDERO_LAYOUT.LAYOUT 
           AND CTB_BORDERO_LAYOUT.LAYOUT = '0255' 

    select @validcnt0256 = count(*)
      from inserted,CTB_BORDERO_LAYOUT
     where
           inserted.LAYOUT = CTB_BORDERO_LAYOUT.LAYOUT 
           AND CTB_BORDERO_LAYOUT.LAYOUT = '0256' 
           
    select @insLANCAMENTO = LTRIM(RTRIM(CTB_BORDERO.LANCAMENTO))
      from inserted,CTB_BORDERO
     where inserted.LAYOUT IN ('0255','0256') AND CTB_BORDERO.LANCAMENTO = inserted.LANCAMENTO
    
    select @insSEQUENCIAL = CTB_BORDERO_LAYOUT.SEQUENCIAL_LAYOUT
      from CTB_BORDERO_LAYOUT
     where CTB_BORDERO_LAYOUT.LAYOUT = '0255'

    /* REMESSA DE INCLUSAO SERASA */
    if @validcnt0255 > 0
    begin
		UPDATE CTB_BORDERO
		set SEQUENCIAL_LAYOUT=@insSEQUENCIAL
		where LAYOUT='0255' and LANCAMENTO=@insLANCAMENTO

        UPDATE CTB_BORDERO_LAYOUT
        SET SEQUENCIAL_LAYOUT=REPLICATE('0',(6-LEN(Sequencial_layout+1)))+CAST(SEQUENCIAL_LAYOUT+1 AS VARCHAR(6))
        WHERE LAYOUT = '0255'
    end
    
    /* REMESSA DE EXCLUSAO SERASA */
    if @validcnt0256 > 0
    begin
		UPDATE CTB_BORDERO
		set SEQUENCIAL_LAYOUT=@insSEQUENCIAL
		where LAYOUT='0256' and LANCAMENTO=@insLANCAMENTO

        --- ATUALIZA APENAS O SEQUENCIAL DO LAYOUT DE ENVIO 0155, POIS É PRECISO PEGAR O ÚLTIMO ENVIO, SEJA I OU E.
        UPDATE CTB_BORDERO_LAYOUT
        SET SEQUENCIAL_LAYOUT=REPLICATE('0',(6-LEN(Sequencial_layout+1)))+CAST(SEQUENCIAL_LAYOUT+1 AS VARCHAR(6))
        WHERE LAYOUT = '0255'
    end

  end

  return
error:
    raiserror @errno @errmsg
    rollback transaction
end




