package fr.univ.carto.repository.entity.establishmentgames;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalTime;

@Getter
@Setter
@Entity
@Table(name = "establishment_games")
public class EstablishmentGamesEntity {
    @EmbeddedId
    private EstablishmentEmbeddedId establishmentEmbeddedId;
    private int numberOfGame;
    private LocalTime openingTime;
    private LocalTime closingTime;
}
