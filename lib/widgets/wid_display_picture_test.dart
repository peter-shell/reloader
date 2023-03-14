import 'package:flutter/material.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreenTest extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreenTest({super.key, required this.imagePath});

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

// input: 0 for top, 1 for left
// output: returns top or left position as double
double getcoordinates(int position) {
  // convert icon.global positions to image.local positons
  // image local to global
  // set green icon to global
  RenderBox imageBox = imageKey.currentContext?.findRenderObject() as RenderBox;
  RenderBox iconBox = iconKey.currentContext?.findRenderObject() as RenderBox;
  Offset iconPositions = iconBox.localToGlobal(Offset.zero);
  Offset globalToLocalImage = imageBox.globalToLocal(iconPositions);
  if (position == 0) {
    return globalToLocalImage.dy;
  }
  if (position == 1) {
    return globalToLocalImage.dx;
  } else {
    return 0;
  }
}

var myStack = <Widget>[]; // used to dynamically insert widgets into stack
GlobalKey imageKey = GlobalKey(); // tied to group image in stack
GlobalKey iconKey = GlobalKey(); // tied to pink aiming icon
final controller = TransformationController();

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double viewerScale = controller.value.getMaxScaleOnAxis();

    return Scaffold(
        appBar: AppBar(title: const Text('Measure Your Group')),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.

        body: Container(
          alignment: Alignment.center,
          child: Stack(children: [
            InteractiveViewer(
              maxScale: 2,
              minScale: .5,
              constrained: true,
              boundaryMargin: const EdgeInsets.all(double.infinity),
              transformationController: controller,
              onInteractionEnd: (details) {
                viewerScale = controller.value.getMaxScaleOnAxis();
              },

              child: Stack(
                  key: imageKey,
                  children: myStack), // myStack initially contains Image Widget
            ),
            Align(
                alignment: const Alignment(0, 0),
                child: Icon(
                  key: iconKey,
                  Icons.add_circle_outline,
                  color: Colors.pink,
                  size: 50.0,
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    setState(() {
                      myStack.add(Positioned(
                          // bunch of stuff to add here:
                          // select bullet diameter
                          // add individual shot to charge/group linker
                          // add logic to compute group size as shots are added
                          // add dashboard see metrics
                          // add button to save photo to user device
                          // logic to save on firestore, then add group picture to test card
                          // flag for disabling finish button or add to test button

                          // movement direction is correct but scaling needs some work
                          // below.
                          top: getcoordinates(0),
                          left: getcoordinates(1),
                          child: Icon(
                            Icons.add_circle_outline,
                            color: Colors.green,
                            size: 50.0 / viewerScale,
                          )));
                    });
                  },
                  label: const Text('Mark Impact'),
                ),
              ),
            ),
          ]),
        ));
  }
}
