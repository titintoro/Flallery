package com.salesianostriana.dam.flalleryapi.services;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
import com.salesianostriana.dam.flalleryapi.models.ArtworkCategory;
import com.salesianostriana.dam.flalleryapi.repositories.ArtworkCategoryRepository;
import com.salesianostriana.dam.flalleryapi.repositories.ArtworkRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ArtworkCategoryService {

    private final ArtworkCategoryRepository artworkCategoryRepository;

    public List<ArtworkCategory> findAll(){ return artworkCategoryRepository.findAll();}

    public Optional<ArtworkCategory> findById(Long id){ return  artworkCategoryRepository.findById(id);}

    public ArtworkCategory save(ArtworkCategory a){
        return artworkCategoryRepository.save(a);
    }


    public void delete(ArtworkCategory a) {
        ArtworkCategory sinCategoria;

        if (artworkCategoryRepository.findById(1L).isPresent()){
            sinCategoria = artworkCategoryRepository.findById(1L).get();
        }
        else {
            sinCategoria = ArtworkCategory.builder()
                    .idCategory(1L)
                    .name("Sin categoria")
                    .build();
        }


        artworkCategoryRepository.delete(a);}
}
