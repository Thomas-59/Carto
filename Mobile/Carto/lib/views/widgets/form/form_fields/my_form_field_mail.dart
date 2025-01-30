import 'package:carto/views/widgets/form/form_fields/my_form_field.dart';

/// The default form field for email address
class MyFormFieldMail extends MyFormField {
  /// The initializer of the class
  const MyFormFieldMail({
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

    final RegExp mailRegex =
    RegExp( r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" );
    if(!mailRegex.hasMatch(value)) {
      return "$value n'est pas ${isFeminine ? "une" : "un"} "
        "${label.toLowerCase()} valide";
    }

    return null;
  }
}
