import 'package:flutter/material.dart';

import '../../models/establishment.dart';

/// The tag to show a game and the number of instance of this one
class GameTag extends StatelessWidget {

  /// The game to show
  final GameTypeDto game;

  /// The initializer of the class
  const GameTag({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEB663B), width: 1.5),
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

/// A list of game tag
class GameTagsList extends StatelessWidget {
  /// The list of games
  final List<GameTypeDto> games;

  /// The initializer of the class
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

/// A tag to show some information
class InfoTag extends StatelessWidget {
  /// The information to show
  final String infoName;

  /// The initializer of the class
  const InfoTag({super.key, required this.infoName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF005CFF), width: 1.5),
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

/// A tag to show the average price of games
class PriceTag extends StatelessWidget {
  /// The average price to show
  final Price price;

  /// The initializer of the class
  const PriceTag({super.key, required this.price});

  /// Parse the price to a String with €
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF005CFF), width: 1.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        "prix jeux : ${formatPrice(price)}",
        style: const TextStyle(
          color: Color(0xFF005CFF),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

/// Show the list of info tag and price tag of a establishment
class EstablishmentInfo extends StatelessWidget {
  /// The establishment to get data
  final Establishment establishment;

  /// The initializer of the class
  const EstablishmentInfo({super.key, required this.establishment});

  @override
  Widget build(BuildContext context) {
    List<Widget> infoTags = [];

    infoTags.add(PriceTag(price: establishment.price));

    if (establishment.proximityTransport) {
      infoTags.add(const InfoTag(infoName: "Proximité Transport"));
    }

    if (establishment.accessPRM) {
      infoTags.add(const InfoTag(infoName: "Accès Personne à Mobilité Réduite"));
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