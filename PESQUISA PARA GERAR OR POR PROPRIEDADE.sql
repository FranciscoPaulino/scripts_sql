USE [HOMOLOGACAO]
GO
/****** Object:  StoredProcedure [dbo].[LX_GERA_RESERVA]    Script Date: 05/28/2015 14:22:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[LX_GERA_RESERVA] @romaneio char(8), @filial varchar(25), @regiao_i varchar(25) = null, @regiao_f varchar(25) = null, @pontualidade_i varchar(25) = null, @pontualidade_f varchar(25) = null, @tipo_cliente_i varchar(25) = null, @tipo_cliente_f varchar(25) = null, 
	@prior_cliente_i tinyint = 0, @prior_cliente_f tinyint = 9, @clifor_i char(6) = null, @clifor_f char(6) = null, @conceito_i varchar(25) = null, @conceito_f varchar(25) = null, @entrega_i datetime = null, @entrega_f datetime = null, @limite_i datetime = null, @limite_f datetime = null, 
	@emissao_i datetime = null, @emissao_f datetime = null, @tipo_venda varchar(25) = null, @representante_i varchar(25) = null, @representante_f varchar(25) = null, @gerente_i varchar(25) = null, @gerente_f varchar(25) = null,
	@porc_fat_i numeric(5, 2) = 0, @porc_fat_f numeric(5, 2) = 0, @colecao varchar(25) = null, @status_venda varchar(25) = null, @prior_venda_i tinyint = 0, @prior_venda_f tinyint = 9, @ultimo_fat datetime = null, @qtde_estoque tinyint = 0, @atraso int = 0, 
	@clifor_entregai char(6) = null, @clifor_entregaf char(6) = null, @id_modificacao char(6), @pedido_inicial char(12) = null, @pedido_final char(12) = null
as

/* 11/01/2006 p/ Estevam  - Inclusão do campo gerente_i e gerente_f (xwhere6) */
/* 09/06/2005 p/ Estevam  - Inclusão do campo id_modificacao (xwhere4) */
/* 18/10/2004 p/ Sergio   - Correção da alteração anterior, ficou faltando um begin/end dentro do if, o que fazia com que o delete de atraso sempre fosse executando, não retornando itens */
/* 26/07/2004 p/ Basilio  - Alteração na verificacao do atraso para pegar o parametro BLOQUEIO_EXPEDICAO_FILIAL para verificar se deve bloquear por filial*/
/* 13/08/2003 p/ Sergio   - corrigido erro ao calcular campo valor_r qdo produto possui variacao de preco por tamanho */
/* 13/08/2003 p/ Sergio   - Inclusao de filtro de faixa de pedidos */
/* 12/09/2003 p/ Sergio   - Inclusão de filtro para não trazer pedidos com tipo de rateio = 3 (rateio p/ Separação) */
/* 20/10/2003 p/ Sergio   - Alteração para verificar atraso utilizando os titulos do financeiro novo (5.0) e antigo (4.0 e anterior) */
/* 28/10/2003 p/ Sergio   - Alteração no comando select que verifica o atraso dos titulos no financeiro novo, agora está verificando pelo campo vencimento_real */
set nocount on

declare @xwhere1 varchar(250), @xwhere2 varchar(250), @xwhere3 varchar(250), @xwhere4 varchar(250), @xwhere5 varchar(250), @xwhere6 varchar(250), @xwhere7 varchar(250), @xwhere8 varchar(250),
	@xwhere9 varchar(250), @produto char(12), @cor_produto char(10), @ordem_producao char(8), @status char(1), @pedido char(12), @entrega datetime, @qtde_entregar int, @qtde int,
	@ve1  int, @ve2  int, @ve3  int, @ve4  int, @ve5  int, @ve6  int, @ve7  int, @ve8  int, @ve9  int, @ve10 int, @ve11 int, @ve12 int, @ve13 int, @ve14 int, @ve15 int, @ve16 int, 
	@ve17 int, @ve18 int, @ve19 int, @ve20 int, @ve21 int, @ve22 int, @ve23 int, @ve24 int, @ve25 int, @ve26 int, @ve27 int, @ve28 int, @ve29 int, @ve30 int, @ve31 int, @ve32 int, 
	@ve33 int, @ve34 int, @ve35 int, @ve36 int, @ve37 int, @ve38 int, @ve39 int, @ve40 int, @ve41 int, @ve42 int, @ve43 int, @ve44 int, @ve45 int, @ve46 int, @ve47 int, @ve48 int,
	@xwhere10 varchar(250), @xwhere11 varchar(250), @xwhere12 varchar(250), @aspas char(1), @item_unico bit, @item_pedido char(4), @valor_r numeric(16, 2), @conta int, 
	@preco1 numeric(16, 2), @preco2 numeric(16, 2), @preco3 numeric(16, 2), @preco4 numeric(16, 2), @desconto_item numeric(16, 2), @ponteiro_preco_tam varchar(48), @varia_preco_tam bit,
	@valor_atual char(1)

select @item_unico = case when valor_atual = '.T.' then 1 else 0 end from parametros where parametro = 'reserva_item_unica_or'
if @@rowcount = 0
	select @item_unico = 0

select @xwhere1 = '', @xwhere2 = '', @xwhere3 = '', @xwhere4 = '', @xwhere5 = '', @xwhere6 = '', @xwhere7 = '', @xwhere8 = '', @xwhere9 = ''
select @aspas=char(39)

if isnull(@regiao_i, '') <> ''
	select @xwhere1 = ' and clientes_atacado.regiao >= ' + @aspas + @regiao_i + @aspas + ' and clientes_atacado.regiao <= ' + @aspas + @regiao_f +  + @aspas + ' '
if isnull(@pontualidade_i, '') <> ''
	select @xwhere1 = @xwhere1 + ' and clientes_atacado.pontualidade >= ' + @aspas + @pontualidade_i + @aspas + ' and clientes_atacado.pontualidade <= ' + @aspas + @pontualidade_f + @aspas + ' '
if isnull(@tipo_cliente_i, '') <> ''
	select @xwhere2 = ' and clientes_atacado.tipo >= ' + @aspas + @tipo_cliente_i + @aspas + ' and clientes_atacado.tipo <= ' + @aspas + @tipo_cliente_f + @aspas + ' '
