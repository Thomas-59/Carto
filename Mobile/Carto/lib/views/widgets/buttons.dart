import 'package:flutter/material.dart';
import 'package:carto/views/widgets/constants.dart';

import 'dart:math' as math;

class WhiteSquareIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const WhiteSquareIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: const Color(0xFF005CFF),
          ),
        ),
      ),
    );
  }
}

class BlueSquareIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const BlueSquareIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: blue,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: white,
          ),
        ),
      ),
    );
  }
}

class WhiteSquareIconInvertedButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const WhiteSquareIconInvertedButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Icon(
              icon,
              color: const Color(0xFF005CFF),
            ),
          ),
        ),
      ),
    );
  }
}

class OutlineButtonWithTextAndIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String text;

  const OutlineButtonWithTextAndIcon({
    required this.icon,
    required this.onPressed,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: blue,
        side: const BorderSide(color: blue, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: white,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: whiteTextBold16,
          ),
        ],
      ),
    );
  }
}

class MyElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final Color color;
  final TextStyle textStyle;
  
  const MyElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width = 200,
    this.height = 20,
    this.color = Colors.white,
    this.textStyle = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return  Padding( padding: const EdgeInsets.all(8.0),
      child : ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          fixedSize: Size(width, height)
        ),
        onPressed: onPressed,
        child: Text(
            title,
          style: textStyle,
        ),
      ),
    );
  }
  
}
