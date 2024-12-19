package fr.univ.carto.controller;

import fr.univ.carto.controller.dto.AccountDto;
import fr.univ.carto.exception.InvalidAccountException;
import fr.univ.carto.exception.AccountNotFoundException;
import fr.univ.carto.service.AccountService;
import fr.univ.carto.service.bo.AccountBo;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping("/by-username/{username}")
    public ResponseEntity<AccountBo> getAccountByUsername(@PathVariable String username) {
        AccountBo accountBo = this.accountService.getAccountByUsername(username);
        return ResponseEntity.ok(accountBo);
    }

    @GetMapping({"/by-email-address/{emailAddress"})
    public ResponseEntity<AccountBo> getAccountByEmailAddress(@PathVariable String emailAddress) {
        AccountBo accountBo = this.accountService.getAccountByEmailAddress(emailAddress);
        return ResponseEntity.ok(accountBo);
    }
}