if @prior_cliente_i <> 0 or @prior_cliente_f <> 9
	select @xwhere2 = @xwhere2 + ' and clientes_atacado.prioridade >= ' + convert(char(1), @prior_cliente_i) + ' and clientes_atacado.prioridade <= ' + convert(char(1), @prior_cliente_f) 
if isnull(@clifor_i, '') <> ''
	select @xwhere3 =  ' and clientes_atacado.clifor >= ' + @aspas + @clifor_i + @aspas + ' and clientes_atacado.clifor <= ' + @aspas + @clifor_f + @aspas
if isnull(@conceito_i, '') <> ''
	select @xwhere3 = @xwhere3 + ' and clientes_atacado.conceito >= ' + @aspas + @conceito_i + @aspas + ' and clientes_atacado.conceito <= ' + @aspas + @conceito_f + @aspas
if isnull(@entrega_i, '') <> ''
	select @xwhere4 = ' and vendas_produto.entrega >= ' + @aspas + convert(char(10), @entrega_i, 112) + @aspas + ' and vendas_produto.entrega <= ' + @aspas + convert(char(10),  @entrega_f, 112) + @aspas
if isnull(@limite_i, '') <> ''
	select @xwhere4 = @xwhere4 + ' and vendas_produto.limite_entrega >= ' + @aspas + convert(char(10), @limite_i, 112) + @aspas + ' and vendas_produto.limite_entrega <= ' + @aspas + convert(char(10), @limite_f, 112) + @aspas
if isnull(@id_modificacao, '') <> ''
	select @xwhere4 = @xwhere4 + ' and vendas_produto.id_modificacao = ' + @aspas + @id_modificacao + @aspas
if isnull(@emissao_i, '') <> ''
	select @xwhere5 = ' and vendas.emissao >= ' + @aspas + convert(char(10), @emissao_i, 112) + @aspas + ' and vendas.emissao <= ' + @aspas + convert(char(10), @emissao_f, 112) + @aspas
if isnull(@tipo_venda, '') <> ''
	select @xwhere5 = @xwhere5 + ' and vendas.tipo = ' + @aspas + @tipo_venda  + @aspas
if isnull(@representante_i, '') <> ''
	select @xwhere6 = ' and vendas.representante >= ' + @aspas + @representante_i + @aspas + ' and vendas.representante <= ' + @aspas + @representante_f + @aspas
if isnull(@gerente_i, '') <> ''
	select @xwhere6 = ' and vendas.gerente >= ' + @aspas + @gerente_i + @aspas + ' and vendas.gerente <= ' + @aspas + @gerente_f + @aspas
if @porc_fat_i <> 0 or @porc_fat_f <> 100
	select @xwhere7 = ' and round(((vendas.tot_qtde_entregar / vendas.tot_qtde_original) * 100), 2) >= ' + convert(char(5), @porc_fat_i) + ' and round(((vendas.tot_qtde_entregar / vendas.tot_qtde_original) * 100), 2) <= ' + convert(char(5), @porc_fat_f)
if isnull(@colecao, '') <> ''
	select @xwhere8 = ' and vendas.colecao = ' + @aspas + @colecao  + @aspas
if isnull(@status_venda, '') <> ''
	select @xwhere8 = @xwhere8 + ' and vendas_produto.status_venda_atual = ' + @aspas + @status_venda  + @aspas
if @prior_venda_i <> 0 or @prior_venda_f <> 9
	select @xwhere9 = ' and vendas.prioridade > = ' + convert(char(1), @prior_venda_i) + ' and vendas.prioridade <= ' + convert(char(1), @prior_venda_f)
if isnull(@clifor_entregai, '') <> ''
	select @xwhere9 =  ' and cli.clifor >= ' + @aspas + @clifor_entregai + @aspas + ' and cli.clifor <= ' + @aspas + @clifor_entregaf + @aspas
if isnull(@pedido_inicial, '') <> ''
	select @xwhere9 = ' and vendas.pedido >= ' + @aspas + @pedido_inicial + @aspas + ' and vendas.pedido <= ' + @aspas + @pedido_final + @aspas

select @xwhere11 = ' and vendas_produto.qtde_entregar > vendas_produto.qtde_embalada and vendas.aprovacao = ' + @aspas + 'A' + @aspas + ' and  isnull(vendas.tipo_rateio, 0) <> 2 and isnull(vendas.tipo_rateio, 0) <> 3'
select @xwhere12 = ' and vendas_produto.qtde_entregar > 0 and (clientes_atacado.bloqueio_expedicao = ' + @aspas + @aspas + ' or clientes_atacado.bloqueio_expedicao is null) and vendas.filial = ' + @aspas + @filial + @aspas

create table #reserva (pedido char(12), entrega datetime, item_pedido char(4), qtde_entregar int, preco1 numeric(16, 2), preco2 numeric(16, 2), 
preco3 numeric(16, 2), preco4 numeric(16, 2), desconto_item numeric(16, 2), ponteiro_preco_tam varchar(48), varia_preco_tam bit, 
ve1  int, ve2  int, ve3  int, ve4  int, ve5  int, ve6  int, ve7  int, ve8  int, ve9  int, ve10 int, ve11 int, ve12 int, ve13 int, ve14 int, ve15 int, ve16 int, 
ve17 int, ve18 int, ve19 int, ve20 int, ve21 int, ve22 int, ve23 int, ve24 int, ve25 int, ve26 int, ve27 int, ve28 int, ve29 int, ve30 int, ve31 int, ve32 int, 
ve33 int, ve34 int, ve35 int, ve36 int, ve37 int, ve38 int, ve39 int, ve40 int, ve41 int, ve42 int, ve43 int, ve44 int, ve45 int, ve46 int, ve47 int, ve48 int) 

