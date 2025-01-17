package fr.univ.carto.service;

import fr.univ.carto.controller.dto.Role;
import fr.univ.carto.exception.AccountNotFoundException;
import fr.univ.carto.exception.BadTokenException;
import fr.univ.carto.exception.UnauthorizedException;
import fr.univ.carto.repository.AccountRepository;
import fr.univ.carto.repository.ManagerInformationRepository;
import fr.univ.carto.repository.entity.AccountEntity;
import fr.univ.carto.repository.entity.ManagerInformationEntity;
import fr.univ.carto.service.bo.AccountBo;
import fr.univ.carto.utils.EmailSender;
import fr.univ.carto.utils.Token;
import jakarta.transaction.Transactional;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.auth0.jwt.exceptions.TokenExpiredException;

import java.util.Optional;

@Service
public class AccountService {
    private final AccountRepository accountRepository;
    private final ManagerInformationRepository managerInformationRepository;
    private final PasswordEncoder passwordEncoder;

    public AccountService(AccountRepository accountRepository, ManagerInformationRepository managerInformationRepository, PasswordEncoder passwordEncoder) {
        this.accountRepository = accountRepository;
        this.managerInformationRepository = managerInformationRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public AccountBo getAccountById(String token) throws AccountNotFoundException, BadTokenException {
        long accountId = Token.decodedToken(token);
        Optional<AccountEntity> account = accountRepository.findById(accountId);
        if (account.isPresent()) {
            AccountBo accountBo = account.get().toBo();
            accountBo.setPassword("");
            return accountBo;
        } else {
            throw new AccountNotFoundException("No account found for given id");
        }
    }

    @Transactional
    public Long createAccount(AccountBo accountBo) {
        AccountEntity accountEntity = new AccountEntity();

        accountEntity.setUsername(accountBo.getUsername());
        accountEntity.setEmailAddress(accountBo.getEmailAddress());

        // Encrypt password
        String hashedPassword = passwordEncoder.encode(accountBo.getPassword());
        accountEntity.setPassword(hashedPassword);

        accountEntity.setCreatedAt(accountBo.getCreatedAt());
        accountEntity.setRole(accountBo.getRole());

        if (accountEntity.getRole() == Role.MANAGER) {
            ManagerInformationEntity managerInformationEntity = new ManagerInformationEntity();

            managerInformationEntity.setSurname(accountBo.getManagerInformation().getSurname());
            managerInformationEntity.setFirstname(accountBo.getManagerInformation().getFirstname());
            managerInformationEntity.setPhoneNumber(accountBo.getManagerInformation().getPhoneNumber());
            managerInformationEntity.setSirenNumber(accountBo.getManagerInformation().getSirenNumber());

            accountEntity.setManagerInformation(managerInformationEntity);
        }

        accountRepository.save(accountEntity);

        new EmailSender().sendWelcomeEmail(accountBo.getEmailAddress(), accountBo.getUsername());

        return accountEntity.getId();
    }

    public boolean checkUsernameExist(String username) {
        return accountRepository.existsByUsername(username);
    }

    public boolean checkEmailExist(String emailAddress) {
        return accountRepository.existsByEmailAddress(emailAddress);
    }
  
    public void deleteUser(String token) throws BadTokenException {
        long accountId = Token.decodedToken(token);
        this.accountRepository.deleteById(accountId);
    }

    @Transactional
    public Long updateAccount(AccountBo accountBo, String token) throws BadTokenException, AccountNotFoundException {
        Long accountId = Token.decodedToken(token);
        Optional<AccountEntity> optionalAccountEntity = accountRepository.findById(accountId);
        AccountEntity accountEntity;
        if (optionalAccountEntity.isEmpty()) {
            throw new AccountNotFoundException("No account found for given id");
        } else {
            accountEntity = optionalAccountEntity.get();
        }

        accountEntity.setUsername(accountBo.getUsername());
        accountEntity.setEmailAddress(accountBo.getEmailAddress());


        if(!accountBo.getPassword().isEmpty()) {
            // Encrypt password
            String hashedPassword = passwordEncoder.encode(accountBo.getPassword());
            accountEntity.setPassword(hashedPassword);
        }

        if (accountBo.getRole() == Role.MANAGER) {

            if (accountEntity.getManagerInformation() == null) {
                ManagerInformationEntity managerInformationEntity = new ManagerInformationEntity();
                managerInformationEntity.setSurname(accountBo.getManagerInformation().getSurname());
                managerInformationEntity.setFirstname(accountBo.getManagerInformation().getFirstname());
                managerInformationEntity.setPhoneNumber(accountBo.getManagerInformation().getPhoneNumber());
                managerInformationEntity.setSirenNumber(accountBo.getManagerInformation().getSirenNumber());
                accountEntity.setManagerInformation(managerInformationEntity);
            } else {
                ManagerInformationEntity existingManagerInfo = accountEntity.getManagerInformation();
                existingManagerInfo.setSurname(accountBo.getManagerInformation().getSurname());
                existingManagerInfo.setFirstname(accountBo.getManagerInformation().getFirstname());
                existingManagerInfo.setPhoneNumber(accountBo.getManagerInformation().getPhoneNumber());
                existingManagerInfo.setSirenNumber(accountBo.getManagerInformation().getSirenNumber());
            }

        } else if ((accountBo.getRole() == Role.USER) && (accountEntity.getRole() == Role.MANAGER)) {
            if (accountEntity.getManagerInformation() != null) {
                managerInformationRepository.deleteById(accountEntity.getManagerInformation().getId());
                accountEntity.setManagerInformation(null);
            }
        }

        accountEntity.setRole(accountBo.getRole());

        accountRepository.save(accountEntity);

        return accountEntity.getId();
    }

    public String login(String userNameOrMail, String password) throws AccountNotFoundException, UnauthorizedException {
        Optional<AccountEntity> account = accountRepository.findByUsername(userNameOrMail);
        if (account.isPresent()) {
            if (!passwordEncoder.matches(password, account.get().getPassword())) {
                throw new UnauthorizedException("bad password");
            }
            return Token.createCredential(userNameOrMail, password);
        }

        account = accountRepository.findByEmailAddress(userNameOrMail);
        if (account.isPresent()) {
            if (!passwordEncoder.matches(password, account.get().getPassword())) {
                throw new UnauthorizedException("bad password");
            }
            return Token.createCredential(userNameOrMail, password);
        } else {
            throw new AccountNotFoundException("No account found for given " + userNameOrMail + "/" + password);
        }
    }

    public String getToken(String credential) throws AccountNotFoundException, UnauthorizedException, TokenExpiredException, BadTokenException {
        String[] decodedCredential = Token.decodedCredential(credential);
        Optional<AccountEntity> account = accountRepository.findByUsername(decodedCredential[0]);
        if (account.isPresent()) {
            if (!passwordEncoder.matches(decodedCredential[1], account.get().getPassword())) {
                throw new UnauthorizedException("bad password");
            }
            return Token.createToken(account.get().getId());
        }

        account = accountRepository.findByEmailAddress(decodedCredential[0]);
        if (account.isPresent()) {
            if (!passwordEncoder.matches(decodedCredential[1], account.get().getPassword())) {
                throw new UnauthorizedException("bad password");
            }
            return Token.createToken(account.get().getId());
        } else {
            throw new AccountNotFoundException("No account found for given " + decodedCredential[0] + "/" + decodedCredential[1]);
        }
    }

    public void sendEmailForgottenPassword(String email) {
        Optional<AccountEntity> account = accountRepository.findByEmailAddress(email);
        if (account.isPresent()) {
            String link = "https://carto.onrender.com/account/forgottenPassword/" +
                    Token.createTokenForgottenPassword(account.get().getId());
            EmailSender emailSender = new EmailSender();
            emailSender.sendForgottenPassword(email, link);
        }
    }

    public void updatePassword(String password, long id) throws AccountNotFoundException {
        Optional<AccountEntity> optionalAccountEntity = accountRepository.findById(id);
        AccountEntity accountEntity;

        if (optionalAccountEntity.isEmpty()) {
            throw new AccountNotFoundException("No account found for given id");
        }

        accountEntity = optionalAccountEntity.get();
        String hashedPassword = passwordEncoder.encode(password);
        accountEntity.setPassword(hashedPassword);
        accountRepository.save(accountEntity);
    }
}
