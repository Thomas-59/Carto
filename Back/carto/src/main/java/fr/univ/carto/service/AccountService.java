package fr.univ.carto.service;

import fr.univ.carto.controller.dto.Role;
import fr.univ.carto.exception.AccountNotFoundException;
import fr.univ.carto.repository.AccountRepository;
import fr.univ.carto.repository.entity.AccountEntity;
import fr.univ.carto.repository.entity.ManagerInformationEntity;
import fr.univ.carto.service.bo.AccountBo;
import jakarta.transaction.Transactional;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AccountService {
    private final AccountRepository accountRepository;
    private final PasswordEncoder passwordEncoder;

    public AccountService(AccountRepository accountRepository, PasswordEncoder passwordEncoder) {
        this.accountRepository = accountRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public AccountBo getAccountById(Long id) throws AccountNotFoundException {
        Optional<AccountEntity> account = accountRepository.findById(id);
        if (account.isPresent()) {
            return account.get().toBo();
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

        return accountEntity.getId();
    }

    public void deleteUser(Long accountId) throws AccountNotFoundException {
        this.getAccountById(accountId);
        this.accountRepository.deleteById(accountId);
    }

    public AccountBo getAccountByUsername(String username) {
        Optional<AccountEntity> account = accountRepository.findByUsername(username);
        return account.map(AccountEntity::toBo).orElse(null);
    }

    public AccountBo getAccountByEmailAddress(String emailAddress) {
        Optional<AccountEntity> account = accountRepository.findByEmailAddress(emailAddress);
        return account.map(AccountEntity::toBo).orElse(null);
    }
}
