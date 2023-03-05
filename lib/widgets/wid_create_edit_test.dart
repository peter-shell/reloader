import 'package:flutter/material.dart';
import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';
import 'package:measure_group/classes/class_inc_var_test.dart';
import 'package:measure_group/widgets/wid_powder_form.dart';

// serves as the create and edit screens for building/editing a cartridge
// bullet_form -> powder_form -> brass_form -> primer_form -> cartridge_form
class TestForm extends StatefulWidget {
  TestForm(
      {super.key,
      required this.loadObjects,
      required this.fireArmObjects,
      required this.emptyTest,
      required this.index,
      required this.titleString,
      required this.arrow});
  List<Cartridge> loadObjects;
  List<FireArm> fireArmObjects;
  IncrementVarTest emptyTest;
  int index;
  String titleString;
  bool arrow;

  @override
  State<TestForm> createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "select", child: Text("select a test")),
      const DropdownMenuItem(
          value: "charge weight", child: Text("Charge Weigh")),
      const DropdownMenuItem(
          value: "seating depth", child: Text("Seating Depth")),
    ];

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
              child: ListView(children: [
                Card(
                    child: Column(
                  children: [
                    ListTile(title: Text(widget.titleString)),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              DropdownButton(
                                value: widget.emptyTest.testType,
                                items: menuItems,
                                onChanged: (newValue) {
                                  setState(() {
                                    widget.emptyTest.testType = newValue!;
                                  });
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      // TODO: fix button width, it's too big right now
                      onPressed: () {},
                      // pass firearms, loads, bullet to next screen

                      // TODO: need to add function to package for cloud here
                      // build new object from forms, add to loadsList, convert
                      // lists to json, save, force reload
                      // formKey.currentState.validate();
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder()),
                      child: const Text('Next'),
                    )
                  ],
                )),
              ]),
            )));
  }
}
