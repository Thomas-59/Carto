package fr.univ.carto.repository.entity.establishmentgames;

import fr.univ.carto.repository.entity.EstablishmentEntity;
import jakarta.persistence.Embeddable;
import jakarta.persistence.ManyToOne;
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
    @ManyToOne
    private EstablishmentEntity idEstablishment;
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private GameType game_type;
}
