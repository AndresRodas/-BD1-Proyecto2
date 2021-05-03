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
     pregunta varchar(150),
     respuesta_posible varchar(100),
     respuesta_correcta varchar(100),
     pais varchar(50),
     respuesta_pais varchar(50)
);
create table carga_3_temporal(
     nombre_region varchar(50),
     region_padre varchar(50)
);


#seteando variable
SET GLOBAL local_infile=1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';
mysql --local-infile=1 -u root -p1;

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

#creando tablas del modelo
