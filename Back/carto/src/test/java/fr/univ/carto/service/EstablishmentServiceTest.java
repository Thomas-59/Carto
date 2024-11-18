package fr.univ.carto.service;
import fr.univ.carto.exception.EstablishmentNotFoundException;
import fr.univ.carto.repository.EstablishmentRepository;
import fr.univ.carto.repository.entity.EstablishmentEntity;
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
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class EstablishmentServiceTest {
    @Mock
    private EstablishmentRepository establishmentRepository;
    private EstablishmentService establishmentService;
    private EstablishmentBo establishmentBo;
    private EstablishmentEntity establishmentEntityInDB;
    private List<EstablishmentEntity> establishmentEntities;
    private List<EstablishmentBo> establishmentBos;
    @BeforeEach
    void init(){
        this.establishmentService = new EstablishmentService(establishmentRepository);
        this.establishmentBo = EstablishmentBo.builder()
                .name("name")
                .description("description")
                .cityName("cityname")
                .latitude(50.0)
                .longitude(3.0)
                .id(1L)
                .build();
        this.establishmentEntityInDB = EstablishmentEntity.fromBo(establishmentBo);
        this.establishmentEntityInDB.setId(1L);
        this.establishmentEntities = new ArrayList<>();
        establishmentEntities.add(establishmentEntityInDB);
        this.establishmentBos = new ArrayList<>();
        this.establishmentBos.add(establishmentEntityInDB.toBo());
    }

    @Test
    void getAllEstablishmentTest(){
        when(establishmentRepository.findAll()).thenReturn(establishmentEntities);
        List<EstablishmentBo> establishmentBoList = establishmentService.getAllEstablishment();
        for(int i=0;i<establishmentBoList.size()-1;i++){
            assertEquals(establishmentBos,establishmentBoList);
        }
    }

    @Test
    void getEstablishmentByIdIfInDbTest() throws EstablishmentNotFoundException {
        when(establishmentRepository.findById(1L)).thenReturn(Optional.ofNullable(establishmentEntityInDB));
        EstablishmentBo boInDb = this.establishmentService.getEstablishmentById(1L);
        assertEquals(establishmentBo,boInDb);
    }

    @Test
    void getEstablishmentByIdIfNotInDbTest(){
        when(establishmentRepository.findById(2L)).thenReturn(Optional.ofNullable(null));
        EstablishmentNotFoundException exception = assertThrows(
                EstablishmentNotFoundException.class,
                ()->establishmentService.getEstablishmentById(2L)
        );
        assertEquals("No establishment found for given id",exception.getMessage());
    }

    @Test
    void createEstablishmentTest(){
        establishmentEntityInDB.setId(null);
        establishmentBo.setId(null);
        EstablishmentEntity toReturn = establishmentEntityInDB;
        toReturn.setId(2L);
        when(establishmentRepository.save(any())).thenReturn(toReturn);
        Long expectedId = 2L;
        Long returnId = establishmentService.createEstablishment(establishmentBo);
        assertEquals(expectedId,returnId);
    }

}
