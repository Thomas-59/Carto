import 'package:carto/views/widgets/form/form_fields/my_form_field.dart';

class MyFormFieldMail extends MyFormField {
  const MyFormFieldMail({
    super.key,
    required super.label,
    required super.controller,
    super.isFeminine,
    super.canBeEmpty,
    super.minLines,
    super.maxLines,
  });

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
