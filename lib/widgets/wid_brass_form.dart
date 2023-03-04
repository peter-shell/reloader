import 'package:flutter/material.dart';
import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';
import 'package:measure_group/widgets/wid_primer_form.dart';

class BrassForm extends StatefulWidget {
  BrassForm(
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
  State<BrassForm> createState() => _BrassFormState();
}

class _BrassFormState extends State<BrassForm> {
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
                              initialValue:
                                  widget.blankCartridge.brass.brassManufacture,
                              decoration: const InputDecoration(
                                  hintText: "Ex: Lapua",
                                  labelText: "Brass Manufacture"),
                              onChanged: (value) {
                                widget.blankCartridge.brass.brassManufacture =
                                    value;
                              },
                            ),
                            TextFormField(
                              // TODO: maybe change this to a dropdown menu?
                              initialValue:
                                  widget.blankCartridge.brass.numOfFirings,
                              decoration: const InputDecoration(
                                  hintText: "Ex: 1",
                                  labelText: "Number of Firings"),
                              onChanged: (value) {
                                widget.blankCartridge.brass.numOfFirings =
                                    value;
                              },
                            ),
                            TextFormField(
                              initialValue:
                                  widget.blankCartridge.brass.brassLotNumber,
                              decoration: const InputDecoration(
                                  hintText: "Ex: 0",
                                  labelText: "Brass Lot Number"),
                              onChanged: (value) {
                                widget.blankCartridge.brass.brassLotNumber =
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
                            builder: (context) => PrimerForm(
                                  loadObjects: widget.loadObjects,
                                  fireArmObjects: widget.fireArmObjects,
                                  blankCartridge: widget.blankCartridge,
                                  titleString: "Primer Information",
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
