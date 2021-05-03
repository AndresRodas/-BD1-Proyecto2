import { Component, OnInit } from '@angular/core';

//importacion de servicios

//importacion de modelos

//router
import { Router } from '@angular/router'
import { RouterLink } from '@angular/router';
import { isNullOrUndefined } from 'util';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  //del NgModel
  user_input: string = ''
  pass_input: string = ''
  //de la interfaz
  Users: string[] = []

  constructor( private router: Router ) { }

  Ingresar(){
    
    if (this.user_input == 'admin' && this.pass_input == 'admin' ) {
      console.log('Ingresando!')
      this.router.navigate(['/home'])
    }else{
      console.log('Datos erroneos!')
      alert('Los datos ingresados son incorrectos!')
      this.user_input = ''
      this.pass_input = ''
    }
  }


  ngOnInit(): void {
  }

}
