import { Component, OnInit } from '@angular/core';

//importacion de servicio
import { PatentsService } from '../../services/patents.service'

//importacion de modelos
import { Query1 } from '../../models/query1.interface'
import { Query2 } from '../../models/query2.interface'
import { Query3 } from '../../models/query3.interface'
import { Query4 } from '../../models/query4.interface'
import { Query5 } from '../../models/query5.interface'
import { Query6 } from '../../models/query6.interface'
import { Query7 } from '../../models/query7.interface'
import { Query8 } from '../../models/query8.interface'
import { Query9 } from '../../models/query9.interface'
import { Query10 } from '../../models/query10.interface'
import { Query11 } from '../../models/query11.interface'
import { Query12 } from '../../models/query12.interface'
import { Query13 } from '../../models/query13.interface'
import { Query14 } from '../../models/query14.interface'
import { Query15 } from '../../models/query15.interface'
import { Query16 } from '../../models/query16.interface'
import { Query17 } from '../../models/query17.interface'
import { Query18 } from '../../models/query18.interface'
import { Query19 } from '../../models/query19.interface'
import { Query20 } from '../../models/query20.interface'

//router
import { Router } from '@angular/router'
import { RouterLink } from '@angular/router';
import { isNullOrUndefined } from 'util';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  Consulta1:Query1[] = []
  Consulta2:Query2[] = []
  Consulta3:Query3[] = []
  Consulta4:Query4[] = []
  Consulta5:Query5[] = []
  Consulta6:Query6[] = []
  Consulta7:Query7[] = []
  Consulta8:Query8[] = []
  Consulta9:Query9[] = []
  Consulta10:Query10[] = []
  Consulta11:Query11[] = []
  Consulta12:Query12[] = []
  Consulta13:Query13[] = []
  Consulta14:Query14[] = []
  Consulta15:Query15[] = []
  Consulta16:Query16[] = []
  Consulta17:Query17[] = []
  Consulta18:Query18[] = []
  Consulta19:Query19[] = []
  Consulta20:Query20[] = []

  constructor(public PatentService: PatentsService, private router: Router) { }



  ngOnInit(): void {
    //llenando consultas
    this.PatentService.GetQuery1().subscribe((res:Query1[])=>{
      this.Consulta1 = res
    })
    this.PatentService.GetQuery2().subscribe((res:Query2[])=>{
      this.Consulta2 = res
    })
    this.PatentService.GetQuery3().subscribe((res:Query3[])=>{
      this.Consulta3 = res
    })
    this.PatentService.GetQuery4().subscribe((res:Query4[])=>{
      this.Consulta4 = res
    })
    this.PatentService.GetQuery5().subscribe((res:Query5[])=>{
      this.Consulta5 = res
    })
    this.PatentService.GetQuery6().subscribe((res:Query6[])=>{
      this.Consulta6 = res
    })
    this.PatentService.GetQuery7().subscribe((res:Query7[])=>{
      this.Consulta7 = res
    })
    this.PatentService.GetQuery8().subscribe((res:Query8[])=>{
      this.Consulta8 = res
    })
    this.PatentService.GetQuery9().subscribe((res:Query9[])=>{
      this.Consulta9 = res
    })
    this.PatentService.GetQuery10().subscribe((res:Query10[])=>{
      this.Consulta10 = res
    })
    this.PatentService.GetQuery11().subscribe((res:Query11[])=>{
      this.Consulta11 = res
    })
    this.PatentService.GetQuery12().subscribe((res:Query12[])=>{
      this.Consulta12 = res
    })
    this.PatentService.GetQuery13().subscribe((res:Query13[])=>{
      this.Consulta13 = res
    })
    this.PatentService.GetQuery14().subscribe((res:Query14[])=>{
      this.Consulta14 = res
    })
    this.PatentService.GetQuery15().subscribe((res:Query15[])=>{
      this.Consulta15 = res
    })
    this.PatentService.GetQuery16().subscribe((res:Query16[])=>{
      this.Consulta16 = res
    })
    this.PatentService.GetQuery17().subscribe((res:Query17[])=>{
      this.Consulta17 = res
    })
    this.PatentService.GetQuery18().subscribe((res:Query18[])=>{
      this.Consulta18 = res
    })
    this.PatentService.GetQuery19().subscribe((res:Query19[])=>{
      this.Consulta19 = res
    })
    this.PatentService.GetQuery20().subscribe((res:Query20[])=>{
      this.Consulta20 = res
    })
  }

}
