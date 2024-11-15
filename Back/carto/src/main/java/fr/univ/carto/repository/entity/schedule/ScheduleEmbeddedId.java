package fr.univ.carto.repository.entity.schedule;

import fr.univ.carto.repository.entity.EstablishmentEntity;
import jakarta.persistence.Embeddable;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

@Getter
@Setter
@Embeddable
@EqualsAndHashCode
@RequiredArgsConstructor
@NoArgsConstructor
public class ScheduleEmbeddedId {
    @ManyToOne
    private EstablishmentEntity idEstablishment;
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private DayOfTheWeek dayOfTheWeek;
}
