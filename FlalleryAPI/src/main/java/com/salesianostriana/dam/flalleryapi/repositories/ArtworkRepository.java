package com.salesianostriana.dam.flalleryapi.repositories;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
import com.salesianostriana.dam.flalleryapi.models.Comment;
import com.salesianostriana.dam.flalleryapi.models.User;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ArtworkRepository extends JpaRepository<Artwork, UUID>, JpaSpecificationExecutor<Artwork> {

    Optional<Artwork> findFirstByName(String name);

    @EntityGraph(value = "Artwork.commentsAndLoved", type = EntityGraph.EntityGraphType.LOAD)
    Optional<Artwork> findByIdArtwork(Long id);

    @Query("""
            SELECT u FROM User u JOIN Loved l on u.username=l.lover WHERE l.lovedArtwork.name = :artworkName
            """)
    List<User> findUsersWhoLikedArtwork(String artworkName);


    @Modifying
    @Query("delete from Comment c where c.artwork.name=:artworkName")
    void deleteCommentsOfAnArtwork(String artworkName);


    @Modifying
    @Query("delete from Loved l where l.lovedArtwork.name=:artworkName")
    void deleteLovesOfAnArtwork(String artworkName);



}
