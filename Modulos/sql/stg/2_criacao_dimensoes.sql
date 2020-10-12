/*
1) VERIFICAR SE ESSAS TABELAS DIMENSÃO SÃO CRIADAS NO STG E CARREGADAS NO DW OU
SE A CRIAÇÃO JÁ É JUNTO COM O INSERT NO DW.
2) DESLIGANDO AS FOREIGN KEYS PARA FAZER A INSERÇÃO
*/
PRAGMA foreign_keys=off;

/*
################################################################################
CRIAÇÃO DA DIMENSÃO DIM_PARTICIP
################################################################################
 */
drop TABLE if EXISTS dim_particip;
create table dim_particip (
id_particip integer primary key AUTOINCREMENT,
cod_filme integer not null,
nome_artista TEXT,
papel text,
rank decimal(10,2),
foreign key (cod_filme) references filme(id_filme)
);
insert into dim_particip (cod_filme, nome_artista, papel, rank)
/*
IMPORTANTE: O COALESCE RETORNA OS REGISTROS QUE TEM O ID_FILME NULO, ATRIBUINDO
O -1 NO LUGAR DO NULL. COMO INSERIMOS ESSE REGISTRO VAZIO A TABELA DE FILMES, A
INTEGRIDADE SERÁ MANTIDA E GARANTIREMOS QUE TODOS OS REGISTROS DA TABELA PARTICIP
SEJAM CARREGADOS
*/
select coalesce(f.id_filme, -1) cod_filme, a.nome, p.papel, p.rank
from partic p
join filme f on p.codfilme=f.num
join artista a on p.codartista=a.num;



/*
################################################################################
CRIAÇÃO DA DIMENSÃO DIM_LOCAL
################################################################################
 */
drop table if exists dim_local;
create table dim_local (
id_local integer PRIMARY KEY AUTOINCREMENT,
num_sala integer not null,
cinema text,
local text,
cidade text,
estado text,
regiao text,
pais TEXT
);
insert into dim_local (num_sala, cinema, local, cidade, estado, regiao, pais)
select coalesce(s.num, -1), 
c.nome, l.local, cd.nome, e.nome, r.nome, p.nome
from sala s
join local l on l.num=s.codlocal
join cinema c on c.num=codcinema
join cidade cd on cd.num=l.cidade
join estado e on e.num=l.estado
join regiao r on r.num=l.regiao
join pais p on p.num=l.pais;


/*
################################################################################
CRIAÇÃO DA TABELA FATO
################################################################################
 */
drop table if exists fato_exibt;
create table fato_exibt (
id_exibt integer primary key AUTOINCREMENT,
cod_particip integer,
cod_local integer,
cod_data BIGINT,
publico numeric,
arrecad decimal(10,2),
FOREIGN KEY (cod_particip) references dim_particip(id_particip),
FOREIGN KEY (cod_local) references dim_local(id_local),
FOREIGN KEY (cod_data) references dim_tempo(id_tempo)
);
insert into fato_exibt (cod_particip, cod_local, cod_data, publico, arrecad)
select
	coalesce(p.id_particip, -1) cod_particip,
	coalesce(l.id_local, -1) cod_local,
	coalesce(d.id_tempo, -1) cod_data,
	e.publico,
	e.arrecad
from exibt e
left join dim_particip p on p.cod_filme=e.codfilme
left join dim_local l on l.num_sala=e.codsala
left join dim_tempo d on d.id_tempo=e.coddata;
/*
LIGANDO AS CONSTRAINTS DE RELACIONAMENTO. CASO AS TABELAS TENHAM ALGUM PROBLEMA
DE INTEGRIDADE NOS RELACIONAMENTOS, RETORNARÁ UM ERRO */
PRAGMA foreign_keys=on;
