import 'package:carto/views/widgets/form/form_fields/my_form_field.dart';

class MyFormFieldHttpLink extends MyFormField {
  const MyFormFieldHttpLink({
    super.key,
    required super.label,
    required super.controller,
    super.isFeminine,
    super.canBeEmpty,
    super.minLines,
    super.maxLines,
  });

  @override
  String getValue() {
    return controller.text.isEmpty
      || controller.text.contains("http://", 0)
      || controller.text.contains("https://", 0) ?
        controller.text
        : "http://${controller.text}";
  }

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

    if(value.contains(" ")) {
      return "Les espaces ne sont pas autorisés";
    }

    return null;
  }
}
