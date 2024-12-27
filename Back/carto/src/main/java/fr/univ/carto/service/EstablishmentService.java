package fr.univ.carto.service;

import fr.univ.carto.exception.EstablishmentNotFoundException;
import fr.univ.carto.repository.EstablishmentRepository;
import fr.univ.carto.repository.entity.EstablishmentEntity;
import fr.univ.carto.repository.entity.establishmentgames.EstablishmentGamesEntity;
import fr.univ.carto.repository.entity.schedule.ScheduleEntity;
import fr.univ.carto.service.bo.EstablishmentBo;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class EstablishmentService {
    private final EstablishmentRepository establishmentRepository;

    public EstablishmentService(EstablishmentRepository establishmentRepository){
        this.establishmentRepository = establishmentRepository;
    }

    public List<EstablishmentBo> getAllEstablishment(){
        return establishmentRepository.findByIsdisplayedTrue().stream()
                .map(EstablishmentEntity::toBo)
                .collect(Collectors.toList());
    }

    public EstablishmentBo getEstablishmentById(Long id) throws EstablishmentNotFoundException {
        Optional<EstablishmentEntity> establishment = establishmentRepository.findById(id);
        if(establishment.isPresent()){
            return establishment.get().toBo();
        } else {
            throw new EstablishmentNotFoundException("No establishment found for given id");
        }
    }

    @Transactional
    public Long createEstablishment(EstablishmentBo establishmentBo) {
        // First create the establishment without relationships
        EstablishmentEntity establishmentEntity = new EstablishmentEntity();
        establishmentEntity.setName(establishmentBo.getName());
        establishmentEntity.setAddress(establishmentBo.getAddress());
        establishmentEntity.setSite(establishmentBo.getSite());
        establishmentEntity.setDescription(establishmentBo.getDescription());
        establishmentEntity.setPrice(establishmentBo.getPrice());
        establishmentEntity.setLatitude(establishmentBo.getLatitude());
        establishmentEntity.setLongitude(establishmentBo.getLongitude());
        establishmentEntity.setAccessPrm(establishmentBo.isAccessPRM());
        establishmentEntity.setEmailAddress(establishmentBo.getEmailAddress());
        establishmentEntity.setPhoneNumber(establishmentBo.getPhoneNumber());
        establishmentEntity.setProximityTransport(establishmentBo.isProximityTransport());

        // Save the establishment first to get the ID
        establishmentEntity = establishmentRepository.save(establishmentEntity);
        final Long establishmentId = establishmentEntity.getId();

        // Now set up the games
        EstablishmentEntity finalEstablishmentEntity = establishmentEntity;
        List<EstablishmentGamesEntity> games = establishmentBo.getGameTypeDtoList().stream()
                .map(gameTypeDto -> {
                    EstablishmentGamesEntity game = new EstablishmentGamesEntity();
                    game.getEstablishmentGameEmbeddedId().setEstablishmentId(establishmentId);
                    game.getEstablishmentGameEmbeddedId().setGameType(gameTypeDto.getGameType());
                    game.setNumberOfGame(gameTypeDto.getNumberOfGame());
                    game.setEstablishmentEntity(finalEstablishmentEntity);
                    return game;
                })
                .collect(Collectors.toList());
        establishmentEntity.setEstablishmentGamesEntities(games);

        // Set up the schedules
        EstablishmentEntity finalEstablishmentEntity1 = establishmentEntity;
        List<ScheduleEntity> schedules = establishmentBo.getDayScheduleList().stream()
                .map(daySchedule -> {
                    ScheduleEntity schedule = new ScheduleEntity();
                    schedule.getScheduleEmbeddedId().setDayofweek(daySchedule.getDayOfTheWeek());
                    schedule.getScheduleEmbeddedId().setIdEstablishment(finalEstablishmentEntity1);
                    schedule.setOpeningTime(daySchedule.getOpeningTime());
                    schedule.setClosingTime(daySchedule.getClosingTime());
                    schedule.setClosed(daySchedule.getIsClosed());
                    schedule.setEstablishmentEntity(finalEstablishmentEntity1);
                    return schedule;
                })
                .collect(Collectors.toList());
        schedules.sort(Comparator.comparingInt(o -> o.getScheduleEmbeddedId().getDayofweek().ordinal()));
        establishmentEntity.setDayScheduleList(schedules);


        establishmentRepository.save(establishmentEntity);

        return establishmentId;
    }

    @Transactional
    public void update(EstablishmentBo establishmentBo) throws EstablishmentNotFoundException {
        this.getEstablishmentById(establishmentBo.getId());
        this.establishmentRepository.save(EstablishmentEntity.fromBo(establishmentBo));
    }

    public void deleteEstablishment(Long id) throws EstablishmentNotFoundException{
        this.getEstablishmentById(id);
        this.establishmentRepository.deleteById(id);
    }
}
