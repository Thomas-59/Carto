import 'package:carto/views/widgets/form/form_fields/my_form_field.dart';

class MyFormFieldDouble extends MyFormField {
  const MyFormFieldDouble({
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

    try {
      double.parse(value);
    } catch (e) {
      return "Veuillez entrer ${isFeminine ? "une" : "un"} "
        "${label.toLowerCase()} valide";
    }

    return null;
  }
}
