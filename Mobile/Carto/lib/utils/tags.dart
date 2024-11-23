import 'package:flutter/material.dart';

import '../models/establishment.dart';

class GameTag extends StatelessWidget {
  final GameTypeDto game;

  const GameTag({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFEB663B), width: 1.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            game.gameType.value.toLowerCase(),
            style: const TextStyle(
              color: Color(0xFFEB663B),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "(${game.numberOfGame})",
            style: const TextStyle(
              color: Color(0xFFEB663B),
            ),
          ),
        ],
      ),
    );
  }
}

class GameTagsList extends StatelessWidget {
  final List<GameTypeDto> games;

  const GameTagsList({super.key, required this.games});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: games.map((game) {
            return GameTag(game: game);
          }).toList(),
        ),
      ),
    );
  }
}

class InfoTag extends StatelessWidget {
  final String infoName;

  const InfoTag({super.key, required this.infoName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF005CFF), width: 1.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        infoName.toLowerCase(),
        style: const TextStyle(
          color: Color(0xFF005CFF),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class PriceTag extends StatelessWidget {
  final Price price;

  const PriceTag({super.key, required this.price});

  String formatPrice(Price price) {
    String value;

    switch (price.value.toUpperCase()) {
      case 'LOW':
        value = "€";
        break;
      case 'MEDIUM':
        value = "€€";
        break;
      case 'HIGH':
        value = "€€€";
        break;
      default:
        value = "unknown";
        break;
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF005CFF), width: 1.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        "Prix : ${formatPrice(price)}",
        style: const TextStyle(
          color: Color(0xFF005CFF),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class EstablishmentInfo extends StatelessWidget {
  final Establishment establishment;

  const EstablishmentInfo({super.key, required this.establishment});

  @override
  Widget build(BuildContext context) {
    List<Widget> infoTags = [];

    infoTags.add(PriceTag(price: establishment.price));

    if (establishment.proximityTransport) {
      infoTags.add(InfoTag(infoName: "Proximité Transport"));
    }

    if (establishment.accessPRM) {
      infoTags.add(InfoTag(infoName: "Accès PMR"));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: infoTags,
        ),
      ),
    );
  }
}