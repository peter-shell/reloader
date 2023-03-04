class Shot {
  double velocity;
  double xpos;
  double ypos;

  Shot({required this.velocity, required this.xpos, required this.ypos});

  factory Shot.fromJson(Map<String, dynamic> data) {
    final velocity = double.parse(data['velocity'] ?? "0.0");
    // not sure if this is the most efficient thing to do here
    //final tempxpos = data['xpos'] as String?;
    final xpos = double.parse(data['xpos'] ?? "0.0");
    // final tempypos = data['ypos'] as String?;
    final ypos = double.parse(data['ypos'] ?? "0.0");

    return Shot(velocity: velocity, xpos: xpos, ypos: ypos);
  }
  Map<String, dynamic> toJson() => {
        "velocity": velocity.toString(),
        "xpos": xpos.toString(),
        "ypos": ypos.toString()
      };
}
