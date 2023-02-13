package com.salesianostriana.dam.flalleryapi.controllers;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
import com.salesianostriana.dam.flalleryapi.models.dtos.ArtworkResponse;
import com.salesianostriana.dam.flalleryapi.models.dtos.PageDto;
import com.salesianostriana.dam.flalleryapi.repositories.ArtworkRepository;
import com.salesianostriana.dam.flalleryapi.search.util.SearchCriteria;
import com.salesianostriana.dam.flalleryapi.search.util.SearchCriteriaExtractor;
import com.salesianostriana.dam.flalleryapi.services.ArtworkService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;


@RestController
@RequiredArgsConstructor
public class ArtworkController {

    private final ArtworkService artworkService;
    private final ArtworkRepository artworkRepository;

    @GetMapping("/product")
    public ResponseEntity<PageDto<Artwork>> search(
            @RequestParam(value = "s", defaultValue = "") String s,
            @PageableDefault(size = 25, page = 0) Pageable pageable) {

        List<SearchCriteria> params = SearchCriteriaExtractor.extractSearchCriteriaList(s);


        Page<Artwork> result = artworkService.search(params, pageable);


        if ( result.isEmpty())
            return ResponseEntity.notFound().build();

        return ResponseEntity.ok(new PageDto<Artwork>(result));
    }

    @GetMapping("/product/{id}")
    public ResponseEntity<ArtworkResponse> getArtwork(@PathVariable UUID id){

        ArtworkResponse response = new ArtworkResponse();
        return ResponseEntity.of(Optional.of(response.artworkToArtworkResponse(artworkService.findById(id).get())));
    }



    @DeleteMapping
    public ResponseEntity<?> delete(@PathVariable UUID id) {

        artworkRepository.deleteById(id);

        return ResponseEntity.noContent().build();

    }

}

