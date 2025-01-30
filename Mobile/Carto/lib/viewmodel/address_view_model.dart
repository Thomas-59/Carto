import '../models/address.dart';
import '../services/address_service.dart';

/// The viewModel of the service to manage an address
class AddressViewModel {
  /// The instance of the service who manage the address service
  AddressService addressService = AddressService();

  /// Search a address comparable to the proposed address
  Future<List<Address>> searchAddress(String partialAddress) {
    return addressService.searchAddress(partialAddress);
  }
}