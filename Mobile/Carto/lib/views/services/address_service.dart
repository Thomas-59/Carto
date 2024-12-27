import 'package:dio/dio.dart';

import '../../models/address.dart';
import '../../models/address_search.dart';

class AddressService {
  final Dio dio = Dio();

  Future<List<Address>> searchAddress(String addressToSearch) async {
    String query = toQuery(addressToSearch);
    Response<dynamic> response = await dio.get(
        "https://api-adresse.data.gouv.fr/search/?q=$query&type=housenumber"
    );
    AddressSearch addressSearch = AddressSearch.fromJson(response.data);
    return addressSearch.addressList;
  }

  String toQuery(String addressToSearch) {
    return addressToSearch.trim().replaceAll(" ", "+");
  }
}
