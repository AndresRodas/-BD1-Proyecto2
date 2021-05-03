const { Router } = require('express'); //se jala ruta de express
const router = Router();
const BD = require('../config/configbd');
var nodemailer = require('nodemailer')

//GET MYSQL
router.get('/get', async (req, res) => {
    BD.query(`
    select * from pais
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
router.get('/get:id', async (req, res) => {
    const { id } = req.params;
    BD.query('select * from pais where id = ?', [id],(err,rows,fields) => {
        if(!err){
            res.json(rows[0]);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});

//POST MYSQL
router.post('/addpais', async (req, res) => {
    const { nombre, poblacion, area, capital, id_region } = req.body;
    const query = `
    insert into pais(nombre,poblacion,area,capital,id_region)
    values(?,?,?,?,?);
    `;
    BD.query(query,[nombre, poblacion, area, capital, id_region],(err,rows,fields) => {
        if(!err){
            res.json({Status: 'Pais '+nombre+' agregado!'});
        } else{
            console.log('Error al hacer consulta: '+err)
        }  
    });

})

//UPDATE MYSQL
router.put("/put:id", async (req, res) => {
    const { nombre, poblacion, area, capital, id_region } = req.body;
    const { id } = req.params;
    const query = `
        UPDATE pais
        SET nombre = ?, poblacion = ?, area = ?, capital = ?, id_region = ? WHERE id = ?
    `; 
    BD.query(query, [nombre, poblacion, area, capital, id_region, id], (err, rows, fields) => {
        if(!err){
            res.json({Status: 'Pais '+nombre+' editado!'});
        } else{
            console.log('Error al hacer consulta: '+err)
        } 
    })
})

//DELETE MYSQL
router.delete("/delete:id", async (req, res) => {
    const { id } = req.params;
    const query = 'delete from pais where id = ?';
    BD.query(query, [id], (err, rows, fields) => {
        if(!err){
            res.json({ "msg": "Pais eliminado" })
        } else{
            console.log('Error al hacer consulta: '+err)
        } 
    }); 

    
})





//enviar correo
router.post('/enviarcorreo', function(req, res){
    const { name, lname, email } = req.body;
    var smtpTransport = nodemailer.createTransport({
        service: 'Gmail',
        auth: {
            user: 'bastianperis12@gmail.com',
            pass: 'hesoyam666'
        }
    })
    var output = '<strong><h1>CORREO DE CONFIRMACION</h1> \n\nHola <h3>'+name+' '+lname+'</h3>\nTu correo electronico ha sido confirmado en <h3>GTSales!!</h3>\nIngresa al siguiente link: http://localhost:4200/login para ingresar con tu correo electronico y contraseña.</strong>'
    var mailOptions = {
        from: 'GTSales',
        to: email,
        subject: 'Confirmacion',
        text: 'Correo de confirmacion.',
        html: output
    }
    smtpTransport.sendMail(mailOptions, function(error, respuesta){
        if(error){
            console.log(error)
        }else{
            res.send('Mensaje enviado!!')
        }
    })
})

module.exports = router;