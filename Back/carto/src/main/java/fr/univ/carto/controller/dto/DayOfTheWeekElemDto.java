package fr.univ.carto.controller.dto;

import fr.univ.carto.repository.entity.schedule.DayOfTheWeek;
import lombok.*;

import java.time.LocalTime;
@Getter
@Setter
@Builder
@AllArgsConstructor
public class DayOfTheWeekElemDto {
    private DayOfTheWeek dayOfTheWeek;
    private LocalTime openingTime;
    private LocalTime closingTime;
    private Boolean isClosed;
}