declare cur_romaneios cursor for select produto, cor_produto, ordem_producao from romaneios_produto 
where romaneio = @romaneio and filial = @filial and status = 'A' order by produto, cor_produto
open cur_romaneios
fetch next from cur_romaneios into @produto, @cor_produto, @ordem_producao
while @@fetch_status = 0
begin
	delete from romaneios_reservas where produto = @produto and cor_produto = @cor_produto and romaneio = @romaneio and filial = @filial 
	select @status = 'S'
	if @qtde_estoque > 0
	begin
		if not exists (select * from estoque_produtos where produto = @produto and cor_produto = @cor_produto and filial = @filial and estoque > @qtde_estoque)
		begin
			select @status = 'T'
			update romaneios_produto set status = @status, filtros_processo = 'vendas_produto.qtde_entregar > vendas_produto.qtde_embalada and vendas.aprovacao = ' + @aspas + 'A' + @aspas + ' and vendas_produto.qtde_entregar > 0 and (clientes_atacado.bloqueio_expedicao = ' + @aspas + @aspas + ' or clientes_atacado.bloqueio_expedicao is null) and vendas.filial = ' + @filial +  @xwhere1 + @xwhere2 + @xwhere3 + @xwhere4 + @xwhere5 + @xwhere6 + @xwhere7 + @xwhere8 + @xwhere9 where romaneio = @romaneio and filial = @filial and produto = @produto and cor_produto = @cor_produto
			fetch next from cur_romaneios into @produto, @cor_produto, @ordem_producao
			continue
		end
	end
	if @ordem_producao <> '' and @ordem_producao is not null
	begin
		if not exists (select * from producao_ordem_cor where ordem_producao = @ordem_producao and produto = @produto and cor_produto = @cor_produto) and
		   not exists (select * from compras_produto where pedido = @ordem_producao and produto = @produto and cor_produto = @cor_produto)
		begin
			select @status = 'O'
			update romaneios_produto set status = @status, filtros_processo = 'vendas_produto.qtde_entregar > vendas_produto.qtde_embalada and vendas.aprovacao = ' + @aspas + 'A' + @aspas + ' and vendas_produto.qtde_entregar > 0 and (clientes_atacado.bloqueio_expedicao = ' + @aspas + @aspas + ' or clientes_atacado.bloqueio_expedicao is null) and vendas.filial = ' + @filial +  @xwhere1 + @xwhere2 + @xwhere3 + @xwhere4 + @xwhere5 + @xwhere6 + @xwhere7 + @xwhere8 + @xwhere9 where romaneio = @romaneio and filial = @filial and produto = @produto and cor_produto = @cor_produto
			fetch next from cur_romaneios into @produto, @cor_produto, @ordem_producao
			continue
		end
	end
	truncate table #reserva
	select @xwhere10 = ' and vendas_produto.produto = ' + @aspas + @produto + @aspas + ' and vendas_produto.cor_produto = ' + @aspas + @cor_produto + @aspas 
	insert into #reserva execute('select vendas_produto.pedido, vendas_produto.entrega, vendas_produto.item_pedido, vendas_produto.qtde_entregar,  preco1, preco2, preco3, preco4, desconto_item, ponteiro_preco_tam, varia_preco_tam, ' +
		'vendas_produto.ve1,  vendas_produto.ve2,  vendas_produto.ve3,  vendas_produto.ve4,  vendas_produto.ve5,  vendas_produto.ve6,  vendas_produto.ve7,  vendas_produto.ve8, ' +
		'vendas_produto.ve9,  vendas_produto.ve10, vendas_produto.ve11, vendas_produto.ve12, vendas_produto.ve13, vendas_produto.ve14, vendas_produto.ve15, vendas_produto.ve16, ' +
		'vendas_produto.ve17, vendas_produto.ve18, vendas_produto.ve19, vendas_produto.ve20, vendas_produto.ve21, vendas_produto.ve22, vendas_produto.ve23, vendas_produto.ve24, ' +
		'vendas_produto.ve25, vendas_produto.ve26, vendas_produto.ve27, vendas_produto.ve28, vendas_produto.ve29, vendas_produto.ve30, vendas_produto.ve31, vendas_produto.ve32, ' +
		'vendas_produto.ve33, vendas_produto.ve34, vendas_produto.ve35, vendas_produto.ve36, vendas_produto.ve37, vendas_produto.ve38, vendas_produto.ve39, vendas_produto.ve40, ' +
		'vendas_produto.ve41, vendas_produto.ve42, vendas_produto.ve43, vendas_produto.ve44, vendas_produto.ve45, vendas_produto.ve46, vendas_produto.ve47, vendas_produto.ve48 ' +
		'from vendas left join clientes_atacado cli on vendas.nome_clifor_entrega = cli.cliente_atacado, clientes_atacado, vendas_produto, produtos where vendas.cliente_atacado = clientes_atacado.cliente_atacado and vendas.pedido = vendas_produto.pedido  and vendas_produto.produto = produtos.produto ' +
		@xwhere10 + @xwhere11 +	@xwhere12 + @xwhere1 + @xwhere2 + @xwhere3 + @xwhere4 + @xwhere5 + @xwhere6 + @xwhere7 + @xwhere8 + @xwhere9)
	declare cur_itens cursor for select * from #reserva
	open cur_itens
	fetch next from cur_itens into @pedido, @entrega, @item_pedido, @qtde_entregar, @preco1, @preco2, @preco3, @preco4, @desconto_item, @ponteiro_preco_tam, @varia_preco_tam, @ve1, @ve2, @ve3, @ve4, @ve5, @ve6, @ve7, @ve8, @ve9, @ve10, @ve11, @ve12, @ve13, @ve14, @ve15, @ve16, @ve17, @ve18, @ve19, @ve20, @ve21, @ve22, @ve23,
				       @ve24, @ve25, @ve26, @ve27, @ve28, @ve29, @ve30, @ve31, @ve32, @ve33, @ve34, @ve35, @ve36, @ve37, @ve38, @ve39, @ve40, @ve41, @ve42, @ve43, @ve44, @ve45, @ve46, @ve47, @ve48
	while @@fetch_status = 0
	begin
		if @item_unico = 1
		begin
			if exists(select * from romaneios_reservas where produto = @produto and cor_pedido = @cor_produto and entrega = @entrega and item_pedido = @item_pedido and pedido = @pedido)
			begin
				select @status = 'E'
				fetch next from cur_itens into @pedido, @entrega, @item_pedido, @qtde_entregar, @preco1, @preco2, @preco3, @preco4, @desconto_item, @ponteiro_preco_tam, @varia_preco_tam, @ve1, @ve2, @ve3, @ve4, @ve5, @ve6, @ve7, @ve8, @ve9, @ve10, @ve11, @ve12, @ve13, @ve14, @ve15, @ve16, @ve17, @ve18, @ve19, @ve20, @ve21, @ve22, @ve23,
							       @ve24, @ve25, @ve26, @ve27, @ve28, @ve29, @ve30, @ve31, @ve32, @ve33, @ve34, @ve35, @ve36, @ve37, @ve38, @ve39, @ve40, @ve41, @ve42, @ve43, @ve44, @ve45, @ve46, @ve47, @ve48
				continue 
			end
		end
		select @qtde = @qtde_entregar
		select 	@ve1  = case when @ve1  - isnull(sum(r1), 0)  < 0 then 0 else @ve1  - isnull(sum(r1), 0)  end, @ve2  = case when @ve2  - isnull(sum(r2), 0)  < 0 then 0 else @ve2  - isnull(sum(r2), 0)  end, @ve3  = case when @ve3  - isnull(sum(r3), 0)  < 0 then 0 else @ve3  - isnull(sum(r3), 0)  end, @ve4  = case when @ve4  - isnull(sum(r4), 0)  < 0 then 0 else @ve4  - isnull(sum(r4), 0)  end,
			@ve5  = case when @ve5  - isnull(sum(r5), 0)  < 0 then 0 else @ve5  - isnull(sum(r5), 0)  end, @ve6  = case when @ve6  - isnull(sum(r6), 0)  < 0 then 0 else @ve6  - isnull(sum(r6), 0)  end, @ve7  = case when @ve7  - isnull(sum(r7), 0)  < 0 then 0 else @ve7  - isnull(sum(r7), 0)  end, @ve8  = case when @ve8  - isnull(sum(r8), 0)  < 0 then 0 else @ve8  - isnull(sum(r8), 0)  end,
			@ve9  = case when @ve9  - isnull(sum(r9), 0)  < 0 then 0 else @ve9  - isnull(sum(r9), 0)  end, @ve10 = case when @ve10 - isnull(sum(r10), 0) < 0 then 0 else @ve10 - isnull(sum(r10), 0) end, @ve11 = case when @ve11 - isnull(sum(r11), 0) < 0 then 0 else @ve11 - isnull(sum(r11), 0) end, @ve12 = case when @ve12 - isnull(sum(r12), 0) < 0 then 0 else @ve12 - isnull(sum(r12), 0) end,
			@ve13 = case when @ve13 - isnull(sum(r13), 0) < 0 then 0 else @ve13 - isnull(sum(r13), 0) end, @ve14 = case when @ve14 - isnull(sum(r14), 0) < 0 then 0 else @ve14 - isnull(sum(r14), 0) end, @ve15 = case when @ve15 - isnull(sum(r15), 0) < 0 then 0 else @ve15 - isnull(sum(r15), 0) end, @ve16 = case when @ve16 - isnull(sum(r16), 0) < 0 then 0 else @ve16 - isnull(sum(r16), 0) end,
			@ve17 = case when @ve17 - isnull(sum(r17), 0) < 0 then 0 else @ve17 - isnull(sum(r17), 0) end, @ve18 = case when @ve18 - isnull(sum(r18), 0) < 0 then 0 else @ve18 - isnull(sum(r18), 0) end, @ve19 = case when @ve19 - isnull(sum(r19), 0) < 0 then 0 else @ve19 - isnull(sum(r19), 0) end, @ve20 = case when @ve20 - isnull(sum(r20), 0) < 0 then 0 else @ve20 - isnull(sum(r20), 0) end,
			@ve21 = case when @ve21 - isnull(sum(r21), 0) < 0 then 0 else @ve21 - isnull(sum(r21), 0) end, @ve22 = case when @ve22 - isnull(sum(r22), 0) < 0 then 0 else @ve22 - isnull(sum(r22), 0) end, @ve23 = case when @ve23 - isnull(sum(r23), 0) < 0 then 0 else @ve23 - isnull(sum(r23), 0) end, @ve24 = case when @ve24 - isnull(sum(r24), 0) < 0 then 0 else @ve24 - isnull(sum(r24), 0) end,
			@ve25 = case when @ve25 - isnull(sum(r25), 0) < 0 then 0 else @ve25 - isnull(sum(r25), 0) end, @ve26 = case when @ve26 - isnull(sum(r26), 0) < 0 then 0 else @ve26 - isnull(sum(r26), 0) end, @ve27 = case when @ve27 - isnull(sum(r27), 0) < 0 then 0 else @ve27 - isnull(sum(r27), 0) end, @ve28 = case when @ve28 - isnull(sum(r28), 0) < 0 then 0 else @ve28 - isnull(sum(r28), 0) end,
			@ve29 = case when @ve29 - isnull(sum(r29), 0) < 0 then 0 else @ve29 - isnull(sum(r29), 0) end, @ve30 = case when @ve30 - isnull(sum(r30), 0) < 0 then 0 else @ve30 - isnull(sum(r30), 0) end, @ve31 = case when @ve31 - isnull(sum(r31), 0) < 0 then 0 else @ve31 - isnull(sum(r31), 0) end, @ve32 = case when @ve32 - isnull(sum(r32), 0) < 0 then 0 else @ve32 - isnull(sum(r32), 0) end,
			@ve33 = case when @ve33 - isnull(sum(r33), 0) < 0 then 0 else @ve33 - isnull(sum(r33), 0) end, @ve34 = case when @ve34 - isnull(sum(r34), 0) < 0 then 0 else @ve34 - isnull(sum(r34), 0) end, @ve35 = case when @ve35 - isnull(sum(r35), 0) < 0 then 0 else @ve35 - isnull(sum(r35), 0) end, @ve36 = case when @ve36 - isnull(sum(r36), 0) < 0 then 0 else @ve36 - isnull(sum(r36), 0) end,
			@ve37 = case when @ve37 - isnull(sum(r37), 0) < 0 then 0 else @ve37 - isnull(sum(r37), 0) end, @ve38 = case when @ve38 - isnull(sum(r38), 0) < 0 then 0 else @ve38 - isnull(sum(r38), 0) end, @ve39 = case when @ve39 - isnull(sum(r39), 0) < 0 then 0 else @ve39 - isnull(sum(r39), 0) end, @ve40 = case when @ve40 - isnull(sum(r40), 0) < 0 then 0 else @ve40 - isnull(sum(r40), 0) end,
			@ve41 = case when @ve41 - isnull(sum(r41), 0) < 0 then 0 else @ve41 - isnull(sum(r41), 0) end, @ve42 = case when @ve42 - isnull(sum(r42), 0) < 0 then 0 else @ve42 - isnull(sum(r42), 0) end, @ve43 = case when @ve43 - isnull(sum(r43), 0) < 0 then 0 else @ve43 - isnull(sum(r43), 0) end, @ve44 = case when @ve44 - isnull(sum(r44), 0) < 0 then 0 else @ve44 - isnull(sum(r44), 0) end,
			@ve45 = case when @ve45 - isnull(sum(r45), 0) < 0 then 0 else @ve45 - isnull(sum(r45), 0) end, @ve46 = case when @ve46 - isnull(sum(r46), 0) < 0 then 0 else @ve46 - isnull(sum(r46), 0) end, @ve47 = case when @ve47 - isnull(sum(r47), 0) < 0 then 0 else @ve47 - isnull(sum(r47), 0) end, @ve48 = case when @ve48 - isnull(sum(r48), 0) < 0 then 0 else @ve48 - isnull(sum(r48), 0) end
			from romaneios_reservas where produto = @produto and cor_pedido = @cor_produto and entrega = @entrega and item_pedido = @item_pedido and pedido = @pedido
				
			select @qtde_entregar = @ve1  + @ve2  + @ve3  + @ve4  + @ve5  + @ve6  + @ve7  + @ve8  + @ve9  + @ve10 + @ve11 + @ve12 + @ve13 + @ve14 + @ve15 + @ve16 + @ve17 + @ve18 + @ve19 + @ve20 + @ve21 + @ve22 + @ve23 + @ve24 +
						@ve25 + @ve26 + @ve27 + @ve28 + @ve29 + @ve30 + @ve31 + @ve32 + @ve33 + @ve34 + @ve35 + @ve36 + @ve37 + @ve38 + @ve39 + @ve40 + @ve41 + @ve42 + @ve43 + @ve44 + @ve45 + @ve46 + @ve47 + @ve48

		if @qtde_entregar = 0
		begin
			fetch next from cur_itens into @pedido, @entrega, @item_pedido, @qtde_entregar, @preco1, @preco2, @preco3, @preco4, @desconto_item, @ponteiro_preco_tam, @varia_preco_tam, @ve1, @ve2, @ve3, @ve4, @ve5, @ve6, @ve7, @ve8, @ve9, @ve10, @ve11, @ve12, @ve13, @ve14, @ve15, @ve16, @ve17, @ve18, @ve19, @ve20, @ve21, @ve22, @ve23,
						       @ve24, @ve25, @ve26, @ve27, @ve28, @ve29, @ve30, @ve31, @ve32, @ve33, @ve34, @ve35, @ve36, @ve37, @ve38, @ve39, @ve40, @ve41, @ve42, @ve43, @ve44, @ve45, @ve46, @ve47, @ve48
			continue 
		end
		if @qtde <> @qtde_entregar
			select @status = 'E'
		select @qtde = @qtde_entregar
		select 	@ve1  = case when @ve1  - isnull(sum(e1), 0)  < 0 then 0 else @ve1  - isnull(sum(e1), 0)  end, @ve2  = case when @ve2  - isnull(sum(e2), 0)  < 0 then 0 else @ve2  - isnull(sum(e2), 0)  end, @ve3  = case when @ve3  - isnull(sum(e3), 0)  < 0 then 0 else @ve3  - isnull(sum(e3), 0)  end, @ve4  = case when @ve4  - isnull(sum(e4), 0)  < 0 then 0 else @ve4  - isnull(sum(e4), 0)  end,
			@ve5  = case when @ve5  - isnull(sum(e5), 0)  < 0 then 0 else @ve5  - isnull(sum(e5), 0)  end, @ve6  = case when @ve6  - isnull(sum(e6), 0)  < 0 then 0 else @ve6  - isnull(sum(e6), 0)  end, @ve7  = case when @ve7  - isnull(sum(e7), 0)  < 0 then 0 else @ve7  - isnull(sum(e7), 0)  end, @ve8  = case when @ve8  - isnull(sum(e8), 0)  < 0 then 0 else @ve8  - isnull(sum(e8), 0)  end,
			@ve9  = case when @ve9  - isnull(sum(e9), 0)  < 0 then 0 else @ve9  - isnull(sum(e9), 0)  end, @ve10 = case when @ve10 - isnull(sum(e10), 0) < 0 then 0 else @ve10 - isnull(sum(e10), 0) end, @ve11 = case when @ve11 - isnull(sum(e11), 0) < 0 then 0 else @ve11 - isnull(sum(e11), 0) end, @ve12 = case when @ve12 - isnull(sum(e12), 0) < 0 then 0 else @ve12 - isnull(sum(e12), 0) end,
			@ve13 = case when @ve13 - isnull(sum(e13), 0) < 0 then 0 else @ve13 - isnull(sum(e13), 0) end, @ve14 = case when @ve14 - isnull(sum(e14), 0) < 0 then 0 else @ve14 - isnull(sum(e14), 0) end, @ve15 = case when @ve15 - isnull(sum(e15), 0) < 0 then 0 else @ve15 - isnull(sum(e15), 0) end, @ve16 = case when @ve16 - isnull(sum(e16), 0) < 0 then 0 else @ve16 - isnull(sum(e16), 0) end,
			@ve17 = case when @ve17 - isnull(sum(e17), 0) < 0 then 0 else @ve17 - isnull(sum(e17), 0) end, @ve18 = case when @ve18 - isnull(sum(e18), 0) < 0 then 0 else @ve18 - isnull(sum(e18), 0) end, @ve19 = case when @ve19 - isnull(sum(e19), 0) < 0 then 0 else @ve19 - isnull(sum(e19), 0) end, @ve20 = case when @ve20 - isnull(sum(e20), 0) < 0 then 0 else @ve20 - isnull(sum(e20), 0) end,
			@ve21 = case when @ve21 - isnull(sum(e21), 0) < 0 then 0 else @ve21 - isnull(sum(e21), 0) end, @ve22 = case when @ve22 - isnull(sum(e22), 0) < 0 then 0 else @ve22 - isnull(sum(e22), 0) end, @ve23 = case when @ve23 - isnull(sum(e23), 0) < 0 then 0 else @ve23 - isnull(sum(e23), 0) end, @ve24 = case when @ve24 - isnull(sum(e24), 0) < 0 then 0 else @ve24 - isnull(sum(e24), 0) end,
			@ve25 = case when @ve25 - isnull(sum(e25), 0) < 0 then 0 else @ve25 - isnull(sum(e25), 0) end, @ve26 = case when @ve26 - isnull(sum(e26), 0) < 0 then 0 else @ve26 - isnull(sum(e26), 0) end, @ve27 = case when @ve27 - isnull(sum(e27), 0) < 0 then 0 else @ve27 - isnull(sum(e27), 0) end, @ve28 = case when @ve28 - isnull(sum(e28), 0) < 0 then 0 else @ve28 - isnull(sum(e28), 0) end,
			@ve29 = case when @ve29 - isnull(sum(e29), 0) < 0 then 0 else @ve29 - isnull(sum(e29), 0) end, @ve30 = case when @ve30 - isnull(sum(e30), 0) < 0 then 0 else @ve30 - isnull(sum(e30), 0) end, @ve31 = case when @ve31 - isnull(sum(e31), 0) < 0 then 0 else @ve31 - isnull(sum(e31), 0) end, @ve32 = case when @ve32 - isnull(sum(e32), 0) < 0 then 0 else @ve32 - isnull(sum(e32), 0) end,
			@ve33 = case when @ve33 - isnull(sum(e33), 0) < 0 then 0 else @ve33 - isnull(sum(e33), 0) end, @ve34 = case when @ve34 - isnull(sum(e34), 0) < 0 then 0 else @ve34 - isnull(sum(e34), 0) end, @ve35 = case when @ve35 - isnull(sum(e35), 0) < 0 then 0 else @ve35 - isnull(sum(e35), 0) end, @ve36 = case when @ve36 - isnull(sum(e36), 0) < 0 then 0 else @ve36 - isnull(sum(e36), 0) end,
			@ve37 = case when @ve37 - isnull(sum(e37), 0) < 0 then 0 else @ve37 - isnull(sum(e37), 0) end, @ve38 = case when @ve38 - isnull(sum(e38), 0) < 0 then 0 else @ve38 - isnull(sum(e38), 0) end, @ve39 = case when @ve39 - isnull(sum(e39), 0) < 0 then 0 else @ve39 - isnull(sum(e39), 0) end, @ve40 = case when @ve40 - isnull(sum(e40), 0) < 0 then 0 else @ve40 - isnull(sum(e40), 0) end,
			@ve41 = case when @ve41 - isnull(sum(e41), 0) < 0 then 0 else @ve41 - isnull(sum(e41), 0) end, @ve42 = case when @ve42 - isnull(sum(e42), 0) < 0 then 0 else @ve42 - isnull(sum(e42), 0) end, @ve43 = case when @ve43 - isnull(sum(e43), 0) < 0 then 0 else @ve43 - isnull(sum(e43), 0) end, @ve44 = case when @ve44 - isnull(sum(e44), 0) < 0 then 0 else @ve44 - isnull(sum(e44), 0) end,
			@ve45 = case when @ve45 - isnull(sum(e45), 0) < 0 then 0 else @ve45 - isnull(sum(e45), 0) end, @ve46 = case when @ve46 - isnull(sum(e46), 0) < 0 then 0 else @ve46 - isnull(sum(e46), 0) end, @ve47 = case when @ve47 - isnull(sum(e47), 0) < 0 then 0 else @ve47 - isnull(sum(e47), 0) end, @ve48 = case when @ve48 - isnull(sum(e48), 0) < 0 then 0 else @ve48 - isnull(sum(e48), 0) end
			from vendas_prod_embalado where pedido = @pedido and pedido_produto = @produto and pedido_cor_produto = @cor_produto and entrega = @entrega and item_pedido = @item_pedido
		select @qtde_entregar = @ve1  + @ve2  + @ve3  + @ve4  + @ve5  + @ve6  + @ve7  + @ve8  + @ve9  + @ve10 + @ve11 + @ve12 + @ve13 + @ve14 + @ve15 + @ve16 + @ve17 + @ve18 + @ve19 + @ve20 + @ve21 + @ve22 + @ve23 + @ve24 +
					@ve25 + @ve26 + @ve27 + @ve28 + @ve29 + @ve30 + @ve31 + @ve32 + @ve33 + @ve34 + @ve35 + @ve36 + @ve37 + @ve38 + @ve39 + @ve40 + @ve41 + @ve42 + @ve43 + @ve44 + @ve45 + @ve46 + @ve47 + @ve48
		if @qtde <> @qtde_entregar
			select @status = 'R'
		if @qtde_entregar > 0
		begin
			if @status <> 'E' and @status <> 'R'
				select @status = 'P'
			if @varia_preco_tam = 1
			begin
				select @conta = 1, @valor_r = 0
				while @conta <= 48
				begin
					select @valor_r = @valor_r + convert(numeric(16, 2), (
					case @conta 
					when 1  then @ve1  when 2  then @ve2  when 3  then @ve3  when 4  then @ve4  when 5  then @ve5  when 6  then @ve6  when 7  then @ve7  when 8  then @ve8  
					when 9  then @ve9  when 10 then @ve10 when 11 then @ve11 when 12 then @ve12 when 13 then @ve13 when 14 then @ve14 when 15 then @ve15 when 16 then @ve16 
					when 17 then @ve17 when 18 then @ve18 when 19 then @ve19 when 20 then @ve20 when 21 then @ve21 when 22 then @ve22 when 23 then @ve23 when 24 then @ve24
					when 25 then @ve25 when 26 then @ve26 when 27 then @ve27 when 28 then @ve28 when 29 then @ve29 when 30 then @ve30 when 31 then @ve31 when 32 then @ve32 
					when 33 then @ve33 when 34 then @ve34 when 35 then @ve35 when 36 then @ve36 when 37 then @ve37 when 38 then @ve38 when 39 then @ve39 when 40 then @ve40 
					when 41 then @ve41 when 42 then @ve42 when 43 then @ve43 when 44 then @ve44 when 45 then @ve45 when 46 then @ve46 when 47 then @ve47 when 48 then @ve48
					end) * 	((case convert(int, substring(@ponteiro_preco_tam, @conta, 1)) 
					when 1 then @preco1 when 2 then @preco2 when 3 then @preco3 when 4 then @preco4 end) - @desconto_item)), @conta = @conta + 1
				end
			end
			else
				select @valor_r = convert(numeric(16, 2), @qtde_entregar * (@preco1 - @desconto_item))

			insert into romaneios_reservas (romaneio, filial, pedido, produto, cor_produto, cor_pedido, entrega, item_pedido, qtde_r, valor_r, ordem_producao,
				    r1,  r2,  r3,  r4,  r5,  r6,  r7,  r8,  r9,  r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24,
				    r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40 ,r41, r42, r43, r44, r45, r46, r47, r48)
				    values (@romaneio, @filial, @pedido, @produto, @cor_produto, @cor_produto, @entrega, @item_pedido, @qtde_entregar, @valor_r, @ordem_producao,
				    @ve1,  @ve2,  @ve3,  @ve4,  @ve5,  @ve6,  @ve7,  @ve8,  @ve9,  @ve10, @ve11, @ve12, @ve13, @ve14, @ve15, @ve16, @ve17, @ve18, @ve19, @ve20, @ve21, @ve22, @ve23, @ve24,
				    @ve25, @ve26, @ve27, @ve28, @ve29, @ve30, @ve31, @ve32, @ve33, @ve34, @ve35, @ve36, @ve37, @ve38, @ve39, @ve40, @ve41, @ve42, @ve43, @ve44, @ve45, @ve46, @ve47, @ve48)
		end
		fetch next from cur_itens into @pedido, @entrega, @item_pedido, @qtde_entregar, @preco1, @preco2, @preco3, @preco4, @desconto_item, @ponteiro_preco_tam, @varia_preco_tam, @ve1, @ve2, @ve3, @ve4, @ve5, @ve6, @ve7, @ve8, @ve9, @ve10, @ve11, @ve12, @ve13, @ve14, @ve15, @ve16, @ve17, @ve18, @ve19, @ve20, @ve21, @ve22, @ve23,
		@ve24, @ve25, @ve26, @ve27, @ve28, @ve29, @ve30, @ve31, @ve32, @ve33, @ve34, @ve35, @ve36, @ve37, @ve38, @ve39, @ve40, @ve41, @ve42, @ve43, @ve44, @ve45, @ve46, @ve47, @ve48

	end
	close cur_itens
	deallocate cur_itens
	update romaneios_produto set status = @status, filtros_processo = 'vendas_produto.qtde_entregar > vendas_produto.qtde_embalada and vendas.aprovacao = ' + @aspas + 'A' + @aspas + ' and vendas_produto.qtde_entregar > 0 and (clientes_atacado.bloqueio_expedicao = ' + @aspas + @aspas + ' or clientes_atacado.bloqueio_expedicao is null) and vendas.filial = ' + @filial +  @xwhere1 + @xwhere2 + @xwhere3 + @xwhere4 + @xwhere5 + @xwhere6 + @xwhere7 + @xwhere8 + @xwhere9 where romaneio = @romaneio and filial = @filial and produto = @produto and cor_produto = @cor_produto
	fetch next from cur_romaneios into @produto, @cor_produto, @ordem_producao
