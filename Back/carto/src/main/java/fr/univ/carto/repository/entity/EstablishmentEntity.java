package fr.univ.carto.repository.entity;

import fr.univ.carto.service.bo.EstablishmentBo;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "establishment")
public class EstablishmentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String name;

    private String cityname;

    private Double longitude;

    private Double latitude;

    private String description;

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
