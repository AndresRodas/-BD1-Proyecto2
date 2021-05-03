const { Router } = require('express'); //se jala ruta de express
const router = Router();
const BD = require('../config/configbd');
var nodemailer = require('nodemailer')

//GET MYSQL
//Query1
router.get('/query1', async (req, res) => {
    BD.query(`
    select pro.nombre profesional, count(inv.id) inventos from profesional pro
    inner join asigna_invento ai on ai.id_profesional = pro.id
    inner join invento inv on inv.id = ai.id_invento
    group by pro.nombre order by inventos desc
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query2
router.get('/query2', async (req, res) => {
    BD.query(`
    select re.nombre continente, tmp.pais, tmp.respuestas from region re
    inner join (select tmp.id_region id, tmp.pais pais, count(r.respuesta) respuestas from pais pa
    inner join pais_respuesta pr on pa.id = pr.id_pais
    inner join respuesta r on pr.id_respuesta = r.id
    right join (select id_region, nombre pais, null from pais) tmp on tmp.pais = pa.nombre
    group by id, pais) tmp on tmp.id = re.id
    order by pais
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query3
router.get('/query3', async (req, res) => {
    BD.query(`
    select tmp1.area, tmp2.pais from (select pa.area area, pa.nombre pais from pais pa
    inner join frontera fr on pa.id = fr.id_pais1
    where fr.id_pais2 is null
    order by area) tmp1
    inner join (select distinct pa.nombre pais from pais pa
    left join inventor inv on pa.id = inv.id_pais
    where inv.id_pais is null) tmp2 on tmp2.pais = tmp1.pais
    order by area
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query4
router.get('/query4', async (req, res) => {
    BD.query(`
    select distinct pro.nombre jefe, pro2.nombre profesional, ar.nombre area from area ar
    inner join profesional pro on ar.id_jefe = pro.id
    inner join profesional_area pa on ar.id = pa.id_area
    inner join profesional pro2 on pro2.id = pa.id_profesional order by jefe
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query5
router.get('/query5', async (req, res) => {
    BD.query(`
    select a.nombre area, pro.nombre profesional, pro.salario from profesional pro
    inner join profesional_area pa on pro.id = pa.id_profesional
    inner join area a on pa.id_area = a.id
    inner join (select a.nombre area, avg(pro.salario) promedio from profesional pro
    inner join profesional_area pa on pro.id = pa.id_profesional
    inner join area a on pa.id_area = a.id
    group by area order by area) tmp on tmp.area = a.nombre
    where pro.salario > tmp.promedio
    order by area
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query6
router.get('/query6', async (req, res) => {
    BD.query(`
    select pa.nombre, count(rc.id_respuesta) aciertos from pais pa
    inner join pais_respuesta pr on pa.id = pr.id_pais
    inner join respuesta r on pr.id_respuesta = r.id
    inner join respuesta_correcta rc on r.id = rc.id_respuesta
    group by nombre order by aciertos desc
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query7
router.get('/query7', async (req, res) => {
    BD.query(`
    select inv.nombre invento from invento inv
    inner join asigna_invento ai on inv.id = ai.id_invento
    inner join profesional pro on ai.id_profesional = pro.id
    inner join profesional_area pa on pro.id = pa.id_profesional
    inner join area ar on pa.id_area = ar.id_jefe
    where ar.nombre = 'Óptica' order by invento
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query8
router.get('/query8', async (req, res) => {
    BD.query(`
    select substr(pa.nombre,1,1) inicial, sum(pa.area) area from pais pa
    group by inicial
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query9
router.get('/query9', async (req, res) => {
    BD.query(`
    select inv.nombre inventor, inve.nombre invento from inventor inv
    inner join inventado i on inv.id = i.id_inventor
    inner join invento inve on i.id_invento = inve.id
    WHERE inv.nombre LIKE 'Be%'
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query10
router.get('/query10', async (req, res) => {
    BD.query(`
    select inv.nombre inventor, i2.nombre invento, i2.anio from inventor inv
    inner join inventado i on inv.id = i.id_inventor
    inner join invento i2 on i.id_invento = i2.id
    where (inv.nombre like 'B%r' or inv.nombre like 'B%n')
    and (i2.anio > 1800) and (i2.anio < 1900)
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query11
router.get('/query11', async (req, res) => {
    BD.query(`
    select tmp.nombre pais, tmp.area, tmp.fronteras 
    from (select pa.nombre, pa.area, count(fr.id_pais1) fronteras from pais pa
    inner join frontera fr on pa.id = fr.id_pais1
    group by nombre, area order by fronteras) tmp
    where tmp.fronteras > 7 order by area desc
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query12
router.get('/query12', async (req, res) => {
    BD.query(`
    select nombre from invento where nombre like 'L%'
    and  length(nombre) = 4
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query13
router.get('/query13', async (req, res) => {
    BD.query(`
    select pro.nombre, pro.salario, pro.comision,
    (pro.salario+pro.comision) sueldo from profesional pro
    where pro.comision > (pro.salario*0.25)
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query14
router.get('/query14', async (req, res) => {
    BD.query(`
    select tmp.encuesta, count(tmp.pais) paises 
    from (select distinct enc.nombre encuesta, pa.nombre pais from encuesta enc
    inner join pregunta pre on enc.id = pre.id_encuesta
    inner join respuesta res on pre.id = res.id_pregunta
    inner join pais_respuesta pr on res.id = pr.id_respuesta
    inner join pais pa on pr.id_pais = pa.id
    order by enc.nombre) tmp
    group by encuesta
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query15
router.get('/query15', async (req, res) => {
    BD.query(`
    select pa.nombre pais, pa.poblacion, (select sum(pa.poblacion) area from pais pa
    inner join region re on pa.id_region = re.id
    where re.nombre = 'Centro America') poblacion_centroamerica
    from pais pa
    where pa.poblacion > (select sum(pa.poblacion) area from pais pa
    inner join region re on pa.id_region = re.id
    where re.nombre = 'Centro America')
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query16
router.get('/query16', async (req, res) => {
    BD.query(`
    select pro.nombre profesional, ar.nombre area from profesional pro
    inner join area ar on pro.id = ar.id_jefe
    where ar.nombre != (select a.nombre from inventor invo
    inner join inventado indo on invo.id = indo.id_inventor
    inner join invento i on indo.id_invento = i.id
    inner join asigna_invento ai on i.id = ai.id_invento
    inner join profesional pro on ai.id_profesional = pro.id
    inner join profesional_area pa on pro.id = pa.id_profesional
    inner join area a on pa.id_area = a.id
    where invo.nombre = 'Pasteur')    
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query17
router.get('/query17', async (req, res) => {
    BD.query(`
    select inv.nombre invento, inv.anio from invento inv
    where inv.anio = (select i.anio from inventor invr
    inner join inventado inva on invr.id = inva.id_inventor
    inner join invento i on inva.id_invento = i.id
    where invr.nombre = 'Benz')
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query18
router.get('/query18', async (req, res) => {
    BD.query(`
    select pa.nombre pais, pa.poblacion from pais pa
    inner join frontera fro on pa.id = fro.id_pais1
    where id_pais2 is null and pa.area >= (select pa.area from pais pa
    where pa.nombre = 'Japon')
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query19
router.get('/query19', async (req, res) => {
    BD.query(`
    select distinct pa.nombre pais, pa2.nombre frontera from pais pa
    inner join frontera fro on pa.id = fro.id_pais1
    inner join pais pa2 on pa2.id = fro.id_pais2
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Query20
router.get('/query20', async (req, res) => {
    BD.query(`
    select nombre, salario, comision from profesional
    where salario > (2*comision) order by nombre
    `,(err,rows,fields) => {
        if(!err){
            res.json(rows);
        } else{
            console.log('Error al hacer consulta: '+err)
        }
    });
});
//Paises
router.get('/paises', async (req, res) => {
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
router.put("/uppais", async (req, res) => {
    const { id, nombre, poblacion, area, capital, id_region } = req.body;
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