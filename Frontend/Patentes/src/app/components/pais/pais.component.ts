import { Component, OnInit } from '@angular/core';

//importacion de servicio
import { PatentsService } from '../../services/patents.service'

//importacion de modelos
import { Pais } from '../../models/pais.interface'

//router
import { Router } from '@angular/router'
import { RouterLink } from '@angular/router';
import { isNullOrUndefined } from 'util';
import { NONE_TYPE } from '@angular/compiler';



@Component({
  selector: 'app-pais',
  templateUrl: './pais.component.html',
  styleUrls: ['./pais.component.css']
})
export class PaisComponent implements OnInit {


  new_pais: string
  new_poblacion: number
  new_area: number
  new_capital: string
  new_region: number
  up_id: number
  up_pais: string
  up_poblacion: number
  up_area: number
  up_capital: string
  up_region: number
  del_id:number
  Paises:Pais[]=[]

  constructor(public PatentService: PatentsService, private router: Router) { }

  ngOnInit(): void {
    //llenando paises
    this.Read()
  }
  Create(){
    console.log(this.new_area)
    if(this.new_pais != '' && this.new_poblacion != undefined && this.new_area != undefined && this.new_capital != '' && this.new_region != undefined){
      this.PatentService.SetPais(this.new_pais, this.new_poblacion, this.new_area, this.new_capital, this.new_region)
      .subscribe((res: Pais[]) =>{
        console.log(res)
        this.new_pais = ''
        this.new_poblacion = undefined
        this.new_area = undefined
        this.new_capital = ''
        this.new_region = undefined
        alert('Pais creado con exito!! ')
      })
    }else{
      alert('Los datos son incorrectos o faltantes...')
    }
  }
  Read(){
    console.log('Actualizando')
    this.Paises = []
    this.PatentService.GetPaises().subscribe((res:Pais[])=>{
      this.Paises = res 
    })
  }

  Update(){
    console.log('actualizar')
    this.PatentService.UpdatePais(this.up_id,this.up_pais, this.up_poblacion, this.up_area, this.up_capital, this.up_region)
      .subscribe((res: Pais[]) =>{
        console.log(res)
        this.up_id = undefined
        this.up_pais = ''
        this.up_poblacion = undefined
        this.up_area = undefined
        this.up_capital = ''
        this.up_region = undefined
        alert('Pais actualizado con exito!! ')
      })
  }

  Delete(){
    console.log('Eliminando')
    this.PatentService.DeletePais(this.del_id).subscribe((res:Pais[])=>{
      console.log(res) 
      this.del_id = undefined
      alert('Pais eliminado con exito!! ')
    })
  }
  
}
