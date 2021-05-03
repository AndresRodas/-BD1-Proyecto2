#Creando base de datos
create database if not exists bd1_proyecto2;
use bd1_proyecto2;

#creando tablas temporales
create table carga_1_temporal(
        invento varchar(50),
        inventor varchar(50),
        profesional_asignado varchar(50),
        jefe_del_area varchar(50),
        fecha_contrato varchar(50),
        salario integer not null,
        comision integer,
        area_investigacion varchar(50),
        ranking integer,
        anio_invento integer,
        pais_invento varchar(50),
        pais_inventor varchar(50),
        region varchar(50),
        capital varchar(50),
        poblacion bigint,
        area bigint,
        frontera varchar(50),
        norte enum('X'),
        sur enum('X'),
        este enum('X'),
        oeste enum('X')
);

create table carga_2_temporal(
     nombre_encuesta varchar(150),
     pregunta varchar(500),
     respuesta_posible varchar(200),
     respuesta_correcta varchar(200),
     pais varchar(50),
     respuesta_pais char(50)
);
create table carga_3_temporal(
     nombre_region varchar(50),
     region_padre varchar(50)
);


#creando tablas del modelo
#tabla profesional
create table profesional(
     id integer auto_increment not null,
     nombre varchar(150) not null ,
     salario integer not null,
     fecha_contrato date not null ,
     comision integer not null,
     primary key (id)
);
#tabla encuesta
create table encuesta(
     id integer auto_increment not null,
     nombre varchar(150) not null ,
     primary key (id)
);
#tabla region
create table region(
     id integer auto_increment not null,
     nombre varchar(150) not null ,
     id_region integer,
     primary key (id),
     foreign key (id_region) references region(id)
);
#tabla area
create table area(
     id integer auto_increment not null,
     nombre varchar(150) not null ,
     ranking integer not null ,
     descripcion varchar(150) not null ,
     id_jefe integer not null ,
     primary key (id),
     foreign key (id_jefe) references profesional(id)
);
#tabla profesional_area
create table profesional_area(
     id_profesional integer not null ,
     id_area integer not null ,
     foreign key (id_profesional) references profesional(id),
     foreign key (id_area) references area(id)
);
#tabla pregunta
create table pregunta(
     id integer auto_increment not null,
     pregunta varchar(150) not null ,
     id_encuesta integer not null ,
     primary key (id),
     foreign key (id_encuesta) references encuesta(id)
);
#tabla respuesta
create table respuesta(
     id integer auto_increment not null,
     respuesta varchar(150) not null ,
     letra char not null ,
     id_pregunta integer not null ,
     primary key (id),
     foreign key (id_pregunta) references pregunta(id)
);
#tabla respuesta_correcta
create table respuesta_correcta(
     id_respuesta integer not null ,
     id_pregunta integer not null ,
     foreign key (id_respuesta) references respuesta(id),
     foreign key (id_pregunta) references pregunta(id)
);
#tabla pais
create table pais(
     id integer auto_increment not null,
     nombre varchar(150) not null ,
     poblacion integer not null ,
     area integer not null ,
     capital varchar(150) not null ,
     id_region integer not null ,
     primary key (id),
     foreign key (id_region) references region(id)
);
#tabla pais_respuesta
create table pais_respuesta(
     id_pais integer not null ,
     id_respuesta integer not null ,
     foreign key (id_pais) references pais(id),
     foreign key (id_respuesta) references respuesta(id)
);
#tabla frontera
create table frontera(
     norte char,
     sur char,
     este char,
     oeste char,
     id_pais1 integer not null ,
     id_pais2 integer,
     foreign key (id_pais1) references pais(id),
     foreign key (id_pais2) references pais(id)
);
#tabla inventor
create table inventor(
     id integer auto_increment not null ,
     nombre varchar(150) not null ,
     id_pais integer not null ,
     primary key (id),
     foreign key (id_pais) references pais(id)
);
#tabla invento
create table invento(
    id integer auto_increment not null ,
    nombre varchar(150) not null ,
    anio integer not null ,
    id_pais integer not null ,
    primary key (id),
    foreign key (id_pais) references pais(id)
);
#tabla inventado
create table inventado(
     id_inventor integer not null ,
     id_invento integer not null ,
     foreign key (id_inventor) references inventor(id),
     foreign key (id_invento) references invento(id)
);
#tabla asigna_invento
create table asigna_invento(
     id_profesional integer not null ,
     id_invento integer not null ,
     foreign key (id_profesional) references profesional(id),
     foreign key (id_invento) references invento(id)
);

