package com.salesianostriana.dam.flalleryapi.models;

import lombok.*;

import javax.persistence.*;
import java.util.UUID;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Comment {

    @Id
    private UUID idComment;

    @ManyToOne
    @JoinColumn(name = "artwork",
            foreignKey = @ForeignKey(name="ARTWORK_ID_FK"))
    private Artwork artwork;
}
