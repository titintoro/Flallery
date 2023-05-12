import { Component, OnInit, AfterViewInit, ViewChild } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { MatDialog } from '@angular/material/dialog';
import { ModalUsuarioComponent } from '../../modals/modal-usuario/modal-usuario.component';
import { CreateUserRequest } from 'src/app/models/request-dtos/create-user-request.interface';
import { UserService } from 'src/app/services/user.service';
import { UtilService } from 'src/app/reutilizable/util.service';
import Swal from 'sweetalert2';
import { UserResponse } from 'src/app/models/response-dtos/create-user-response.interface';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css']
})
export class UserComponent implements OnInit/*, AfterViewInit*/{

  columnasTable:string[] = ['id','username','fullName','createdAt','acciones'];

  dataInicio:UserResponse[]=[];
  dataListaUsuarios = new MatTableDataSource(this.dataInicio);
  @ViewChild(MatPaginator) paginacionTabla!:MatPaginator;

  constructor(
    private dialog:MatDialog,
    private _usuarioService:UserService,
    private _utilService:UtilService
  ){}

  obtenerUsuarios(){
    this._usuarioService.lista().subscribe({
      next:(data) =>{
        if(data)
          this.dataListaUsuarios.data = data;
        else
          this._utilService.mostrarAlerta("No se encontraron datos", "Oops!")
      },
      error:(e)=>{}
    })
  }

  ngOnInit(): void {
    this.obtenerUsuarios();
  }
  /*
  ngAfterViewInit(): void {
    this.dataListaUsuarios.paginator=this.paginacionTabla;
  }

  aplicarFiltroTabla(event: Event){
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataListaUsuarios.filter = filterValue.trim().toLocaleLowerCase;
  }
  */
  nuevoUsuario(){
    this.dialog.open(ModalUsuarioComponent,{
      disableClose:true
    }).afterClosed().subscribe(res =>{
      if(res=="true")this.obtenerUsuarios();
    });
  }

  editUsuario(userResponse:UserResponse){
    this.dialog.open(ModalUsuarioComponent,{
      disableClose:true,
      data:userResponse
    }).afterClosed().subscribe(res =>{
      if(res=="true")this.obtenerUsuarios();
    });
  }

  eliminarUsuario(userResponse:UserResponse){
    Swal.fire({
      title:'¿Desea eliminar el usuario?',
      text: userResponse.fullName,
      icon:"warning",
      confirmButtonColor:'#3085d6',
      confirmButtonText: "Si, eliminar",
      showCancelButton: true,
      cancelButtonColor: '#d33',
      cancelButtonText: 'No, volver'
    }).then((res) =>{
      if(res.isConfirmed){

        this._usuarioService.eliminar(userResponse.id).subscribe({
          next:(data)=>{
            if(data){
              this._utilService.mostrarAlerta("El usuario fué eliminado","Listo!");
              this.obtenerUsuarios();
            } else{
              this._utilService.mostrarAlerta("No se pudo eliminar el usuario", "Error")
            }
          },
          error:(err)=>{}
        })

      }
    })
  }
}
