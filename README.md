# trabalho_dw

### Organização dos arquivos:
```sh
.
├── Dados
│   ├── distrib_dw.db
│   └── distrib_oltp.db
├── DOC
│   └── EnunciadoDW1Tdist.pdf
├── imagens
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
:point_right: incluir coluna com flag feriado/fds na dimensão tempo  
:point_right: Análise sobre o lançamento nas férias e nos feriados  
:point_right: LAB2 (airflow)  
:point_right: Visualização (gráficos)  
# :point_right: dormir

### :smirk: NELSON
:point_right: Carga no dw. (as dimensões estão prontas no stg,
falta o último passo - carga)  
:point_right: as queries referentes às respostas do exercício (análises)  

---

### :woman: GIOVANNA
:point_right: Diagrama ER e OLAP  
:point_right: Apresentação  

---

### :cuba: GIL
:point_right: Exportar o resultado das queries para o excel  
:point_right: LAB2 (kettle)  
