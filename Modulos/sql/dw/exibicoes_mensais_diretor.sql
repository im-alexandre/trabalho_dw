SELECT p.nome_artista diretor, t.mes, count(e.id_exibt) exibicoes
from fato_exibt e
join dim_particip p on e.cod_particip=p.id_particip
join dim_tempo t on e.cod_data=t.id_tempo
where p.papel='Diretor'
group by p.nome_artista, p.papel, t.mes
