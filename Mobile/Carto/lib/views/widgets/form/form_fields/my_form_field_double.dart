import 'package:carto/views/widgets/form/form_fields/my_form_field.dart';

/// The default form field for double value
class MyFormFieldDouble extends MyFormField {
  /// The initializer of the class
  const MyFormFieldDouble({
    super.key,
    required super.label,
    required super.controller,
    super.isFeminine,
    super.canBeEmpty,
    super.minLines,
    super.maxLines,
  });

  /// Return a string with the message error if the value is not valid
  @override
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      if(canBeEmpty) {
        return null;
      } else {
        return "Veuillez entrer ${isFeminine ? "une" : "un"} "
          "${label.toLowerCase()}";
      }
    }

    try {
      double.parse(value);
    } catch (e) {
      return "Veuillez entrer ${isFeminine ? "une" : "un"} "
        "${label.toLowerCase()} valide";
    }

    return null;
  }
}
