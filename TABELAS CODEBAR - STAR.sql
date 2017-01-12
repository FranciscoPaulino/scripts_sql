USE [CODEBAR]
GO

/****** Object:  Table [dbo].[tmp_Producao_Ordem_Cor]    Script Date: 12/27/2013 08:08:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tmp_Producao_Ordem_Cor](
	[ORDEM_PRODUCAO] [char](8) NOT NULL,
	[PRODUTO] [char](12) NOT NULL,
	[COR_PRODUTO] [char](10) NOT NULL,
	[ALTERACAO_DE_PROGRAMACAO] [int] NULL,
	[PERDAS_NO_PROCESSO] [int] NULL,
	[QTDE_O] [int] NULL,
	[QTDE_P] [int] NULL,
	[O1] [int] NULL,
	[O2] [int] NULL,
	[O3] [int] NULL,
	[O4] [int] NULL,
	[O5] [int] NULL,
	[O6] [int] NULL,
	[O7] [int] NULL,
	[O8] [int] NULL,
	[O9] [int] NULL,
	[O10] [int] NULL,
	[O11] [int] NULL,
	[O12] [int] NULL,
	[O13] [int] NULL,
	[O14] [int] NULL,
	[O15] [int] NULL,
	[O16] [int] NULL,
	[O17] [int] NULL,
	[O18] [int] NULL,
	[O19] [int] NULL,
	[O20] [int] NULL,
	[O21] [int] NULL,
	[O22] [int] NULL,
	[O23] [int] NULL,
	[O24] [int] NULL,
	[O25] [int] NULL,
	[O26] [int] NULL,
	[O27] [int] NULL,
	[O28] [int] NULL,
	[O29] [int] NULL,
	[O30] [int] NULL,
	[O31] [int] NULL,
	[O32] [int] NULL,
	[O33] [int] NULL,
	[O34] [int] NULL,
	[O35] [int] NULL,
	[O36] [int] NULL,
	[O37] [int] NULL,
	[O38] [int] NULL,
	[O39] [int] NULL,
	[O40] [int] NULL,
	[O41] [int] NULL,
	[O42] [int] NULL,
	[O43] [int] NULL,
	[O44] [int] NULL,
	[O45] [int] NULL,
	[O46] [int] NULL,
	[O47] [int] NULL,
	[O48] [int] NULL,
	[P1] [int] NULL,
	[P2] [int] NULL,
	[P3] [int] NULL,
	[P4] [int] NULL,
	[P5] [int] NULL,
	[P6] [int] NULL,
	[P7] [int] NULL,
	[P8] [int] NULL,
	[P9] [int] NULL,
	[P10] [int] NULL,
	[P11] [int] NULL,
	[P12] [int] NULL,
	[P13] [int] NULL,
	[P14] [int] NULL,
	[P15] [int] NULL,
	[P16] [int] NULL,
	[P17] [int] NULL,
	[P18] [int] NULL,
	[P19] [int] NULL,
	[P20] [int] NULL,
	[P21] [int] NULL,
	[P22] [int] NULL,
	[P23] [int] NULL,
	[P24] [int] NULL,
	[P25] [int] NULL,
	[P26] [int] NULL,
	[P27] [int] NULL,
	[P28] [int] NULL,
	[P29] [int] NULL,
	[P30] [int] NULL,
	[P31] [int] NULL,
	[P32] [int] NULL,
	[P33] [int] NULL,
	[P34] [int] NULL,
	[P35] [int] NULL,
	[P36] [int] NULL,
	[P37] [int] NULL,
	[P38] [int] NULL,
	[P39] [int] NULL,
	[P40] [int] NULL,
	[P41] [int] NULL,
	[P42] [int] NULL,
	[P43] [int] NULL,
	[P44] [int] NULL,
	[P45] [int] NULL,
	[P46] [int] NULL,
	[P47] [int] NULL,
	[P48] [int] NULL,
	[TIMESTAMP] [timestamp] NULL,
	[ID_MODIFICACAO] [char](6) NULL,
 CONSTRAINT [PK_tmp_Producao_Ordem_Cor] PRIMARY KEY CLUSTERED 
(
	[ORDEM_PRODUCAO] ASC,
	[PRODUTO] ASC,
	[COR_PRODUTO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO






USE [CODEBAR]
GO

/****** Object:  Table [dbo].[Prop_Produtos]    Script Date: 12/27/2013 08:08:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Prop_Produtos](
	[PROPRIEDADE] [char](5) NOT NULL,
	[VALOR_PROPRIEDADE] [varchar](70) NULL,
	[DATA_PARA_TRANSFERENCIA] [datetime] NULL,
	[PRODUTO] [char](12) NOT NULL,
	[ITEM_PROPRIEDADE] [smallint] NOT NULL,
 CONSTRAINT [PK_Prop_Produtos] PRIMARY KEY CLUSTERED 
(
	[PROPRIEDADE] ASC,
	[PRODUTO] ASC,
	[ITEM_PROPRIEDADE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



USE [CODEBAR]
GO

/****** Object:  Table [dbo].[Produtos_Barra]    Script Date: 12/27/2013 08:08:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Produtos_Barra](
	[CODIGO_BARRA] [varchar](25) NOT NULL,
	[PRODUTO] [char](12) NOT NULL,
	[COR_PRODUTO] [char](10) NOT NULL,
	[TAMANHO] [int] NULL,
	[GRADE] [varchar](8) NOT NULL,
	[DATA_PARA_TRANSFERENCIA] [datetime] NULL,
	[NOME_CLIFOR] [varchar](25) NULL,
	[CODIGO_BARRA_PADRAO] [bit] NOT NULL,
	[INATIVO] [bit] NOT NULL,
	[TIPO_COD_BAR] [tinyint] NULL,
	[BARVL_VOL_L1] [float] NULL,
	[BARVL_VOL_L2] [float] NULL,
	[BARVL_VOL_L3] [float] NULL,
	[BARVL_PESO] [float] NULL,
	[BARQT_CUBAGEM] [float] NULL,
	[BARNR_COR] [int] NULL,
	[ISN_PRODUTO] [int] NULL,
	[BARSIS_BARRA] [nvarchar](50) NULL,
	[BARQT_MULTIPLICADOR] [int] NULL,
 CONSTRAINT [PK_Produtos_Barra] PRIMARY KEY CLUSTERED 
(
	[CODIGO_BARRA] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO




USE [CODEBAR]
GO

/****** Object:  Table [dbo].[Produtos]    Script Date: 12/27/2013 08:08:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Produtos](
	[PRODUTO] [char](12) NOT NULL,
	[CODIGO_PRECO] [char](4) NULL,
	[MATERIAL] [char](11) NULL,
	[PERIODO_PCP] [varchar](25) NULL,
	[TABELA_OPERACOES] [varchar](25) NULL,
	[FATOR_OPERACOES] [decimal](7, 3) NULL,
	[CLASSIF_FISCAL] [char](10) NOT NULL,
	[TIPO_PRODUTO] [varchar](25) NOT NULL,
	[TABELA_MEDIDAS] [varchar](25) NULL,
	[DESC_PRODUTO] [varchar](40) NOT NULL,
	[GRUPO_PRODUTO] [varchar](25) NOT NULL,
	[SUBGRUPO_PRODUTO] [varchar](25) NOT NULL,
	[COLECAO] [char](6) NOT NULL,
	[GRADE] [varchar](25) NOT NULL,
	[DESC_PROD_NF] [varchar](40) NOT NULL,
	[LINHA] [varchar](25) NOT NULL,
	[GRIFFE] [varchar](25) NOT NULL,
	[CARTELA] [char](6) NULL,
	[UNIDADE] [char](5) NOT NULL,
	[PESO] [decimal](14, 8) NULL,
	[REVENDA] [bit] NOT NULL,
	[REFER_FABRICANTE] [varchar](25) NULL,
	[MODELAGEM] [char](10) NULL,
	[SORTIMENTO_COR] [bit] NOT NULL,
	[FABRICANTE] [varchar](25) NOT NULL,
	[SORTIMENTO_TAMANHO] [bit] NOT NULL,
	[VARIA_PRECO_COR] [bit] NOT NULL,
	[VARIA_PRECO_TAM] [bit] NOT NULL,
	[PONTEIRO_PRECO_TAM] [char](48) NOT NULL,
	[VARIA_CUSTO_COR] [bit] NOT NULL,
	[PERTENCE_A_CONJUNTO] [bit] NOT NULL,
	[TRIBUT_ICMS] [char](3) NOT NULL,
	[TRIBUT_ORIGEM] [char](3) NOT NULL,
	[VARIA_CUSTO_TAM] [bit] NOT NULL,
	[CUSTO_REPOSICAO1] [decimal](14, 2) NULL,
	[CUSTO_REPOSICAO2] [decimal](14, 2) NULL,
	[CUSTO_REPOSICAO3] [decimal](14, 2) NULL,
	[CUSTO_REPOSICAO4] [decimal](14, 2) NULL,
	[DATA_REPOSICAO] [datetime] NULL,
	[ESTILISTA] [varchar](25) NULL,
	[MODELISTA] [varchar](25) NULL,
	[TAMANHO_BASE] [int] NULL,
	[GIRO_ENTREGA] [int] NULL,
	[INATIVO] [bit] NOT NULL,
	[ENVIA_LOJA_VAREJO] [bit] NOT NULL,
	[ENVIA_LOJA_ATACADO] [bit] NOT NULL,
	[ENVIA_REPRESENTANTE] [bit] NOT NULL,
	[ENVIA_VAREJO_INTERNET] [bit] NOT NULL,
	[ENVIA_ATACADO_INTERNET] [bit] NOT NULL,
	[MODELO] [char](8) NULL,
	[REDE_LOJAS] [char](6) NULL,
	[DATA_PARA_TRANSFERENCIA] [datetime] NULL,
	[FABRICANTE_ICMS_ABATER] [decimal](8, 5) NULL,
	[FABRICANTE_PRAZO_PGTO] [int] NULL,
	[TAXA_JUROS_DEFLACIONAR] [decimal](8, 5) NULL,
	[TAXAS_IMPOSTOS_APLICAR] [decimal](8, 5) NULL,
	[PRECO_REPOSICAO_1] [decimal](14, 2) NULL,
	[PRECO_REPOSICAO_2] [decimal](14, 2) NULL,
	[PRECO_REPOSICAO_3] [decimal](14, 2) NULL,
	[PRECO_REPOSICAO_4] [decimal](14, 2) NULL,
	[PRECO_A_VISTA_REPOSICAO_1] [decimal](14, 2) NULL,
	[PRECO_A_VISTA_REPOSICAO_2] [decimal](14, 2) NULL,
	[PRECO_A_VISTA_REPOSICAO_3] [decimal](14, 2) NULL,
	[PRECO_A_VISTA_REPOSICAO_4] [decimal](14, 2) NULL,
	[FABRICANTE_FRETE] [decimal](8, 5) NULL,
	[DROP_DE_TAMANHOS] [smallint] NULL,
	[DATA_CADASTRAMENTO] [datetime] NULL,
	[STATUS_PRODUTO] [char](2) NULL,
	[TIPO_STATUS_PRODUTO] [int] NULL,
	[OBS] [text] NULL,
	[COMPOSICAO] [char](6) NULL,
	[RESTRICAO_LAVAGEM] [char](6) NULL,
	[EMPRESA] [int] NOT NULL,
	[ORCAMENTO] [varchar](25) NULL,
	[CLIENTE_DO_PRODUTO] [varchar](25) NULL,
	[CONTA_CONTABIL] [varchar](20) NULL,
	[ESPESSURA] [decimal](14, 2) NULL,
	[ALTURA] [decimal](14, 2) NULL,
	[LARGURA] [decimal](10, 5) NULL,
	[COMPRIMENTO] [decimal](14, 2) NULL,
	[EMPILHAMENTO_MAXIMO] [smallint] NULL,
	[SEXO_TIPO] [smallint] NULL,
	[PARTE_TIPO] [smallint] NULL,
	[OP_QTDE_MINIMA] [int] NULL,
	[OP_QTDE_MAXIMA] [int] NULL,
	[OP_POR_COR] [bit] NOT NULL,
	[INDICADOR_CFOP] [tinyint] NULL,
	[ID_EXCECAO_IMPOSTO] [int] NULL,
	[QUALIDADE] [tinyint] NULL,
	[MONTAGEM_KIT] [tinyint] NULL,
	[VERSAO_FICHA] [char](5) NULL,
	[SEMI_ACABADO] [int] NULL,
	[MRP_AGRUPAR_NECESSIDADE_TIPO] [int] NULL,
	[MRP_AGRUPAR_NECESSIDADE_DIAS] [int] NULL,
	[MRP_MAIOR_GIRO_MP_DIAS] [int] NULL,
	[MRP_EMISSAO_LIBERACAO_DIAS] [int] NULL,
	[MRP_ENTREGA_GIRO_DIAS] [int] NULL,
	[MRP_DIAS_SEGURANCA] [int] NULL,
	[COD_FLUXO_PRODUTO] [char](5) NULL,
	[DATA_INICIO_DESENVOLVIMENTO] [datetime] NULL,
	[MRP_PARTICIPANTE] [int] NULL,
	[CONTA_CONTABIL_COMPRA] [varchar](20) NULL,
	[CONTA_CONTABIL_VENDA] [varchar](20) NULL,
	[CONTA_CONTABIL_DEV_COMPRA] [varchar](20) NULL,
	[CONTA_CONTABIL_DEV_VENDA] [varchar](20) NULL,
	[ID_EXCECAO_GRUPO] [int] NULL,
	[DIAS_COMPRA] [varchar](50) NULL,
	[FATOR_P] [tinyint] NULL,
	[FATOR_Q] [tinyint] NULL,
	[FATOR_F] [tinyint] NULL,
	[CONTINUIDADE] [tinyint] NULL,
	[COD_CATEGORIA] [char](2) NULL,
	[COD_SUBCATEGORIA] [char](2) NULL,
	[COD_PRODUTO_SOLUCAO] [int] NULL,
	[COD_PRODUTO_SEGMENTO] [int] NULL,
	[ID_PRECO] [int] NULL,
	[TIPO_ITEM_SPED] [char](5) NULL,
	[PERC_COMISSAO] [decimal](8, 5) NOT NULL,
	[ACEITA_ENCOMENDA] [tinyint] NOT NULL,
	[DIAS_GARANTIA_LOJA] [smallint] NOT NULL,
	[DIAS_GARANTIA_FABRICANTE] [smallint] NOT NULL,
	[POSSUI_MONTAGEM] [bit] NOT NULL,
	[POSSUI_GTIN] [bit] NOT NULL,
	[PERMITE_ENTREGA_FUTURA] [bit] NOT NULL,
	[NATUREZA_RECEITA] [char](3) NULL,
	[COD_ALIQUOTA_PIS_COFINS_DIF] [varchar](9) NULL,
 CONSTRAINT [PK_Produtos] PRIMARY KEY CLUSTERED 
(
	[PRODUTO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO




USE [CODEBAR]
GO

/****** Object:  Table [dbo].[Produto_Cores]    Script Date: 12/27/2013 08:08:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Produto_Cores](
	[PRODUTO] [char](12) NOT NULL,
	[COR_PRODUTO] [char](10) NOT NULL,
	[SIMILAR] [int] NULL,
	[DESC_COR_PRODUTO] [varchar](40) NOT NULL,
	[SORTIMENTO_COR] [decimal](8, 5) NULL,
	[COR_SORTIDA] [bit] NOT NULL,
	[STATUS_VENDA_ATUAL] [char](1) NULL,
	[INICIO_VENDAS] [datetime] NULL,
	[FIM_VENDAS] [datetime] NULL,
	[COR_FABRICANTE] [char](8) NULL,
	[TIPO_LAVAGEM_TINTURARIA] [varchar](25) NULL,
	[TINTURARIA_LAVAGEM] [bit] NOT NULL,
	[COR] [char](10) NULL,
	[MATERIAL] [char](11) NULL,
	[COR_MATERIAL] [char](10) NULL,
	[ETIQUETA] [char](4) NULL,
	[CUSTO_REPOSICAO1] [decimal](14, 2) NULL,
	[CUSTO_REPOSICAO2] [decimal](14, 2) NULL,
	[CUSTO_REPOSICAO3] [decimal](14, 2) NULL,
	[CUSTO_REPOSICAO4] [decimal](14, 2) NULL,
	[TIMESTAMP] [timestamp] NULL,
	[VARIANTE_TAMANHO] [char](2) NULL,
	[DATA_PARA_TRANSFERENCIA] [datetime] NULL,
	[PRECO_REPOSICAO_1] [decimal](14, 2) NULL,
	[PRECO_REPOSICAO_2] [decimal](14, 2) NULL,
	[PRECO_REPOSICAO_3] [decimal](14, 2) NULL,
	[PRECO_REPOSICAO_4] [decimal](14, 2) NULL,
	[PRECO_A_VISTA_REPOSICAO_1] [decimal](14, 2) NULL,
	[PRECO_A_VISTA_REPOSICAO_2] [decimal](14, 2) NULL,
	[PRECO_A_VISTA_REPOSICAO_3] [decimal](14, 2) NULL,
	[PRECO_A_VISTA_REPOSICAO_4] [decimal](14, 2) NULL,
	[COMPOSICAO] [char](6) NULL,
	[CLASSIF_FISCAL] [char](10) NULL,
	[TRIBUT_ORIGEM] [char](3) NULL,
	[LX_STATUS_REGISTRO] [int] NOT NULL,
 CONSTRAINT [PK_Produto_Cores] PRIMARY KEY CLUSTERED 
(
	[PRODUTO] ASC,
	[COR_PRODUTO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


USE [CODEBAR]
GO

/****** Object:  Table [dbo].[PRODUCAO_ORDEM_COR]    Script Date: 12/27/2013 08:07:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[PRODUCAO_ORDEM_COR](
	[ORDEM_PRODUCAO] [char](8) NOT NULL,
	[PRODUTO] [char](12) NOT NULL,
	[COR_PRODUTO] [char](10) NOT NULL,
	[ALTERACAO_DE_PROGRAMACAO] [int] NULL,
	[PERDAS_NO_PROCESSO] [int] NULL,
	[QTDE_O] [int] NULL,
	[QTDE_P] [int] NULL,
	[O1] [int] NULL,
	[O2] [int] NULL,
	[O3] [int] NULL,
	[O4] [int] NULL,
	[O5] [int] NULL,
	[O6] [int] NULL,
	[O7] [int] NULL,
	[O8] [int] NULL,
	[O9] [int] NULL,
	[O10] [int] NULL,
	[O11] [int] NULL,
	[O12] [int] NULL,
	[O13] [int] NULL,
	[O14] [int] NULL,
	[O15] [int] NULL,
	[O16] [int] NULL,
	[O17] [int] NULL,
	[O18] [int] NULL,
	[O19] [int] NULL,
	[O20] [int] NULL,
	[O21] [int] NULL,
	[O22] [int] NULL,
	[O23] [int] NULL,
	[O24] [int] NULL,
	[O25] [int] NULL,
	[O26] [int] NULL,
	[O27] [int] NULL,
	[O28] [int] NULL,
	[O29] [int] NULL,
	[O30] [int] NULL,
	[O31] [int] NULL,
	[O32] [int] NULL,
	[O33] [int] NULL,
	[O34] [int] NULL,
	[O35] [int] NULL,
	[O36] [int] NULL,
	[O37] [int] NULL,
	[O38] [int] NULL,
	[O39] [int] NULL,
	[O40] [int] NULL,
	[O41] [int] NULL,
	[O42] [int] NULL,
	[O43] [int] NULL,
	[O44] [int] NULL,
	[O45] [int] NULL,
	[O46] [int] NULL,
	[O47] [int] NULL,
	[O48] [int] NULL,
	[P1] [int] NULL,
	[P2] [int] NULL,
	[P3] [int] NULL,
	[P4] [int] NULL,
	[P5] [int] NULL,
	[P6] [int] NULL,
	[P7] [int] NULL,
	[P8] [int] NULL,
	[P9] [int] NULL,
	[P10] [int] NULL,
	[P11] [int] NULL,
	[P12] [int] NULL,
	[P13] [int] NULL,
	[P14] [int] NULL,
	[P15] [int] NULL,
	[P16] [int] NULL,
	[P17] [int] NULL,
	[P18] [int] NULL,
	[P19] [int] NULL,
	[P20] [int] NULL,
	[P21] [int] NULL,
	[P22] [int] NULL,
	[P23] [int] NULL,
	[P24] [int] NULL,
	[P25] [int] NULL,
	[P26] [int] NULL,
	[P27] [int] NULL,
	[P28] [int] NULL,
	[P29] [int] NULL,
	[P30] [int] NULL,
	[P31] [int] NULL,
	[P32] [int] NULL,
	[P33] [int] NULL,
	[P34] [int] NULL,
	[P35] [int] NULL,
	[P36] [int] NULL,
	[P37] [int] NULL,
	[P38] [int] NULL,
	[P39] [int] NULL,
	[P40] [int] NULL,
	[P41] [int] NULL,
	[P42] [int] NULL,
	[P43] [int] NULL,
	[P44] [int] NULL,
	[P45] [int] NULL,
	[P46] [int] NULL,
	[P47] [int] NULL,
	[P48] [int] NULL,
	[TIMESTAMP] [timestamp] NULL,
	[ID_MODIFICACAO] [char](6) NULL,
 CONSTRAINT [PK_PRODUCAO_ORDEM_COR] PRIMARY KEY CLUSTERED 
(
	[ORDEM_PRODUCAO] ASC,
	[PRODUTO] ASC,
	[COR_PRODUTO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO




