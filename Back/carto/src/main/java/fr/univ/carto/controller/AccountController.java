package fr.univ.carto.controller;

import fr.univ.carto.controller.dto.AccountDto;
import fr.univ.carto.exception.InvalidAccountException;
import fr.univ.carto.exception.UnauthorizedException;
import fr.univ.carto.exception.AccountNotFoundException;
import fr.univ.carto.exception.BadTokenException;
import fr.univ.carto.service.AccountService;
import fr.univ.carto.service.bo.AccountBo;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.auth0.jwt.exceptions.TokenExpiredException;

@RestController
@RequestMapping("/account")
public class AccountController {
    private final AccountService accountService;

    public AccountController(AccountService accountService) {
        this.accountService = accountService;
    }

    @PostMapping
    public ResponseEntity<Long> createAccount(@RequestBody AccountDto accountDto) throws InvalidAccountException {
        if (accountDto.validate()) {
            AccountBo accountBo = new AccountBo();

            accountBo.setUsername(accountDto.getUsername());
            accountBo.setPassword(accountDto.getPassword());
            accountBo.setRole(accountDto.getRole());
            accountBo.setCreatedAt(accountDto.getCreatedAt());
            accountBo.setEmailAddress(accountDto.getEmailAddress());

            return new ResponseEntity<>(this.accountService.createAccount(accountBo), HttpStatus.CREATED);
        } else {
            throw new InvalidAccountException("invalid account");
        }
    }

    @PutMapping("/{token}")
    public ResponseEntity<Long> updateAccount(@RequestBody AccountDto accountDto, @PathVariable String token) throws InvalidAccountException, BadTokenException, AccountNotFoundException {
        if (accountDto.validate()) {
            AccountBo accountBo = new AccountBo();

            accountBo.setUsername(accountDto.getUsername());
            accountBo.setPassword(accountDto.getPassword());
            accountBo.setRole(accountDto.getRole());
            accountBo.setCreatedAt(accountDto.getCreatedAt());
            accountBo.setEmailAddress(accountDto.getEmailAddress());

            return new ResponseEntity<>(this.accountService.updateAccount(accountBo, token), HttpStatus.CREATED);
        } else {
            throw new InvalidAccountException("invalid account");
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAccount(@PathVariable Long id) throws AccountNotFoundException {
        this.accountService.deleteUser(id);
        return ResponseEntity.accepted().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<AccountBo> getAccount(@PathVariable Long id) throws AccountNotFoundException {
        AccountBo accountBo = this.accountService.getAccountById(id);
        return ResponseEntity.ok(accountBo);
    }

    @GetMapping("/log")
    public ResponseEntity<String> getCredentialToken(@RequestHeader("Authorization") String credential) throws AccountNotFoundException, UnauthorizedException {
        String decodedCredential = new String(Base64.getDecoder().decode(credential.split(" ")[1]), StandardCharsets.UTF_8);
        String userNameOrMail = decodedCredential.split(":")[0];
        String password = decodedCredential.split(":")[1];
        String token = this.accountService.login(userNameOrMail, password);
        return ResponseEntity.ok(token);
    }

    @GetMapping("/log/{credential}")
    public ResponseEntity<String> getToken(@PathVariable String credential) throws AccountNotFoundException, UnauthorizedException, TokenExpiredException, BadTokenException {
        //String decodedCredential = new String(Base64.getDecoder().decode(credential.split(" ")[1]), StandardCharsets.UTF_8);
        String token = this.accountService.getToken(credential);
        return ResponseEntity.ok(token);
    }
}