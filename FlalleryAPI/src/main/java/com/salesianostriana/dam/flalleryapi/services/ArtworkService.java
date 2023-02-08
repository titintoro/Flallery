package com.salesianostriana.dam.flalleryapi.services;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
import com.salesianostriana.dam.flalleryapi.repositories.ArtworkRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ArtworkService {

    private final ArtworkRepository repo;

    public Artwork add(Artwork artwork) {
        return repo.save(artwork);
    }

    public Optional<Artwork> findById(String name) {
        return repo.findFirstByName(name);
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


}
