package fr.univ.carto.repository.entity.establishmentgames;

public enum GameType {
    POOL("POOL"),
    DARTS("DARTS"),
    BABYFOOT("BABYFOOT"),
    BOWLING("BOWLING"),
    ARCADE("ARCADE"),
    PINBALL("PINBALL"),
    KARAOKE("KARAOKE"),
    CARDS("CARDS"),
    BOARDGAME("BOARDGAME"),
    PETANQUE("PETANQUE");

    private final String displayName;
    GameType(String displayName) {
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
