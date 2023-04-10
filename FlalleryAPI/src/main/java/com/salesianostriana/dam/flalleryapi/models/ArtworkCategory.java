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
public class ArtworkCategory {

    @GeneratedValue
    @Id
    private Long idCategory;

    @OneToMany
    private List<Artwork> artworkList;

    private String name;
}
