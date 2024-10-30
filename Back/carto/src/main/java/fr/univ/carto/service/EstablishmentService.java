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
}
