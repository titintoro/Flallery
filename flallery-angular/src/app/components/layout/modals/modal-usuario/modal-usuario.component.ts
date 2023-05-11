import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { User } from 'src/app/models/response-dtos/user-list-response.interface';
import { UserService } from 'src/app/services/user.service';
import { UtilService } from 'src/app/reutilizable/util.service';
import { CreateUserRequest } from 'src/app/models/request-dtos/create-user-request.interface';
@Component({
  selector: 'app-modal-usuario',
  templateUrl: './modal-usuario.component.html',
  styleUrls: ['./modal-usuario.component.css']
})
export class ModalUsuarioComponent {

  createUserForm: FormGroup;
  ocultarPassword: boolean = true;
  tituloAccion: string = "Agregar";
  botonAccion: string = "Guardar";

  constructor(
    private modalActual: MatDialogRef<ModalUsuarioComponent>,
    @Inject(MAT_DIALOG_DATA) public datosUsuario: CreateUserRequest,
    private fb: FormBuilder,
    private _userService: UserService,
    private _utilService: UtilService
  ) {
    this.createUserForm = this.fb.group({
      username: ["", Validators.required],
      password: ["", Validators.required],
      verifyPassword: ["", Validators.required],
      avatar: ["", Validators.required],
      fullName: ["", Validators.required]
    });

    if (this.datosUsuario != null) {
      this.tituloAccion = "Editar";
      this.botonAccion = "Actualizar";
    }


  }

  ngOnInit(): void {
    if (this.datosUsuario != null) {

      this.createUserForm.patchValue({
        username: this.datosUsuario.username,
        password: this.datosUsuario.password,
        verifyPassword: this.datosUsuario.verifyPassword,
        avatar: this.datosUsuario.avatar,
        fullName: this.datosUsuario.fullName
        });
    }
  }

  guardarEditar_Usuario(){
    const _usuario:CreateUserRequest = {
      username: this.datosUsuario.username,
      password: this.datosUsuario.password,
      verifyPassword: this.datosUsuario.verifyPassword,
      avatar: this.datosUsuario.avatar,
      fullName: this.datosUsuario.fullName
    }

    if(this.datosUsuario == null){
      this._userService.registrarUsuario(_usuario).subscribe({
        next:(data)=>{
          if(data){
              this._utilService.mostrarAlerta("El usuario fue registrado","Éxito")
              this.modalActual.close("true");
          } else {
            this._utilService.mostrarAlerta("No se pudo crear el usuario","Error")
          }},
          error:(e)=>{}
        })
      } else {
        this._userService.registrarUsuario(_usuario).subscribe({
          next:(data)=>{
            if(data){
                this._utilService.mostrarAlerta("El usuario fue registrado","Éxito")
                this.modalActual.close("true");
            } else {
              this._utilService.mostrarAlerta("No se pudo crear el usuario","Error")
            }},
            error:(e)=>{}
          })
      }
    }
  }









