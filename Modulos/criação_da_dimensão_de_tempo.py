# -*- coding: utf-8 -*-
"""
Script para a criação da dimensão tempo
"""

import locale
from datetime import datetime

import numpy as np
import pandas as pd
from sqlalchemy import create_engine

data_home = '/home/alexandre/Cursos/PUC/datawarehousing/lab1/Dados'

# Ajuste das datas para início e fim do período dos dados do OLTP


# definindo a linguagem para PT_BR
locale.setlocale(locale.LC_ALL, 'pt_BR.UTF-8')

# Criando dataframe vazio para rececber os dados de tempo
df = pd.DataFrame()
# utilizando o método pandas.date_range para gerar um iterável de datas e
# Alteração das datas de início e fim para se ajustarem ao dataset
df['data'] = pd.date_range(start='31/12/2002', end='31/12/2003')
"""redefinindo a coluna para ser o nome de data
criando as demais colunas
"""
df['mes_nome'] = df['data'].dt.month_name(locale="pt_BR.UTF-8")
df['mes_abreviado'] = df['data'].dt.month_name(locale="pt_BR.UTF-8")
df['dia'] = df['data'].dt.day
df['mes'] = df['data'].dt.month
df['ano'] = df['data'].dt.year
df['dia_da_semana'] = df['data'].dt.dayofweek
df['dia_da_semana_nome'] = df['data'].dt.day_name(locale="pt_BR.UTF-8")
df['dia_do_ano'] = df['data'].dt.dayofyear
df['trimestre'] = df['data'].dt.quarter
df['semestre'] = np.where(df['trimestre'].isin([1, 2]), 1, 2)
df['final_de_semana'] = np.where(df['dia_da_semana'].isin([5, 6]), 1, 0)
df['data_completa'] = df['dia_da_semana_nome'] + ", " + df['dia'].astype(
    str) + " de " + df['mes_nome'] + " de " + df['ano'].astype(str)

df['id_tempo'] = df.dia.apply(lambda x: str(x).zfill(2)) + \
    df.mes.apply(lambda x: str(x).zfill(2)) + df.ano.astype(str)
df['id_tempo'] = df.id_tempo.astype(int)
"""Forca o campo data ser somente date e não datetime"""
df['data'] = pd.to_datetime(df['data']).dt.date
"""Salvando o arquivo CSV, sem o indice do pandas dataframe"""

engine = create_engine(f'sqlite:///{data_home}/distrib_stg.db', echo=False)

# Mantendo o index para ter a surrogate key para a data na stagging area
df.to_sql('dim_tempo', con=engine, if_exists='replace', index=False)


