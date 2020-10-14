select t.mes, l.regiao, sum(e.publico) publico, sum(e.arrecad) arrecadado
from fato_exibt e
join dim_local l on e.cod_local=id_local
join dim_particip p on e.cod_particip=p.id_particip
join dim_tempo t on e.cod_data=t.id_tempo
join filme f on p.num_filme=f.num
group by t.mes, l.regiao
