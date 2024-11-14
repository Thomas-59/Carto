package fr.univ.carto.repository.entity.schedule;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalTime;

@Getter
@Setter
@Entity
@Table(name = "Schedule")
public class ScheduleEntity {
    @EmbeddedId
    private ScheduleEmbeddedId scheduleEmbeddedId;
    private LocalTime openingTime;
    private LocalTime closingTime;
    private boolean isClosed;
}
