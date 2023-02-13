package com.salesianostriana.dam.flalleryapi.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;


@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Likes {

    private String user;

    @Id
    private Long id;
    @ManyToOne
    @JoinColumn(name = "likedArtwork",
            foreignKey = @ForeignKey(name="LIKEDARTWORK_ID_FK"))
    private Artwork likedArtwork;
}
