select distinct(papel) from partic; --ator/diretor

select codfilme, sum("rank") as qtde
from partic
group by codfilme
having qtde<>1; -- Verificar se existe filme com somatorio diferente de 1 (ou 100%)

select codfilme, papel, sum("rank") qtde from partic
where papel='Ator'
group by codfilme, papel
having qtde<>0.5 
/* Todos os filmes retornam 0.5 de rank para o diretor e o 
restante divido entre os atores, podemos citar que isso foi percebido e que,
em um caso real, seria interessante falar com os especialistas de negócio.
*/

select codfilme, count(codartista) diretores
from partic 
where papel='Diretor'
group by codfilme
having diretores<>1
/*
Todos os filmes tem apenas um diretor. Não foi definido como regra de negócio,
mas no trabalho, podemos citar que isso foi percebido e que, em um caso real,
seria interessante falar com os especialistas de negócio.
 */
