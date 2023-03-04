import 'dart:io';
import 'package:path_provider/path_provider.dart';

// Fetch content from local json file
Future<File> getJson() async {
  const String fileName = "test.json";
  final directory = await getApplicationDocumentsDirectory();
  String path = directory.path;

  // validate JSON file, create one if null
  String pathToCheck = '$path/$fileName';

  if (await File(pathToCheck).exists() == true) {
    // open and return it
    return File(pathToCheck);
  } else {
    // create, open, and return it
    File loadJson = await File(pathToCheck).create();
    //File loadJson = File(pathToCheck);
    return await loadJson.writeAsString('{"loads": [], "fireArms": []}');
  }
}
