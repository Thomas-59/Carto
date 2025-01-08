package fr.univ.carto.repository.entity;

import fr.univ.carto.service.bo.ManagerInformationBo;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "manager_information")
public class ManagerInformationEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "manager_information_generator")
    @SequenceGenerator(name = "manager_information_generator", sequenceName = "manager_information_seq", allocationSize = 1)
    private Long id;

    private String surname;
    private String firstname;
    private String phoneNumber;
    private String sirenNumber;

    public ManagerInformationBo toBo() {
        ManagerInformationBo managerInformationBo = new ManagerInformationBo();
        managerInformationBo.setId(id);
        managerInformationBo.setSurname(surname);
        managerInformationBo.setFirstname(firstname);
        managerInformationBo.setPhoneNumber(phoneNumber);
        managerInformationBo.setSirenNumber(sirenNumber);

        return managerInformationBo;
    }
}
