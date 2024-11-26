package fr.univ.carto.service.bo;

import fr.univ.carto.controller.dto.DayOfTheWeekElemDto;
import fr.univ.carto.controller.dto.GameTypeDto;
import fr.univ.carto.controller.dto.Price;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;
import java.util.Objects;

@Getter
@Setter
public class EstablishmentBo {
    private Long id;

    private String name;

    private String address;
    
    private String site;

    private String description;

    private boolean proximityTransport;

    private boolean accessPRM;

    private Price price;

    private String emailAddress;

    private String phoneNumber;

    private Double longitude;

    private Double latitude;


    private List<DayOfTheWeekElemDto> dayScheduleList;
    private List<GameTypeDto> gameTypeDtoList;

    /*@Override
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
    }*/
}
