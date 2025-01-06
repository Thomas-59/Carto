package fr.univ.carto.repository;

import fr.univ.carto.repository.entity.EstablishmentEntity;
import fr.univ.carto.repository.entity.ManagerInformationEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ManagerInformationRepository extends JpaRepository<ManagerInformationEntity,Long> {
}