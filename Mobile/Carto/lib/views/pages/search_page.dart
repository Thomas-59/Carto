import 'package:flutter/material.dart';

import 'package:carto/models/establishment.dart';
import 'package:carto/views/services/establishment_service.dart';
import 'package:carto/views/widgets/constants.dart';
import 'package:carto/views/widgets/tags.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin
{
  final TextEditingController _searchController = TextEditingController();
  final EstablishmentService _establishmentService = EstablishmentService();
  List<Establishment> _allEstablishments = [];
  List<Establishment> _filteredEstablishments = [];
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _loadEstablishments();
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController!.indexIsChanging) {
      String currentQuery = _searchController.text;
      if (currentQuery.isNotEmpty) {
        if (_tabController!.index == 0) {
          _filterEstablishmentsByName(currentQuery);
        } else if (_tabController!.index == 1) {
          _filterEstablishmentsByAddress(currentQuery);
        }
      }
    }
  }

  void _loadEstablishments() async {
    try {
      List<Establishment> establishments =
        await _establishmentService.getAllEstablishment();
      setState(() {
        _allEstablishments = establishments;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors du chargement des établissements : $e'),
        ),
      );
    }
  }

  void _filterEstablishmentsByName(String query) {
    if (query.length >= 4) {
      setState(() {
        _filteredEstablishments = _allEstablishments
            .where((establishment) =>
            establishment.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        _filteredEstablishments = [];
      });
    }
  }

  void _filterEstablishmentsByAddress(String query) {
    if (query.length >= 4) {
      setState(() {
        _filteredEstablishments = _allEstablishments
            .where((establishment) =>
            establishment.address.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        _filteredEstablishments = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RECHERCHE'),
        backgroundColor: blue,
        titleTextStyle: appBarTextStyle,
        centerTitle: true,
        iconTheme: const IconThemeData(color: white),
        bottom: TabBar(
          controller: _tabController,
          labelStyle: whiteTextNormal14,
          unselectedLabelStyle: whiteTextBold14,
          indicatorColor: white,
          tabs: const [
            Tab(text: 'Établissement'),
            Tab(text: 'Adresse'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSearchTab(
            hintText: 'Rechercher par nom d\'établissement...',
            onSearch: _filterEstablishmentsByName,
          ),
          _buildSearchTab(
            hintText: 'Rechercher par adresse...',
            onSearch: _filterEstablishmentsByAddress,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTab({
    required String hintText,
    required Function(String) onSearch
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: hintText,
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  onSearch('');
                },
              )
                  : null,
            ),
            onChanged: (query) {
              onSearch(query);
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _filteredEstablishments.isEmpty
                ? Center(
              child: _searchController.text.length < 4
                  ? const Text(
                'Entrer le texte pour commencer la recherche...',
                style: textInPageTextStyle,
                textAlign: TextAlign.center,
              )
                  : const Text(
                'Aucun établissement trouvé.',
                style: textInPageTextStyle,
                textAlign: TextAlign.center,
              ),
            )
                : ListView.builder(
              itemCount: _filteredEstablishments.length,
              itemBuilder: (context, index) {
                final establishment = _filteredEstablishments[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(
                      context,
                      '/etablishment_detail',
                      arguments: {'establishment': establishment},
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            establishment.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: blue,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            establishment.address,
                            style: const TextStyle(
                              fontSize: 14,
                              color: black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GameTagsList(
                              games: establishment.gameTypeDtoList),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
