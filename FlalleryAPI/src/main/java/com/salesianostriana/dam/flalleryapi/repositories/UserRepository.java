package com.salesianostriana.dam.flalleryapi.repositories;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
import com.salesianostriana.dam.flalleryapi.models.Comment;
import com.salesianostriana.dam.flalleryapi.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserRepository extends JpaRepository<User, UUID>, JpaSpecificationExecutor<User> {

    Optional<User> findFirstByUsername(String username);

    boolean existsByUsername(String username);
    @Query("""
            SELECT l.lovedArtwork FROM Loved l WHERE l.user = :userName
            """)
    List<Artwork> findArtworksLikedByUser(String userName);

    @Query("""
            SELECT c FROM Comment c WHERE c.writer = :userName
            """)
    List<Comment> findAllCommentsOfAUser(String userName);


}
