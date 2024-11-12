package fr.univ.carto.service;

import fr.univ.carto.exception.EstablishmentNotFoundException;
import fr.univ.carto.repository.EstablishmentRepository;
import fr.univ.carto.repository.entity.EstablishmentEntity;
import fr.univ.carto.service.bo.EstablishmentBo;
import org.springframework.stereotype.Service;

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
        return establishmentRepository.findAll().stream()
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

    public Long createEstablishment(EstablishmentBo establishmentBo) {
        EstablishmentEntity establishmentEntity = EstablishmentEntity.fromBo(establishmentBo);
        return this.establishmentRepository.save(establishmentEntity).getId();
    }

    public void update(EstablishmentBo establishmentBo) throws EstablishmentNotFoundException {
        this.getEstablishmentById(establishmentBo.getId());
        this.establishmentRepository.save(EstablishmentEntity.fromBo(establishmentBo));
    }

    public void deleteEstablishment(Long id) throws EstablishmentNotFoundException{
        this.getEstablishmentById(id);
        this.establishmentRepository.deleteById(id);
    }
}
