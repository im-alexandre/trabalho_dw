# Trabalho de datawarehouse


### Organização dos arquivos e diretorios:
```sh
.
├── Dados
│   ├── distrib_dw.db
│   ├── distrib_oltp.db
│   └── distrib_stg.db
├── DOC
│   └── EnunciadoDW1Tdist.pdf
├── graficos
├── index.md
├── main.tex
├── Modulos
│   ├── criação_da_dimensão_de_tempo.py
│   ├── graficos.ipynb
│   ├── kettle
│   └── sql
│       ├── dw
│       │   ├── 1_carga_inicial.sql
│       │   ├── exibicoes_mensais_diretor.sql
│       │   ├── metricas_semana_cidade.sql
│       │   ├── metricas_semana_estado.sql
│       │   ├── metricas_semana_regiao.sql
│       │   ├── publico_mensal_ator.sql
│       │   └── query_feriado.sql
│       └── stg
│           ├── 1_carga_inicial.sql
│           └── exploração.sql
├── README.md
└── requirements.txt
```

##### Dependências:
:point_right: Para instalar as dependencias do python, use o pip
```sh
pip install -r requirements.txt
```
:point_right: Baixe e instale o sqlite3 e um browser (opcional)

##### Utilização:
```sh
git clone https://github.com/im-alexandre/trabalho_dw
```
:point_right: Antes de tudo, execute o script de criação do esquema *STG*: 
```sh
python Modulos/criação_da_dimensão_de_tempo.py
```
:point_right: Para executar os scripts de Extração, transformação e carga ***(ETL)***,
conecte ao distrib_oltp.db, no diretório "Dados" e execute os scripts na seguinte
ordem:  
    0️⃣ Modulos/sql/stg/1_carga_inicial.sql  
    1️⃣Conecte ao banco recém criado (distrib_stg.db)  
    2️⃣ Modulos/sql/dw/1_carga_inicial.sql  
:point_right: Para executar as queries de métricas e análise, não há ordem.  

### IMPORTANTE‼️ 
:point_right: Desative as constraints de relacionamento manualmente (antes de rodar os scripts
sql). Essa instrução não funciona junto com scripts.   
:point_right: Verifique os caminhos dos diretórios (foram utilizados caminhos absolutos,
modifique nos scripts) ```criação_da_dimensão_de_tempo.py``` ```stg/1_carga_inicial.sql``` e ```dw/1_carga_inicial.sql```  




# TODO

### IMPORTANTE
#### :point_right: REVISAR A DOCUMENTAÇÃO, RETIRAR OS "TODOS" E ALTERAR O NECESSÁRIO
#### :point_right: TESTEM O PROCESSO INTEIRO E VERIFIQUEM SE HÁ ERROS!!!


### :robot: ALEXANDRE
:point_right: LAB2 (airflow)    
:point_right: Visualização (gráficos)   ✅  
:point_right: Carga no dw. (as dimensões estão prontas no stg, falta o último passo - carga)   ✅

### :smirk: NELSON
:point_right: Análise sobre o lançamento nas férias e nos feriados   

---

### :woman: GIOVANNA
:point_right: Diagrama ER, STG e OLAP  
  
---

### :cuba: GIL
:point_right: Apresentação  
:point_right: LAB2 (kettle)   
