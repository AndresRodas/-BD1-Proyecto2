#CONSULTAS
#consulta 1
select pro.nombre profesional, count(inv.id) inventos from profesional pro
inner join asigna_invento ai on ai.id_profesional = pro.id
inner join invento inv on inv.id = ai.id_invento
group by pro.nombre order by inventos desc;

#consulta 2
select re.nombre continente, tmp.pais, tmp.respuestas from region re
inner join (select tmp.id_region id, tmp.pais pais, count(r.respuesta) respuestas from pais pa
inner join pais_respuesta pr on pa.id = pr.id_pais
inner join respuesta r on pr.id_respuesta = r.id
right join (select id_region, nombre pais, null from pais) tmp on tmp.pais = pa.nombre
group by id, pais) tmp on tmp.id = re.id
order by pais;

#consulta 3
select tmp1.area, tmp2.pais from (select pa.area area, pa.nombre pais from pais pa
inner join frontera fr on pa.id = fr.id_pais1
where fr.id_pais2 is null
order by area) tmp1
inner join (select distinct pa.nombre pais from pais pa
left join inventor inv on pa.id = inv.id_pais
where inv.id_pais is null) tmp2 on tmp2.pais = tmp1.pais
order by area;

#consulta 4
select distinct pro.nombre jefe, pro2.nombre profesional, ar.nombre area from area ar
inner join profesional pro on ar.id_jefe = pro.id
inner join profesional_area pa on ar.id = pa.id_area
inner join profesional pro2 on pro2.id = pa.id_profesional order by jefe;

#consulta 5
select a.nombre area, pro.nombre profesional, pro.salario from profesional pro
inner join profesional_area pa on pro.id = pa.id_profesional
inner join area a on pa.id_area = a.id
inner join (select a.nombre area, avg(pro.salario) promedio from profesional pro
inner join profesional_area pa on pro.id = pa.id_profesional
inner join area a on pa.id_area = a.id
group by area order by area) tmp on tmp.area = a.nombre
where pro.salario > tmp.promedio
order by area;

#consulta 6
select pa.nombre, count(rc.id_respuesta) aciertos from pais pa
inner join pais_respuesta pr on pa.id = pr.id_pais
inner join respuesta r on pr.id_respuesta = r.id
inner join respuesta_correcta rc on r.id = rc.id_respuesta
group by nombre order by aciertos desc;

#consulta 7
select inv.nombre invento from invento inv
inner join asigna_invento ai on inv.id = ai.id_invento
inner join profesional pro on ai.id_profesional = pro.id
inner join profesional_area pa on pro.id = pa.id_profesional
inner join area ar on pa.id_area = ar.id_jefe
where ar.nombre = 'Óptica' order by invento;

#consulta 8
select substr(pa.nombre,1,1) inicial, sum(pa.area) area from pais pa
group by inicial;

#consulta 9
select inv.nombre inventor, inve.nombre invento from inventor inv
inner join inventado i on inv.id = i.id_inventor
inner join invento inve on i.id_invento = inve.id
WHERE inv.nombre LIKE 'Be%';

#consulta 10
select inv.nombre inventor, i2.nombre invento, i2.anio from inventor inv
inner join inventado i on inv.id = i.id_inventor
inner join invento i2 on i.id_invento = i2.id
where (inv.nombre like 'B%r' or inv.nombre like 'B%n')
and (i2.anio > 1800) and (i2.anio < 1900);

#consulta 11
select tmp.nombre pais, tmp.area, tmp.fronteras
from (select pa.nombre, pa.area, count(fr.id_pais1) fronteras from pais pa
inner join frontera fr on pa.id = fr.id_pais1
group by nombre, area order by fronteras) tmp
where tmp.fronteras > 7 order by area desc;

#consulta 12
select nombre from invento where nombre like 'L%'
and  length(nombre) = 4;

#consulta 13
select pro.nombre, pro.salario, pro.comision,
(pro.salario+pro.comision) sueldo from profesional pro
where pro.comision > (pro.salario*0.25);

#consulta 14
select tmp.encuesta, count(tmp.pais) paises
from (select distinct enc.nombre encuesta, pa.nombre pais from encuesta enc
inner join pregunta pre on enc.id = pre.id_encuesta
inner join respuesta res on pre.id = res.id_pregunta
inner join pais_respuesta pr on res.id = pr.id_respuesta
inner join pais pa on pr.id_pais = pa.id
order by enc.nombre) tmp
group by encuesta;

#consulta 15
select pa.nombre pais, pa.poblacion, (select sum(pa.poblacion) area from pais pa
inner join region re on pa.id_region = re.id
where re.nombre = 'Centro America') poblacion_centroamerica
from pais pa
where pa.poblacion > (select sum(pa.poblacion) area from pais pa
inner join region re on pa.id_region = re.id
where re.nombre = 'Centro America');

#consulta 16
select pro.nombre profesional, ar.nombre area from profesional pro
inner join area ar on pro.id = ar.id_jefe
where ar.nombre != (select a.nombre from inventor invo
inner join inventado indo on invo.id = indo.id_inventor
inner join invento i on indo.id_invento = i.id
inner join asigna_invento ai on i.id = ai.id_invento
inner join profesional pro on ai.id_profesional = pro.id
inner join profesional_area pa on pro.id = pa.id_profesional
inner join area a on pa.id_area = a.id
where invo.nombre = 'Pasteur');


#consulta 17
select inv.nombre invento, inv.anio from invento inv
where inv.anio = (select i.anio from inventor invr
inner join inventado inva on invr.id = inva.id_inventor
inner join invento i on inva.id_invento = i.id
where invr.nombre = 'Benz');

#consulta 18
select pa.nombre pais, pa.poblacion from pais pa
inner join frontera fro on pa.id = fro.id_pais1
where id_pais2 is null and pa.area >= (select pa.area from pais pa
where pa.nombre = 'Japon');

#consulta 19
select distinct pa.nombre pais, pa2.nombre frontera from pais pa
inner join frontera fro on pa.id = fro.id_pais1
inner join pais pa2 on pa2.id = fro.id_pais2;

#consulta 20
select nombre, salario, comision from profesional
where salario > (2*comision) order by nombre;
show tables;