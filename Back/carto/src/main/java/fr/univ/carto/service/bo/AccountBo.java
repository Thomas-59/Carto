package fr.univ.carto.service.bo;

import fr.univ.carto.controller.dto.Role;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class AccountBo {
    private Long id;

    private String username;

    private String emailAddress;

    private String password;

    private Date createdAt;

    private Role role;

    private ManagerInformationBo managerInformation;
}
