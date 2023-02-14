package com.salesianostriana.dam.flalleryapi.controllers;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
import com.salesianostriana.dam.flalleryapi.models.Comment;
import com.salesianostriana.dam.flalleryapi.models.User;
import com.salesianostriana.dam.flalleryapi.models.dtos.artwork.ArtworkResponse;
import com.salesianostriana.dam.flalleryapi.models.dtos.comment.CommentCreateRequest;
import com.salesianostriana.dam.flalleryapi.services.ArtworkService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.Optional;
import java.util.UUID;

@RequiredArgsConstructor
@RestController
public class CommentController {

    private final ArtworkService artworkService;

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
               .status(HttpStatus.CREATED)
               .body(new ArtworkResponse()
                       .artworkToArtworkResponse(artworkService.deleteComment(idComment,id,user.getUsername())));

    }

}
