/*
1) DESLIGANDO AS FOREIGN KEYS PARA FAZER AS INSERÇÕES
*/
PRAGMA foreign_keys=off;

ATTACH DATABASE '/home/alexandre/Cursos/PUC/datawarehousing/trabalho_dw/Dados/distrib_dw.db' AS dw;
ATTACH DATABASE '/home/alexandre/Cursos/PUC/datawarehousing/trabalho_dw/Dados/distrib_stg.db' AS stg;

/*
################################################################################
CRIAÇÃO DA DIMENSÃO DIM_PARTICIP
################################################################################
 */
drop table if exists dw.filme;
create table dw.filme(
    num primary key not null,
    nome text,
    genero text
);
insert into dw.filme
select 
    coalesce(f.num, -1),
    f.nome, 
    coalesce(g.nome, 'outros')
from stg.filme f
left join stg.genero g on g.num=f.genero;

drop TABLE if EXISTS dw.dim_particip;
create table dw.dim_particip (
    id_particip integer primary key AUTOINCREMENT,
    num_filme integer not null,
    nome_artista TEXT,
    papel text,
    rank decimal(10,2),
    foreign key (num_filme) references dw.filme(num)
);
insert into dw.dim_particip (num_filme, nome_artista, papel, rank)
select 
    coalesce(f.num, -1) num_filme,
    a.nome,
    p.papel,
    p.rank
from stg.partic p
join stg.filme f on p.codfilme=f.num
join stg.artista a on p.codartista=a.num;



/*
################################################################################
CRIAÇÃO DA DIMENSÃO DIM_LOCAL
################################################################################
 */
drop table if exists dw.dim_local;
create table dw.dim_local (
    id_local integer PRIMARY KEY AUTOINCREMENT,
    num_sala integer not null,
    cinema text,
    local text,
    cidade text,
    estado text,
    regiao text,
    pais TEXT
);
insert into dw.dim_local (num_sala, cinema, local, cidade, estado, regiao, pais)
select 
    coalesce(s.num, -1), 
    c.nome,
    l.local,
    cd.nome,
    e.nome,
    r.nome,
    p.nome
from stg.sala s
    join stg.local l on l.num=s.codlocal
    join stg.cinema c on c.num=codcinema
    join stg.cidade cd on cd.num=l.cidade
    join stg.estado e on e.num=l.estado
    join stg.regiao r on r.num=l.regiao
    join stg.pais p on p.num=l.pais;

/*
################################################################################
COPIANDO A DIMENSÃO TEMPO DO STG
################################################################################
 */
create table dw.dim_tempo as 
select * from stg.dim_tempo;


/*
################################################################################
CRIAÇÃO DA TABELA FATO
################################################################################
 */
drop table if exists dw.fato_exibt;
create table dw.fato_exibt (
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
insert into dw.fato_exibt (cod_particip, cod_local, cod_data, publico, arrecad)
select
	coalesce(p.id_particip, -1) cod_particip,
	coalesce(l.id_local, -1) cod_local,
	coalesce(d.id_tempo, -1) cod_data,
	e.publico,
	e.arrecad
from exibt e
left join stg.dim_particip p on p.num_filme=e.codfilme
left join stg.dim_local l on l.num_sala=e.codsala
left join stg.dim_tempo d on d.id_tempo=e.coddata;


/*
LIGANDO AS CONSTRAINTS DE RELACIONAMENTO. CASO AS TABELAS TENHAM ALGUM PROBLEMA
DE INTEGRIDADE NOS RELACIONAMENTOS, RETORNARÁ UM ERRO */
PRAGMA foreign_keys=on;
