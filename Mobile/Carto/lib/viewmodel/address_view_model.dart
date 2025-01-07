
import '../models/address.dart';
import '../services/address_service.dart';

class AddressViewModel{
  AddressService addressService = AddressService();

  Future<List<Address>> searchAdress(String partialAddress){
    return addressService.searchAddress(partialAddress);
  }
}