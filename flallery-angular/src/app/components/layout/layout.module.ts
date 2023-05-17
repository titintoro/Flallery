import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { LayoutRoutingModule } from './layout-routing.module';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { UserComponent } from './pages/user/user.component';
import { ArtworkComponent } from './pages/artwork/artwork.component';
import { VentaComponent } from './pages/venta/venta.component';
import { HistorialVentaComponent } from './pages/historial-venta/historial-venta.component';
import { ReporteComponent } from './pages/reporte/reporte.component';
import { SharedModule } from 'src/app/reutilizable/shared/shared.module';
import { ModalUsuarioComponent } from './modals/modal-usuario/modal-usuario.component';
import { ModalArtworkComponent } from './modals/modal-artwork/modal-artwork.component';
import { ArtworkDetailsDialogComponent } from './modals/artwork-details-dialog/artwork-details-dialog.component';
import { ArtworkEditDialogComponent } from './modals/artwork-edit-dialog/artwork-edit-dialog.component';
import { ArtworkImagePipe } from 'src/app/pipes/artwork-image.pipe';

@NgModule({
  declarations: [
    DashboardComponent,
    UserComponent,
    ArtworkComponent,
    VentaComponent,
    HistorialVentaComponent,
    ReporteComponent,
    ModalUsuarioComponent,
    ModalArtworkComponent,
    ArtworkDetailsDialogComponent,
    ArtworkEditDialogComponent,
    ArtworkImagePipe
  ],
  imports: [
    CommonModule,
    LayoutRoutingModule,
    SharedModule
  ]
})
export class LayoutModule { }
