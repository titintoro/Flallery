package com.salesianostriana.dam.flalleryapi.models;

import lombok.*;

import javax.persistence.*;
import java.util.*;

@Getter
@Setter
@Entity
@Table(name="artwork")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Artwork {

    @Id
    private UUID idArtwork;

    private String name;

    private String description;
    @OneToMany(mappedBy = "artwork", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<Comment> comments = new ArrayList<>();

    private String owner;

    @OneToMany(mappedBy = "lovedArtwork", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @Builder.Default
    private Set<Loved> usersThatLiked = new HashSet<>();

}
