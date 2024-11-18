package fr.univ.carto.controller;


import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import static org.junit.jupiter.api.Assertions.*;

class ExceptionHandlerControllerTest {
    private ExceptionHandlerController exceptionHandlerController;
    @BeforeEach
    void init(){
        this.exceptionHandlerController = new ExceptionHandlerController();
    }

    @Test
    void establishmentNotFoundTest(){
        ResponseEntity<Object> responseEntity = exceptionHandlerController.establishmentNotFound();
        assertEquals("No establishment found for given id",responseEntity.getBody());
        assertEquals(HttpStatus.NOT_FOUND,responseEntity.getStatusCode());
    }

    @Test
    void invalidEstablishmentTest(){
        ResponseEntity<Object> responseEntity = exceptionHandlerController.invalidEstablishment();
        assertEquals("Invalid establishment: the given establishment should have a name, a description, a cityName, a latitude who should be between -90 and 90 and a longitude who should be between -180 and 180",responseEntity.getBody());
        assertEquals(HttpStatus.BAD_REQUEST,responseEntity.getStatusCode());
    }

}
