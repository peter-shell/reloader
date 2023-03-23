import 'package:flutter/material.dart';
import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';
import 'package:measure_group/classes/class_group.dart';
import 'package:measure_group/classes/class_shot.dart';
import 'package:measure_group/module/mod_list_caliber_data.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreenTest extends StatefulWidget {
  final String imagePath;

  DisplayPictureScreenTest({
    super.key,
    required this.imagePath,
    required this.loadObjects,
    required this.fireArmObjects,
    required this.groupToAddShotData,
    required this.index,
    required this.titleString,
  });
  List<Cartridge> loadObjects;
  List<FireArm> fireArmObjects;
  Group groupToAddShotData;
  int index;
  String titleString;
  String? dropDownValue;
  bool fabDisabled = true;

  @override
  State<DisplayPictureScreenTest> createState() =>
      _DisplayPictureScreenTestState();
}

@override
void initState() {
  //final controller = TransformationController();
  controller.value = Matrix4.identity() * 0.5;
  initState();
}

@override
void dispose() {
  controller.dispose();
  dispose();
}

// input: x or y for coords
// output: returns top or left position as double
double getcoordinates(String position) {
  // convert icon.global positions to image.local positons
  // image local to global
  // set green icon to global
  RenderBox imageBox = imageKey.currentContext?.findRenderObject() as RenderBox;
  RenderBox iconBox = iconKey.currentContext?.findRenderObject() as RenderBox;
  Offset iconPositions = iconBox.localToGlobal(Offset.zero);
  Offset globalToLocalImage = imageBox.globalToLocal(iconPositions);
  if (position == "y") {
    return globalToLocalImage.dy;
  }
  if (position == "x") {
    return globalToLocalImage.dx;
  } else {
    return 0;
  }
}

var myStack = <Widget>[]; // used to dynamically insert widgets into stack
GlobalKey imageKey = GlobalKey(); // tied to group image in stack
GlobalKey iconKey = GlobalKey(); // tied to pink aiming icon
final controller = TransformationController();
bool scaleEnabled = true;

class _DisplayPictureScreenTestState extends State<DisplayPictureScreenTest> {
  @override
  void initState() {
    myStack = <Widget>[
      Image.asset(
        // change .asset to .file for async loading
        widget.imagePath,
        //key: key,
      ),
    ];
    // for dropdown button
    widget.dropDownValue = caliberMenuItems.first.value!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double viewerScale = controller.value.getMaxScaleOnAxis();

    return Scaffold(
        appBar: AppBar(title: Text(widget.titleString)),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.

        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Stack(children: [
                  InteractiveViewer(
                    maxScale: 2,
                    minScale: .5,
                    scaleEnabled: scaleEnabled,
                    constrained: true,
                    boundaryMargin: const EdgeInsets.all(double.infinity),
                    transformationController: controller,
                    onInteractionEnd: (details) {
                      viewerScale = controller.value.getMaxScaleOnAxis();
                    },

                    child: Stack(
                        key: imageKey,
                        children:
                            myStack), // myStack initially contains Image Widget
                  ),
                  Align(
                      alignment: const Alignment(0, 0),
                      child: Icon(
                        key: iconKey,
                        Icons.add_circle_outline,
                        color: Colors.pink,
                        size: 50.0,
                      )),
                ]),
              ),
              DropdownButton<String>(
                value: widget.dropDownValue,
                items: caliberMenuItems,
                onChanged: (newValue) {
                  if (newValue != "None") {
                    widget.fabDisabled = false;
                    widget.groupToAddShotData.bulletDiameter =
                        double.parse(newValue!);
                  }
                  if (newValue == "None") {
                    widget.fabDisabled = true;
                  }
                  setState(() {
                    widget.dropDownValue = newValue!;
                  });
                },
              ),
              ListTile(
                subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          "CTC Group Size: ${widget.groupToAddShotData.ctcGroupSize}"),
                      Text(
                          "Number Of Shots: ${widget.groupToAddShotData.shots.length}")
                    ]),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: FloatingActionButton(
                    backgroundColor:
                        widget.fabDisabled ? Colors.grey : Colors.blue,
                    onPressed: widget.fabDisabled
                        ? null
                        : () {
                            setState(() {
                              scaleEnabled =
                                  false; // this works but needs wrapped in a conditional
                              double x = getcoordinates("x");

                              double y = getcoordinates("y");
                              print(x);
                              print(y);
                              myStack.add(Positioned(

                                  // bunch of stuff to add here:
                                  // select bullet diameter
                                  // add individual shot to charge/group linker
                                  // add logic to compute group size as shots are added
                                  // add dashboard see metrics
                                  // add button to save photo to user device
                                  // logic to save on firestore, then add group picture to test card
                                  // flag for disabling finish button or add to test button
                                  top: y,
                                  left: x,
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.green,
                                    size: 50.0 / viewerScale,
                                  )));

                              widget.groupToAddShotData.iconSize = 50.0 /
                                  viewerScale; // only need to set this once, it shouldn't change
                              widget.groupToAddShotData
                                  .addShot(Shot(velocity: 0, xpos: x, ypos: y));
                            });
                          },
                    child: const Text('Mark'),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
