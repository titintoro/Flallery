package com.salesianostriana.dam.flalleryapi.models;

import lombok.*;

import javax.persistence.*;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name="artwork_category")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@NamedEntityGraph(name = "ArtworkCategory.artwork", attributeNodes = {
        @NamedAttributeNode("artworkList")
})
public class ArtworkCategory {

    @GeneratedValue
    @Id
    private Long idCategory;

    @OneToMany(mappedBy = "category", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<Artwork> artworkList;

    private String name;

    @PreRemove
    private void setCategorySinCategoria(){

        ArtworkCategory ac = ArtworkCategory.builder()
                .idCategory(1L)
                .name("Sin categoria")
                .build();

        for (Artwork a: artworkList) {
            a.setCategory(ac);
        };
    }
}
