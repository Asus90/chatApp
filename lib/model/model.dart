import 'package:app/ui/userUi.dart';

class model {
  var number;

  model({
    required this.number,
  });
  factory model.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return model(
        number: '',
      );
    } else {
      return model(
        number: json['number'],
      );
    }
  }
}
