import 'package:flutter/cupertino.dart';

class DefaultText extends Text {

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