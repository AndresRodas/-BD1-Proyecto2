LOAD DATA
LOCAL IN FILE '/home/alu/Escritorio/Projects/-BD1-Proyecto2/Database/CargaMasiva/CargaP-I.csv'
INTO TABLE carga_I_temporal
character set utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY ‘”‘
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(invento, inventor, profesional_asignado, jefe_del_area, fecha_contrato, salario, comision, area_investigacion, ranking, anio_invento, pais_invento, pais_inventor, region, capital, poblacion, area, frontera, norte, sur, este, oeste);
