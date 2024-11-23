import 'package:carto/models/establishment.dart';
import 'package:carto/utils/accordeons.dart';
import 'package:carto/utils/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class EtablishmentDisplayPage extends StatefulWidget {
  const EtablishmentDisplayPage({super.key});

  @override
  State<EtablishmentDisplayPage> createState() =>
      _EtablishmentDisplayPageState();
}

class _EtablishmentDisplayPageState extends State<EtablishmentDisplayPage> {
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
            stops: [0, 1],
            begin: Alignment.topCenter,
            end: Alignment(0.0, 2.0),
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
                              SizedBox(height: 4),
                              Text(
                                establishment.address,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
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
                              icon: Icon(Icons.phone, color: Color(0xFF005CFF)),
                              onPressed: () {
                                // TODO implements to contact
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 32, thickness: 1, color: Colors.black),
                    Column(
                      children: [
                        HoursAccordion(schedule: establishment.dayScheduleList),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lacinia neque justo, non euismod nibh tincidunt quis. Phasellus rutrum, erat id facilisis convallis, nunc leo sollicitudin augue, pharetra dictum leo velit dapibus ipsum. Duis purus ligula, rutrum eu feugiat eu, fringilla ut metus. Integer tellus metus, accumsan posuere aliquam quis, laoreet vel augue. Sed tortor nibh, imperdiet sed vestibulum eget, scelerisque ut ligula. Aenean ex mi, varius eu ligula ut, varius lacinia mi. Cras non libero vitae lorem viverra condimentum. In ut augue augue. Integer volutpat lacus a ullamcorper tincidunt. Donec massa urna, porta at ipsum vel, interdum condimentum nulla. Suspendisse congue vulputate est vel gravida. Donec ut tincidunt orci, nec tristique augue. Curabitur faucibus tempor ante, eget facilisis nisi finibus at. Nullam maximus neque a malesuada porttitor. Praesent sollicitudin nulla in nisl auctor, eleifend suscipit dui pharetra. Proin commodo tellus congue orci fringilla blandit. Duis viverra ac quam nec elementum. Morbi in tincidunt dui. Nam hendrerit, augue id dictum condimentum, ipsum elit congue nisl, ac viverra felis justo ac ex. Suspendisse ut sollicitudin turpis, vitae consectetur justo. Nam at quam a purus gravida pharetra imperdiet id nulla. Morbi ultricies tristique risus, quis finibus tellus rutrum eget. Nulla semper dignissim erat, et luctus tellus mollis consectetur. Nulla commodo arcu quis dui suscipit, ac cursus purus accumsan. Quisque pretium ipsum lacus, vitae faucibus nibh accumsan id. Sed sed urna eu turpis volutpat cursus. Suspendisse interdum, mi vitae viverra maximus, metus tellus posuere felis, a condimentum risus ligula et dui. Pellentesque molestie bibendum leo, a tempus purus maximus egestas. Vivamus vel nisl a arcu condimentum bibendum at quis massa. Sed ac consequat ligula. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec laoreet lacinia lectus nec lacinia. Curabitur sed dui lacus. Integer dignissim laoreet risus ut egestas. Donec erat leo, suscipit vitae nisl et, aliquet facilisis mauris. Cras finibus fermentum urna, id luctus nunc rutrum placerat. Maecenas lorem est, efficitur dignissim molestie sed, tincidunt ac nulla. Vivamus mi eros, rutrum at venenatis pretium, imperdiet in elit. Nullam id eleifend lectus. Donec turpis enim, consequat vitae sagittis ac, scelerisque eu nisi. Nullam maximus dui dui, ac pretium metus congue eu. Etiam fermentum congue augue, vitae dapibus metus vehicula ut. Vivamus tincidunt neque magna, et posuere libero imperdiet non. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed gravida mi magna, sed euismod metus varius imperdiet. ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
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
