import 'package:flutter/material.dart';
import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';
import 'package:measure_group/classes/class_inc_var_test.dart';
import 'package:measure_group/widgets/wid_test_group_measure.dart';
import 'package:measure_group/module/mod_wrap_obj_to_json.dart' as rewrap;
import 'package:measure_group/module/mod_save_json.dart' as save_json;

// serves as the create and edit screens for building/editing a cartridge
// bullet_form -> powder_form -> brass_form -> primer_form -> cartridge_form
// going to dynamically create widgets that represent tested variable and
// the corresponding shot group.
// Input: loadObjects and fireArmObjects are complete lists of the users
// cartridges and firearms. emptyTest is a shell object for collecting all the
// tested variables and shot groups. The previous screen needs to create those
// variable/shot groups (empty) and insert them into emptyTest. index of loadobjects so we know
// which cartridge we are messing with. titleString is SE. disabledBackArrow so
// we can force the user to move through the entire screen; use create screen for
// updates.

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
  //String? dropDownValue;
  bool isButtonDiasabled = false;

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

  Future bottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Measure Group'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TestGroupMeasurer(
                                loadObjects: widget.loadObjects,
                                fireArmObjects: widget.fireArmObjects,
                                emptyTest: widget.emptyTest,
                                index: widget.index,
                              )));
                },
              ),
            ],
          );
        });
  }

  Widget listBuilder(IncrementVarTest test) {
    return ListView.builder(
        itemCount: widget.emptyTest.varGroupList.length,
        scrollDirection: Axis.vertical,
        //shrinkWrap: true,
        itemBuilder: (context, index) {
          return newGroupWidget(widget.emptyTest, index);
        });
  }

  Widget newGroupWidget(IncrementVarTest test, int index) {
    // creates empty cha
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text("Group ${index + 1}"),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                bottomSheet();
              },
            ),
          ),
          ListTile(
            subtitle: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue:
                        test.varGroupList[index].chargeWeight.toString(),
                    decoration: const InputDecoration(
                        //hintText: "Ex: 2.2",
                        labelText: "Charge Weight"),
                    onChanged: (value) {
                      // TODO: validation on string to double
                      test.varGroupList[index].chargeWeight =
                          double.parse(value);
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
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
                ),
                Expanded(
                  child: TextFormField(
                    initialValue:
                        test.varGroupList[index].group.numShots.toString(),
                    decoration: const InputDecoration(
                        //hintText: "Ex: 2.2",
                        labelText: "Number Of Shots"),
                    onChanged: (value) {
                      // TODO: validation on string to double
                      test.varGroupList[index].group.numShots =
                          int.parse(value);
                    },
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            subtitle: Row(
              children: [
                Expanded(
                  child: TextFormField(
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
                ),
                Expanded(
                  child: TextFormField(
                    initialValue:
                        test.varGroupList[index].group.minVelocity.toString(),
                    decoration: const InputDecoration(
                        //hintText: "Ex: 2.2",
                        labelText: "Minimum Velocity"),
                    onChanged: (value) {
                      // TODO: validation on string to double
                      test.varGroupList[index].group.minVelocity =
                          double.parse(value);
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    initialValue:
                        test.varGroupList[index].group.maxVelocity.toString(),
                    decoration: const InputDecoration(
                        //hintText: "Ex: 2.2",
                        labelText: "Maximum Velocity"),
                    onChanged: (value) {
                      // TODO: validation on string to double
                      test.varGroupList[index].group.maxVelocity =
                          double.parse(value);
                    },
                  ),
                )
              ],
            ),
          ),
          ListTile(
            subtitle: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: test.varGroupList[index].group.standDeviation
                        .toString(),
                    decoration: const InputDecoration(
                        //hintText: "Ex: 2.2",
                        labelText: "Standard Deviation"),
                    onChanged: (value) {
                      // TODO: validation on string to double
                      test.varGroupList[index].group.standDeviation =
                          double.parse(value);
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    initialValue:
                        test.varGroupList[index].group.extremeSpread.toString(),
                    decoration: const InputDecoration(
                        //hintText: "Ex: 2.2",
                        labelText: "Extreme Spread"),
                    onChanged: (value) {
                      // TODO: validation on string to double
                      test.varGroupList[index].group.extremeSpread =
                          double.parse(value);
                    },
                  ),
                )
              ],
            ),
          ),
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
            padding: const EdgeInsets.all(5),
            child: Form(
                key: formKey,
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: listBuilder(widget.emptyTest),
                      )),
                      ElevatedButton(
                        // adds widget.emptyTest to current cartridge
                        // package and save
                        // pop back to previous page and send updated data, no
                        // cloud reload needed
                        onPressed: widget.isButtonDiasabled
                            ? null
                            : () {
                                //widget.loadObjects[widget.index].tests
                                //    .add(widget.emptyTest);
                                widget.emptyTest.smallestAndLargestGroup();
                                final newJson = rewrap.rewrap(
                                    widget.loadObjects, widget.fireArmObjects);
                                save_json.writeJson(newJson);
                                // moves back to LoadDetail screen with newly added test
                                int count = 0;
                                Navigator.popUntil(context, (route) {
                                  return count++ == 1;
                                });
                              },

                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder()),
                        child: const Text('Finish'),
                      ),
                    ],
                  ),
                ))));
  }
}
