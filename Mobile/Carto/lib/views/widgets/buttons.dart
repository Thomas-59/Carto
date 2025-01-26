import 'package:flutter/material.dart';
import 'package:carto/views/widgets/constants.dart';

import 'dart:math' as math;

/// The default white square icon button
class WhiteSquareIconButton extends StatelessWidget {
  /// The icon to apply on the button
  final IconData icon;
  /// the action to take when pressed
  final VoidCallback onPressed;

  /// The initializers of the class
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
            color: white,
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
            color: blue,
          ),
        ),
      ),
    );
  }
}

/// The default blue square icon button
class BlueSquareIconButton extends StatelessWidget {
  /// The icon to apply on the button
  final IconData icon;
  /// the action to take when pressed
  final VoidCallback onPressed;

  /// The initializers of the class
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
          width: 55,
          height: 55,
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

/// The default white square icon inverted button
class WhiteSquareIconInvertedButton extends StatelessWidget {
  /// The icon to apply on the button
  final IconData icon;
  /// the action to take when pressed
  final VoidCallback onPressed;

  /// The initializers of the class
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

/// The default outline button with text and icon
class OutlineButtonWithTextAndIcon extends StatelessWidget {
  /// The icon to apply on the button
  final IconData icon;
  /// the action to take when pressed
  final VoidCallback onPressed;
  /// The label to apply next to the icon
  final String text;

  /// The initializers of the class
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

/// The default elevated button medium size
class DefaultElevatedButton extends StatelessWidget {
  /// The label to apply on the button
  final String title;
  /// The action to take when pressing the button
  final VoidCallback onPressed;
  /// The height of the button
  final double height;
  /// The width of the button
  final double width;
  /// The color of the button when action is possible
  final Color validColor;
  /// The color of the button when action is not possible
  final Color unValidColor;
  /// The style to apply on the label
  final TextStyle textStyle;
  /// If the button can take action
  final bool validator;

  /// The initializers of the class
  const DefaultElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width = 200,
    this.height = 20,
    this.validColor = Colors.white,
    this.unValidColor = Colors.grey,
    this.textStyle = const TextStyle(),
    this.validator = true,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding( padding: const EdgeInsets.all(8.0),
      child : ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: validator ? validColor : unValidColor,
          fixedSize: Size(width, height)
        ),
        onPressed: validator ?
          onPressed
          : null,
        child: Text(
            title,
          style: textStyle,
        ),
      ),
    );
  }
}

/// The default blue elevated button medium size
class BlueElevatedButton extends DefaultElevatedButton {
  /// The initializers of the class
  const BlueElevatedButton({
    super.key,
    required super.title,
    required super.onPressed,
    super.height,
    super.width,
    super.validator,
    super.unValidColor,
  }): super(
    validColor: Colors.blueAccent,
    textStyle: const TextStyle(color: Colors.white)
  );
}


/// The default white elevated button medium size
class WhiteElevatedButton extends DefaultElevatedButton {
  /// The initializers of the class
  const WhiteElevatedButton({
    super.key,
    required super.title,
    required super.onPressed,
    super.height,
    super.width,
    super.validator,
    super.unValidColor,
  }): super(
      validColor: white,
      textStyle: blueTextBold16
  );
}

/// The default red elevated button medium size
class RedElevatedButton extends DefaultElevatedButton {
  /// The initializers of the class
  const RedElevatedButton({
    super.key,
    required super.title,
    required super.onPressed,
    super.height,
    super.width,
    super.validator,
    super.unValidColor
  }): super(
    validColor: Colors.red,
    textStyle: const TextStyle(color: Colors.white)
  );
}

/// The default elevated button large size
class LargeDefaultElevatedButton extends StatelessWidget {
  /// The label to apply on the button
  final String title;
  /// The action to take when pressing the button
  final VoidCallback onPressed;
  /// The height of the button
  final double height;
  /// The width of the button
  final double width;
  /// The color of the button when action is possible
  final Color validColor;
  /// The color of the button when action is not possible
  final Color unValidColor;
  /// The style to apply on the label
  final TextStyle textStyle;
  /// If the button can take action
  final bool validator;

  /// The initializers of the class
  const LargeDefaultElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width = 200,
    this.height = 20,
    this.validColor = white,
    this.unValidColor = Colors.grey,
    this.textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: blue
    ),
    this.validator = true,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding( padding: const EdgeInsets.all(8.0),
      child : FractionallySizedBox(
        alignment: Alignment.center,
        widthFactor: 0.8,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: validator ? validColor : unValidColor,
              fixedSize: Size(width, height)
          ),
          onPressed: validator ?
          onPressed
              : null,
          child: Text(
            title,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

/// The default blue elevated button large size
class LargeBlueElevatedButton extends LargeDefaultElevatedButton {
  /// The initializers of the class
  const LargeBlueElevatedButton({
    super.key,
    required super.title,
    required super.onPressed,
    super.height,
    super.width,
    super.validator,
    super.unValidColor,
  }): super(
      validColor: blue,
      textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: white
      ),
  );
}

/// The default red elevated button large size
class LargeRedElevatedButton extends LargeDefaultElevatedButton {
  /// The initializers of the class
  const LargeRedElevatedButton({
    super.key,
    required super.title,
    required super.onPressed,
    super.height,
    super.width,
    super.validator,
    super.unValidColor
  }): super(
      validColor: red,
      textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: white
      ),
  );
}