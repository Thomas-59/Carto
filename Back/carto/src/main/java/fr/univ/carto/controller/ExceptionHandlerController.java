package fr.univ.carto.controller;

import fr.univ.carto.exception.EstablishmentNotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ExceptionHandlerController {
    @ExceptionHandler(value = EstablishmentNotFoundException.class)
    public ResponseEntity<Object> establishmentNotFound(){
        return new ResponseEntity<>("No establishment found for given id", HttpStatus.NOT_FOUND);
    }
}
