select l.cidade, t.semana, sum(e.publico) publico, sum(e.arrecad) arrecadado
from fato_exibt e
join dim_local l on e.cod_local=l.id_local
join dim_particip p on e.cod_particip=p.id_particip
join dim_tempo t on e.cod_data=t.id_tempo
group by t.semana, l.cidade
order by cidade, semana
