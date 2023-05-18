import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { RegisterComponent } from './components/register/register.component';
import { LoginComponent } from './components/login/login.component';
import { LayoutComponent } from './components/layout/layout.component';
import { SharedModule } from './reutilizable/shared/shared.module';
import { authInterceptorProviders } from './_helpers/auth.interceptor';
import { ArtworkImagePipe } from './pipes/artwork-image.pipe';
import { UserImagePipe } from './pipes/user-image.pipe';

@NgModule({
  declarations: [
    AppComponent,
    RegisterComponent,
    LoginComponent,
    LayoutComponent,
    UserImagePipe
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    SharedModule
  ],
  providers: [
    authInterceptorProviders
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
