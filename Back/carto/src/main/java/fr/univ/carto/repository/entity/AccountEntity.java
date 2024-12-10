package fr.univ.carto.repository.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import fr.univ.carto.controller.dto.Role;
import fr.univ.carto.service.bo.AccountBo;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "account")
public class AccountEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "account_generator")
    @SequenceGenerator(name = "account_generator", sequenceName = "account_seq", allocationSize = 1)
    private Long id;

    private String username;

    @Column(name = "emailaddress")
    private String emailAddress;

    private String password;

    @Column(name = "createdat", nullable = false)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private Role role;

    public AccountBo toBo() {
        AccountBo accountBo = new AccountBo();
        accountBo.setId(id);
        accountBo.setUsername(username);
        accountBo.setEmailAddress(emailAddress);
        accountBo.setPassword(password);
        accountBo.setRole(role);
        return accountBo;
    }
}
