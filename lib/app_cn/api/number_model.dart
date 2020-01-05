class NumberModel {
  String text;
  int number;

  NumberModel({
    String text,
    int number,
  });

  NumberModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    number = (json['number'] as num).toInt();
  }
}
