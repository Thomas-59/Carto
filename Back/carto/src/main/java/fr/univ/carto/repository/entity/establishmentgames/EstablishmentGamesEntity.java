package fr.univ.carto.repository.entity.establishmentgames;

import fr.univ.carto.repository.entity.EstablishmentEntity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalTime;

@Getter
@Setter
@Entity
@Table(name = "establishment_games")
public class EstablishmentGamesEntity {
    @EmbeddedId
    private EstablishmentGameEmbeddedId establishmentGameEmbeddedId = new EstablishmentGameEmbeddedId();

    @ManyToOne
    @JoinColumn(name = "idestablishment", insertable = false, updatable = false)
    private EstablishmentEntity establishmentEntity;
    @Column(name = "numberofgame")
    private int numberOfGame;
}


