package fr.univ.carto.controller.request;

import fr.univ.carto.controller.dto.ManagerInformationDto;
import fr.univ.carto.controller.dto.Role;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class AccountRequest {

    private String username;
    private String emailAddress;
    private String password;
    private Date createdAt;
    private Role role;
    private ManagerInformationDto managerInformation;

}

