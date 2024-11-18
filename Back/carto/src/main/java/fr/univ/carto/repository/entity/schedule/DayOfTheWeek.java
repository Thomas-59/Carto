package fr.univ.carto.repository.entity.schedule;

import fr.univ.carto.repository.entity.establishmentgames.GameType;

public enum DayOfTheWeek {
    MONDAY("MONDAY"),
    TUESDAY("TUESDAY"),
    WEDNESDAY("WEDNESDAY"),
    THURSDAY("THURSDAY"),
    FRIDAY("FRIDAY"),
    SATURDAY("SATURDAY"),
    SUNDAY("SUNDAY");

    private final String displayName;
    DayOfTheWeek(String displayName) {
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
            throw new IllegalArgumentException("Unknown game type: " + text);
        }
    }
}
