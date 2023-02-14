package com.salesianostriana.dam.flalleryapi.services;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
import com.salesianostriana.dam.flalleryapi.models.Comment;
import com.salesianostriana.dam.flalleryapi.models.Loved;
import com.salesianostriana.dam.flalleryapi.repositories.ArtworkRepository;
import com.salesianostriana.dam.flalleryapi.search.spec.ArtworkSpecificationBuilder;
import com.salesianostriana.dam.flalleryapi.search.util.SearchCriteria;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ArtworkService {

    private final ArtworkRepository repo;

    public Artwork add(Artwork artwork) {
        return repo.save(artwork);
    }

    public Optional<Artwork> findById(UUID uuid) {
        return repo.findById(uuid);
    }

    public List<Artwork> findAll() {
        return repo.findAll();
    }

    public Artwork edit(Artwork artwork) {
        return repo.save(artwork);
    }

    public void delete(Artwork artwork) {
        repo.delete(artwork);
    }

    public Page<Artwork> search(List<SearchCriteria> params, Pageable pageable) {

        ArtworkSpecificationBuilder artworkSpecificationBuilder =
                new ArtworkSpecificationBuilder(params);

        Specification<Artwork> spec =  artworkSpecificationBuilder.build();
        return repo.findAll(spec, pageable);
    }

    public Artwork addComment(Comment c, UUID uuid) {
       Artwork response = repo.findById(uuid).get();
       response.getComments().add(c);

       return repo.save(response);
    }

    public Artwork deleteComment(UUID idComment, UUID idArtwork, String writer){

        Artwork response = repo.findById(idArtwork).get();

        response.getComments().removeIf(comment -> comment.getIdComment().equals(idComment) && comment.getWriter().equals(writer));

        return repo.save(response);
    }


    public Artwork likeArtwork(UUID idArtwork, String liker){

        Artwork response = repo.findById(idArtwork).get();

        response.getUsersThatLiked().add(Loved.builder().lovedArtwork(response).lover(liker).build())

        return repo.save(response);;

    }

    public Artwork unlike(UUID idArtwork, String unliker ){
        Artwork response = repo.findById(idArtwork).get();
        response.getUsersThatLiked().removeIf(like-> like.getLover().equals(unliker));

        return repo.save(response);
    }

}
