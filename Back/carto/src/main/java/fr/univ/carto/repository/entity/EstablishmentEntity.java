package fr.univ.carto.repository.entity;

import fr.univ.carto.repository.entity.establishmentgames.EstablishmentGamesEntity;
import fr.univ.carto.service.bo.EstablishmentBo;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.sql.SQLType;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "establishment")
public class EstablishmentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "establishment_generator")
    @SequenceGenerator(name = "establishment_generator", sequenceName = "establishment_seq", allocationSize = 1)
    private Long id;

    private String name;

    private String cityname;

    private Double longitude;

    private Double latitude;

    private String address;

    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private String price;

    @OneToMany
    private List<EstablishmentGamesEntity> establishmentGamesEntities;


    public EstablishmentBo toBo(){
        return EstablishmentBo.builder()
                .id(id)
                .cityName(cityname)
                .description(description)
                .name(name)
                .latitude(latitude)
                .longitude(longitude)
                .build();
    }

    public static EstablishmentEntity fromBo(EstablishmentBo establishmentBo){
        EstablishmentEntity establishmentEntity = new EstablishmentEntity();
        establishmentEntity.setId(establishmentBo.getId());
        establishmentEntity.setName(establishmentBo.getName());
        establishmentEntity.setLatitude(establishmentBo.getLatitude());
        establishmentEntity.setLongitude(establishmentBo.getLongitude());
        establishmentEntity.setCityname(establishmentBo.getCityName());
        establishmentEntity.setDescription(establishmentBo.getDescription());
        return establishmentEntity;
    }
}
