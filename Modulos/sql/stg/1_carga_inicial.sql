/*
Rodar o script no banco de dados oltp. Ele vai "atachar" o banco stg e vai criar
as tabelas
 */
ATTACH DATABASE '/home/alexandre/Cursos/PUC/datawarehousing/trabalho_dw/Dados/distrib_stg.db' AS stg;


/* 
desligando as constraints para poder inserir os dados
sem dar erro 
 */
PRAGMA foreign_keys=off; 

/*
###############################################################################
INÍCIO DAS TABELAS QUE IRÃO COMPOR A DIM_PARTICIP
###############################################################################
*/

DROP TABLE IF EXISTS stg."artista";
CREATE TABLE stg."artista" (
    "id_artista" integer primary key autoincrement,
	"num"	integer,
	"nome"	text
);
insert into stg.artista (num, nome)
select num,nome from artista;
insert into stg.artista (id_artista) values(-1); 


DROP TABLE IF EXISTS stg."filme";
CREATE TABLE stg."filme" (
    "id_filme" integer primary key autoincrement,
	"num"	INT,
	"nome"	TEXT,
	"genero"	TEXT
);
insert into stg.filme(
	"num"	,
	"nome"	,
	"genero"
)
select * from filme;
insert into stg.filme (id_filme) values(-1);


DROP TABLE IF EXISTS stg."genero";
CREATE TABLE stg."genero" (
    "id_genero" integer primary key autoincrement,
	"num"	integer,
	"nome"	text
);
insert into stg.genero(
	"num",
	"nome"
)
select * from genero;
insert into stg.genero (id_genero) values(-1);


DROP TABLE IF EXISTS stg."partic";
CREATE TABLE stg."partic" (
    "id_partic" integer primary key autoincrement,
	"codartista"	integer,
	"codfilme"	integer,
	"papel"	TEXT,
	"rank"	NUMERIC,
	foreign key (codartista) references artista(num),
	foreign key (codfilme) references filme(num)
);
insert into stg.partic(
	"codartista",
	"codfilme",
	"papel",
	"rank"
)
select 
	"codartista",
	"codfilme",
	"papel",
	"rank"
from partic;
/*
###############################################################################
FIM DAS TABELAS QUE IRÃO COMPOR A DIM_PARTICIP
###############################################################################
*/


/*
###############################################################################
INÍCIO DAS TABELAS QUE IRÃO COMPOR A DIM_LOCAL 
############################################################################### 
 */
DROP TABLE IF EXISTS stg."sala";
CREATE TABLE stg."sala" (
	"num"	integer,
	"codlocal"	integer,
	"capacidade"	integer,
	"codcinema"	integer,
	foreign key (codlocal) references local(num),
	foreign key (codcinema) references cinema(num)
);
insert into stg.sala(
	"num",
	"codlocal",
	"capacidade",
	"codcinema"
)
select 
	"num",
	"codlocal",
	"capacidade",
	"codcinema"
from sala;


DROP TABLE IF EXISTS stg."cinema";
CREATE TABLE stg."cinema" (
    "id_cinema" integer primary key autoincrement,
	"num"	integer,
	"nome"	text
);
insert into stg.cinema (num, nome)
select num,nome from cinema;


DROP TABLE IF EXISTS stg."local";
CREATE TABLE stg."local" (
    "id_local" integer primary key autoincrement,
	"num"	INT,
	"local"	TEXT,
	"cidade"	INT,
	"estado"	INT,
	"regiao"	INT,
	"pais"	INT,
	foreign key (cidade) references cidade(num),
	foreign key (estado) references estado(num),
	foreign key (regiao) references regiao(num),
	foreign key (pais) references pais(num)
);
insert into stg.local(
	"num",
	"local",
	"cidade",
	"estado",
	"regiao",
	"pais"	
)
select * from local;
insert into stg.local (id_local, num) values (-1, -1);


DROP TABLE IF EXISTS stg."cidade";
CREATE TABLE stg."cidade" (
	"num"	integer,
	"nome"	text
);
insert into stg.cidade(num, nome)
select num, nome from cidade;

DROP TABLE IF EXISTS stg."estado";
CREATE TABLE stg."estado" (
	"num"	integer,
	"nome"	text
);
insert into stg.estado(num, nome)
select num, nome from estado;


DROP TABLE IF EXISTS stg."regiao";
CREATE TABLE stg."regiao" (
	"num"	integer,
	"nome"	text
);
insert into stg.regiao(
	"num",
	"nome"
)
select num, nome from regiao;


DROP TABLE IF EXISTS stg."pais";
CREATE TABLE stg."pais" (
	"num"	integer,
	"nome"	text
);
insert into stg.pais(
	"num",
	"nome"
)
select * from pais;
/*
###############################################################################
FIM DAS TABELAS QUE IRÃO COMPOR A DIM_LOCAL 
############################################################################### 
 */


/*
###############################################################################
TABELA QUE DARÁ ORIGEM À TABELA FATO
############################################################################### 
 */
DROP TABLE IF EXISTS stg."exibt";
CREATE TABLE stg."exibt" (
    "id_exibt" integer primary key autoincrement,
	"num"	integer,
	"data"	date,
	"coddata" BIGINT,
	"codsala"	integer,
	"codfilme"	integer,
	"publico"	integer,
	"arrecad"	decimal(10, 2),
	foreign key (coddata) REFERENCES data(chave),
	foreign key (codsala) references sala(num)	
);
insert into stg.exibt(
	"num",
	"data",
	"codsala",
	"codfilme",
	"publico",
	"arrecad"
	)
select 
	"num",
	"data",
	"codsala",
	"codfilme",
	"publico",
	"arrecad"
 from exibt;
update stg.exibt set coddata=substr(data,1,2)||substr(data,4,2)||Substr(data,7,4);
