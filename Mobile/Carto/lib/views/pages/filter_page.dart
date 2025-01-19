import 'dart:collection';
import 'package:carto/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:carto/views/widgets/filter_tag.dart';

import '../widgets/constants.dart';
import '../widgets/map_widget.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late HashMap<String, bool> filterMap;

  @override
  void initState() {
    super.initState();
    filterMap = DataManager.filterMap;
  }

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
              Padding(padding: EdgeInsets.all(5.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if(isReset(filterMap)){
                        DataManager.resetEstablishmentsFuture();
                        Navigator.pop(context);
                        MapWidget.mapKey.currentState?.reload();
                      }
                      else{
                        DataManager.appliedFilter(filterMap,
                            await DataManager.establishmentsOriginFuture);
                        Navigator.pop(context);
                        MapWidget.mapKey.currentState?.reload();
                      }
                    },
                    child: const Text('Appliquer'),
                    style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.greenAccent)),
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

  isReset(HashMap<String,bool> filterMap){
    for(MapEntry<String,bool> entry in filterMap.entries){
      if(entry.value){
        return false;
      }
    }
    return true;
  }
}
