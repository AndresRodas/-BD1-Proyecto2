import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { from } from 'rxjs';

//Importar a manoo!!
import { LoginComponent } from './components/login/login.component';
import { HomeComponent } from './components/home/home.component';
import { PaisComponent } from './components/pais/pais.component';
import { PreguntaComponent } from './components/pregunta/pregunta.component';
import { InventosComponent } from './components/inventos/inventos.component';
import { RespuestasComponent } from './components/respuestas/respuestas.component';


//Aqui se colocan las rutas
const routes: Routes = [
  {
    path:'', 
    component:LoginComponent
  },{
    path:'home',
    component: HomeComponent
  },{
    path:'pais',
    component: PaisComponent
  },{
    path:'pregunta',
    component: PreguntaComponent
  },{
    path:'inventos',
    component: InventosComponent
  },{
    path:'respuestas',
    component: RespuestasComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