end

drop table #reserva
close cur_romaneios
deallocate cur_romaneios

if @ultimo_fat is not null and @ultimo_fat <> ''
	delete from romaneios_reservas where pedido in (select pedido from vendas, faturamento where cliente_atacado = nome_clifor group by pedido having max(faturamento.emissao) > @ultimo_fat) and romaneio = @romaneio and filial = @filial

if @atraso > 0 
begin
	SELECT @VALOR_ATUAL=VALOR_ATUAL FROM PARAMETROS WHERE PARAMETRO='BLOQUEIO_EXPEDICAO_FILIAL'
	if isnull(@valor_atual,'')='' or isnull(@valor_atual,'')='0'
	begin
		delete romaneios_reservas from romaneios_reservas 
		join vendas on romaneios_reservas.pedido = vendas.pedido 
		join (
		select nome_clifor from a_receber_parcelas where valor_a_receber > 0 group by nome_clifor having datediff(day, min(vencimento), getdate()) > @atraso
		union all
		select nome_clifor from ctb_a_receber_parcela 
		join ctb_a_receber_fatura on ctb_a_receber_parcela.empresa = ctb_a_receber_fatura.empresa and ctb_a_receber_parcela.lancamento = ctb_a_receber_fatura.lancamento and ctb_a_receber_parcela.item = ctb_a_receber_fatura.item
		join cadastro_cli_for on ctb_a_receber_fatura.cod_clifor = cadastro_cli_for.clifor
		where valor_a_receber > 0 group by nome_clifor having datediff(day, min(vencimento_real), getdate()) > @atraso
		) a on vendas.cliente_atacado = a.nome_clifor
		where romaneios_reservas.romaneio = @romaneio and romaneios_reservas.filial = @filial 
	end
	else
	begin
		delete romaneios_reservas from romaneios_reservas 
		join vendas on romaneios_reservas.pedido = vendas.pedido 
		join (
		select a_receber_parcelas.nome_clifor from a_receber_parcelas join a_receber_fatura on a_receber_fatura.fatura=a_receber_parcelas.fatura and a_receber_fatura.nome_clifor=a_receber_parcelas.nome_clifor where a_receber_parcelas.valor_a_receber > 0 and a_receber_fatura.filial=@filial group by a_receber_parcelas.nome_clifor having datediff(day, min(a_receber_parcelas.vencimento), getdate()) > @atraso
		union all
		select nome_clifor from ctb_a_receber_parcela 
		join ctb_a_receber_fatura on ctb_a_receber_parcela.empresa = ctb_a_receber_fatura.empresa and ctb_a_receber_parcela.lancamento = ctb_a_receber_fatura.lancamento and ctb_a_receber_parcela.item = ctb_a_receber_fatura.item
		join cadastro_cli_for on ctb_a_receber_fatura.cod_clifor = cadastro_cli_for.clifor
		join filiais on filiais.cod_filial=ctb_a_receber_fatura.cod_emissor
		where valor_a_receber > 0 and filiais.filial=@filial group by nome_clifor having datediff(day, min(vencimento_real), getdate()) > @atraso
		) a on vendas.cliente_atacado = a.nome_clifor
		where romaneios_reservas.romaneio = @romaneio and romaneios_reservas.filial = @filial 

	end
