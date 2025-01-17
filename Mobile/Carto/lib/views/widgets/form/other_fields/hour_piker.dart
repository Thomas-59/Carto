import 'package:carto/views/widgets/constants.dart';
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
    return Padding( padding: const EdgeInsets.all(8.0),
      child : Column(
        children: <Widget>[
          Text(widget.text, style: blueTextBold16,),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _setButton("ouvert", true),
            _setButton("fermé", false),
          ],),
          Visibility(
            visible: _opened,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("de"),
                InkWell(
                  onTap: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: _openingTime
                    );
                    if (pickedTime != null && pickedTime != _openingTime) {
                      setState(() {
                        _openingTime = pickedTime;
                        widget.onTimeChange(<TimeOfDay> [_openingTime,
                          _closingTime]);
                      });
                    }
                  },
                  child: _setTime(_openingTime.hour, _openingTime.minute),
                ),
                Text("à"),
                InkWell(
                  onTap: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: _closingTime
                    );
                    if (pickedTime != null && pickedTime != _closingTime) {
                      setState(() {
                        _closingTime = pickedTime;
                        widget.onTimeChange(<TimeOfDay> [_openingTime,
                          _closingTime]);
                      });
                    }
                  },
                  child: _setTime(_closingTime.hour, _closingTime.minute),
                ),
              ],
            ),
          ),

        ],
      )
    );
  }

  Widget _setButton(String title, bool value) {
    return Expanded(
      child: RadioListTile<bool>(
        title: Text(
            title,
            style: const TextStyle(fontSize: 15)
        ),
        value: value,
        groupValue: _opened,
        onChanged: (bool? value) {
          if (value != null) {
            setState(() {
              _opened = value;
              widget.onOpeningChange(value);
            });
          }
        }
      )
    );
  }

  Widget _setTime(int hour, int minute) {
    return Row(
      children: [
        _setBox(hour.toString()),
        const Text(" : "),
        _setBox(minute.toString()),
      ],
    );
  }

  Widget _setBox(String title) {
    return Container(
      width: 60.0,
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