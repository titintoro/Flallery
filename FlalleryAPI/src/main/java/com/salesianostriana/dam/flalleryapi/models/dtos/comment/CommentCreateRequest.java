package com.salesianostriana.dam.flalleryapi.models.dtos.comment;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
import com.salesianostriana.dam.flalleryapi.models.Comment;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import javax.persistence.*;
import java.util.UUID;


@Getter
@Setter
@Builder
public class CommentCreateRequest {

    private String text;


    public Comment commentCreateRequestToComment(Artwork artwork, String writer){

        return Comment.builder()
                .artwork(artwork)
                .writer(writer)
                .text(text)
                .build();
    }

}
