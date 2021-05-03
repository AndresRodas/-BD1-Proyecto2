import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from "@angular/common/http";
import { map } from "rxjs/operators";
import { Observable } from 'rxjs';
@Injectable({
  providedIn: 'root'
})
export class PatentsService {

  constructor(private http: HttpClient) { }

  headers: HttpHeaders = new HttpHeaders({
    "Content-Type": "application/json"
  })

  GetPaises(){
    const url = 'http://localhost:3600/paises';
    return this.http.get(url);
  }
  GetQuery1(){
    const url = 'http://localhost:3600/query1';
    return this.http.get(url);
  }
  GetQuery2(){
    const url = 'http://localhost:3600/query2';
    return this.http.get(url);
  }
  GetQuery3(){
    const url = 'http://localhost:3600/query3';
    return this.http.get(url);
  }
  GetQuery4(){
    const url = 'http://localhost:3600/query4';
    return this.http.get(url);
  }
  GetQuery5(){
    const url = 'http://localhost:3600/query5';
    return this.http.get(url);
  }
  GetQuery6(){
    const url = 'http://localhost:3600/query6';
    return this.http.get(url);
  }
  GetQuery7(){
    const url = 'http://localhost:3600/query7';
    return this.http.get(url);
  }
  GetQuery8(){
    const url = 'http://localhost:3600/query8';
    return this.http.get(url);
  }
  GetQuery9(){
    const url = 'http://localhost:3600/query9';
    return this.http.get(url);
  }
  GetQuery10(){
    const url = 'http://localhost:3600/query10';
    return this.http.get(url);
  }
  GetQuery11(){
    const url = 'http://localhost:3600/query11';
    return this.http.get(url);
  }
  GetQuery12(){
    const url = 'http://localhost:3600/query12';
    return this.http.get(url);
  }
  GetQuery13(){
    const url = 'http://localhost:3600/query13';
    return this.http.get(url);
  }
  GetQuery14(){
    const url = 'http://localhost:3600/query14';
    return this.http.get(url);
  }
  GetQuery15(){
    const url = 'http://localhost:3600/query15';
    return this.http.get(url);
  }
  GetQuery16(){
    const url = 'http://localhost:3600/query16';
    return this.http.get(url);
  }
  GetQuery17(){
    const url = 'http://localhost:3600/query17';
    return this.http.get(url);
  }
  GetQuery18(){
    const url = 'http://localhost:3600/query18';
    return this.http.get(url);
  }
  GetQuery19(){
    const url = 'http://localhost:3600/query19';
    return this.http.get(url);
  }
  GetQuery20(){
    const url = 'http://localhost:3600/query20';
    return this.http.get(url);
  }

  SetPais(nombre: string, poblacion:number, area:number, capital: string, id_region: number){
    const url = 'http://localhost:3600/addpais'
    return this.http.post(
      url, 
      {
        'nombre': nombre,
        'poblacion': poblacion,
        'area': area,
        'capital': capital,
        'id_region': id_region
      },
      {
        headers: this.headers
      }
    ).pipe(map(data => data))  
  }

  UpdatePais(id:number, nombre: string, poblacion:number, area:number, capital: string, id_region: number){
    const url = 'http://localhost:3600/uppais'

    return this.http.put(
      url,
      {
        'id': id,
        'nombre': nombre,
        'poblacion': poblacion,
        'area': area,
        'capital': capital,
        'id_region': id_region
      },
      {
        headers: this.headers
      }
    ).pipe(map(data => data))
  }

  DeletePais(id:number){
    const url = 'http://localhost:3600/delete'+id
    return this.http.delete(url)
  }



}
