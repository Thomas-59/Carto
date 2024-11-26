import 'package:carto/models/establishment.dart';
import 'package:carto/utils/accordeons.dart';
import 'package:carto/utils/buttons.dart';
import 'package:carto/utils/intent_utils/intent_utils.dart';
import 'package:carto/utils/tags.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class EstablishmentDisplayPage extends StatefulWidget {
  const EstablishmentDisplayPage({super.key});

  @override
  State<EstablishmentDisplayPage> createState() =>
      _EstablishmentDisplayPageState();
}

class _EstablishmentDisplayPageState extends State<EstablishmentDisplayPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <Establishment, dynamic>{}) as Map;

    Establishment establishment = arguments['establishment'];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffffffff), Color(0xffd4bbf9)],
            stops: [0.7, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  // TODO replace this URL by establishment image
                  "https://www.shutterstock.com/image-photo/arcade-machine-game-600nw-706155493.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              leading: WhiteSquareIconButton(
                  icon: Icons.arrow_back_ios_new,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              actions: [
                WhiteSquareIconInvertedButton(
                    icon: Icons.reply_outlined,
                    onPressed: () {
                      IntentUtils.launchNavigation(context, establishment);
                    }),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                establishment.name.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF005CFF),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                establishment.address,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              GameTagsList(
                                  games: establishment.gameTypeDtoList),
                              EstablishmentInfo(establishment: establishment),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.favorite_border,
                                  color: Color(0xFF005CFF)),
                              onPressed: () {
                                // TODO implements to fav
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.phone,
                                  color: Color(0xFF005CFF)),
                              onPressed: () {
                                // TODO implements to contact
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                        height: 32, thickness: 1, color: Colors.black),
                    Column(
                      children: [
                        HoursAccordion(schedule: establishment.dayScheduleList),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lacinia neque justo, non euismod nibh tincidunt quis. ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Wrap(
                            alignment: WrapAlignment.spaceEvenly,
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: [
                              OutlineButtonWithTextAndIcon(
                                  icon: Icons.phone,
                                  onPressed: () {},
                                  text: establishment.phoneNumber),
                              OutlineButtonWithTextAndIcon(
                                  icon: Icons.mail,
                                  onPressed: () {},
                                  text: establishment.emailAddress)
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
