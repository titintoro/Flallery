package com.salesianostriana.dam.flalleryapi.controllers;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
import com.salesianostriana.dam.flalleryapi.models.Comment;
import com.salesianostriana.dam.flalleryapi.models.User;
import com.salesianostriana.dam.flalleryapi.models.dtos.artwork.ArtworkCreateRequest;
import com.salesianostriana.dam.flalleryapi.models.dtos.artwork.ArtworkResponse;
import com.salesianostriana.dam.flalleryapi.models.dtos.PageDto;
import com.salesianostriana.dam.flalleryapi.models.dtos.comment.CommentCreateRequest;
import com.salesianostriana.dam.flalleryapi.repositories.ArtworkRepository;
import com.salesianostriana.dam.flalleryapi.search.util.SearchCriteria;
import com.salesianostriana.dam.flalleryapi.search.util.SearchCriteriaExtractor;
import com.salesianostriana.dam.flalleryapi.services.ArtworkService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;
import java.util.Optional;
import java.util.UUID;


@RestController
@RequiredArgsConstructor
public class ArtworkController {

    private final ArtworkService artworkService;
    private final ArtworkRepository artworkRepository;

    @GetMapping("/artwork")
    public ResponseEntity<PageDto<Artwork>> search(
            @RequestParam(value = "s", defaultValue = "") String s,
            @PageableDefault(size = 25, page = 0) Pageable pageable) {

        List<SearchCriteria> params = SearchCriteriaExtractor.extractSearchCriteriaList(s);


        Page<Artwork> result = artworkService.search(params, pageable);


        if (result.isEmpty())
            return ResponseEntity.notFound().build();

        return ResponseEntity.ok(new PageDto<Artwork>(result));
    }

    @GetMapping("/artwork/{id}")
    public ResponseEntity<ArtworkResponse> getArtwork(@PathVariable UUID id){

        ArtworkResponse response = new ArtworkResponse();
        return ResponseEntity.of(Optional.of(response.artworkToArtworkResponse(artworkService.findById(id).get())));
    }


    @PostMapping("/artwork")
    public ResponseEntity<ArtworkResponse>createArtwork(
            @RequestBody ArtworkCreateRequest artworkCreateRequest,
            @AuthenticationPrincipal User user){

        Artwork artwork = artworkService.add(artworkCreateRequest.ArtworkCreateRequestToArtwork(user.getFullName()));

        URI createdURI = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(artwork.getIdArtwork()).toUri();

        return ResponseEntity
                .created(createdURI)
                .body(new ArtworkResponse().artworkToArtworkResponse(artwork));
    }

    @DeleteMapping("/artwork")
    public ResponseEntity<?> delete(
            @PathVariable UUID id,
            @AuthenticationPrincipal User user) {

        Artwork artwork = artworkService.findById(id).get();
        artworkService.delete(artwork , user.getUsername());

        return ResponseEntity.noContent().build();

    }

    @PostMapping("/artwork/{id}/like")
    public ResponseEntity<ArtworkResponse> likeArtwork(
            @PathVariable UUID id,
            @AuthenticationPrincipal User user){

        Artwork artwork = artworkService.likeArtwork(id,user.getUsername());


        URI createdURI = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/artwork/{id}/like")
                .buildAndExpand(artwork.getIdArtwork()).toUri();

        return ResponseEntity
                .created(createdURI)
                .body(new ArtworkResponse().artworkToArtworkResponse(artwork));

    }


    @DeleteMapping("/artwork/{id}/like")
    public ResponseEntity<ArtworkResponse> deleteLike(
            @PathVariable UUID idArtwork,
            @AuthenticationPrincipal User user){

        return ResponseEntity
                .status(HttpStatus.NO_CONTENT)
                .body(new ArtworkResponse()
                        .artworkToArtworkResponse(artworkService.unlike(idArtwork,user.getUsername())));

    }


    @PostMapping("/artwork/{id}/comment")
    public ResponseEntity<Comment> addComment(
            @PathVariable UUID id,
            @RequestBody CommentCreateRequest comment,
            @AuthenticationPrincipal User user){

        Artwork artwork = artworkService.findById(id).get();

        Comment response = comment.commentCreateRequestToComment(artwork,user.getUsername());

        URI createdURI = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/artwork/{id}/comment")
                .buildAndExpand(response.getIdComment()).toUri();

        return ResponseEntity
                .created(createdURI)
                .body(response);

    }


    @DeleteMapping("/artwork/{id}/comment/{idComment}")
    public ResponseEntity<ArtworkResponse> deleteComment(@PathVariable UUID id, UUID idComment, @AuthenticationPrincipal User user){

        return ResponseEntity
                .status(HttpStatus.NO_CONTENT)
                .body(new ArtworkResponse()
                        .artworkToArtworkResponse(artworkService.deleteComment(idComment,id,user.getUsername())));

    }

}

