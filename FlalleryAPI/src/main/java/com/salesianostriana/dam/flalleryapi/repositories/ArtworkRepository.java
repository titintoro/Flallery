package com.salesianostriana.dam.flalleryapi.repositories;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
import com.salesianostriana.dam.flalleryapi.models.Comment;
import com.salesianostriana.dam.flalleryapi.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ArtworkRepository extends JpaRepository<Artwork, UUID>, JpaSpecificationExecutor<Artwork> {

    Optional<Artwork> findFirstByName(String name);

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
