package fr.univ.carto.repository.entity.schedule;

import fr.univ.carto.repository.entity.EstablishmentEntity;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.io.Serializable;

@Getter
@Setter
@Embeddable
public class ScheduleEmbeddedId implements Serializable {
    @ManyToOne
    @JoinColumn(name = "idestablishment")
    private EstablishmentEntity idEstablishment;
    @Column(name = "dayofweek")
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private DayOfTheWeek dayofweek;
}
