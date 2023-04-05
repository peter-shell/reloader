import 'package:flutter/material.dart';
import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';
import 'package:measure_group/widgets/wid_cartridge_form.dart';

class PrimerForm extends StatefulWidget {
  PrimerForm(
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
  State<PrimerForm> createState() => _PrimerFormState();
}

class _PrimerFormState extends State<PrimerForm> {
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
                              initialValue: widget
                                  .blankCartridge.primer.primerManufacture,
                              decoration: const InputDecoration(
                                  hintText: "Ex: CCI",
                                  labelText: "Primer Manufacture"),
                              onChanged: (value) {
                                widget.blankCartridge.primer.primerManufacture =
                                    value;
                              },
                            ),
                            TextFormField(
                              initialValue:
                                  widget.blankCartridge.primer.primerName,
                              decoration: const InputDecoration(
                                  hintText: "Ex: Long Rifle",
                                  labelText: "Primer Type"),
                              onChanged: (value) {
                                widget.blankCartridge.primer.primerName = value;
                              },
                            ),
                            TextFormField(
                              initialValue:
                                  widget.blankCartridge.primer.primerLotNumber,
                              decoration: const InputDecoration(
                                  hintText: "Ex: 0",
                                  labelText: "Primer Lot Number"),
                              onChanged: (value) {
                                widget.blankCartridge.primer.primerLotNumber =
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
                            builder: (context) => CartridgeForm(
                                  loadObjects: widget.loadObjects,
                                  fireArmObjects: widget.fireArmObjects,
                                  blankCartridge: widget.blankCartridge,
                                  titleString: "Cartridge Information",
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
