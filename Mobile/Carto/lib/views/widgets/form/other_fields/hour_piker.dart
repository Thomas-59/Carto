import 'package:flutter/material.dart';

class HourPiker extends StatefulWidget {
  final ValueChanged<List<TimeOfDay>> onTimeChange;
  final ValueChanged<bool> onOpeningChange;
  final TimeOfDay openingTime;
  final TimeOfDay closingTime;
  final String text;
  final bool opened;

  const HourPiker({
    super.key,
    required this.text,
    required this.opened,
    required this.openingTime,
    required this.closingTime,
    required this.onTimeChange,
    required this.onOpeningChange
  });

  @override
  State<HourPiker> createState() => _HourPikerState();
}

class _HourPikerState extends State<HourPiker> {
  late TimeOfDay _openingTime;
  late TimeOfDay _closingTime;
  late bool _opened;

  @override
  void initState() {
    super.initState();
    _opened = widget.opened;
    _openingTime = widget.openingTime;
    _closingTime = widget.closingTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(widget.text),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          setButton("ouvert", true),
          setButton("fermé", false),
        ],),
        Visibility(
          visible: _opened,
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: _openingTime);
                  if (pickedTime != null && pickedTime != _openingTime) {
                    setState(() {
                      _openingTime = pickedTime;
                    });
                  }
                },
                child: setTime(_openingTime.hour, _openingTime.minute),
              ),
              InkWell(
                onTap: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: _closingTime);
                  if (pickedTime != null && pickedTime != _closingTime) {
                    setState(() {
                      _closingTime = pickedTime;
                      widget.onTimeChange(<TimeOfDay> [_openingTime, _closingTime]);
                    });
                  }
                },
                child: setTime(_closingTime.hour, _closingTime.minute),
              ),
            ],
          ),
        ),

      ],
    );
  }

  Widget setButton(String title, bool value) {
    return Expanded(
      child: RadioListTile<bool>(
        title: Text(title),
        value: value,
        groupValue: _opened,
        onChanged: (bool? value) {
          if (value != null) {
            setState(() {
              _opened = value;
              widget.onOpeningChange(value);
            });
          }
        },
      )
    );
  }

  Widget setTime(int hour, int minute) {
    return Row(
      children: [
        setBox(hour.toString()),
        const Text(" : "),
        setBox(minute.toString()),
      ],
    );
  }

  Widget setBox(String title) {
    return Container(
      width: 75.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}