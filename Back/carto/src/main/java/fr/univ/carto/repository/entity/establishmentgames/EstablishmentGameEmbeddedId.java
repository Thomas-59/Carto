package fr.univ.carto.repository.entity.establishmentgames;

import fr.univ.carto.repository.entity.EstablishmentEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.ManyToOne;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.io.Serializable;

@Getter
@Setter
@Embeddable
@EqualsAndHashCode
@NoArgsConstructor
public class EstablishmentGameEmbeddedId implements Serializable {
    @Column(name = "idestablishment")
    private Long establishmentId;
    @Column(name = "game")
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private GameType gameType;
}
