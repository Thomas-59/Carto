package fr.univ.carto.service.bo;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class EstablishmentBo {
    private Long id;

    private String name;

    private String cityName;

    private Double longitude;

    private Double latitude;

    private String description;
}
