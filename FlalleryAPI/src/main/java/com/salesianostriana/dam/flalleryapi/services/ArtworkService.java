package com.salesianostriana.dam.flalleryapi.services;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
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

    public Page<Artwork> search(List<SearchCriteria> params, Pageable pageable) {

        ArtworkSpecificationBuilder artworkSpecificationBuilder =
                new ArtworkSpecificationBuilder(params);

        Specification<Artwork> spec =  artworkSpecificationBuilder.build();
        return repo.findAll(spec, pageable);
    }

}
