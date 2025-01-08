import 'package:carto/viewmodel/address_view_model.dart';
import 'package:flutter/material.dart';

import '../../models/address.dart';
import '../widgets/constants.dart';

class AddressInputPage extends StatefulWidget {
  final Address? initialAddress;
  final Function(Address? address, String latitude, String longitude)
    onAddressValidated;


  const AddressInputPage({
    super.key,
    required this.initialAddress,
    required this.onAddressValidated,
  });

  @override
  State<AddressInputPage> createState() => _AddressInputPageState();
}

class _AddressInputPageState extends State<AddressInputPage> {
  late TextEditingController _addressController;
  late List<Address> _listAddress=[];
  AddressViewModel addressViewModel = AddressViewModel();
  Address? _addressPick;
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

  bool _addressValueIsValid(String value) {
    return value.isNotEmpty;
  }

  void getResult()  async {
    if (_addressController.text.length > 2) {
      var res = await addressViewModel.searchAdress(_addressController.text);
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
                child: const Text("Valider", style: blueTextBold16,),
                style: ElevatedButton.styleFrom(
                  backgroundColor: white,
                ),
              ),
            ):const SizedBox(),
          ],
        ),
      ),
    );
  }
}