#pasando datos de tablas temporales a tablas del modelo
#funcion fecha
CREATE FUNCTION nueva_fecha (fecha_in varchar(50))
RETURNS varchar(50)
BEGIN
DECLARE mont VARCHAR(10);
IF substr(fecha_in,2,1)=' ' then
    case substr(fecha_in,6,3)
     when 'ene' then
     set mont='01';
     when 'feb' then
     set mont='02';
     when 'mar' then
     set mont='03';
     when 'abr' then
     set mont='04';
     when 'may' then
     set mont='05';
     when 'jun' then
     set mont='06';
     when 'jul' then
     set mont='07';
     when 'ago' then
     set mont='08';
     when 'sep' then
     set mont='09';
     when 'oct' then
     set mont='10';
     when 'nov' then
     set mont='11';
     when 'dic' then
     set mont='12';
    end case;
    return concat('19',substr(fecha_in,13,2),'-',mont,'-','0',substr(fecha_in,1,1));
ELSE
    case substr(fecha_in,7,3)
     when 'ene' then
     set mont='01';
     when 'feb' then
     set mont='02';
     when 'mar' then
     set mont='03';
     when 'abr' then
     set mont='04';
     when 'may' then
     set mont='05';
     when 'jun' then
     set mont='06';
     when 'jul' then
     set mont='07';
     when 'ago' then
     set mont='08';
     when 'sep' then
     set mont='09';
     when 'oct' then
     set mont='10';
     when 'nov' then
     set mont='11';
     when 'dic' then
     set mont='12';
    end case;
    return concat('19',substr(fecha_in,14,2),'-',mont,'-',substr(fecha_in,1,2));
END IF;
END;

#funcion Respuesta
CREATE FUNCTION div_respuesta (resp varchar(200))
RETURNS varchar(100)
BEGIN
DECLARE respuesta_final VARCHAR(50);
IF substr(resp,3,1)=' ' then
    set respuesta_final = substr(resp,4,50);
    return respuesta_final;
ELSE
    set respuesta_final = substr(resp,3,50);
    return respuesta_final;
END IF;
END;


#ingreando datos a tabla profesional
insert into profesional (nombre, salario, fecha_contrato, comision)
select distinct profesional_asignado, salario,
nueva_fecha(fecha_contrato) as fecha,
comision from carga_1_temporal where salario != 0;

#ingresando datos a tabla encuesta
insert into encuesta(nombre)
select distinct nombre_encuesta from carga_2_temporal
order by nombre_encuesta asc limit 2;

#ingresando datos a tabla region
insert into region (nombre)
select nombre_region from carga_3_temporal
where nombre_region != 'NOMBRE_REGION';
#ingresando id_region en tabla region
UPDATE region re
inner join (select c3.nombre_region, re.id from region re
inner join carga_3_temporal c3 on region_padre = re.nombre
where region_padre is not null) tmp on tmp.nombre_region = re.nombre
SET re.id_region = tmp.id where id_region is null;
#valor faltante
insert into region (nombre, id_region) values ('Europa Occidental',6);

#ingresando datos en tabla area
insert into area(nombre, ranking, id_jefe)
select tmp.area nombre, tmp.ranking, pro.id id_jefe from profesional pro
inner join (select distinct tmp.area, tmp.ranking, c1.profesional_asignado from carga_1_temporal c1
inner join (select distinct tmp.area, c1.ranking from carga_1_temporal c1,                                                                                                                  (select distinct jefe_del_area area from carga_1_temporal
where jefe_del_area != 'EL_PROFESIONAL_ES_JEFE_DEL_AREA' and jefe_del_area != ''
union select distinct area_investigacion from carga_1_temporal
where area_investigacion != 'AREA_INVEST_DEL_PROF' and area_investigacion != ''
order by area) tmp
where tmp.area = c1.area_investigacion or tmp.area = 'TODAS'
order by area limit 9) tmp on tmp.area = c1.jefe_del_area order by area) tmp on tmp.profesional_asignado = pro.nombre
order by area;
#datos aparte
insert into area (nombre, ranking, id_jefe)
values ('Medicina',8,8),('Electrónica',8,8);

