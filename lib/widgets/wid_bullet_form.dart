import 'package:flutter/material.dart';
import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';
import 'package:measure_group/widgets/wid_powder_form.dart';

// serves as the create and edit screens for building/editing a cartridge
// bullet_form -> powder_form -> brass_form -> primer_form -> cartridge_form
class BulletForm extends StatefulWidget {
  BulletForm(
      {super.key,
      required this.loadObjects,
      required this.fireArmObjects,
      required this.blankCartridge,
      required this.titleString,
      required this.arrow});
  List<Cartridge> loadObjects;
  List<FireArm> fireArmObjects;
  String titleString;
  bool arrow;

  Cartridge blankCartridge;
  // passing in bulletObject so we can use the same screen to update
  // already created cartridges

  @override
  State<BulletForm> createState() => _BulletFormState();
}

class _BulletFormState extends State<BulletForm> {
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
      appBar: AppBar(
        title: Text(widget.titleString),
        // this is a cheap hack to keep the user from moving all the way out of
        // of the create/edit cartridge screens. Maybe need some more thought on
        // better solution to keep the user from dropping information unexpectedly

        automaticallyImplyLeading: widget.arrow,
      ),
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
                              initialValue:
                                  widget.blankCartridge.bullet.bulletCaliber,
                              decoration: const InputDecoration(
                                hintText: "Ex: 6.5 Creedmoor",
                                labelText: "Caliber",

                                //enabledBorder: OutlineInputBorder()
                              ),
                              onChanged: (text) {
                                widget.blankCartridge.bullet.bulletCaliber =
                                    text;
                              },
                            ),
                            TextFormField(
                              initialValue:
                                  widget.blankCartridge.bullet.bulletWeight,
                              decoration: const InputDecoration(
                                  hintText: "Ex: 147 or 153.5",
                                  labelText: "Bullet Weight"),
                              onChanged: (text) {
                                widget.blankCartridge.bullet.bulletWeight =
                                    text;
                              },
                            ),
                            TextFormField(
                              initialValue: widget
                                  .blankCartridge.bullet.bulletManufacture,
                              decoration: const InputDecoration(
                                  hintText: "Ex: Berger",
                                  labelText: "Bullet Manufacture"),
                              onChanged: (value) {
                                widget.blankCartridge.bullet.bulletManufacture =
                                    value;
                              },
                            ),
                            TextFormField(
                              initialValue:
                                  widget.blankCartridge.bullet.bulletName,
                              decoration: const InputDecoration(
                                  hintText: "Ex: Long Range Hybrid Target",
                                  labelText: "Bullet Name"),
                              onChanged: (value) {
                                widget.blankCartridge.bullet.bulletName = value;
                              },
                            ),
                            TextFormField(
                              initialValue: widget.blankCartridge.bullet.g1bc,
                              decoration: const InputDecoration(
                                  hintText: "Ex: .694",
                                  labelText: "Bullet G1 BC"),
                              onChanged: (value) {
                                widget.blankCartridge.bullet.g1bc = value;
                              },
                            ),
                            TextFormField(
                              initialValue: widget.blankCartridge.bullet.g7bc,
                              decoration: const InputDecoration(
                                  hintText: "Ex: .356",
                                  labelText: "Bullet G7 BC"),
                              onChanged: (value) {
                                widget.blankCartridge.bullet.g7bc = value;
                              },
                            ),
                            TextFormField(
                              initialValue:
                                  widget.blankCartridge.bullet.bulletDiameter,
                              decoration: const InputDecoration(
                                  hintText: ".264",
                                  labelText: "Bullet Diameter"),
                              onChanged: (value) {
                                widget.blankCartridge.bullet.bulletDiameter =
                                    value;
                              },
                            ),
                            TextFormField(
                              initialValue:
                                  widget.blankCartridge.bullet.bulletLotNumber,
                              decoration: const InputDecoration(
                                  hintText: "Ex: XXXXX",
                                  labelText: "Bullet Lot Number"),
                              onChanged: (value) {
                                widget.blankCartridge.bullet.bulletLotNumber =
                                    value;
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  // TODO: fix button width, it's too big right now
                  onPressed: () {
                    // pass firearms, loads, bullet to next screen
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PowderForm(
                                  loadObjects: widget.loadObjects,
                                  fireArmObjects: widget.fireArmObjects,
                                  blankCartridge: widget.blankCartridge,
                                  titleString: "Powder Information",
                                )));
                  },
                  // TODO: need to add function to package for cloud here
                  // build new object from forms, add to loadsList, convert
                  // lists to json, save, force reload
                  // formKey.currentState.validate();
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Text('Next'),
                )
              ],
            )),
      ),
    );
  }
}
