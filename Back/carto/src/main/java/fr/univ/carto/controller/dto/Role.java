package fr.univ.carto.controller.dto;

public enum Role {
    USER("USER"),
    ADMIN("ADMIN"),
    MANAGER("MANAGER");

    private final String role;


    Role(String role) {
        this.role = role;
    }

    public String getRole() {
        return this.role;
    }

    @Override
    public String toString() {
        return this.role;
    }
}
