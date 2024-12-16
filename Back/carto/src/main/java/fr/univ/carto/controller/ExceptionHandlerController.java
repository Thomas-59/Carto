package fr.univ.carto.controller;

import fr.univ.carto.exception.EstablishmentNotFoundException;
import fr.univ.carto.exception.InvalidEstablishmentException;
import fr.univ.carto.exception.UnauthorizedException;
import fr.univ.carto.exception.AccountNotFoundException;
import fr.univ.carto.exception.InvalidAccountException;
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

    @ExceptionHandler(value = AccountNotFoundException.class)
    public ResponseEntity<Object> accountNotFound(){
        return new ResponseEntity<>("No account found for given data", HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(value = InvalidEstablishmentException.class)
    public ResponseEntity<Object> invalidEstablishment(){
        return new ResponseEntity<>("Invalid establishment: the given establishment should have a name, a description, a cityName, a latitude who should be between -90 and 90 and a longitude who should be between -180 and 180",HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(value = InvalidAccountException.class)
    public ResponseEntity<Object> invalidAccount(){
        return new ResponseEntity<>("Invalid account: the given account should have a username, a emailAddress, a createdat, a password a role who should be USER",HttpStatus.BAD_REQUEST);
    }
    
    @ExceptionHandler(value = UnauthorizedException.class)
    public ResponseEntity<Object> Unauthorized(){
        return new ResponseEntity<>("Unauthorized action",HttpStatus.UNAUTHORIZED);
    }
}
