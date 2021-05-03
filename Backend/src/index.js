const express = require('express');
const morgan = require('morgan');
const cors = require('cors');
const app = express();



//imports
const Routes = require('./routes/rutas');

//settings
app.set('port', 3600); //se setea el puerto

//middlewares: porciones de codigo que se ejecutan antes, enmedio o despues de una solicitud a endpoints
app.use(morgan('dev')); //con morgan se imprimie en consola el verbo de la peticion que se esté recibiendo
app.use(express.json()); //toda la info que entre a la api sera de tipo json
app.use(express.urlencoded({ extended: false })); //info anidada por medio de rutas

//routes
app.use(cors())
app.use(Routes);

    
//run
app.listen(app.get('port'), () => {
    console.log('Server on Port 3600 ')
})
