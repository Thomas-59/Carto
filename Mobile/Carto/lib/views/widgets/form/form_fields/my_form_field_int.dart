import 'package:carto/views/widgets/form/form_fields/my_form_field.dart';

class MyFormFieldInt extends MyFormField {
  const MyFormFieldInt({
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
      int.parse(value);
    } catch (e) {
      return "Veuillez entrer un ${label.toLowerCase()} valide";
    }

    return null;
  }
}
