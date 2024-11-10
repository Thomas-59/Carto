package fr.univ.carto.controller;

import fr.univ.carto.controller.dto.EstablishmentDto;
import fr.univ.carto.service.EstablishmentService;
import fr.univ.carto.service.bo.EstablishmentBo;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class EstablishmentControllerTest {
    @Mock
    private EstablishmentService establishmentService;
    private EstablishmentController establishmentController;
    private EstablishmentBo establishmentBoInDB;
    private List<EstablishmentDto> establishmentDtoListInDB;
    private List<EstablishmentBo> establishmentBOList;
    @BeforeEach
    void init(){
        this.establishmentController = new EstablishmentController(establishmentService);
        this.establishmentBOList = new ArrayList<>();
        this.establishmentBoInDB = EstablishmentBo.builder()
                .id(1L)
                .name("Tagh-Heul")
                .cityName("Lille")
                .longitude(3.01)
                .latitude(50.0)
                .description("TG")
                .build();
        this.establishmentBOList.add(establishmentBoInDB);
        this.establishmentDtoListInDB = establishmentBOList.stream()
                .map(EstablishmentDto::fromBo)
                .toList();
    }

    @Test
    void getAllEstablishmentTest(){
        when(establishmentService.getAllEstablishment()).thenReturn(this.establishmentBOList);

        ResponseEntity<List<EstablishmentDto>> responseEntity = this.establishmentController.getAllEstablishment();
        assertEquals(establishmentDtoListInDB,responseEntity.getBody());
        assertEquals(HttpStatus.OK,responseEntity.getStatusCode());
    }


}
