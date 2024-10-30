package fr.univ.carto.controller;

import fr.univ.carto.controller.dto.EstablishmentDto;
import fr.univ.carto.exception.EstablishmentNotFoundException;
import fr.univ.carto.service.EstablishmentService;
import fr.univ.carto.service.bo.EstablishmentBo;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
