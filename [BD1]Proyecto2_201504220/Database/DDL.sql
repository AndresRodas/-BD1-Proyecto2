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














