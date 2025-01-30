import 'package:flutter/cupertino.dart';

/// The text with parameter and padding by default for the application
class DefaultText extends Text {

  /// The initializer of the class
  const DefaultText(
    super.data,
    {
      super.key,
      super.locale,
      super.maxLines,
      super.overflow,
      super.selectionColor,
      super.semanticsLabel,
      super.softWrap,
      super.strutStyle,
      super.style,
      super.textAlign,
      super.textDirection,
      super.textHeightBehavior,
      super.textScaler,
      super.textWidthBasis,
    }
  );

  @override
  Widget build(BuildContext context) {
    return  Padding( padding: const EdgeInsets.all(8.0),
      child: super.build(context)
    );
  }
}