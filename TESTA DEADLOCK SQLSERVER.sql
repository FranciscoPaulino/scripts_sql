sp_who2


TentaNovamente:
SET @NumTentativas += 1 -- incrementa o contador 

BEGIN TRY
  BEGIN TRANSACTION
  UPDATE Production.Product SET ListPrice = 09.99 WHERE ProductID = 1
  UPDATE Production.Product SET ListPrice = 04.99 WHERE ProductID = 2
  COMMIT TRANSACTION
END TRY 

BEGIN CATCH
  SET @Err = @@ERROR
  IF @Err = 1205 -- um deadlock foi detectado
  BEGIN
    ROLLBACK TRANSACTION
    WAITFOR DELAY '00:00:05'
    PRINT 'Aconteceu um deadlock!, tentativa ' + CAST(@NumTentativas AS CHAR(1)) -- insira aqui o que você quer fazer para avisar ao usuario sobre a nova tentativa, etc.
    IF @NumTentativas < @MaxPermitido -- testa quantas vezes tentaremos de novo
      GOTO TentaNovamente; -- tenta executar o update novamente
  END
END CATCH 
