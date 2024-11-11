import 'package:flutter/material.dart';

import '../../../../enum/price_enum.dart';

class PriceButton extends StatefulWidget {
  final PriceEnum averageGamePrice;
  final ValueChanged<PriceEnum> onPriceChanged;
  final String text;

  const PriceButton({
    super.key,
    required this.averageGamePrice,
    required this.onPriceChanged,
    required this.text
  });

  @override
  State<PriceButton> createState() => _PriceButtonState();
}

class _PriceButtonState extends State<PriceButton> {
  late PriceEnum _selectedPrice;

  @override
  void initState() {
    super.initState();
    _selectedPrice = widget.averageGamePrice;
  }

  @override
  Widget build(BuildContext context) {
    return Padding( padding: const EdgeInsets.all(8.0),
      child : Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(widget.text),
          /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[*/
            setButton("€", PriceEnum.low),
            setButton("€€", PriceEnum.medium),
            setButton("€€€", PriceEnum.high),
          //],),
        ],
      )
    );
  }

  Widget setButton(String title, PriceEnum value) {
    return Column(
      children: [
        Text(title),
        Radio<PriceEnum>(
          value: value,
          groupValue: _selectedPrice,
          onChanged: (PriceEnum? value) {
            if (value != null) {
              setState(() {
                _selectedPrice = value;
                widget.onPriceChanged(value);
              });
            }
          },
        ),
      ],
    );
  }
}