end
set nocount off

return



/* VISUALLINX ExecuteNonQuery()  */
  exec lx_gera_reserva @romaneio = '34778', @filial = 'DR VAREJO', @regiao_i = '', @regiao_f = '', @pontualidade_i = '', @pontualidade_f = '', @tipo_cliente_i = '', @tipo_cliente_f = '', @prior_cliente_i = 0, @prior_cliente_f = 9, @clifor_i = '', @clifor_f = '', @conceito_i = '', @conceito_f = '', @entrega_i = '20150525', @entrega_f = '20150530', @limite_i = null, @limite_f = null, @emissao_i = '20140101', @emissao_f = '20151231', @tipo_venda = '', @representante_i = '', @representante_f = '', @gerente_i = '', @gerente_f = '', @porc_fat_i = 0.000, @porc_fat_f = 100.0, @colecao = '', @status_venda = '', @prior_venda_i = 0, @prior_venda_f = 8, @ultimo_fat = null, @qtde_estoque = 0, @atraso =     0, @clifor_entregai = '', @clifor_entregaf = '', @id_modificacao = '', @pedido_inicial = '', @pedido_final = ''
  
  
  
/* VISUALLINX ExecuteNonQuery()  */
  exec lx_gera_reserva @romaneio = '34779', @filial = 'DR VAREJO', @regiao_i = '', @regiao_f = '', @pontualidade_i = '', @pontualidade_f = '', @tipo_cliente_i = '', @tipo_cliente_f = '', @prior_cliente_i = 0, @prior_cliente_f = 9, @clifor_i = '', @clifor_f = '', @conceito_i = '', @conceito_f = '', @entrega_i = '20140101', @entrega_f = '20151231', @limite_i = null, @limite_f = null, @emissao_i = '20140101', @emissao_f = '20151231', @tipo_venda = '', @representante_i = '', @representante_f = '', @gerente_i = '', @gerente_f = '', @porc_fat_i = 0.000, @porc_fat_f = 100.0, @colecao = '', @status_venda = '', @prior_venda_i = 0, @prior_venda_f = 8, @ultimo_fat = null, @qtde_estoque = 0, @atraso =     0, @clifor_entregai = '', @clifor_entregaf = '', @id_modificacao = '', @pedido_inicial = '589522', @pedido_final = '589530'
  
  
  
