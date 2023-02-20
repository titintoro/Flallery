package com.salesianostriana.dam.flalleryapi.models.dtos.artwork;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
import com.salesianostriana.dam.flalleryapi.models.Comment;
import com.salesianostriana.dam.flalleryapi.models.Loved;
import lombok.*;

import javax.persistence.CascadeType;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotEmpty;
import java.util.*;


@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ArtworkCreateRequest {

    @NotEmpty(message = "{artworkCreateRequest.name.notempty}")
    private String name;
    private String description;


    public Artwork ArtworkCreateRequestToArtwork(String ownerName, String imgUrl) {
        return Artwork.builder()
                .owner(ownerName)
                .name(this.name)
                .imgUrl(imgUrl)
                .comments(new ArrayList<>())
                .usersThatLiked(new HashSet<>())
                .description(this.description)
                .build();
    }

}
