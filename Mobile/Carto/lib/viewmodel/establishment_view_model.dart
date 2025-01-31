import 'package:carto/enum/price_enum.dart';
import 'package:carto/utils/establishment_games.dart';
import 'package:carto/utils/opening_hours.dart';
import 'package:flutter/material.dart';

import '../models/establishment.dart';
import '../services/establishment_service.dart';

/// The viewModel of the service to manage an establishment
class EstablishmentViewModel {
  /// The instance of the service who manage an establishment
  EstablishmentService establishmentService = EstablishmentService();

  /// Add a establishment in the data base
  Future<BigInt> createEstablishment(
    String name,
    String address,
    String site,
    String description,
    bool nearTransport,
    bool pmrAccess,
    PriceEnum gamePrice,
    String mail,
    String phoneNumber,
    String longitude,
    String latitude,
    WeekOpening weekOpeningHour,
    EstablishmentGames games,
  ) {
    List<DayOfTheWeekElemDto> days = [];
    days.add(_parseOpeningHours(weekOpeningHour.monday));
    days.add(_parseOpeningHours(weekOpeningHour.tuesday));
    days.add(_parseOpeningHours(weekOpeningHour.wednesday));
    days.add(_parseOpeningHours(weekOpeningHour.thursday));
    days.add(_parseOpeningHours(weekOpeningHour.friday));
    days.add(_parseOpeningHours(weekOpeningHour.saturday));
    days.add(_parseOpeningHours(weekOpeningHour.sunday));

    List<GameTypeDto> gamesDto = [];
    for(EstablishmentGame game in games.games) {
      if (game.numberOfGame > 0) {
        gamesDto.add(
          GameTypeDto(GameType.fromString(game.getName()), game.numberOfGame)
        );
      }
    }

    Establishment establishment = Establishment(
      null,
      name,
      address,
      site,
      description,
      nearTransport,
      pmrAccess,
      Price.fromString(gamePrice.value),
      mail,
      phoneNumber,
      double.parse(longitude),
      double.parse(latitude),
      days,
      gamesDto,
    );
    
    return establishmentService.createEstablishment(establishment);
  }

  DayOfTheWeekElemDto _parseOpeningHours(OpeningHours day) {
    return DayOfTheWeekElemDto(
        DayOfTheWeek.fromString(day.dayOfTheWeek.value),
        convertToString(day.openingTime),
        convertToString(day.closingTime),
        day.isClosed,
    );
  }

  /// Give all certified establishment in the data base
  Future<List<Establishment>> getAllEstablishment(){
    return establishmentService.getAllEstablishment();
  }

  /// Parse the time to a String
  String convertToString(TimeOfDay time) {
    String minRes;
    String hourRes;
    if (time.hour < 10) {
      hourRes = "0${time.hour}";
    } else {
      hourRes = "${time.hour}";
    }
    if (time.minute < 10) {
      minRes = "0${time.minute}";
    } else {
      minRes = "${time.minute}";
    }

    return "$hourRes:$minRes:00";
  }
}
