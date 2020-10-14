# -*- coding: utf-8 -*-
"""
Script para a criação da dimensão tempo
"""

import locale
from datetime import datetime
import holidays # Incluí o import para tratar feriados. (pip install holidays), caso não tenha o pcte instalado.

import numpy as np
import pandas as pd
from sqlalchemy import create_engine


# Inserir o caminho dos dados aqui. O python faz o resto
data_home = '/home/alexandre/Cursos/PUC/datawarehousing/trabalho_dw/Dados'


# definindo a linguagem para PT_BR
locale.setlocale(locale.LC_ALL, 'pt_BR.UTF-8')

# criando uma lista com os feriados no Brasil no período:
feriados_bra= holidays.Brazil()
feriados = []
for feriado in feriados_bra['2002-12-31': '2003-11-30'] :
    feriados.append(feriado)

# Criando dataframe vazio para rececber os dados de tempo
df = pd.DataFrame()
# utilizando o método pandas.date_range para gerar um iterável de datas e
# O END É EXCLUSIVO, OU SEJA, SE FOR INFORMADA A ÚLTIMA DATA PRESENTE NO
# DATASET, PERDEM-SE REGISTROS
df['data'] = pd.date_range(start='31/12/2002', end='30/11/2003')
"""redefinindo a coluna para ser o nome de data
criando as demais colunas
"""
df['mes_nome'] = df['data'].dt.month_name(locale="pt_BR.UTF-8")
df['mes_abreviado'] = df['data'].dt.month_name(locale="pt_BR.UTF-8")
df['dia'] = df['data'].dt.day
df['mes'] = df['data'].dt.month
df['ano'] = df['data'].dt.year
df['semana'] = df['data'].apply(lambda x: datetime.date(x).isocalendar()[1])
df['dia_da_semana'] = df['data'].dt.dayofweek
df['dia_da_semana_nome'] = df['data'].dt.day_name(locale="pt_BR.UTF-8")
df['dia_do_ano'] = df['data'].dt.dayofyear
df['trimestre'] = df['data'].dt.quarter
df['semestre'] = np.where(df['trimestre'].isin([1, 2]), 1, 2)
df['final_de_semana'] = np.where(df['dia_da_semana'].isin([5, 6]), 1, 0)
df['feriado'] = df['data'].apply(lambda x: 1 if x in feriados else 0)
df['dia_util'] = np.where((df['final_de_semana'] + df['feriado']) == 0, 1, 0)
df['data_completa'] = df['dia_da_semana_nome'] + ", " + df['dia'].astype(
    str) + " de " + df['mes_nome'] + " de " + df['ano'].astype(str)


# criando a surrogate key, que servirá para o join com a tabela fato
df['id_tempo'] = df.dia.apply(lambda x: str(x).zfill(2)) + \
    df.mes.apply(lambda x: str(x).zfill(2)) + df.ano.astype(str)
df['id_tempo'] = df.id_tempo.astype(int)
"""Forca o campo data ser somente date e não datetime"""
df['data'] = pd.to_datetime(df['data']).dt.date

# INSERINDO A DIMENSÃO TEMPO NO BANCO
engine = create_engine(f'sqlite:///{data_home}/distrib_stg.db', echo=False)
df.to_sql('dim_tempo', con=engine, if_exists='replace', index=False)


