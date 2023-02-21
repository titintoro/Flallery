package com.salesianostriana.dam.flalleryapi.controllers;

import com.salesianostriana.dam.flalleryapi.models.Artwork;
import com.salesianostriana.dam.flalleryapi.models.Comment;
import com.salesianostriana.dam.flalleryapi.models.UserRole;
import com.salesianostriana.dam.flalleryapi.models.dtos.PageDto;
import com.salesianostriana.dam.flalleryapi.models.dtos.artwork.ArtworkResponse;
import com.salesianostriana.dam.flalleryapi.models.dtos.comment.CommentResponse;
import com.salesianostriana.dam.flalleryapi.models.dtos.user.*;
import com.salesianostriana.dam.flalleryapi.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import com.salesianostriana.dam.flalleryapi.security.jwt.access.JwtProvider;
import com.salesianostriana.dam.flalleryapi.security.jwt.refresh.RefreshToken;
import com.salesianostriana.dam.flalleryapi.security.jwt.refresh.RefreshTokenException;
import com.salesianostriana.dam.flalleryapi.security.jwt.refresh.RefreshTokenRequest;
import com.salesianostriana.dam.flalleryapi.security.jwt.refresh.RefreshTokenService;
import com.salesianostriana.dam.flalleryapi.models.User;
import com.salesianostriana.dam.flalleryapi.services.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import javax.validation.Valid;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final AuthenticationManager authManager;
    private final JwtProvider jwtProvider;
    private final RefreshTokenService refreshTokenService;
    private final UserRepository userRepository;


    @PostMapping("/auth/register")
    public ResponseEntity<UserResponse> createUserWithUserRole(@Valid @RequestBody CreateUserRequest createUserRequest) {
        User user = userService.createUserWithUserRole(createUserRequest);

        return ResponseEntity.status(HttpStatus.CREATED).body(UserResponse.fromUser(user));
    }

    @PostMapping("/auth/register/admin")
    public ResponseEntity<UserResponse> createUserWithAdminRole(@RequestBody CreateUserRequest createUserRequest) {
        User user = userService.createUserWithAdminRole(createUserRequest);

        return ResponseEntity.status(HttpStatus.CREATED).body(UserResponse.fromUser(user));
    }


    @PostMapping("/auth/login")
    public ResponseEntity<JwtUserResponse> login(@RequestBody LoginRequest loginRequest) {

        // Realizamos la autenticación

        Authentication authentication =
                authManager.authenticate(
                        new UsernamePasswordAuthenticationToken(
                                loginRequest.getUsername(),
                                loginRequest.getPassword()
                        )
                );

        // Una vez realizada, la guardamos en el contexto de seguridad
        SecurityContextHolder.getContext().setAuthentication(authentication);

        // Devolvemos una respuesta adecuada
        String token = jwtProvider.generateToken(authentication);

        User user = (User) authentication.getPrincipal();

        // Eliminamos el token (si existe) antes de crearlo, ya que cada usuario debería tener solamente un token de refresco simultáneo
        refreshTokenService.deleteByUser(user);
        RefreshToken refreshToken = refreshTokenService.createRefreshToken(user);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(JwtUserResponse.of(user, token, refreshToken.getToken()));


    }

    @PostMapping("/refreshtoken")
    public ResponseEntity<?> refreshToken(@RequestBody RefreshTokenRequest refreshTokenRequest) {
        String refreshToken = refreshTokenRequest.getRefreshToken();

        return refreshTokenService.findByToken(refreshToken)
                .map(refreshTokenService::verify)
                .map(RefreshToken::getUser)
                .map(user -> {
                    String token = jwtProvider.generateToken(user);
                    refreshTokenService.deleteByUser(user);
                    RefreshToken refreshToken2 = refreshTokenService.createRefreshToken(user);
                    return ResponseEntity.status(HttpStatus.CREATED)
                            .body(JwtUserResponse.builder()
                                    .token(token)
                                    .refreshToken(refreshToken2.getToken())
                                    .build());
                })
                .orElseThrow(() -> new RefreshTokenException("Refresh token not found"));

    }

    @GetMapping("/user/artwork/like")
    public ResponseEntity<List<ArtworkResponse>> getAllLikedArtworksOfAUser(
            @AuthenticationPrincipal User user){


        List<Artwork> result = userService.findArtworksLikedByUser(user.getUsername());

        List<ArtworkResponse> response = result.stream().map(ArtworkResponse::artworkToArtworkResponse).toList();


        if (response.isEmpty())
            return ResponseEntity.notFound().build();

        return ResponseEntity.ok(response);

    }


    @GetMapping("/user/artwork")
    public ResponseEntity<List<ArtworkResponse>> getAllArtworksOfAUser(
            @AuthenticationPrincipal User user){


        List<Artwork> result = userService.findArtworksOfAUser(user.getUsername());

        List<ArtworkResponse> response = result.stream().map(ArtworkResponse::artworkToArtworkResponse).toList();


        if (response.isEmpty())
            return ResponseEntity.notFound().build();

        return ResponseEntity.ok(response);

    }


    @GetMapping("/user/comment")
    public ResponseEntity<List<CommentResponse>> getAllCommentsOfAUser(
            @AuthenticationPrincipal User user) {

        List<Comment> result = userService.findAllCommentsOfAUser(user.getUsername());

        List<CommentResponse> response = result.stream().map(CommentResponse::commentToCommentResponse).toList();


        if (response.isEmpty())
            return ResponseEntity.notFound().build();

        return ResponseEntity.ok(response);
    }


    @PutMapping("/user/changePassword")
    public ResponseEntity<UserResponse> changePassword(@RequestBody ChangePasswordRequest changePasswordRequest,
                                                       @AuthenticationPrincipal User loggedUser) {

        // Este código es mejorable.
        // La validación de la contraseña nueva se puede hacer con un validador.
        // La gestión de errores se puede hacer con excepciones propias
        try {
            if (userService.passwordMatch(loggedUser, changePasswordRequest.getOldPassword())) {
                Optional<User> modified = userService.editPassword(loggedUser.getId(), changePasswordRequest.getNewPassword());
                if (modified.isPresent())
                    return ResponseEntity.ok(UserResponse.fromUser(modified.get()));
            } else {
                // Lo ideal es que esto se gestionara de forma centralizada
                // Se puede ver cómo hacerlo en la formación sobre Validación con Spring Boot
                // y la formación sobre Gestión de Errores con Spring Boot
                throw new RuntimeException();
            }
        } catch (RuntimeException ex) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Password Data Error");
        }

        return null;
    }

    @DeleteMapping("/user/{id}")
    public ResponseEntity<?> deleteMyUser(@AuthenticationPrincipal User user, @RequestParam UUID id){

            Optional<User> userUtil = userService.findById(id);
            if (userUtil.isPresent()) {
                User userResponse = userUtil.get();

                if (userResponse.getPassword().equals(user.getPassword()))
                    userService.deleteById(id, user.getUsername());
        }

        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @GetMapping("/me")
    public UserResponse getMyUser(@AuthenticationPrincipal User user){
       return UserResponse.fromUser(user);
    }

    @DeleteMapping("auth/user/{id}")
    public ResponseEntity<?> deleteOtherUser(@AuthenticationPrincipal User user, @RequestParam UUID id){
        if (user.getRoles().contains(UserRole.ADMIN)){
            userService.deleteById(id, user.getUsername());
        }
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

}
