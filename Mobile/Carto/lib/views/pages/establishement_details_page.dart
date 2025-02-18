import 'package:carto/data_manager.dart';
import 'package:carto/models/establishment.dart';
import 'package:carto/views/widgets/accordeons.dart';
import 'package:carto/views/widgets/buttons.dart';
import 'package:carto/utils/intent_utils/intent_utils.dart';
import 'package:carto/views/widgets/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:carto/views/widgets/tags.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

/// The page who display the establishment data to a user
class EstablishmentDisplayPage extends StatefulWidget {

  /// The initializer of the class
  const EstablishmentDisplayPage({super.key});

  @override
  State<EstablishmentDisplayPage> createState() =>
      _EstablishmentDisplayPageState();
}


/// The state of the EstablishmentDisplayPage stateful widget
class _EstablishmentDisplayPageState extends State<EstablishmentDisplayPage> {
  /// The url to the image who represent the establishment
  String? _imageUrl;
  /// The Supabase instance to fetch the image
  final supabase = Supabase.instance.client;
  /// The folder name where to search the image
  final folderName = 'establishment-images';
  /// The state of loading for the image
  bool _isLoading = true;
  /// The establishment who information where displayed
  late Establishment establishment;


  @override
  void initState() {
    super.initState();
  }

  /// Fetch the image of the establishment
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

  /// Give the url used to fetch the image of the establishment
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
    establishment = arguments['establishment'];
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
                    icon: Icons.map,
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
                                  color: black,
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
                               onPressed: _call,
                             ),
                             IconButton(
                               icon: const Icon(Icons.share,
                                   color: Color(0xFF005CFF)),
                               onPressed: _shareEstablishment,
                             ),
                           establishment.site.isEmpty ?
                             const SizedBox() :
                             IconButton(
                               icon: const Icon(Icons.open_in_browser,
                                   color: Color(0xFF005CFF)),
                               onPressed: _openBrowser,
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
                                  onPressed: _call,
                                  text: establishment.phoneNumber
                                ),
                            establishment.emailAddress.isEmpty ?
                              const SizedBox() :
                              OutlineButtonWithTextAndIcon(
                                icon: Icons.mail,
                                onPressed: _sendEmail,
                                text: establishment.emailAddress
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    if(DataManager.isLogged)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Divider(height: 32, thickness: 1, color: Colors.black),
                          LargeDefaultElevatedButton(
                            title: "Des informations sont erronées ? ",
                            onPressed: _falseData,
                            height: 50,
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

  /// Share the establishment with other application
  ///
  /// ```
  /// name
  /// address
  /// available game
  /// contact (if available)
  /// ```
  void _shareEstablishment() async {
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

  /// Launch the telephone app with the number of the establishment
  void _call() async {
    if(establishment.phoneNumber.isNotEmpty) {
      Uri url = Uri.parse
      ("tel:${establishment.phoneNumber}");
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }
  }

  /// Open the preferred browser on the website of the establishment
  _openBrowser() async {
    if(establishment.site.isNotEmpty) {
      Uri url = Uri.parse(establishment.site);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }
  }

  /// Let the user chose the email app he want and open a new email with the
  /// coordinate of the establishment
  _sendEmail() async {
    if(establishment.emailAddress.isNotEmpty) {
      Uri url = Uri.parse("mailto:"
          "${establishment.emailAddress}");
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }
  }


  /// Let the user chose the email app he want and open a new email with the
  /// coordinate of contact of the application and a patron of email to warn
  /// the need of change of expired data in the page
  void _falseData() async {
    String subject = Uri.encodeComponent("Information établissement erronée");
    String body = Uri.encodeComponent(
        "Bonjour,\n\n"
        "Je suis l'utilisateur ${DataManager.account?.username} et je vous "
          "contacte car j'ai repéré des erreurs dans l'établissement "
          "\"${establishment.name}\" situé au ${establishment.address}.\n\n"
        "Les erreurs sont :\n"
        "   -"
    );
    Uri url = Uri.parse("mailto:cartoapp.contact@gmail.com?subject=$subject&body=$body");
    if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
    }
  }
}
