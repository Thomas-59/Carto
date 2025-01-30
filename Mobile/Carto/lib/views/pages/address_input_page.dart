import 'package:carto/viewmodel/address_view_model.dart';
import 'package:flutter/material.dart';

import '../../models/address.dart';
import '../widgets/constants.dart';

/// The page to seek after a address existing in the French government API
class AddressInputPage extends StatefulWidget {

  /// The address to initially show in the page
  final Address? initialAddress;

  /// The call back to doe when the address is validated
  final Function(Address? address, String latitude, String longitude)
    onAddressValidated;

  /// The initializer of the class
  const AddressInputPage({
    super.key,
    required this.initialAddress,
    required this.onAddressValidated,
  });

  @override
  State<AddressInputPage> createState() => _AddressInputPageState();
}

/// The state of the AddressInputPage stateful widget
class _AddressInputPageState extends State<AddressInputPage> {
  /// The TextEditingController of the field where enter the new address
  late TextEditingController _addressController;
  /// The list of corresponding address to show to the user
  late List<Address> _listAddress=[];
  /// The view model to access to the service which communicate with the french
  /// government API
  AddressViewModel addressViewModel = AddressViewModel();
  /// The chosen address
  Address? _addressPick;
  /// The validity state of the address
  bool _addressIsValid = false;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: "");
    _addressController.addListener(() async {
      setState(() {
        _addressIsValid = _addressValueIsValid(_addressController.text);
      });
    super.initState();
    });
  }

  /// Try if the address is valid
  bool _addressValueIsValid(String value) {
    return value.isNotEmpty;
  }

  /// update _listAddress with new corresponding address
  void getResult()  async {
    if (_addressController.text.length > 2) {
      var res = await addressViewModel.searchAddress(_addressController.text);
      setState(() {
        _listAddress = res;
      });
    } else {
      setState(() {
        _listAddress = [];
        _addressPick = null;
      });
    }
  }


  /// If a address is chosen, call onAddressValidated and go back to the last
  /// page or send a popup to warn the user to chose a address before retrying
  /// this action
  void _validateAddress() {
    var lat =_addressPick!.geometry.coordinates[1];
    var long =_addressPick!.geometry.coordinates[0];
    if (_addressController.text.isNotEmpty) {
      widget.onAddressValidated(
        _addressPick,
        "$lat",
        "$long",
      );

      // Optionally navigate back to GeneralForm
      Navigator.pop(context);
    } else {
      // Show an error if the address is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez entrer une adresse.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ENTRER L'ADRESSE"),
          backgroundColor: blue,
          titleTextStyle: appBarTextStyle,
          centerTitle: true,
      iconTheme: const IconThemeData(color: white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Saisissez l'adresse de l'établissement :",
              style: blackTextBold16,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _addressController,
              onChanged: (value) {
                getResult();
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "1 Rue de la Paix 75002 Paris",
                hintStyle: greyTextBold16,
              ),
            ),
            _listAddress.isNotEmpty? Expanded(
              child: ListView.builder(
                itemCount: _listAddress.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ElevatedButton(
                      style: _addressPick == _listAddress[index] ?
                        const ButtonStyle(
                          backgroundColor :
                            WidgetStatePropertyAll(Colors.greenAccent)
                        )
                        : null,
                      onPressed: () {
                        setState(() {
                          _addressPick = _listAddress[index];
                          _addressController.text =
                              _addressPick!.properties.label;
                        });
                      },
                      child: Text(_listAddress[index].properties.label)
                    ),
                    enabled: _addressIsValid,
                  );
                },),
            ):const SizedBox(),
            const SizedBox(height: 20),
            _addressPick!=null?Center(
              child: ElevatedButton(
                onPressed: _validateAddress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: white,
                ),
                child: const Text("Valider", style: blueTextBold16,),
              ),
            ):const SizedBox(),
          ],
        ),
      ),
    );
  }
}
