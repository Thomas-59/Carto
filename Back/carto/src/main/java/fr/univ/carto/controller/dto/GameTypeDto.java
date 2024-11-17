package fr.univ.carto.controller.dto;

import fr.univ.carto.repository.entity.establishmentgames.GameType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
@AllArgsConstructor
public class GameTypeDto {
    private GameType gameType;
    private int numberOfGame;
}
