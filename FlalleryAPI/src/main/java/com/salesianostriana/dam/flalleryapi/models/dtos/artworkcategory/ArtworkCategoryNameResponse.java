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
public class ArtworkCategoryNameResponse {

    private String name;

    public static ArtworkCategoryNameResponse artworkCategoryToArtworkCategoryNameResponse(ArtworkCategory artworkCategory) {

        return ArtworkCategoryNameResponse.builder().name(artworkCategory.getName()).build();

    }

}
