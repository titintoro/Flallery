package com.salesianostriana.dam.flalleryapi.repositories;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface ArtworkRepository extends JpaRepository<Artwork, UUID>, JpaSpecificationExecutor<Artwork> {

    Optional<Artwork> findFirstByName(String name);

}
