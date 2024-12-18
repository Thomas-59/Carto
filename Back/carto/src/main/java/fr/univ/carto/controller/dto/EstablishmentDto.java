package fr.univ.carto.controller.dto;

import fr.univ.carto.service.bo.EstablishmentBo;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.Objects;

@Getter
@Setter
@Builder
public class EstablishmentDto {
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

    public static EstablishmentDto fromBo(EstablishmentBo establishmentBo){
        return EstablishmentDto.builder()
                .id(establishmentBo.getId())
                .address(establishmentBo.getAddress())
                .name(establishmentBo.getName())
                .site(establishmentBo.getSite())
                .description(establishmentBo.getDescription())
                .proximityTransport(establishmentBo.isProximityTransport())
                .accessPRM(establishmentBo.isAccessPRM())
                .price(establishmentBo.getPrice())
                .emailAddress(establishmentBo.getEmailAddress())
                .phoneNumber(establishmentBo.getPhoneNumber())
                .dayScheduleList(establishmentBo.getDayScheduleList())
                .gameTypeDtoList(establishmentBo.getGameTypeDtoList())
                .latitude(establishmentBo.getLatitude())
                .longitude(establishmentBo.getLongitude())
                .build();
    }

    public boolean validate(){
        return  !this.name.isBlank() &&
                !this.address.isBlank() &&
                this.latitude != null &&
                this.longitude != null &&
                this.latitude>=-90 &&
                this.latitude<=90 &&
                this.longitude>=-180 &&
                this.longitude<=180;

    }/*
    @Override
    public boolean equals(Object object){
        if(object instanceof EstablishmentDto establishmentDto){
            return Objects.equals(this.id, establishmentDto.id) &&
                    Objects.equals(this.latitude, establishmentDto.getLatitude()) &&
                    Objects.equals(this.longitude, establishmentDto.getLongitude()) &&
                    Objects.equals(this.description, establishmentDto.getDescription()) &&
                    Objects.equals(this.address, establishmentDto.getAddress()) &&
                    Objects.equals(this.name, establishmentDto.getName());
        }
        return false;
    }*/
}
