package com.salesianostriana.dam.flalleryapi.models.dtos.artwork;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
import com.salesianostriana.dam.flalleryapi.models.Comment;
import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ArtworkResponse {

    private String name;

    private List<Comment> comments;

    private String owner;

    private String description;
    public ArtworkResponse artworkToArtworkResponse(Artwork artwork){

        return ArtworkResponse.builder()
                .name(artwork.getName())
                .owner(artwork.getName())
                .description(artwork.getDescription())
                .comments(artwork.getComments())
                .build();
    }
}
