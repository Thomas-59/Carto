package fr.univ.carto.controller;

import fr.univ.carto.controller.dto.Role;
import fr.univ.carto.controller.request.AccountRequest;
import fr.univ.carto.exception.InvalidAccountException;
import fr.univ.carto.exception.UnauthorizedException;
import fr.univ.carto.exception.AccountNotFoundException;
import fr.univ.carto.exception.BadTokenException;
import fr.univ.carto.service.AccountService;
import fr.univ.carto.service.bo.AccountBo;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.regex.Pattern;

import fr.univ.carto.utils.Token;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.auth0.jwt.exceptions.TokenExpiredException;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/account")
public class AccountController {
    private final AccountService accountService;

    public AccountController(AccountService accountService) {
        this.accountService = accountService;
    }

    @PostMapping
    public ResponseEntity<Long> createAccount(@RequestBody AccountRequest accountRequest) throws InvalidAccountException {
        AccountBo account = accountRequestToAccountBo(accountRequest);

        return new ResponseEntity<>(this.accountService.createAccount(account), HttpStatus.CREATED);
    }

    @PostMapping("/forgottenPassword")
    public ModelAndView resetPassword(
            @RequestParam("token") String token,
            @RequestParam("password") String password,
            @RequestParam("confirmPassword") String confirmPassword
    ) {
        ModelAndView modelAndView = new ModelAndView("ResetPassword");
        modelAndView.addObject("token", token);

        if (!password.equals(confirmPassword)) {
            modelAndView.addObject("error", "Les mots de passe ne correspondent pas.");
            return modelAndView;
        }

        Pattern pattern = Pattern.compile("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{7,}$");
        if(!pattern.matcher(password).matches()) {
            modelAndView.addObject("error", "Le mot de passe doivent comporter au moins 7 caractères, une majuscule, une minuscule et un chiffre.");
            return modelAndView;
        }try {
            long id = Token.decodedTokenForgottenPassword(token);
            accountService.updatePassword(password, id);
            modelAndView.setViewName("ResetPasswordSuccess");
            return modelAndView;
        } catch (BadTokenException  | TokenExpiredException e) {
            modelAndView.setViewName("BadToken");
            return modelAndView;
        } catch (Exception e) {
            modelAndView.addObject("error", "Une erreur s’est produite lors de la réinitialisation de votre mot de passe. Veuillez réessayer.");
            return modelAndView;
        }
    }

    @PutMapping
    public ResponseEntity<Long> updateAccount(@RequestBody AccountRequest accountRequest, @RequestHeader("Authorization") String token) throws InvalidAccountException, BadTokenException, AccountNotFoundException {
        AccountBo account = accountRequestToAccountBo(accountRequest);
        return new ResponseEntity<>(this.accountService.updateAccount(account, token), HttpStatus.OK);
    }

    @PutMapping("/forgottenPassword/{email}")
    public ResponseEntity<Void> forgottenPassword(@PathVariable String email) throws InvalidAccountException {
        accountService.sendEmailForgottenPassword(email);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping
    public ResponseEntity<Void> deleteAccount(@RequestHeader("Authorization") String token) throws BadTokenException {
        this.accountService.deleteUser(token);
        return ResponseEntity.accepted().build();
    }

    @GetMapping
    public ResponseEntity<AccountBo> getAccount(@RequestHeader("Authorization") String token) throws AccountNotFoundException, BadTokenException {
        AccountBo accountBo = this.accountService.getAccountById(token);
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

    @GetMapping("/token")
    public ResponseEntity<String> getToken(@RequestHeader("Authorization") String credential) throws AccountNotFoundException, UnauthorizedException, TokenExpiredException, BadTokenException {
       String token = this.accountService.getToken(credential);
        return ResponseEntity.ok(token);
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

    @GetMapping("/forgottenPassword/{token}")
    public ModelAndView forgottenPasswordForm(@PathVariable String token) throws InvalidAccountException {
        ModelAndView modelAndView = new ModelAndView("ResetPassword");
        modelAndView.addObject("token", token);
        return modelAndView;
    }



    private AccountBo accountRequestToAccountBo(AccountRequest accountRequest) {
        AccountBo account = new AccountBo();
        account.setUsername(accountRequest.getUsername());
        account.setEmailAddress(accountRequest.getEmailAddress());
        account.setCreatedAt(accountRequest.getCreatedAt());
        account.setPassword(accountRequest.getPassword());
        account.setRole(accountRequest.getRole());

        if (account.getRole() == Role.MANAGER && accountRequest.getManagerInformation() != null) {
            account.setManagerInformation(accountRequest.getManagerInformation());
        }
        return account;
    }
}