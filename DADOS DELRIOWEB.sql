---- Exporta em TXT com delimitador
---- Gerar todos os arquivos com separador ","
---- Representantes e seus clientes (cliente_repre.csv)
INSERT OPENROWSET('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\AtualizacaoWEB',cliente_repre#txt)
select representante=UPPER(representante),cliente_atacado=UPPER(cliente_atacado),data_para_transferencia,comissao,representante_principal from cliente_repre with (nolock)
where representante_principal=1
GO

---- Representantes e Gerentes (representantes_gerente.csv)
INSERT OPENROWSET('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\AtualizacaoWEB',representantes_gerente#txt)
select REPRESENTANTE,GERENTE,REGIAO,TIPO,COMISSAO,PORCENTAGEM_ACERTO,ACERTO_PGTO,INATIVO,MARGEM_NEGOCIACAO,DESCONTO_COMISSAO,CGC_CPF,CLIFOR,SEQUENCIAL,COMISSAO_GERENTE,IRRF,COD_REPRESENTANTE,DATA_PARA_TRANSFERENCIA,CONTA_CONTABIL,CTB_CONTA_CONTABIL from representantes with (nolock) where representantes.inativo=0 and GERENTE is not null
GO 

---- Condições de pagamentos (pagamento.csv)
INSERT OPENROWSET('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\AtualizacaoWEB',pagamento#txt)
select CONDICAO_PGTO,DESC_COND_PGTO,TIPO_CONDICAO,NUMERO_PARCELAS,DESCONTO,ENCARGO,DESCONTO_ITEM,DESCONTO_FATURAMENTO,ENCARGO_FATURAMENTO,DESCONTO_ITEM_FATURAMENTO,DIAS_DESCONTO_VENCIMENTO,DESCONTO_VENCIMENTO,EXCLUSIVO_LINX,CONDICAO_ESPECIAL,VALOR_MINIMO_PARCELAMENTO,VALOR_MAXIMO_PARCELAMENTO,NOVO_PARCELAMENTO_MINIMO,NOVO_PARCELAMENTO_MAXIMO,INCIDE_SOBRE_PRECO,PORC_ANTECIPACAO,INDICA_PARCELAS_IGUAIS,PARCELA_ARRED_MENOR,PARCELA_ARRED_MAIOR,DATA_PARA_TRANSFERENCIA,COND_PGTO_ENTRADA,LX_TIPO_DOCUMENTO from FORMA_PGTO with (nolock)
WHERE LEN(CONDICAO_PGTO)<=2 AND CONDICAO_PGTO<>'##' AND CONDICAO_ESPECIAL=0    
and CONDICAO_PGTO not like '0%' 
and CONDICAO_PGTO not like '1%' 
and CONDICAO_PGTO not like '2%' 
and CONDICAO_PGTO not like '3%' 
and CONDICAO_PGTO not like '4%' 
and CONDICAO_PGTO not like '5%' 
and CONDICAO_PGTO not like '6%' 
and CONDICAO_PGTO not like '7%' 
and CONDICAO_PGTO not like '8%' 
and CONDICAO_PGTO not like '9%'

GO


---- Periodo de faturamento (perfat.csv)
----INSERT OPENROWSET('Microsoft.Jet.OLEDB.4.0','Text;Database=C:\AtualizacaoWEB',perfat#txt)
----select NUMERO_ENTREGA,PERIODO_PCP,convert(char(10),ENTREGA,120) AS ENTREGA,CONVERT(CHAR(10),LIMITE,120) AS LIMITE,CONVERT(CHAR(10),Data_para_transferencia,120) AS DATA_PARA_TRANSFERENCIA from PRODUTOS_PERIODOS_ENTREGAS
-----WHERE LIMITE >= getdate()+64 and limite < '20101213'  or limite > '20110101' and limite < '20110301'
-----ORDER BY ENTREGA
-----GO

INSERT OPENROWSET('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\AtualizacaoWEB',perfat#txt)
select A.NUMERO_ENTREGA,A.PERIODO_PCP,convert(char(10),ENTREGA,120) AS ENTREGA,CONVERT(CHAR(10),LIMITE,120) AS LIMITE,CONVERT(CHAR(10),Data_para_transferencia,120) AS DATA_PARA_TRANSFERENCIA from PRODUTOS_PERIODOS_ENTREGAS A with (nolock)
JOIN COTA_LIMITE_PERFAT B with (nolock) ON B.NUMERO_ENTREGA=A.NUMERO_ENTREGA AND B.PERIODO_PCP=A.PERIODO_PCP
WHERE B.FECHADO=0
ORDER BY ENTREGA
GO


---- Produtos e precos (produtos.csv) so em linha
INSERT OPENROWSET('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\AtualizacaoWEB',produtos#txt)
select produtos_barra.CODIGO_BARRA,produtos_barra.PRODUTO,produtos_barra.COR_PRODUTO,produtos_barra.TAMANHO,
produtos_barra.GRADE,produtos_barra.DATA_PARA_TRANSFERENCIA,produtos_barra.NOME_CLIFOR,
produtos_barra.CODIGO_BARRA_PADRAO,produtos_barra.INATIVO
from produtos_barra with (nolock), produtos_precos with (nolock), produto_cores with (nolock),produtos with (nolock)
where produtos_barra.produto=produtos_precos.produto 
and produtos_precos.codigo_tab_preco='VA' 
and produto_cores.produto = produtos_barra.produto
and produto_cores.cor_produto = produtos_barra.cor_produto
and produtos_barra.codigo_barra_padrao=1
and produto_cores.desc_cor_produto not like '%-FL'
and produtos.produto=produto_cores.produto
and produtos.cod_categoria <> 'FORA DE LINHA' 
and produtos.cod_subcategoria <> 'FORA DE LINHA' 
and produtos.inativo = 0
and produtos.PRODUTO like 'V%'
and getdate() between produto_cores.inicio_vendas and produto_cores.fim_vendas
GO


---- Clientes (clientes.csv)
INSERT OPENROWSET('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\AtualizacaoWEB',clientes#txt)
select nome_clifor=UPPER(nome_clifor) , regiao,a.inativo,passweb,a.clifor,cod_cliente,ind_representante,a.cgc_cpf,filial,transportadora,expedicao_porcentagem_minima,razao_social,b.codigo_tab_preco,b.condicao_pgto,b.indicador_venda,a.email
from cadastro_cli_for a with (nolock) ,clientes_atacado b with (nolock)
where a.clifor=b.clifor and a.inativo=0 and b.inativo=0  and b.FILIAL='DR VAREJO' AND B.TIPO <> 'BALCONISTA'
GO


---- Produtos Precos (Produtos_precos.csv)
INSERT OPENROWSET('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\AtualizacaoWEB',Produtos_Precos#txt)
select codigo_tab_preco, produto, preco1 from produtos_precos with (nolock)
where codigo_tab_preco in ('VA','VS')  and PRODUTO like 'V%'
GO
