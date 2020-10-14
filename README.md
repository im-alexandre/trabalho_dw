# Trabalho de datawarehouse

Calendário 2003
https://www.anbima.com.br/feriados/fer_nacionais/2003.asp

### Organização dos arquivos:
```sh
.
├── Dados
│   ├── distrib_dw.db
│   └── distrib_oltp.db
├── DOC
│   └── EnunciadoDW1Tdist.pdf
├── imagens                                 # imagens dos diagramas mostrados nas aulas
│   ├── 1210021618.png
│   ├── 1210021757.png
│   └── 1210021805.png
├── index.md
├── main.tex                                # arquivo para apresentação em LaTeX
├── Modulos
│   ├── criação_da_dimensão_de_tempo.py
│   ├── kettle
│   │   ├── dw
│   │   └── stg
│   └── sql
│       ├── dw
│       │   ├── 1_carga_inicial.sql
│       │   └── 2_fato.sql
│       └── stg 
│           ├── 1_carga_inicial.sql         #esse script será rodado no banco OLTP
│           ├── 2_criacao_dimensoes.sql     #esse script será rodado no banco STG
│           └── exploração.sql              #Arquivo com algumas queries para "análise expliratória"
├── README.md
```

# TODO

### :robot: ALEXANDRE
:point_right: LAB2 (airflow)    
:point_right: Visualização (gráficos)   
:point_right: Carga no dw. (as dimensões estão prontas no stg, falta o último passo - carga)   
:point_right: LAB2 (kettle)   

### :smirk: NELSON
:point_right: as queries referentes às respostas do exercício (análises)   
:point_right: Análise sobre o lançamento nas férias e nos feriados   

---

### :woman: GIOVANNA
:point_right: Diagrama ER, STG e OLAP  
  
---

### :cuba: GIL
:point_right: Apresentação  

# Como utilizar
Abrir o db distrib_oltp.db, executar o arquivo Modulos/sql/stg/carga_inicial.sql
Abrir o db distrib_stg.db e executar o arquivo Modulos/sql/stg/criacao_dimensoes.sql  
