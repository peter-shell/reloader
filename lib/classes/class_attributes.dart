class Attributes {
  String value;
  String labelText;
  String hintText;
  String name;

  Attributes(
      {required this.value,
      required this.labelText,
      required this.hintText,
      required this.name});

  factory Attributes.fromJson(Map<String, dynamic> data) {
    final value = data['value'] as String?;
    final labelText = data['labelText'] as String?;
    final hintText = data['hintText'] as String?;
    final name = data['name'] as String?;
    return Attributes(
        value: value ?? "",
        labelText: labelText ?? "",
        hintText: hintText ?? "",
        name: name ?? "");
  }
  Map<String, dynamic> toJson() => {
        "value": value,
        "labelText": labelText,
        "hintText": hintText,
        "name": name
      };
}
