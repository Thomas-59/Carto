import 'package:carto/views/widgets/constants.dart';
import 'package:flutter/material.dart';

/// The widget to show and pick opening hour
class HourPiker extends StatefulWidget {
  /// The action to take on hour change
  final ValueChanged<List<TimeOfDay>> onTimeChange;
  /// The action to take on opening change
  final ValueChanged<bool> onOpeningChange;
  /// The initial opening hour
  final TimeOfDay openingTime;
  /// The initial closing hour
  final TimeOfDay closingTime;
  /// The label of the day
  final String text;
  /// The initial opening state
  final bool isClosed;

  /// The initializer of the class
  const HourPiker({
    super.key,
    required this.text,
    required this.isClosed,
    required this.openingTime,
    required this.closingTime,
    required this.onTimeChange,
    required this.onOpeningChange
  });

  @override
  State<HourPiker> createState() => _HourPikerState();
}

/// The state of HourPiker
class _HourPikerState extends State<HourPiker> {
  /// The current opening hour
  late TimeOfDay _openingTime;
  /// The current closing hour
  late TimeOfDay _closingTime;
  /// The current opening state
  late bool _isClosed;

  @override
  void initState() {
    super.initState();
    _isClosed = widget.isClosed;
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
            _setButton("ouvert", false),
            _setButton("fermé", true),
          ],),
          Visibility(
            visible: !_isClosed,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("de"),
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
                const Text("à"),
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

  /// Give the widget which chose the opening state
  Widget _setButton(String title, bool value) {
    return Expanded(
      child: RadioListTile<bool>(
        title: Text(
            title,
            style: const TextStyle(fontSize: 15)
        ),
        value: value,
        groupValue: _isClosed,
        onChanged: (bool? value) {
          if (value != null) {
            setState(() {
              _isClosed = value;
              widget.onOpeningChange(value);
            });
          }
        }
      )
    );
  }

  /// Give the widget representing a hour
  Widget _setTime(int hour, int minute) {
    return Row(
      children: [
        _setBox(hour.toString()),
        const Text(" : "),
        _setBox(minute.toString()),
      ],
    );
  }

  /// Give the box representing a hour or a minute
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