package com.salesianostriana.dam.flalleryapi.models;

import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;
import javax.persistence.*;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name="comment")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Comment {

    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
            name = "UUID",
            strategy = "org.hibernate.id.UUIDGenerator",
            parameters = {
                    @Parameter(
                            name = "uuid_gen_strategy_class",
                            value = "org.hibernate.id.uuid.CustomVersionOneStrategy"
                    )
            }
    )
    @Column(columnDefinition = "uuid")
    private UUID idComment;

    @ManyToOne
    @JoinColumn(name = "artwork",
            foreignKey = @ForeignKey(name="ARTWORK_ID_FK"))
    private Artwork artwork;

    private String writer;
}
