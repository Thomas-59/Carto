package fr.univ.carto.controller.dto;

import fr.univ.carto.repository.entity.establishmentgames.GameType;

public enum Price {
    LOW("LOW"),
    MEDIUM("MEDIUM"),
    HIGH("HIGH");

    private final String displayName;
    Price(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName(){
        return this.displayName;
    }

    @Override
    public String toString(){
        return this.displayName;
    }

    public static GameType fromString(String text){
        if(text==null||text.trim().isEmpty()){
            throw new IllegalArgumentException("Text cannot be null or empty");
        }
        String toConvert = text.toUpperCase().trim();
        try {
            return GameType.valueOf(toConvert);
        }catch (IllegalArgumentException e){
            throw new IllegalArgumentException("Unknown price type: " + text);
        }
    }
}
