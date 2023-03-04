class Note {
  String date;
  String note;

  Note({required this.date, required this.note});

  factory Note.fromJson(Map<String, dynamic> data) {
    final date = data['date'] as String?;
    // converts epoch time to DateTime
    //DateTime convertedDate = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    final note = data['note'] as String?;

    return Note(
        date: date ?? "", // formats DateTime and converts to string
        note: note ?? "");
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "note": note,
      };
}
