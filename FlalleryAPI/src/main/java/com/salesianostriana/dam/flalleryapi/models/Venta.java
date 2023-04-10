package com.salesianostriana.dam.flalleryapi.models;
import lombok.*;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name="venta")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Venta {

    @GeneratedValue
    @Id
    private Long idVenta;

    @OneToOne
    private Artwork artwork;

    private double precio;
    private Date fechaVenta;

    private String usernameComprador;

    private String usernameVendedor;
}
