import 'package:carto/models/establishment.dart';
import 'package:carto/utils/accordeons.dart';
import 'package:carto/utils/buttons.dart';
import 'package:carto/utils/tags.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

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
                  "https://www.shutterstock.com/image-photo/arcade-machine-game"
                      "-600nw-706155493.jpg",
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
                      // TODO: implements redirection to itinerary
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
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF005CFF),
                                ),
                              ),
                              const SizedBox(height: 4),
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
                       Column(
                         children: [
                           IconButton(
                             icon: const Icon(Icons.favorite_border,
                                 color: Color(0xFF005CFF)),
                             onPressed: () {
                               // TODO implements to fav
                             },
                           ),
                           establishment.phoneNumber.isEmpty ?
                             const SizedBox() :
                             IconButton(
                               icon: const Icon(Icons.phone,
                                   color: Color(0xFF005CFF)),
                               onPressed: () async {
                                 if(establishment.phoneNumber.isNotEmpty) {
                                   Uri url = Uri.parse
                                     ("tel:${establishment.phoneNumber}");
                                   if (!await launchUrl(url)) {
                                     throw Exception('Could not launch $url');
                                   }
                                 }
                               },
                             ),
                           IconButton(
                             icon: const Icon(Icons.share,
                                 color: Color(0xFF005CFF)),
                             onPressed: () {
                               // TODO implements to share
                             },
                           ),
                           establishment.site.isEmpty ?
                             const SizedBox() :
                             IconButton(
                               icon: const Icon(Icons.open_in_browser,
                                   color: Color(0xFF005CFF)),
                               onPressed: () async {
                                 if(establishment.site.isNotEmpty) {
                                   Uri url = Uri.parse(establishment.site);
                                   if (!await launchUrl(url)) {
                                     throw Exception('Could not launch $url');
                                   }
                                 }
                               },
                             ),
                         ],
                       )
                      ],
                    ),
                    const Divider(
                        height: 32, thickness: 1, color: Colors.black),
                    Column(
                      children: [
                        HoursAccordion(schedule: establishment.dayScheduleList),
                        Text(
                          establishment.description,
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
                              establishment.phoneNumber.isEmpty ?
                                const SizedBox() :
                                OutlineButtonWithTextAndIcon(
                                  icon: Icons.phone,
                                  onPressed: () async {
                                    if(establishment.phoneNumber.isNotEmpty) {
                                      Uri url = Uri.parse("tel:"
                                          "${establishment.phoneNumber}");
                                      if (!await launchUrl(url)) {
                                        throw Exception('Could not launch $url');
                                      }
                                    }
                                  },
                                  text: establishment.phoneNumber
                                ),
                            establishment.phoneNumber.isEmpty ?
                              const SizedBox() :
                              OutlineButtonWithTextAndIcon(
                                  icon: Icons.mail,
                                  onPressed: () async {
                                    if(establishment.emailAddress.isNotEmpty) {
                                      Uri url = Uri.parse("mailto:"
                                          "${establishment.emailAddress}");
                                      if (!await launchUrl(url)) {
                                        throw Exception('Could not launch $url');
                                      }
                                    }
                                  },
                                  text: establishment.emailAddress
                                ),
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