/* VISUALLINX ExecuteNonQuery()  */
  exec lx_gera_reserva @romaneio = '34780', @filial = 'DR VAREJO', @regiao_i = '', @regiao_f = '', @pontualidade_i = '', @pontualidade_f = '', @tipo_cliente_i = '', @tipo_cliente_f = '', @prior_cliente_i = 0, @prior_cliente_f = 9, @clifor_i = '', @clifor_f = '', @conceito_i = '', @conceito_f = '', @entrega_i = '20150525', @entrega_f = '20150530', @limite_i = null, @limite_f = null, @emissao_i = '20140101', @emissao_f = '20151231', @tipo_venda = '', @representante_i = '', @representante_f = '', @gerente_i = '', @gerente_f = '', @porc_fat_i = 0.000, @porc_fat_f = 100.0, @colecao = '', @status_venda = '', @prior_venda_i = 0, @prior_venda_f = 9, @ultimo_fat = null, @qtde_estoque = 0, @atraso =     0, @clifor_entregai = '', @clifor_entregaf = '', @id_modificacao = '', @pedido_inicial = '592943', @pedido_final = '592943'
  
  
/* VISUALLINX ExecuteNonQuery()  */
  exec lx_gera_reserva @romaneio = '347854', @filial = 'DR VAREJO', @regiao_i = '', @regiao_f = '', @pontualidade_i = '', @pontualidade_f = '', @tipo_cliente_i = '', @tipo_cliente_f = '', @prior_cliente_i = 0, @prior_cliente_f = 9, @clifor_i = '', @clifor_f = '', @conceito_i = '', @conceito_f = '', @entrega_i = '20140101', @entrega_f = '20151231', @limite_i = null, @limite_f = null, @emissao_i = '20140101', @emissao_f = '20151231', @tipo_venda = '', @representante_i = '', @representante_f = '', @gerente_i = '', @gerente_f = '', @porc_fat_i = 0.000, @porc_fat_f = 100.0, @colecao = '', @status_venda = '', @prior_venda_i = 0, @prior_venda_f = 9, @ultimo_fat = null, @qtde_estoque = 0, @atraso =     0, @clifor_entregai = '', @clifor_entregaf = '', @id_modificacao = '', @pedido_inicial = '592943', @pedido_final = '592943'
  
  
  
  --- TABELA PROPRIEDADES
  select * from PROP_VENDAS
  WHERE PROPRIEDADE='00003'
  
  
  SELECT PROP_VENDAS.*,VENDAS.* FROM VENDAS
  JOIN (select * from PROP_VENDAS WHERE PROPRIEDADE='00003') AS PROP_VENDAS ON PROP_VENDAS.PEDIDO=VENDAS.PEDIDO
  WHERE PROP_VENDAS.VALOR_PROPRIEDADE='30/04/2015'
  
  
  SELECT DISTINCT PROP_VENDAS.PEDIDO,VENDAS.PEDIDO FROM VENDAS
  JOIN (select * from PROP_VENDAS WHERE PROPRIEDADE='00003') AS PROP_VENDAS ON PROP_VENDAS.PEDIDO=VENDAS.PEDIDO
  WHERE CONVERT(DATE,PROP_VENDAS.VALOR_PROPRIEDADE,103)>='20150520' AND CONVERT(DATE,PROP_VENDAS.VALOR_PROPRIEDADE,103)<='20150530'
  
  
