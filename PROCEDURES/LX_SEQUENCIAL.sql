USE [DRVAREJO] 
GO

/****** Object:  StoredProcedure [dbo].[LX_SEQUENCIAL]    Script Date: 11/19/2015 13:17:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LX_SEQUENCIAL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[LX_SEQUENCIAL]
GO

--USE [CONSULTA]
GO

/****** Object:  StoredProcedure [dbo].[LX_SEQUENCIAL]    Script Date: 11/19/2015 13:17:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[LX_SEQUENCIAL] @TABELA_COLUNA     VARCHAR(37), 
                                       @EMPRESA           INT = NULL, 
                                       @SEQUENCIA         VARCHAR(20) OUTPUT, 
                                       @UPDATE_SEQUENCIAL BIT = 1, 
                                       @NEWVALUE          VARCHAR(20) = NULL
-- 20/04/2015 - MARCELO FUSTINI - 01.15.001A - IMPLEMENTADO TRY CATCH, ESTAVA OCASIONANDO PROBLEMAS NA CARGA DAS TABELAS LCF
-- 19/12/2006 - Alessandro Araújo - Reformulação para atualização e seleção de uma só vez 
-- 08/02/2006 - Sergio - Retirado um SET que estava sem utilidade, e que ocasionava erro na Colômbia
-- 10/06/2003 - Joao Ricardo
AS 
  BEGIN TRY 
      SET NOCOUNT ON 

      DECLARE @ERRMSG VARCHAR(255) 

      IF @UPDATE_SEQUENCIAL = 1 
        BEGIN 
            IF ISNULL(@NEWVALUE, '') = '' 
              BEGIN 
                  IF ISNULL(@EMPRESA, 0) <> 0 
                     AND ISNULL(DBO.FX_PARAMETRO_EMPRESA('CTRL_MULTI_EMPRESA', @EMPRESA), '.F.') = '.T.'
                     AND EXISTS(SELECT 1 
                                FROM   EMPRESA_SEQUENCIAIS 
                                WHERE  TABELA_COLUNA = @TABELA_COLUNA 
                                       AND EMPRESA = @EMPRESA) 
                    UPDATE EMPRESA_SEQUENCIAIS 
                    SET    @SEQUENCIA = SEQUENCIA = RIGHT(Replicate('0', TAMANHO) 
                                                          + CONVERT(VARCHAR(20), CONVERT(INT, EMPRESA_SEQUENCIAIS.SEQUENCIA)+1), TAMANHO)
                    FROM   EMPRESA_SEQUENCIAIS 
                           JOIN SEQUENCIAIS 
                             ON ( EMPRESA_SEQUENCIAIS.TABELA_COLUNA = SEQUENCIAIS.TABELA_COLUNA )
                    WHERE  EMPRESA_SEQUENCIAIS.TABELA_COLUNA = @TABELA_COLUNA 
                           AND EMPRESA_SEQUENCIAIS.EMPRESA = @EMPRESA 
                  ELSE 
                    UPDATE SEQUENCIAIS 
                    SET    @SEQUENCIA = SEQUENCIA = RIGHT(Replicate('0', TAMANHO) 
                                                          + CONVERT(VARCHAR(20), CONVERT(INT, SEQUENCIA)+1), TAMANHO)
                    WHERE  TABELA_COLUNA = @TABELA_COLUNA 
              END 
            ELSE 
              BEGIN 
                  IF ISNULL(@EMPRESA, 0) <> 0 
                     AND ISNULL(DBO.FX_PARAMETRO_EMPRESA('CTRL_MULTI_EMPRESA', @EMPRESA), '.F.') = '.T.'
                     AND EXISTS(SELECT 1 
                                FROM   EMPRESA_SEQUENCIAIS 
                                WHERE  TABELA_COLUNA = @TABELA_COLUNA 
                                       AND EMPRESA = @EMPRESA) 
                    UPDATE EMPRESA_SEQUENCIAIS 
                    SET    @SEQUENCIA = SEQUENCIA = RIGHT(Replicate('0', TAMANHO) 
                                                          + CONVERT(VARCHAR(20), CONVERT(INT, @NEWVALUE)), TAMANHO)
                    FROM   EMPRESA_SEQUENCIAIS 
                           JOIN SEQUENCIAIS 
                             ON ( EMPRESA_SEQUENCIAIS.TABELA_COLUNA = SEQUENCIAIS.TABELA_COLUNA )
                    WHERE  EMPRESA_SEQUENCIAIS.TABELA_COLUNA = @TABELA_COLUNA 
                           AND EMPRESA_SEQUENCIAIS.EMPRESA = @EMPRESA 
                  ELSE 
                    UPDATE SEQUENCIAIS 
                    SET    @SEQUENCIA = SEQUENCIA = RIGHT(Replicate('0', TAMANHO) 
                                                          + CONVERT(VARCHAR(20), CONVERT(INT, @NEWVALUE)), TAMANHO)
                    WHERE  TABELA_COLUNA = @TABELA_COLUNA 
              END 
        END 
      ELSE 
        BEGIN 
            IF ISNULL(@EMPRESA, 0) <> 0 
               AND ISNULL(DBO.FX_PARAMETRO_EMPRESA('CTRL_MULTI_EMPRESA', @EMPRESA), '.F.') = '.T.'
               AND EXISTS(SELECT 1 
                          FROM   EMPRESA_SEQUENCIAIS 
                          WHERE  TABELA_COLUNA = @TABELA_COLUNA 
                                 AND EMPRESA = @EMPRESA) 
              SELECT @SEQUENCIA = RIGHT(Replicate('0', TAMANHO) 
                                        + CONVERT(VARCHAR(20), CONVERT(INT, EMPRESA_SEQUENCIAIS.SEQUENCIA)+1), TAMANHO)
              FROM   EMPRESA_SEQUENCIAIS 
                     JOIN SEQUENCIAIS 
                       ON ( EMPRESA_SEQUENCIAIS.TABELA_COLUNA = SEQUENCIAIS.TABELA_COLUNA ) 
              WHERE  EMPRESA_SEQUENCIAIS.TABELA_COLUNA = @TABELA_COLUNA 
                     AND EMPRESA_SEQUENCIAIS.EMPRESA = @EMPRESA 
            ELSE 
              SELECT @SEQUENCIA = RIGHT(Replicate('0', TAMANHO) 
                                        + CONVERT(VARCHAR(20), CONVERT(INT, SEQUENCIA)+1), TAMANHO)
              FROM   SEQUENCIAIS 
              WHERE  TABELA_COLUNA = @TABELA_COLUNA 
        END 

      IF @@ROWCOUNT = 0 
        BEGIN 
            SELECT @ERRMSG = 'O sequencial #' + Rtrim(@TABELA_COLUNA) + ' # não existe na tabela de sequenciais !!!'
        END 
  END TRY 

  BEGIN CATCH 
      GOTO ERROR 
  END CATCH 

    RETURN 

    SET NOCOUNT OFF 

    ERROR: 

    RAISERROR(@ERRMSG,16,1)
GO


