#cargando archivo 1
LOAD DATA
LOCAL INFILE '/home/alu/Escritorio/Projects/-BD1-Proyecto2/Database/CargaMasiva/CargaP-I.csv'
INTO TABLE carga_1_temporal
character set utf8mb4
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(invento, inventor, profesional_asignado, jefe_del_area, fecha_contrato, salario, comision, area_investigacion, ranking, anio_invento, pais_invento, pais_inventor, region, capital, poblacion, area, frontera, norte, sur, este, oeste);

#cargando archivo 2
LOAD DATA
LOCAL INFILE '/home/alu/Escritorio/Projects/-BD1-Proyecto2/Database/CargaMasiva/CargaP-II.csv'
INTO TABLE carga_2_temporal
character set utf8mb4
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(pregunta, respuesta_posible, respuesta_correcta, pais);

#cargando archivo 3
LOAD DATA
LOCAL INFILE '/home/alu/Escritorio/Projects/-BD1-Proyecto2/Database/CargaMasiva/CargaP-III.csv'
INTO TABLE carga_3_temporal
character set utf8mb4
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(nombre_region, region_padre);

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
