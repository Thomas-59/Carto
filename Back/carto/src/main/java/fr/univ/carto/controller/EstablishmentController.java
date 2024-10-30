package fr.univ.carto.controller;

import fr.univ.carto.controller.dto.EstablishmentDto;
import fr.univ.carto.exception.EstablishmentNotFoundException;
import fr.univ.carto.exception.InvalidEstablishmentException;
import fr.univ.carto.service.EstablishmentService;
import fr.univ.carto.service.bo.EstablishmentBo;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/establishment")
public class EstablishmentController {
    private final EstablishmentService establishmentService;
    public EstablishmentController(EstablishmentService establishmentService){
        this.establishmentService = establishmentService;
    }

    @GetMapping("/all")
    public ResponseEntity<List<EstablishmentDto>> getAllEstablishment(){
        List<EstablishmentDto> establishmentDtos = this.establishmentService.getAllEstablishment().stream()
                .map(EstablishmentDto::fromBo)
                .toList();
        return ResponseEntity.ok(establishmentDtos);
    }

    @GetMapping("/{id}")
    public ResponseEntity<EstablishmentDto> getEstablishmentById(@PathVariable Long id) throws EstablishmentNotFoundException {
        EstablishmentBo establishmentBo =this.establishmentService.getEstablishmentById(id);
        EstablishmentDto establishmentDto = EstablishmentDto.builder()
                .id(establishmentBo.getId())
                .name(establishmentBo.getName())
                .description(establishmentBo.getDescription())
                .longitude(establishmentBo.getLongitude())
                .latitude(establishmentBo.getLatitude())
                .cityName(establishmentBo.getCityName())
                .build();
        return ResponseEntity.ok(establishmentDto);
    }

    @PostMapping
    public ResponseEntity<Long> createEstablishment(@RequestBody EstablishmentDto establishmentDto) throws InvalidEstablishmentException {
        if(establishmentDto.validate()){
            EstablishmentBo establishmentBo = EstablishmentBo.builder()
                    .cityName(establishmentDto.getCityName())
                    .name(establishmentDto.getName())
                    .description(establishmentDto.getDescription())
                    .longitude(establishmentDto.getLongitude())
                    .latitude(establishmentDto.getLatitude())
                    .build();
            return new ResponseEntity<Long>(this.establishmentService.createEstablishment(establishmentBo), HttpStatus.CREATED);
        } else {
            throw new InvalidEstablishmentException("invalid establishment");
        }
    }
}
