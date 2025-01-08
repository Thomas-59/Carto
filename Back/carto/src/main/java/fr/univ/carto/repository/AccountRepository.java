package fr.univ.carto.repository;

import fr.univ.carto.repository.entity.AccountEntity;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AccountRepository extends JpaRepository<AccountEntity, Long> {
    boolean existsByUsername(String username);

    boolean existsByEmailAddress(String emailAddress);

    Optional<AccountEntity> findByUsername(String userNameOrMail);

    Optional<AccountEntity> findByEmailAddress(String userNameOrMail);
}
