import 'package:carto/models/establishment.dart';
import 'package:carto/views/widgets/accordeons.dart';
import 'package:carto/views/widgets/buttons.dart';
import 'package:carto/utils/intent_utils/intent_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:carto/views/widgets/tags.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class EstablishmentDisplayPage extends StatefulWidget {
  const EstablishmentDisplayPage({super.key});

  @override
  State<EstablishmentDisplayPage> createState() =>
      _EstablishmentDisplayPageState();
}

class _EstablishmentDisplayPageState extends State<EstablishmentDisplayPage> {
  String? _imageUrl;
  final supabase = Supabase.instance.client;
  final folderName = 'establishment-images';
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
  }

  void _fetchImageUrl() async {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <Establishment, dynamic>{}) as Map;

    Establishment establishment = arguments['establishment'];
    final fileName = '${establishment.id}.jpg';
    final filePath = '$folderName/$fileName';

    String? url = await getImageUrl(filePath);
    setState(() {
      _imageUrl = url;
      _isLoading = false;
    });
  }

  Future<String?> getImageUrl(String filePath) async {
    try {
      final fileName = filePath.split('/').last;
      final folderPath = filePath.replaceFirst(fileName, '');

      final response = await supabase.storage
          .from('CartoBucket')
          .list(path: folderPath);

      final fileExists = response.any((file) => file.name == fileName);

      if (fileExists) {
        final publicUrl =
          supabase.storage.from('CartoBucket').getPublicUrl(filePath);
        return publicUrl;
      } else {
        if (kDebugMode) {
          print('File does not exist.');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Unexpected error: $e');
      }
      return null;
    }
  }


  @override
  Widget build(BuildContext context)  {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <Establishment, dynamic>{}) as Map;
    Establishment establishment = arguments['establishment'];
    _fetchImageUrl();
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
                background: _isLoading? null :Image.network(
                  _imageUrl ?? "https://www.shutterstock.com/image-photo/"
                      "arcade-machine-game-600nw-706155493.jpg",
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
                               shareEstablishment(establishment);
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
                            establishment.emailAddress.isEmpty ?
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

  void shareEstablishment(Establishment establishment) async {
    String text = "${establishment.name}\n"
      "Au : ${establishment.address}\n"
      "Jeux disponibles :\n";
    for(GameTypeDto game in establishment.gameTypeDtoList) {
      text += "   ${game.gameType.value} : ${game.numberOfGame}\n";
    }
    if(establishment.site.isNotEmpty) {
      text += "Site web : ${establishment.site}\n";
    }
    if(establishment.phoneNumber.isNotEmpty ||
        establishment.emailAddress.isNotEmpty)
    {
      text += "Contact :\n";
      if(establishment.phoneNumber.isNotEmpty) {
        text += "   Téléphone : ${establishment.phoneNumber}\n";
      }
      if(establishment.emailAddress.isNotEmpty) {
        text += "   Mail : ${establishment.emailAddress}\n";
      }
    }
    final result = await Share.share(text);
    if(result.status != ShareResultStatus.success) {
      throw Exception('Could not share');
    }
  }


}
