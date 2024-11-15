package fr.univ.carto.service.bo;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.Objects;

@Getter
@Setter
@Builder
public class EstablishmentBo {
    private Long id;

    private String name;

    private String cityname;

    private Double longitude;

    private Double latitude;

    private String description;

    @Override
    public boolean equals(Object o){
        if(o instanceof EstablishmentBo establishmentBo) {
            return Objects.equals(this.id, establishmentBo.id) &&
                    Objects.equals(this.latitude, establishmentBo.getLatitude()) &&
                    Objects.equals(this.longitude, establishmentBo.getLongitude()) &&
                    Objects.equals(this.description, establishmentBo.getDescription()) &&
                    Objects.equals(this.cityName, establishmentBo.getCityName()) &&
                    Objects.equals(this.name, establishmentBo.getName());
        }
        return false;
    }
}
