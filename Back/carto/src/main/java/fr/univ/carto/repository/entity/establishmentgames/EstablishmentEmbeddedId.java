package fr.univ.carto.repository.entity.establishmentgames;

import jakarta.persistence.Embeddable;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

@Getter
@Setter
@Embeddable
@EqualsAndHashCode
@RequiredArgsConstructor
@NoArgsConstructor
public class EstablishmentEmbeddedId {
    private Long idEstablishment;
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private GameType game_type;
}
