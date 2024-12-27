package fr.univ.carto.controller;

import fr.univ.carto.controller.dto.Role;
import fr.univ.carto.controller.request.AccountRequest;
import fr.univ.carto.exception.InvalidAccountException;
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

    @GetMapping("/check-username/{username}")
    public ResponseEntity<String> checkUsernameExists(@PathVariable String username) {
        boolean exists = this.accountService.checkUsernameExist(username);
        if (exists) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Username already exists");
        } else {
            return ResponseEntity.ok("Username is available");
        }
    }

    @GetMapping("/check-email/{emailAddress}")
    public ResponseEntity<String> checkEmailExists(@PathVariable String emailAddress) {
        boolean exists = this.accountService.checkEmailExist(emailAddress);
        if (exists) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Email address already exists");
        } else {
            return ResponseEntity.ok("Email address is available");
        }
    }
}