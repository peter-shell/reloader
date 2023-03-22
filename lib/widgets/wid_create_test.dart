import 'package:flutter/material.dart';
import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';
import 'package:measure_group/classes/class_group.dart';
import 'package:measure_group/classes/class_inc_var_test.dart';
import 'package:measure_group/classes/class_var_group_linker_test.dart';
import 'package:measure_group/widgets/wid_view_update_test.dart';

// serves as the create and edit screens for building/editing a cartridge
// bullet_form -> powder_form -> brass_form -> primer_form -> cartridge_form
// TODO: handle back button stuff. What happens when user goes backward on creation
// of objects, what happens when user is updating already created objects

// TODO: form validation!! also control flow through forms

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
  String? dropDownValue;
  bool isButtonDiasabled = true;
  int numVariations = 0;
  double chargeWeightJump = 0.0;
  double startingMeasurement = 0.0;

  List<DropdownMenuItem<String>> testMenuItems = [
    const DropdownMenuItem(
        value: "Select A Test", child: Text("Select A Test")),
    const DropdownMenuItem(
        value: "Charge Weight", child: Text("Charge Weight")),
    const DropdownMenuItem(
        value: "Seating Depth", child: Text("Seating Depth")),
  ];

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
  void initState() {
    widget.dropDownValue = widget.testMenuItems.first.value!;
    super.initState();
  }

  // logic for creating variable/shot group objects
  void createGroups() {
    double charge = widget.startingMeasurement;
    for (int i = 0; i < widget.numVariations; i++) {
      Group myGroup = Group(
          shots: [],
          ctcGroupSize: 0,
          avgVelocity: 0,
          extremeSpread: 0,
          maxVelocity: 0,
          minVelocity: 0,
          standDeviation: 0,
          numShots: 0);
      VarGroupLinker chargeWeight =
          VarGroupLinker(chargeWeight: charge, group: myGroup);
      widget.emptyTest.addGroup(chargeWeight);
      // print(widget.emptyTest.varGroupList[i].chargeWeight);
      charge += widget.chargeWeightJump;
      charge = double.parse(charge.toStringAsFixed(2));
      // charge = double.parse(charge.toStringAsPrecision(1));
    }
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
              child: ListView(children: [
                Card(
                    child: Column(
                  children: [
                    ListTile(title: Text(widget.titleString)),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(children: [
                            DropdownButton<String>(
                              value: widget.dropDownValue,
                              items: widget.testMenuItems,
                              onChanged: (newValue) {
                                setState(() {
                                  widget.dropDownValue = newValue!;
                                  widget.emptyTest.testType = newValue;
                                });
                              },
                            ),
                          ]),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  initialValue: "",
                                  decoration: InputDecoration(
                                      hintText: "Ex: 5",
                                      labelText:
                                          "Enter Number Of ${widget.emptyTest.testType} Variations"),
                                  onChanged: (value) {
                                    widget.numVariations = int.parse(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                    initialValue: "",
                                    decoration: InputDecoration(
                                        hintText: "Ex: .2",
                                        labelText:
                                            "Enter Jump In ${widget.emptyTest.testType}"),
                                    onChanged: (value) {
                                      widget.chargeWeightJump =
                                          double.parse(value);
                                    }),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                    initialValue: "",
                                    decoration: const InputDecoration(
                                        hintText: "Ex: 41.5 or -.2",
                                        labelText:
                                            "Enter Starting Measurement"),
                                    onChanged: (value) {
                                      widget.startingMeasurement =
                                          double.parse(value);
                                      if (value.length > 1) {
                                        widget.isButtonDiasabled = false;
                                        setState(() {});
                                      } else {
                                        widget.isButtonDiasabled = true;
                                      }
                                    }),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      // TODO: fix button width, it's too big right now
                      // isButtonDisabled set by entering value is last TextFormField
                      onPressed: widget.isButtonDiasabled
                          ? null
                          : () {
                              //create groups -> add to tests[]
                              createGroups();
                              widget.loadObjects[widget.index].tests
                                  .insert(0, widget.emptyTest);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => TestViewUpdateForm(
                                            loadObjects: widget.loadObjects,
                                            fireArmObjects:
                                                widget.fireArmObjects,
                                            emptyTest: widget
                                                .loadObjects[widget.index]
                                                .tests[0],
                                            index: widget.index,
                                            titleString: "Tests",
                                            disableBackArrow: false,
                                            numJumpsBack: 2,
                                          ))));
                            },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder()),
                      child: const Text('Create'),
                    )
                  ],
                )),
              ]),
            )));
  }
}
