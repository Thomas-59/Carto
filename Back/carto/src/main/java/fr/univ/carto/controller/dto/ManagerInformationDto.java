package fr.univ.carto.controller.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class ManagerInformationDto {
    private Long id;
    private String surname;
    private String firstname;
    private String phoneNumber;
    private String sirenNumber;
}
