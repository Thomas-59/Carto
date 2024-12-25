package fr.univ.carto.controller;

import fr.univ.carto.controller.dto.AccountDto;
import fr.univ.carto.controller.dto.ManagerInformationDto;
import fr.univ.carto.controller.dto.Role;
import fr.univ.carto.controller.request.AccountRequest;
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
    public ResponseEntity<Long> createAccount(@RequestBody AccountRequest accountRequest) throws InvalidAccountException {
        AccountBo account = new AccountBo();
        account.setUsername(accountRequest.getUsername());
        account.setEmailAddress(accountRequest.getEmailAddress());
        account.setCreatedAt(accountRequest.getCreatedAt());
        account.setPassword(accountRequest.getPassword());
        account.setRole(accountRequest.getRole());

        if (account.getRole() == Role.MANAGER && accountRequest.getManagerInformation() != null) {
            account.setManagerInformation(accountRequest.getManagerInformation());
        }

        return new ResponseEntity<>(this.accountService.createAccount(account), HttpStatus.CREATED);
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

    @GetMapping({"/by-email-address/{emailAddress}"})
    public ResponseEntity<AccountBo> getAccountByEmailAddress(@PathVariable String emailAddress) {
        AccountBo accountBo = this.accountService.getAccountByEmailAddress(emailAddress);
        return ResponseEntity.ok(accountBo);
    }
}