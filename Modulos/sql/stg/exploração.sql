
select * from artista;

select * from filme;

select distinct(papel) from partic; --ator/diretor

select codfilme, sum("rank") as qtde
from partic
group by codfilme
having qtde<>1; -- Verificar se existe filme com somatorio diferente de 1 (ou 100%)

select * from exibt
where arrecad BETWEEN 75000 and 80000;

select * from exibt;

select count(*) from exibt;

select strftime(data, '%d/%m/%Y') from exibt;

select * from cinema;

select * from sala;

select * from local;

select codfilme, papel, sum("rank") qtde from partic
where papel='Ator'
group by codfilme, papel
having qtde<>0.5

select * from partic
where codfilme=232

select codfilme, count(codartista) diretores
from partic 
where papel='Diretor'
group by codfilme
having diretores<>1

where papel='Diretor'
