package fr.univ.carto.repository.entity.schedule;

import fr.univ.carto.repository.entity.EstablishmentEntity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.time.LocalTime;

@Getter
@Setter
@Entity
@Table(name = "schedule")
public class ScheduleEntity {
    @ManyToOne
    @JoinColumn(name = "idestablishment", insertable = false, updatable = false)
    private EstablishmentEntity establishmentEntity;

    @EmbeddedId
    private ScheduleEmbeddedId scheduleEmbeddedId = new ScheduleEmbeddedId();

    @Column(name = "openingtime")
    private LocalTime openingTime;

    @Column(name = "closingtime")
    private LocalTime closingTime;

    @Column(name = "isclosed")
    private boolean isClosed;
}