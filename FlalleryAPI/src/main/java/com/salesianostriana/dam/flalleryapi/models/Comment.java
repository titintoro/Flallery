package com.salesianostriana.dam.flalleryapi.models;

import com.salesianostriana.dam.flalleryapi.repositories.ArtworkRepository;
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
@NamedEntityGraph(name = "Comment.artwork", attributeNodes = @NamedAttributeNode("artwork"))
public class Comment {

    @Id
    @GeneratedValue
    private Long idComment;

    private String text;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "artwork",
            foreignKey = @ForeignKey(name="ARTWORK_ID_FK"))
    private Artwork artwork;

    private String writer;

    @PreRemove
    public void deleteCommentFromArtwork(){
        artwork.getComments().remove(this);
    }
}
