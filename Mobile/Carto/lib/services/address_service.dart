import 'package:dio/dio.dart';

import '../../models/address.dart';
import '../../models/address_search.dart';

/// The service to get a address from the government API
class AddressService {
  /// The dio service
  final Dio dio = Dio();

  /// Search a address comparable to the proposed address
  Future<List<Address>> searchAddress(String addressToSearch) async {
    String query = _toQuery(addressToSearch);
    Response<dynamic> response = await dio.get(
        "https://api-adresse.data.gouv.fr/search/?q=$query&type=housenumber"
    );
    AddressSearch addressSearch = AddressSearch.fromJson(response.data);
    return addressSearch.addressList;
  }

  /// Parse the address to a state usable by the apy
  String _toQuery(String addressToSearch) {
    return addressToSearch.trim().replaceAll(" ", "+");
  }
}
