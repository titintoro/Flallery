package com.salesianostriana.dam.flalleryapi.models.dtos.artworkcategory;

import com.salesianostriana.dam.flalleryapi.models.ArtworkCategory;
import com.salesianostriana.dam.flalleryapi.models.dtos.artwork.ArtworkResponse;
import lombok.*;

import java.util.List;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ArtworkCategoryResponse {

    private String name;

    private List<ArtworkResponse> artworkResponseList;

    public static ArtworkCategoryResponse artworkCategoryToArtworkCategoryResponse(ArtworkCategory artworkCategory){

        return ArtworkCategoryResponse.builder()
                .name(artworkCategory.getName())
                .artworkResponseList(artworkCategory.getArtworkList()
                        .stream()
                        .map(ArtworkResponse::artworkToArtworkResponse)
                        .toList())
                .build();
    }

}
