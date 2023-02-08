package com.salesianostriana.dam.flalleryapi.models;

import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class Artwork {

    @Id
    private UUID idArtwork;

    private String name;

    @OneToMany(mappedBy = "artwork", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<Comment> comments = new ArrayList<>();

    private int likes;
}
