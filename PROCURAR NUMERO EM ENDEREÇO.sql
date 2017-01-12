select endereco,PATINDEX('%1%',endereco),
case 
when charindex('1',endereco)>0 then substring(endereco,charindex('1',endereco),10) 
when charindex('2',endereco)>0 then substring(endereco,charindex('2',endereco),10) 
when charindex('3',endereco)>0 then substring(endereco,charindex('3',endereco),10) 
when charindex('4',endereco)>0 then substring(endereco,charindex('4',endereco),10) 
when charindex('5',endereco)>0 then substring(endereco,charindex('5',endereco),10) 
when charindex('6',endereco)>0 then substring(endereco,charindex('6',endereco),10) 
when charindex('7',endereco)>0 then substring(endereco,charindex('7',endereco),10) 
when charindex('8',endereco)>0 then substring(endereco,charindex('8',endereco),10) 
when charindex('9',endereco)>0 then substring(endereco,charindex('9',endereco),10) 
else ''
end as numero
from CADASTRO_CLI_FOR



select * from CADASTRO_CLI_FOR
where CGC_CPF='01790247000111'


