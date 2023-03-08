import 'package:flutter/material.dart';
import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';
import 'package:measure_group/classes/class_inc_var_test.dart';

// serves as the create and edit screens for building/editing a cartridge
// bullet_form -> powder_form -> brass_form -> primer_form -> cartridge_form
class TestViewUpdateForm extends StatefulWidget {
  TestViewUpdateForm(
      {super.key,
      required this.loadObjects,
      required this.fireArmObjects,
      required this.emptyTest,
      required this.index,
      required this.titleString,
      required this.disableBackArrow});
  List<Cartridge> loadObjects;
  List<FireArm> fireArmObjects;
  IncrementVarTest emptyTest;
  int index;
  String titleString;
  bool disableBackArrow;
  String? dropDownValue;
  bool isButtonDiasabled = true;
  double numVariations = 0.0;
  double chargeWeightJump = 0.0;

  @override
  State<TestViewUpdateForm> createState() => _TestViewUpdateFormState();
}

class _TestViewUpdateFormState extends State<TestViewUpdateForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Function addGroup() {
    return () {};
  }

  Widget listBuilder(IncrementVarTest test) {
    return Container(
      child: Expanded(
        child: ListView.builder(
            itemCount: widget.emptyTest.chargesAndGroups!.length,
            itemBuilder: (context, index) {
              return newGroupWidget(widget.emptyTest, index);
            }),
      ),
    );
  }

  Widget newGroupWidget(IncrementVarTest test, int index) {
    // creates empty cha
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              TextFormField(
                initialValue: test.varGroupList[index].chargeWeight.toString(),
                decoration: const InputDecoration(
                    //hintText: "Ex: 2.2",
                    labelText: "Charge Weight"),
                onChanged: (value) {
                  // TODO: validation on string to double
                  test.varGroupList[index].chargeWeight = double.parse(value);
                },
              ),
              TextFormField(
                initialValue:
                    test.varGroupList[index].group.ctcGroupSize.toString(),
                decoration: const InputDecoration(
                    //hintText: "Ex: 2.2",
                    labelText: "Group Size"),
                onChanged: (value) {
                  // TODO: validation on string to double
                  test.varGroupList[index].group.ctcGroupSize =
                      double.parse(value);
                },
              ),
              TextFormField(
                initialValue:
                    test.varGroupList[index].group.numShots.toString(),
                decoration: const InputDecoration(
                    //hintText: "Ex: 2.2",
                    labelText: "Group Size"),
                onChanged: (value) {
                  // TODO: validation on string to double
                  test.varGroupList[index].group.numShots = double.parse(value);
                },
              ),
            ],
          ),
          Row(
            children: [
              TextFormField(
                initialValue:
                    test.varGroupList[index].group.avgVelocity.toString(),
                decoration: const InputDecoration(
                    //hintText: "Ex: 2.2",
                    labelText: "Average Velocity"),
                onChanged: (value) {
                  // TODO: validation on string to double
                  test.varGroupList[index].group.avgVelocity =
                      double.parse(value);
                },
              ),
              TextFormField(
                initialValue:
                    test.varGroupList[index].group.minVelocity.toString(),
                decoration: const InputDecoration(
                    //hintText: "Ex: 2.2",
                    labelText: "Average Velocity"),
                onChanged: (value) {
                  // TODO: validation on string to double
                  test.varGroupList[index].group.minVelocity =
                      double.parse(value);
                },
              ),
              TextFormField(
                initialValue:
                    test.varGroupList[index].group.maxVelocity.toString(),
                decoration: const InputDecoration(
                    //hintText: "Ex: 2.2",
                    labelText: "Average Velocity"),
                onChanged: (value) {
                  // TODO: validation on string to double
                  test.varGroupList[index].group.maxVelocity =
                      double.parse(value);
                },
              )
            ],
          ),
          Row(
            children: [
              TextFormField(
                initialValue:
                    test.varGroupList[index].group.standDeviation.toString(),
                decoration: const InputDecoration(
                    //hintText: "Ex: 2.2",
                    labelText: "Average Velocity"),
                onChanged: (value) {
                  // TODO: validation on string to double
                  test.varGroupList[index].group.standDeviation =
                      double.parse(value);
                },
              ),
              TextFormField(
                initialValue:
                    test.varGroupList[index].group.extremeSpread.toString(),
                decoration: const InputDecoration(
                    //hintText: "Ex: 2.2",
                    labelText: "Average Velocity"),
                onChanged: (value) {
                  // TODO: validation on string to double
                  test.varGroupList[index].group.extremeSpread =
                      double.parse(value);
                },
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.titleString),
          automaticallyImplyLeading: widget.disableBackArrow,
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: ListView(children: [
                Card(
                    child: Column(
                  children: [
                    listBuilder(widget.emptyTest),
                    ElevatedButton(
                      // TODO: fix button width, it's too big right now
                      onPressed: widget.isButtonDiasabled ? null : addGroup,

                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder()),
                      child: const Text('Finish'),
                    )
                  ],
                )),
              ]),
            )));
  }
}
