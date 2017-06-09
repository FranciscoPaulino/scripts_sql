--- calendario
USE [DRLINGERIE]
GO

/****** Object:  Table [dbo].[SAW_CALENDARIO_PGTO]    Script Date: 22/03/2017 12:52:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SAW_CALENDARIO_PGTO](
	[VENCIMENTO] [datetime] NOT NULL,
	[E_DIA_SEMANA] [bit] NULL,
	[ANO] [char](4) NULL,
	[QUADRIMESTRE] [int] NULL,
	[MES] [int] NULL,
	[DIA] [int] NULL,
	[DIA_SEMANA] [int] NULL,
	[NOME_MES] [varchar](20) NULL,
	[NOME_DIA] [varchar](20) NULL,
	[NUMERO_SEMANA] [int] NULL,
	[PERIODO_FOLHA_PGTO] [bit] NULL,
 CONSTRAINT [PK_SAW_CALENDARIO_PGTO] PRIMARY KEY CLUSTERED 
(
	[VENCIMENTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


--- limite_pgto_diario
USE [DRLINGERIE]
GO

/****** Object:  Table [dbo].[SAW_LIMITE_PGTO_DIARIO]    Script Date: 22/03/2017 12:51:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SAW_LIMITE_PGTO_DIARIO](
	[VENCIMENTO] [datetime] NOT NULL,
	[VALOR_LIBERADO] [numeric](18, 2) NULL,
	[TOTAL_A_PAGAR] [numeric](18, 2) NULL,
	[VALOR_DISPONIVEL]  AS ([VALOR_LIBERADO]-[TOTAL_A_PAGAR]),
 CONSTRAINT [PK_SAW_LIMITE_PGTO_DIARIO] PRIMARY KEY CLUSTERED 
(
	[VENCIMENTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO




declare @start datetime,
@end datetime
set @start = '2007-01-01'
set @end = '2051-01-01'
;with calendar(vencimento,e_dia_semana, ano, quadrimestre,mes,dia,dia_semana,nome_mes,nome_dia,numero_semana,periodo_folha_pgto) as
(
select @start ,
case when datepart(dw,@start) in (1,7) then 0 else 1 end,
year(@start),
datepart(qq,@start),
datepart(mm,@start),
datepart(dd,@start),
datepart(dw,@start),
datename(month, @start),
datename(dw, @start),
datepart(wk, @start),
0
union all
select vencimento + 1,
case when datepart(dw,vencimento + 1) in (1,7) then 0 else 1 end,
year(vencimento + 1),
datepart(qq,vencimento + 1),
datepart(mm,vencimento + 1),
datepart(dd,vencimento + 1),
datepart(dw,vencimento + 1),
datename(month, vencimento + 1),
datename(dw, vencimento + 1),
datepart(wk, vencimento + 1),
0
from calendar where vencimento + 1< @end
)
insert into SAW_CALENDARIO_PGTO (vencimento,e_dia_semana, ano, quadrimestre,mes,dia,dia_semana,nome_mes,nome_dia,numero_semana,periodo_folha_pgto)
select vencimento,e_dia_semana, ano, quadrimestre,mes,dia,dia_semana,nome_mes,nome_dia,numero_semana, periodo_folha_pgto 
from calendar option(maxrecursion 30000)


select * from saw_calendario_pgto
select * from saw_limite_pgto_diario

SELECT W_CTB_A_PAGAR_PARCELA.VENCIMENTO,
sum(W_CTB_A_PAGAR_PARCELA.VALOR_ORIGINAL) as VALOR_ORIGINAL,             
sum(W_CTB_A_PAGAR_PARCELA.VALOR_ORIGINAL_PADRAO) as VALOR_ORIGINAL_PADRAO, 
sum(W_CTB_A_PAGAR_PARCELA.VALOR_A_PAGAR) as VALOR_A_PAGAR,             
sum(W_CTB_A_PAGAR_PARCELA.VALOR_A_PAGAR_PADRAO) as VALOR_A_PAGAR_PADRAO, 
sum(W_CTB_A_PAGAR_PARCELA.SALDO_PRINCIPAL_DEVIDO) as SALDO_PRINCIPAL_DEVIDO
FROM   {OJ{OJ  W_CTB_A_PAGAR_PARCELA W_CTB_A_PAGAR_PARCELA      
LEFT OUTER JOIN DBO.BANCOS BANCOS                ON  W_CTB_A_PAGAR_PARCELA.BANCO = BANCOS.BANCO}      
LEFT OUTER JOIN DBO.CTB_ESPECIE_SERIE CTB_ESPECIE_SERIE                ON  W_CTB_A_PAGAR_PARCELA.ESPECIE_SERIE = CTB_ESPECIE_SERIE.ESPECIE_SERIE} 
WHERE w_ctb_a_pagar_parcela.VALOR_A_pagar > 0
group by W_CTB_A_PAGAR_PARCELA.VENCIMENTO
order by W_CTB_A_PAGAR_PARCELA.VENCIMENTO