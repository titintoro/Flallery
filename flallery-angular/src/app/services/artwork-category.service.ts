import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ArtworkCategoryList } from '../models/response-dtos/artwork-category-response';
import { environemnt } from 'src/environments/environment';
import { Observable } from 'rxjs/internal/Observable';

@Injectable({
  providedIn: 'root'
})
export class ArtworkCategoryService {

  constructor(private http:HttpClient) { }

  private urlApi:string = "http://localhost:8080/category";

  getAllCategories(): Observable<ArtworkCategoryList>{
    return this.http.get<ArtworkCategoryList>(this.urlApi)
  }
}
