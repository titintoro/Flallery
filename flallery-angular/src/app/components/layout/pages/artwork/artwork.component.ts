import { Component } from '@angular/core';
import { ModalArtworkComponent } from '../../modals/modal-artwork/modal-artwork.component';
import { MatDialog } from '@angular/material/dialog';
import { ArtworkService } from 'src/app/services/artwork.service';

@Component({
  selector: 'app-artwork',
  templateUrl: './artwork.component.html',
  styleUrls: ['./artwork.component.css']
})
export class ArtworkComponent {

  constructor(private dialog: MatDialog, private artworkService: ArtworkService) {}

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
          },
          error => {
            // Handle error response
            console.error('Failed to create artwork:', error);
          }
        // Perform further actions with the new artwork and selected file
    )}
    });
  }
}

