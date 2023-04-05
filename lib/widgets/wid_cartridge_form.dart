import 'package:flutter/material.dart';
import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';
import 'package:measure_group/module/mod_wrap_obj_to_json.dart' as rewrap;
import 'package:measure_group/module/mod_save_json.dart' as save_json;

class CartridgeForm extends StatefulWidget {
  CartridgeForm(
      {super.key,
      required this.loadObjects,
      required this.fireArmObjects,
      required this.blankCartridge,
      required this.titleString});

  List<Cartridge> loadObjects;
  List<FireArm> fireArmObjects;
  Cartridge blankCartridge;
  String titleString;

  @override
  State<CartridgeForm> createState() => _CartridgeFormState();
}

class _CartridgeFormState extends State<CartridgeForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titleString)),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: formKey,
            child: ListView(
              children: [
                Card(
                  child: Column(
                    children: [
                      ListTile(title: Text(widget.titleString)),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: widget.blankCartridge.powderWeight,
                              decoration: const InputDecoration(
                                  hintText: "Ex: 41.5",
                                  labelText: "Charge Weight"),
                              onChanged: (value) {
                                widget.blankCartridge.powderWeight = value;
                              },
                            ),
                            TextFormField(
                              initialValue: widget.blankCartridge.trimLength,
                              decoration: const InputDecoration(
                                  hintText: "Ex: 2.2",
                                  labelText: "Trim Length"),
                              onChanged: (value) {
                                widget.blankCartridge.trimLength = value;
                              },
                            ),
                            TextFormField(
                              initialValue: widget.blankCartridge.coal,
                              decoration: const InputDecoration(
                                  hintText: "Ex: 2.8",
                                  labelText: "Cartridge Over All Length"),
                              onChanged: (value) {
                                widget.blankCartridge.trimLength = value;
                              },
                            ),
                            TextFormField(
                              initialValue: widget.blankCartridge.cbto,
                              decoration: const InputDecoration(
                                  hintText: "Ex: 2.55",
                                  labelText: "Cartridge Base To Ogive"),
                              onChanged: (value) {
                                widget.blankCartridge.cbto = value;
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  // TODO: fix button width, it's too big right now
                  onPressed: () {
                    // adds new cartridge to list
                    // turns all objects into json
                    // saves, then to home screen!
                    widget.loadObjects.insert(0, widget.blankCartridge);
                    // widget.loadObjects.add(widget.blankCartridge);
                    final newJsonData = rewrap.rewrap(
                        widget.loadObjects, widget.fireArmObjects);
                    save_json.writeJson(newJsonData);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  // TODO: need to add function to package for cloud here
                  // build new object from forms, add to loadsList, convert
                  // lists to json, save, force reload
                  // formKey.currentState.validate();
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Text('Finish'),
                )
              ],
            )),
      ),
    );
  }
}
