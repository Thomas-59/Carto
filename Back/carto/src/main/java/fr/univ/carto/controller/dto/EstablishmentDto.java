package fr.univ.carto.controller.dto;

import fr.univ.carto.service.bo.EstablishmentBo;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.Objects;

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
    @Override
    public boolean equals(Object object){
        if(object instanceof EstablishmentDto establishmentDto){
            return Objects.equals(this.id, establishmentDto.id) &&
                    Objects.equals(this.latitude, establishmentDto.getLatitude()) &&
                    Objects.equals(this.longitude, establishmentDto.getLongitude()) &&
                    Objects.equals(this.description, establishmentDto.getDescription()) &&
                    Objects.equals(this.cityName, establishmentDto.getCityName()) &&
                    Objects.equals(this.name, establishmentDto.getName());
        }
        return false;
    }
}
