import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';

import 'module/mod_get_json.dart' as get_json;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:measure_group/widgets/wid_load_view.dart';
// import 'package:measure_group/widgets/wid_load_form.dart';
import 'package:measure_group/module/mod_unwrap_json_to_obj.dart' as unwrap;
import 'package:measure_group/module/mod_empty_cart_obj.dart' as empty;
import 'package:measure_group/widgets/wid_bullet_form.dart';

// General design: JSON from cloud->converted to load or fireArm objects->custom
// list view->any create, update, or delete get's packaged back into JSON file
// with all other objects->sent to cloud->back to JSON from cloud for the
// rebuild
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reloading Log',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Reloading Log'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Cartridge> loadObjects = [];
  List<FireArm> fireArmObjects = [];

  Future<void> readJson() async {
    //  below reads file from app's documents, this is where FireStore gets inserted
    // and replaces the local file
    final File response = await get_json.getJson();
    String responseString = await response.readAsString();
    //print(responseString);
    final data = await json.decode(responseString);
    setState(() {
      List objs = unwrap.unwrap(data);
      loadObjects = objs[0];
      fireArmObjects = objs[1];
    });
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //File? image;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          LoadsView(loadObjects: loadObjects, fireArmObjects: fireArmObjects),
          // fireArm objects gets sent alongside loadObjects because all objects
          // will need combined and sent to file storage to update the overall JSON
          // file that runs this whole thing
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: FloatingActionButton.extended(
                label: const Text('New Entry'),
                onPressed: (() {
                  // TODO: create blank cartridge object here
                  // TODO: add to List, send list with index to new LoadForm widget
                  Cartridge blankCartridge = empty.createSingleLoadObj();
                  // loadObjects.add(blankCartridge);
                  // print(blankCartridge.bullet.bulletCaliber);
                  int loadIndex = loadObjects.length - 1;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BulletForm(
                                loadObjects: loadObjects,
                                fireArmObjects: fireArmObjects,
                                blankCartridge: blankCartridge,
                                titleString: "Bullet Information",
                                arrow: true,
                              ))).then((value) => setState(() {}));
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
