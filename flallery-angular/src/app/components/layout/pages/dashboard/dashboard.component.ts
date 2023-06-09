import { Component } from '@angular/core';
import { ArtworkResponse } from 'src/app/models/response-dtos/artwork-response-list.interface';
import { JwtUserResponse } from 'src/app/models/response-dtos/login-response.interface';
import { ArtworkDetailsDialogComponent } from '../../modals/artwork-details-dialog/artwork-details-dialog.component';
import { MatDialog } from '@angular/material/dialog';
import { UtilService } from 'src/app/reutilizable/util.service';
import { ArtworkCategoryService } from 'src/app/services/artwork-category.service';
import { ArtworkService } from 'src/app/services/artwork.service';
import { ArtworkEditDialogComponent } from '../../modals/artwork-edit-dialog/artwork-edit-dialog.component';
import Swal from 'sweetalert2';
import { CommentRequest } from 'src/app/models/request-dtos/comment-create-request.interface';
import { ModalUsuarioComponent } from '../../modals/modal-usuario/modal-usuario.component';
import { UserResponse } from 'src/app/models/response-dtos/create-user-response.interface';
@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent {

  user: JwtUserResponse | null = null;
  userArtworks: ArtworkResponse[] = [];

  constructor(
    private artworkCategoryService: ArtworkCategoryService,
    private dialog: MatDialog,
    private artworkService: ArtworkService,
    private _utilService: UtilService) { }

  ngOnInit(): void {
    const userJson = localStorage.getItem('user');


    this.artworkService.getUserArtworks().subscribe(
      (artworks: ArtworkResponse[]) => {
        this.userArtworks = artworks;
      },
    );

    if (userJson) {
      this.user = JSON.parse(userJson);
    }
  }


  openDetailsDialog(artwork: ArtworkResponse): void {
    this.dialog.open(ArtworkDetailsDialogComponent, {
      width: '70%',
      data: artwork
    });
  }



  openEditDialog(artwork: ArtworkResponse): void {
    this.dialog.open(ArtworkEditDialogComponent, {
      width: '500px',
      data: artwork
    });
  }

  deleteArtwork(artwork: ArtworkResponse) {
    Swal.fire({
      title: '¿Desea eliminar el artwork?',
      text: artwork.name,
      icon: "warning",
      confirmButtonColor: '#3085d6',
      confirmButtonText: "Si, eliminar",
      showCancelButton: true,
      cancelButtonColor: '#d33',
      cancelButtonText: 'No, volver'
    }).then((res) => {
      if (res.isConfirmed) {

        this.artworkService.deleteArtwork(artwork.uuid).subscribe({
          next: (data) => {
            this._utilService.mostrarAlerta("El artwork fue eliminado", "Listo!");
            this.userArtworks = this.userArtworks.filter(a => a.uuid !== artwork.uuid); // Remove the deleted artwork from the artworks array

          },
        })

      }
    })
  }


  commentArtwork(artwork: ArtworkResponse): void {
    Swal.fire({
      title: "Add Comment",
      text: "Enter your comment",
      input: 'text',
      showCancelButton: true
  }).then((result) => {
    if (result.isConfirmed) {
      const comment: CommentRequest = {
        text: result.value
      };
      if (result.value.trim()!=''){
        this.artworkService.addComment(artwork.uuid,comment).subscribe(
          (res) => {
            Swal.fire({title:'Comment added!',
            text:'Your comment has been submitted successfully.',
            showCancelButton: false,
            showConfirmButton: false,
            icon:'success',
            showDenyButton: false });

          },
        );
        setTimeout(() => {
          location.reload();
        }, 1500)

      } else{
        Swal.fire('Error', 'You can not submit a empty comment. Please try again.', 'error');
      }
    }
  });
}


editUsuario(userResponse: UserResponse) {
  this.dialog.open(ModalUsuarioComponent, {
    disableClose: true,
    data: userResponse
  }).afterClosed().subscribe(res => {
    if (res == "true") {
      const userJson = localStorage.getItem('user');

      if (userJson) {
        this.user = JSON.parse(userJson);
      }
    }
  });
}

}
