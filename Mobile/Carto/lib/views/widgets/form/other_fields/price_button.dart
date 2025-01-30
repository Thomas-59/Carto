import 'package:flutter/material.dart';

import '../../../../enum/price_enum.dart';

/// The widget to chose the average price between is three state
class PriceButton extends StatefulWidget {
  /// The initial average price
  final PriceEnum averageGamePrice;
  /// The action to take on price change
  final ValueChanged<PriceEnum> onPriceChanged;
  /// The text to show before the button
  final String text;

  /// The initializer of the class
  const PriceButton({
    super.key,
    required this.averageGamePrice,
    required this.onPriceChanged,
    required this.text
  });

  @override
  State<PriceButton> createState() => _PriceButtonState();
}

/// The state of PriceButton
class _PriceButtonState extends State<PriceButton> {
  /// The chosen average price
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
            _setButton("€", PriceEnum.low),
            _setButton("€€", PriceEnum.medium),
            _setButton("€€€", PriceEnum.high),
          //],),
        ],
      )
    );
  }

  /// Set the radio button on the widget
  Widget _setButton(String title, PriceEnum value) {
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