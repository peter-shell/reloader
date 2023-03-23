import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';
import 'package:measure_group/classes/class_group.dart';
import 'package:measure_group/classes/class_inc_var_test.dart';
import 'package:measure_group/widgets/wid_display_picture.dart';
import 'package:measure_group/widgets/wid_display_picture_test.dart';

// broke this widget when I removed it from main.dart. Unsure why but I'm
// pausing to work on another portion of the app

class TestGroupMeasurer extends StatefulWidget {
  TestGroupMeasurer({
    super.key,
    required this.loadObjects,
    required this.fireArmObjects,
    required this.groupToAddShotData,
    required this.index,
    //required this.titleString,
  });
  List<Cartridge> loadObjects;
  List<FireArm> fireArmObjects;
  Group groupToAddShotData;
  int index;
  //String titleString;
  @override
  State<TestGroupMeasurer> createState() => _TestGroupMeasurerState();
}

class _TestGroupMeasurerState extends State<TestGroupMeasurer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
              onPressed: () async {
                try {
                  final image =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (image == null) return;

                  if (!mounted) return;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DisplayPictureScreen(imagePath: image.path)));
                } on PlatformException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to pick image: $e')));
                  // add better error handling here...
                  // print('Failed to pick image: $e');
                }
              },
              child: const Text('Take Photo')),
          ElevatedButton(
            child: const Text('Load Photo'),
            onPressed: () async {
              try {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image == null) return;

                if (!mounted) return;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DisplayPictureScreen(
                              imagePath: image.path,
                            )));
              } on PlatformException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to pick image: $e')));
                // add better error handling here...
                // print('Failed to pick image: $e');
              }
            },
          ),
          ElevatedButton(
              onPressed: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DisplayPictureScreenTest(
                              imagePath: 'assets/images/test.jpg',
                              loadObjects: widget.loadObjects,
                              fireArmObjects: widget.fireArmObjects,
                              groupToAddShotData: widget.groupToAddShotData,
                              index: widget.index,
                              titleString: 'Measure Your Group',
                            )));
              }),
              child: const Text('Test group stuff'))
        ],
      ),
    );
  }
}
