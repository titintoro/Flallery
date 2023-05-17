
import { ModalArtworkComponent } from '../../modals/modal-artwork/modal-artwork.component';
import { MatDialog } from '@angular/material/dialog';
import { ArtworkService } from 'src/app/services/artwork.service';
import { Component, OnInit, AfterViewInit, ViewChild } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { UtilService } from 'src/app/reutilizable/util.service';
import Swal from 'sweetalert2';
import { UserResponse } from 'src/app/models/response-dtos/create-user-response.interface';
import { ArtworkCategoryService } from 'src/app/services/artwork-category.service';
import { ArtworkResponse } from 'src/app/models/response-dtos/artwork-response-list.interface';
import { ArtworkDetailsDialogComponent } from '../../modals/artwork-details-dialog/artwork-details-dialog.component';
import { ArtworkEditDialogComponent } from '../../modals/artwork-edit-dialog/artwork-edit-dialog.component';



@Component({
  selector: 'app-artwork',
  templateUrl: './artwork.component.html',
  styleUrls: ['./artwork.component.css']
})
export class ArtworkComponent {

  columnasTable: string[] = ['id', 'categoria', 'fullName', 'createdAt', 'acciones'];
  artworks: ArtworkResponse[] = [];

  dataInicio: UserResponse[] = [];
  dataListaUsuarios = new MatTableDataSource(this.dataInicio);
  @ViewChild(MatPaginator) paginacionTabla!: MatPaginator;

  constructor(
    private artworkCategoryService: ArtworkCategoryService,
    private dialog: MatDialog,
    private artworkService: ArtworkService) { }

  ngOnInit(): void {
    this.loadArtworks();
    console.log(this.artworks)
  }

  loadArtworks(): void {
    this.artworks = [];
    this.artworkCategoryService.getAllCategories().subscribe(
      response => {
        response.forEach(c => c.artworkResponseList.forEach(a => this.artworks.push(a)));
      },
    );
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

  openCreateArtworkDialog() {
    const dialogRef = this.dialog.open(ModalArtworkComponent, {
      width: '500px',
      disableClose: true
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        const newArtwork = result.artwork;
        const selectedFile = result.file;
        console.log(result)
        this.artworkService.createArtwork(newArtwork, selectedFile).subscribe(
          response => {
            // Handle success response
            console.log('Artwork created successfully!', response);
            this.loadArtworks()
          }
        )
      }
    });
  }
}

