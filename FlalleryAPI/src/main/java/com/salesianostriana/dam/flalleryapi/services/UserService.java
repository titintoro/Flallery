package com.salesianostriana.dam.flalleryapi.services;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
import com.salesianostriana.dam.flalleryapi.models.Comment;
import com.salesianostriana.dam.flalleryapi.models.dtos.user.CreateUserRequest;
import lombok.RequiredArgsConstructor;
import com.salesianostriana.dam.flalleryapi.models.User;
import com.salesianostriana.dam.flalleryapi.models.UserRole;
import com.salesianostriana.dam.flalleryapi.repositories.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.EnumSet;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UserService {

    private final PasswordEncoder passwordEncoder;
    private final UserRepository userRepository;

    public User createUser(CreateUserRequest createUserRequest, EnumSet<UserRole> roles) {
        User user =  User.builder()
                .username(createUserRequest.getUsername())
                .password(passwordEncoder.encode(createUserRequest.getPassword()))
                .avatar(createUserRequest.getAvatar())
                .fullName(createUserRequest.getFullName())
                .roles(roles)
                .build();

        return userRepository.save(user);
    }

    public User createUserWithUserRole(CreateUserRequest createUserRequest) {
        return createUser(createUserRequest, EnumSet.of(UserRole.USER));
    }

    public User createUserWithAdminRole(CreateUserRequest createUserRequest) {
        return createUser(createUserRequest, EnumSet.of(UserRole.ADMIN));
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public Optional<User> findById(UUID id) {
        return userRepository.findById(id);
    }


    public Optional<User> findByUsername(String username) {
        return userRepository.findFirstByUsername(username);
    }


    public List<Artwork> findArtworksLikedByUser (String userName){ return userRepository.findArtworksLikedByUser(userName);}


    public List<Artwork> findArtworksOfAUser (String userName){return userRepository.findArtworksOfAUser(userName);}


    public List<Comment> findAllCommentsOfAUser (String userName) { return userRepository.findAllCommentsOfAUser(userName);}


    public void deleteArtworksOfAUSer(String owner) { userRepository.deleteArtworksOfAUSer(owner);}


    public void deleteCommentsOfAUSer(String owner) { userRepository.deleteCommentsOfAUSer(owner);}


    public Optional<User> edit(User user) {

        // El username no se puede editar
        // La contraseña se edita en otro método

        return userRepository.findById(user.getId())
                .map(u -> {
                    u.setAvatar(user.getAvatar());
                    u.setFullName(user.getFullName());
                    return userRepository.save(u);
                }).or(() -> Optional.empty());

    }

    public Optional<User> editPassword(UUID userId, String newPassword) {

        // Aquí no se realizan comprobaciones de seguridad. Tan solo se modifica

        return userRepository.findById(userId)
                .map(u -> {
                    u.setPassword(passwordEncoder.encode(newPassword));
                    return userRepository.save(u);
                }).or(() -> Optional.empty());

    }

    public void delete(User user) { userRepository.deleteById(user.getId());}


    public void deleteById(UUID id, String name) {
        // Prevenimos errores al intentar borrar algo que no existe
        if (userRepository.existsById(id)) {
            userRepository.deleteCommentsOfAUSer(name);
            userRepository.deleteArtworksOfAUSer(name);
            userRepository.deleteById(id);
        }
    }


    public boolean userExists(String username) {
        return userRepository.existsByUsername(username);
    }


    public boolean passwordMatch(User user, String clearPassword) {
        return passwordEncoder.matches(clearPassword, user.getPassword());
    }


}

