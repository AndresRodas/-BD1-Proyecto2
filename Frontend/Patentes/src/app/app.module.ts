import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
//!!!IMPORTANTE!! agregar TODOS a imports
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from "@angular/common/http";

//se van agregando los componentes al crearlos
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './components/login/login.component';
import { HomeComponent } from './components/home/home.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { PaisComponent } from './components/pais/pais.component';
import { PreguntaComponent } from './components/pregunta/pregunta.component';
import { InventosComponent } from './components/inventos/inventos.component';
import { RespuestasComponent } from './components/respuestas/respuestas.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    HomeComponent,
    PaisComponent,
    PreguntaComponent,
    InventosComponent,
    RespuestasComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    NgbModule,
    FormsModule,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
