package fr.univ.carto.repository.entity;

import fr.univ.carto.controller.dto.DayOfTheWeekElemDto;
import fr.univ.carto.controller.dto.GameTypeDto;
import fr.univ.carto.controller.dto.Price;
import fr.univ.carto.repository.entity.establishmentgames.EstablishmentGameEmbeddedId;
import fr.univ.carto.repository.entity.establishmentgames.EstablishmentGamesEntity;
import fr.univ.carto.repository.entity.schedule.ScheduleEmbeddedId;
import fr.univ.carto.repository.entity.schedule.ScheduleEntity;
import fr.univ.carto.service.bo.EstablishmentBo;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
@Entity
@Table(name = "establishment")
public class EstablishmentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "establishment_generator")
    @SequenceGenerator(name = "establishment_generator", sequenceName = "establishment_seq", allocationSize = 1)
    private Long id;

    private String name;
    private Double longitude;
    private Double latitude;
    private String address;

    @Column(name = "emailaddress")
    private String emailAddress;

    @Column(name = "proximitytransport")
    private boolean proximityTransport;

    @Column(name = "accessprm")
    private boolean accessPrm;

    @Column(name = "phonenumber")
    private String phoneNumber;

    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    private Price price;

    @OneToMany(mappedBy = "establishmentEntity", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<EstablishmentGamesEntity> establishmentGamesEntities = new ArrayList<>();

    @OneToMany(mappedBy = "establishmentEntity", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ScheduleEntity> dayScheduleList = new ArrayList<>();

    public EstablishmentBo toBo(){
        EstablishmentBo establishmentBo = new EstablishmentBo();
        establishmentBo.setId(id);
        establishmentBo.setAddress(address);
        establishmentBo.setName(name);
        establishmentBo.setPrice(price);
        establishmentBo.setLatitude(latitude);
        establishmentBo.setLongitude(longitude);
        establishmentBo.setAccessPRM(accessPrm);
        establishmentBo.setEmailAddress(emailAddress);
        establishmentBo.setPhoneNumber(phoneNumber);
        establishmentBo.setProximityTransport(proximityTransport);
        establishmentBo.setGameTypeDtoList(establishmentGamesEntities
                .stream()
                .map(establishmentGamesEntity -> new GameTypeDto(establishmentGamesEntity
                        .getEstablishmentGameEmbeddedId()
                        .getGameType(),
                        establishmentGamesEntity.getNumberOfGame()))
                .collect(Collectors.toList()));

        establishmentBo.setDayScheduleList(dayScheduleList
                .stream()
                .map(scheduleEntity -> new DayOfTheWeekElemDto(
                        scheduleEntity
                                .getScheduleEmbeddedId()
                                .getDayofweek(),
                        scheduleEntity.getOpeningTime(),
                        scheduleEntity.getClosingTime(),
                        scheduleEntity.isClosed()
                ))
                .collect(Collectors.toList()));

        return establishmentBo;
    }

    public static EstablishmentEntity fromBo(EstablishmentBo establishmentBo){
        EstablishmentEntity establishmentEntity=new EstablishmentEntity();
        establishmentEntity.setId(establishmentBo.getId());
        establishmentEntity.setAddress(establishmentBo.getAddress());
        establishmentEntity.setName(establishmentBo.getName());
        establishmentEntity.setPrice(establishmentBo.getPrice());
        establishmentEntity.setLatitude(establishmentBo.getLatitude());
        establishmentEntity.setLongitude(establishmentBo.getLongitude());
        establishmentEntity.setAccessPrm(establishmentBo.isAccessPRM());
        establishmentEntity.setEmailAddress(establishmentBo.getEmailAddress());
        establishmentEntity.setPhoneNumber(establishmentBo.getPhoneNumber());
        establishmentEntity.setProximityTransport(establishmentBo.isProximityTransport());

        List<EstablishmentGamesEntity> establishmentGamesEntities1 = new ArrayList<>();
        establishmentBo.getGameTypeDtoList().forEach(gameTypeDto -> {

            EstablishmentGameEmbeddedId establishmentGameEmbeddedId = new EstablishmentGameEmbeddedId();
            establishmentGameEmbeddedId.setGameType(gameTypeDto.getGameType());
            establishmentGameEmbeddedId.setEstablishmentId(establishmentEntity.getId());

            EstablishmentGamesEntity gamesEntity = new EstablishmentGamesEntity();
            gamesEntity.setEstablishmentGameEmbeddedId(establishmentGameEmbeddedId);
            gamesEntity.setNumberOfGame(gameTypeDto.getNumberOfGame());
            establishmentGamesEntities1.add(
                    gamesEntity
            );
        });
        establishmentEntity.setEstablishmentGamesEntities(establishmentGamesEntities1);

        List<ScheduleEntity> scheduleEntities = new ArrayList<>();
        establishmentBo.getDayScheduleList().forEach(day -> {

            ScheduleEmbeddedId scheduleEmbeddedId = new ScheduleEmbeddedId();
            scheduleEmbeddedId.setDayofweek(day.getDayOfTheWeek());
            scheduleEmbeddedId.setIdEstablishment(establishmentEntity);

            ScheduleEntity scheduleEntity = new ScheduleEntity();
            scheduleEntity.setScheduleEmbeddedId(scheduleEmbeddedId);
            scheduleEntity.setClosed(day.getIsClosed());
            scheduleEntity.setOpeningTime(day.getOpeningTime());
            scheduleEntity.setClosingTime(day.getClosingTime());
            scheduleEntities.add(
                    scheduleEntity
            );
        });
        establishmentEntity.setDayScheduleList(scheduleEntities);
        return establishmentEntity;
    }
}