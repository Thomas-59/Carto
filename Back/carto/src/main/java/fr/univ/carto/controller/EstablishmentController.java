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
/*
    @GetMapping("/{id}")
    public ResponseEntity<EstablishmentDto> getEstablishmentById(@PathVariable Long id) throws EstablishmentNotFoundException {
        EstablishmentBo establishmentBo =this.establishmentService.getEstablishmentById(id);
        EstablishmentDto establishmentDto = EstablishmentDto.builder()
                .id(establishmentBo.getId())
                .name(establishmentBo.getName())
                .description(establishmentBo.getDescription())
                .longitude(establishmentBo.getLongitude())
                .latitude(establishmentBo.getLatitude())
                .address(establishmentBo.getCityName())
                .build();
        return ResponseEntity.ok(establishmentDto);
    }
*/
    @PostMapping
    public ResponseEntity<Long> createEstablishment(@RequestBody EstablishmentDto establishmentDto) throws InvalidEstablishmentException {
        if(establishmentDto.validate()){
            EstablishmentBo establishmentBo = new EstablishmentBo();

            establishmentBo.setAddress(establishmentDto.getAddress());
            establishmentBo.setName(establishmentDto.getName());
            establishmentBo.setSite(establishmentDto.getSite());
            establishmentBo.setDescription(establishmentDto.getDescription());
            establishmentBo.setPhoneNumber(establishmentDto.getPhoneNumber());
            establishmentBo.setDayScheduleList(establishmentDto.getDayScheduleList());
            establishmentBo.setGameTypeDtoList(establishmentDto.getGameTypeDtoList());
            establishmentBo.setPrice(establishmentDto.getPrice());
            establishmentBo.setAccessPRM(establishmentDto.isAccessPRM());
            establishmentBo.setProximityTransport(establishmentDto.isProximityTransport());
            establishmentBo.setLongitude(establishmentDto.getLongitude());
            establishmentBo.setLatitude(establishmentDto.getLatitude());
            establishmentBo.setEmailAddress(establishmentDto.getEmailAddress());
            return new ResponseEntity<>(this.establishmentService.createEstablishment(establishmentBo), HttpStatus.CREATED);
        } else {
            throw new InvalidEstablishmentException("invalid establishment");
        }
    }
/*
    @PutMapping
    public ResponseEntity<Object> updateEstablishment(@RequestBody EstablishmentDto establishmentDto) throws EstablishmentNotFoundException,InvalidEstablishmentException{
        if(establishmentDto.validate()){
            if(establishmentDto.getId()==null){
                throw new InvalidEstablishmentException("no id given");
            }
            EstablishmentBo establishmentBo = EstablishmentBo.builder()
                    .id(establishmentDto.getId())
                    .latitude(establishmentDto.getLatitude())
                    .longitude(establishmentDto.getLongitude())
                    .name(establishmentDto.getName())
                    .description(establishmentDto.getDescription())
                    .cityName(establishmentDto.getAddress())
                    .build();
            establishmentService.update(establishmentBo);
            return ResponseEntity.ok().build();
        }else {
            throw new InvalidEstablishmentException("Invalid Establishment given");
        }
    }
*/
    @DeleteMapping("/{id}")
    public ResponseEntity<Object> deleteEstablishment(@PathVariable Long id) throws EstablishmentNotFoundException {
        this.establishmentService.deleteEstablishment(id);
        return ResponseEntity.accepted().build();
    }
}
