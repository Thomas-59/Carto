package fr.univ.carto.controller.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@Builder
public class AccountDto {
    private Long id;

    private String username;

    private String emailAddress;

    private String password;

    private Date createdAt;

    private Role role;

    public boolean validate() {
        return !this.username.isBlank() &&
                !this.emailAddress.isBlank() &&
                !this.password.isBlank() &&
                this.role != null;
    }
}
