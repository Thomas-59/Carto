# Back Carto

## MCD

````mermaid
erDiagram
    Establishment ||--o{ Establishment_Games : has
    Establishment ||--o{ Schedule : has

    Establishment {
        bigint id PK
        string name
        string cityName
        decimal longitude
        decimal latitude
        text description
    }

    Establishment_Games {
        bigint idEstablishment PK,FK
        enum game PK "game_type"
    }

    Schedule {
        bigint id PK
        bigint idEstablishment FK
        enum dayOfWeek "day_of_week"
        time openingTime
        time closingTime
        boolean isClosed
    }
````


