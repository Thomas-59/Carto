package fr.univ.carto.repository;

import fr.univ.carto.repository.entity.EstablishmentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EstablishmentRepository extends JpaRepository<EstablishmentEntity,Long> {
    List<EstablishmentEntity> findByIsdisplayedTrue();
}