#ingresando datos en tabla profesional_area
insert into profesional_area(id_profesional, id_area)
select pro.id, a.id from (select distinct profesional_asignado profesional, area_investigacion area from carga_1_temporal
where profesional_asignado != 'PROFESIONAL_ASIGANDO_AL_INVENTO' and profesional_asignado != '') tmp
inner join profesional pro on pro.nombre = tmp.profesional
inner join area a on a.nombre = tmp.area;

#ingresando datos en tabla pregunta
insert into pregunta(pregunta, id_encuesta)
select distinct pregunta, en.id from carga_2_temporal c2
inner join encuesta en on en.nombre = c2.nombre_encuesta order by pregunta;

#ingresando datos en tabla respuesta
insert into respuesta(respuesta, letra, id_pregunta)
select distinct div_respuesta(c2.respuesta_posible) respuesta,
substr(c2.respuesta_posible,1,1) letra, pre.id from carga_2_temporal c2
inner join pregunta pre on pre.pregunta = c2.pregunta;

#ingresando datos en tabla respuesta_correcta
insert into respuesta_correcta(id_respuesta, id_pregunta)
select distinct re.id respuesta, pre.id pregunta from carga_2_temporal c2
inner join pregunta pre on c2.pregunta = pre.pregunta
inner join respuesta re on div_respuesta(c2.respuesta_correcta) = re.respuesta
order by pre.id;

#ingresando datos en la tabla pais
insert into pais(nombre, poblacion, area, capital, id_region)
select distinct c1.pais_inventor, c1.poblacion, c1.area,c1.capital, re.id from carga_1_temporal c1
inner join region re on re.nombre = c1.region
where pais_inventor != 'PAIS_DEL_INVENTOR'
order by pais_inventor;

#ingresando datos en la tabla pais_respuesta
insert into pais_respuesta(id_pais, id_respuesta)
select pa.id id_pais, re.id id_respuesta
from carga_2_temporal c2
inner join pregunta pre on pre.pregunta = c2.pregunta
inner join respuesta re on re.id_pregunta = pre.id
inner join pais pa on pa.nombre = trim(c2.pais)
where c2.respuesta_pais = re.letra order by pais;

#insertando datos en la tabla frontera
insert into frontera(norte, sur, este, oeste, id_pais1, id_pais2)
select distinct c1.norte, c1.sur, c1.este, c1.oeste,
pa1.id, pa2.id from carga_1_temporal c1
inner join pais pa1 on pa1.nombre = c1.pais_inventor
left join pais pa2 on pa2.nombre = c1.frontera
order by pa1.id;

#insertando datos en la tabla inventor
insert into inventor(nombre, id_pais)
select distinct c1.inventor, pa.id from carga_1_temporal c1
inner join pais pa on pa.nombre = c1.pais_inventor
where c1.inventor != '' order by inventor;

#insertando datos en la tabla invento
insert into invento(nombre, anio, id_pais)
select distinct c1.invento, c1.anio_invento, pa.id from carga_1_temporal c1
inner join pais pa on pa.nombre = c1.pais_invento
where c1.invento != '' order by invento;

#insertando datos en la tabla inventado
insert into inventado(id_inventor, id_invento)
select distinct ior.id id_inventor , ito.id id_invento from carga_1_temporal c1
inner join invento ito on ito.nombre = c1.invento
inner join inventor ior on ior.nombre = c1.inventor;

#insertando datos en la tabla asigna_invento
insert into asigna_invento(id_profesional, id_invento)
select distinct p.id id_profesional, inv.id id_invento from carga_1_temporal c1
inner join invento inv on inv.nombre = c1.invento
inner join profesional p on p.nombre = c1.profesional_asignado;


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
#inner join region re2 on re2.id = re.id_region
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
select tmp.nombre pais, tmp.area, tmp.fronteras from (select pa.nombre, pa.area, count(fr.id_pais1) fronteras from pais pa
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
select tmp.encuesta, count(tmp.pais) paises from (select distinct enc.nombre encuesta, pa.nombre pais from encuesta enc
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
where inv.anio =
(select i.anio from inventor invr
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
select * from pais;