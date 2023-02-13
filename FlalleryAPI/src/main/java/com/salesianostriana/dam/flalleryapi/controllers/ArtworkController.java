package com.salesianostriana.dam.flalleryapi.controllers;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
import com.salesianostriana.dam.flalleryapi.models.dtos.PageDto;
import com.salesianostriana.dam.flalleryapi.search.util.SearchCriteria;
import com.salesianostriana.dam.flalleryapi.search.util.SearchCriteriaExtractor;
import com.salesianostriana.dam.flalleryapi.services.ArtworkService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@RestController
@RequiredArgsConstructor
public class ArtworkController {

    private final ArtworkService artworkService;
    @GetMapping("/product")
    public ResponseEntity<PageDto> search(
            @RequestParam(value = "s", defaultValue = "") String s,
            @PageableDefault(size = 25, page = 0) Pageable pageable) {

        List<SearchCriteria> params = SearchCriteriaExtractor.extractSearchCriteriaList(s);


        Page<Artwork> result = artworkService.search(params, pageable);


        if ( result.isEmpty())
            return ResponseEntity.notFound().build();

        return ResponseEntity.ok(new PageDto(result));
    }

}

