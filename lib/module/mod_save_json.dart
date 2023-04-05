import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

// Fetch content from local json file
void writeJson(Map<String, dynamic> dataToWrite) async {
  const String fileName = "test.json";
  final directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  // print(path);
  String pathToSave = '$path/$fileName';
  final fileToSave = File(pathToSave);
  await fileToSave.writeAsString(json.encode(dataToWrite));
}
