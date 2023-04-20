package com.salesianostriana.dam.flalleryapi.models;

import lombok.*;
import org.hibernate.annotations.GenericGenerator;

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
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
            name = "UUID",
            strategy = "org.hibernate.id.UUIDGenerator",
            parameters = {
                    @org.hibernate.annotations.Parameter(
                            name = "uuid_gen_strategy_class",
                            value = "org.hibernate.id.uuid.CustomVersionOneStrategy"
                    )
            }
    )
    @Column(columnDefinition = "uuid")
    private UUID idArtwork;

    private String name;

    private String imgUrl;

    private String description;
    @OneToMany(mappedBy = "artwork", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<Comment> comments = new ArrayList<>();

    private String owner;

    @OneToMany(mappedBy = "lovedArtwork", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @Builder.Default
    private Set<Loved> usersThatLiked = new HashSet<>();

    @ManyToOne
    @JoinColumn(name = "category",
            foreignKey = @ForeignKey(name="CATEGORY_ID_FK"))
    private ArtworkCategory category;

    @OneToOne
    @JoinColumn(name = "venta",
            foreignKey = @ForeignKey(name="VENTA_ID_FK"))
    private Venta venta;

    private boolean disponibleParaComprar;


    @PreRemove
    public void deleteCommentFromArtwork(){

    }
}
