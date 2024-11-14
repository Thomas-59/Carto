package fr.univ.carto.repository.entity.schedule;

import jakarta.persistence.Embeddable;
import jakarta.persistence.EmbeddedId;
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
    private Long idEstablishment;
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private DayOfTheWeek dayOfTheWeek;
}
