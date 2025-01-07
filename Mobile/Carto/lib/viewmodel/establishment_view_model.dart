import 'package:carto/enum/price_enum.dart';
import 'package:flutter/material.dart';

import '../models/establishment.dart';
import '../services/establishment_service.dart';

class EstablishmentViewModel {
  EstablishmentService establishmentService = EstablishmentService();

  EstablishmentViewModel() {
    establishmentService = EstablishmentService();
  }

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
      List<List<TimeOfDay>> weekOpeningHour,
      List<bool> weekOpening,
      List<String> gameTitles,
      List<int> gameNumbers
      ) {
    
    
    List<DayOfTheWeekElemDto> days = [];
    days.add(DayOfTheWeekElemDto(
        DayOfTheWeek.monday,
        convertToString(weekOpeningHour[0][0]),
        convertToString(weekOpeningHour[0][1]),
        !weekOpening[0]));
    days.add(DayOfTheWeekElemDto(
        DayOfTheWeek.tuesday,
        convertToString(weekOpeningHour[1][0]),
        convertToString(weekOpeningHour[1][1]),
        !weekOpening[1]));
    days.add(DayOfTheWeekElemDto(
        DayOfTheWeek.wednesday,
        convertToString(weekOpeningHour[2][0]),
        convertToString(weekOpeningHour[2][1]),
        !weekOpening[2]));
    days.add(DayOfTheWeekElemDto(
        DayOfTheWeek.thursday,
        convertToString(weekOpeningHour[3][0]),
        convertToString(weekOpeningHour[3][1]),
        !weekOpening[3]));
    days.add(DayOfTheWeekElemDto(
        DayOfTheWeek.friday,
        convertToString(weekOpeningHour[4][0]),
        convertToString(weekOpeningHour[4][1]),
        !weekOpening[4]));
    days.add(DayOfTheWeekElemDto(
        DayOfTheWeek.saturday,
        convertToString(weekOpeningHour[5][0]),
        convertToString(weekOpeningHour[5][1]),
        !weekOpening[5]));
    days.add(DayOfTheWeekElemDto(
        DayOfTheWeek.sunday,
        convertToString(weekOpeningHour[6][0]),
        convertToString(weekOpeningHour[6][1]),
        !weekOpening[6]));

    List<GameTypeDto> games = [];
    int i = 0;
    while (i < gameTitles.length - 1) {
      if (gameNumbers[i] > 0) {
        games.add(
            GameTypeDto(GameType.fromString(gameTitles[i]), gameNumbers[i]));
      }
      i++;
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
      games,
    );
    
    return establishmentService.createEstablishment(establishment);
  }

  Future<List<Establishment>> getAllEstablishment(){
    return establishmentService.getAllEstablishment();
  }

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
