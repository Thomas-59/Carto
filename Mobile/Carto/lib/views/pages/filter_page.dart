import 'dart:collection';
import 'package:carto/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:carto/views/widgets/filter_tag.dart';

import '../../models/establishment.dart';
import '../widgets/constants.dart';
import '../widgets/map_widget.dart';

/// The page with all filter the user can apply on the map
class FilterPage extends StatefulWidget {

  /// The initializer of the class
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}


/// The state of the FilterPage stateful widget
class _FilterPageState extends State<FilterPage> {
  /// The list of all used filter
  late HashMap<String, bool> filterMap;

  @override
  void initState() {
    super.initState();
    filterMap = DataManager.filterMap;
  }

  /// Apply or discard a filter
  void _toggleFilter(String tagName) {
    setState(() {
      filterMap[tagName] = !filterMap[tagName]!;
    });
    DataManager.filterMap = filterMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TES FILTRES"),
        backgroundColor: blue,
        titleTextStyle: appBarTextStyle,
        centerTitle: true,
        iconTheme: const IconThemeData(color: white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                const Text(
                  'Jeux',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const Divider(color: Colors.orange),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: filterMap.keys.map((tagName) {
                    return FilterTag(
                      filterMap: filterMap,
                      tagName: tagName,
                      onToggle: _toggleFilter,
                    );
                  }).toList(),
                ),
              Padding(padding: const EdgeInsets.all(5.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if(noFilterSelected(filterMap)){
                        resetFilter();
                        Navigator.pop(context);
                        MapWidget.mapKey.currentState?.reload();
                      }
                      else{
                        appliedFilter(filterMap,
                            await DataManager.establishmentsOriginFuture);
                        Navigator.pop(context);
                        MapWidget.mapKey.currentState?.reload();
                      }
                    },
                    style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.greenAccent)),
                    child: const Text('Appliquer'),
                  ),
                  ElevatedButton(onPressed: () {
                    resetMap(filterMap);
                    MapWidget.mapKey.currentState?.reload();
                  }, child: const Text('Réinitialiser'))
                ],
              ),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Discard all filter in the hashMap
  resetMap(HashMap<String,bool> filterMap){
    setState(() {
      filterMap['Billard']= false;
      filterMap['Fléchettes']= false;
      filterMap['Babyfoot']= false;
      filterMap['Ping-Pong']= false;
      filterMap['Arcade']= false;
      filterMap['Flipper']= false;
      filterMap['Karaoké']= false;
      filterMap['Cartes']= false;
      filterMap['Sociétés']= false;
      filterMap['Pétanque']= false;
    });
    DataManager.filterMap = filterMap;
  }

  /// return true if no filter is used
  noFilterSelected(HashMap<String,bool> filterMap){
    for(MapEntry<String,bool> entry in filterMap.entries){
      if(entry.value){
        return false;
      }
    }
    return true;
  }

  /// apply all chosen filter on the map
  appliedFilter(HashMap<String,bool> filterMap,List<Establishment> toFiltered){
    List<Establishment> filtered= [];
    for(Establishment establishment in toFiltered){
      for(GameTypeDto gameTypeDto in establishment.gameTypeDtoList){
        if(filterMap[gameTypeDto.gameType.value]!){
          filtered.add(establishment);
          break;
        }
      }
    }
    DataManager.establishmentsFuture=Future.value(filtered);
  }

  /// Discard all used filter
  resetFilter(){
    DataManager.establishmentsFuture = DataManager.establishmentsOriginFuture;
  }
}
