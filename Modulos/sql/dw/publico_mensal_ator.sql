SELECT p.nome_artista, t.mes, sum(e.publico) publico
from fato_exibt e
join dim_particip p on e.cod_particip=p.id_particip
join dim_tempo t on e.cod_data=t.id_tempo
where p.papel='Ator'
group by p.nome_artista, p.papel, t.mes
