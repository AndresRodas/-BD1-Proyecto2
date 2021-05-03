const { Router } = require('express'); //se jala ruta de express
const router = Router();
const BD = require('../config/configbd');
var nodemailer = require('nodemailer')

//test coneccion mysql
//GET MYSQL
router.get('/pro', async (req, res) => {
    BD.query('select * from profesional',(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
router.get('/getUsers', async (req, res) => {
    BD.query('select * from usuario',(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
router.get('/getPosts', async (req, res) => {
    BD.query(`
    select pu.id, us.username user, ju.nombre game, pu.fecha date, pu.comentario comment from publicacion pu
    inner join usuario us on pu.id_usuario = us.id
    inner join juego ju on pu.id_juego = ju.id
    order by pu.fecha desc;
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
router.get('/getComments', async (req, res) => {
    BD.query(`
    select us.username user, co.comentario comment, co.id_publicacion post  from comentario co
    inner join usuario us on co.id_usuario = us.id;
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});



router.get('/:id', async (req, res) => {
    const { id } = req.params;
    BD.query('select * from persona where id = ?', [id],(err,rows,fields) => {
        if(!err){
            res.json(rows[0]);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});

//POST MYSQL
router.post('/add', async (req, res) => {
    const { nombre, apellido, genero} = req.body;
    const query = `
    insert into persona(nombre,apellido,genero)
    values(?,?,?);
    `;
    BD.query(query,[nombre, apellido, genero],(err,rows,fields) => {
        if(!err){
            res.json({Status: 'Persona '+nombre+' agregada!'});
        } else{
            console.log('Error al hacer consulta: '+err)
        }  
    });

})
router.post('/setUsers', async (req, res) => {
    const { name, last_name, user, email, pass, bio, fecha  } = req.body;
    console.log(name,last_name,user,email,pass,bio,fecha)
    const query = `
    insert into usuario (nombre,apellido,username,correo,password,biografia,fecha)
    values(?,?,?,?,?,?,?);
    `;
    BD.query(query,[name, last_name, user, email, pass, bio, fecha],(err,rows,fields) => {
        if(!err){
            res.json({Status: 'Persona '+name+' agregada!'});
        } else{
            console.log('Error al hacer consulta: '+err)
        }  
    });

})



//UPDATE MYSQL
router.put("/:id", async (req, res) => {
    const { nombre, apellido, genero } = req.body;
    const { id } = req.params;
    const query = `
        UPDATE persona
        SET nombre = ?, apellido = ?, genero = ? WHERE id = ?
    `; 
    BD.query(query, [nombre, apellido, genero, id], (err, rows, fields) => {
        if(!err){
            res.json({Status: 'Persona '+nombre+' editada!'});
        } else{
            console.log('Error al hacer consulta: '+err)
        } 
    })
})

//DELETE MYSQL
router.delete("/:id", async (req, res) => {
    const { id } = req.params;
    const query = 'delete from persona where id = ?';
    BD.query(query, [id], (err, rows, fields) => {
        if(!err){
            res.json({ "msg": "Persona eliminada" })
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