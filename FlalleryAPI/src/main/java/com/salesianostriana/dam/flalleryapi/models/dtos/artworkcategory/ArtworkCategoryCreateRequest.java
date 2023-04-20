package com.salesianostriana.dam.flalleryapi.models.dtos.artworkcategory;

import com.salesianostriana.dam.flalleryapi.models.ArtworkCategory;
import lombok.*;

import javax.validation.constraints.NotEmpty;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ArtworkCategoryCreateRequest {

    @NotEmpty(message = "{artworkCategoryCreateRequest.name.notempty}")
    private String name;

    public ArtworkCategory artworkCategoryCreateRequestToArtworkCategory () {
        return ArtworkCategory
                .builder()
                .name(this.name)
                .build();
    }
}
