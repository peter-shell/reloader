import 'package:flutter/material.dart';
import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';
import 'package:measure_group/widgets/wid_brass_form.dart';

class PowderForm extends StatefulWidget {
  PowderForm(
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
  State<PowderForm> createState() => _PowderFormState();
}

class _PowderFormState extends State<PowderForm> {
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
                      const ListTile(title: Text('Powder Information')),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: widget
                                  .blankCartridge.powder.powderManufacture,
                              decoration: const InputDecoration(
                                  hintText: "Hodgedon",
                                  labelText: "Powder Manufacture"),
                              onChanged: (value) {
                                widget.blankCartridge.powder.powderManufacture =
                                    value;
                              },
                            ),
                            TextFormField(
                              initialValue:
                                  widget.blankCartridge.powder.powderName,
                              decoration: const InputDecoration(
                                  hintText: "Ex: H4350",
                                  labelText: "Powder Name"),
                              onChanged: (value) {
                                widget.blankCartridge.powder.powderName = value;
                              },
                            ),
                            TextFormField(
                              initialValue:
                                  widget.blankCartridge.powder.powderLotNumber,
                              decoration: const InputDecoration(
                                  hintText: "Ex: XXXXX",
                                  labelText: "Powder Lot Number"),
                              onChanged: (value) {
                                widget.blankCartridge.powder.powderLotNumber =
                                    value;
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BrassForm(
                                  loadObjects: widget.loadObjects,
                                  fireArmObjects: widget.fireArmObjects,
                                  blankCartridge: widget.blankCartridge,
                                  titleString: "Brass Information",
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
