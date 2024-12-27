import 'package:carto/views/services/address_service.dart';

import '../models/address.dart';

class AddressViewModel{
  AddressService addressService = AddressService();

  Future<List<Address>> searchAdress(String partialAddress){
    return addressService.searchAddress(partialAddress);
  }
}