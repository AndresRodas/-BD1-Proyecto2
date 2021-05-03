const mysql = require('mysql');
const { promisify } = require('util');
//const { connect } = require('../routes/person-rotes');


database = {
    host: '34.86.109.0',
    user: 'bd1-proyecto2',
    password: 'MAYQ',
    database: 'bd1_proyecto2'
}

const pool = mysql.createPool(database)

pool.getConnection((err,connection)=>{
    if (err){
        if (err.code === 'PROTOCOL_CONNECTION_LOST'){
            console.log('La coneccion con la base de datos fue cerrada')
        }
        if (err.code === 'ER_CON_COUNT_ERROR'){
            console.log('La base de datos tiene muchas conecciones')
        }
        if (err.code === 'ECONNREFUSED'){
            console.log('La coneccion con la base de datos fue rechazada')
        }
    }
    if(connection) connection.release();
    console.log('Base de datos conectada!')
    return;
});

pool.query = promisify(pool.query);
module.exports = pool;