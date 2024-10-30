package fr.univ.carto.controller.dto;

import fr.univ.carto.service.bo.EstablishmentBo;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class EstablishmentDto {
    private Long id;

    private String name;

    private String cityName;

    private Double longitude;

    private Double latitude;

    private String description;

    public static EstablishmentDto fromBo(EstablishmentBo establishmentBo){
        return EstablishmentDto.builder()
                .id(establishmentBo.getId())
                .cityName(establishmentBo.getCityName())
                .name(establishmentBo.getName())
                .description(establishmentBo.getDescription())
                .latitude(establishmentBo.getLatitude())
                .longitude(establishmentBo.getLongitude())
                .build();
    }

    public boolean validate(){
        return  !this.name.isBlank() &&
                !this.cityName.isBlank() &&
                !this.description.isBlank() &&
                this.latitude != null &&
                this.longitude != null &&
                this.latitude>=-90 &&
                this.latitude<=90 &&
                this.longitude>=-180 &&
                this.longitude<=180;

    }
}
