import 'package:flutter/material.dart';
import 'package:measure_group/classes/class_brass.dart';
import 'package:measure_group/classes/class_inc_var_test.dart';
import 'package:measure_group/classes/class_note.dart';
import 'package:measure_group/classes/class_powder.dart';
import 'package:measure_group/classes/class_primer.dart';
import 'package:measure_group/module/mod_wrap_obj_to_json.dart' as rewrap;
import 'package:measure_group/module/mod_save_json.dart' as save_json;
import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';
import 'package:measure_group/classes/class_bullet.dart';
import 'package:measure_group/widgets/wid_create_test.dart';
import 'package:measure_group/widgets/wid_note_form.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class LoadDetail extends StatefulWidget {
  LoadDetail(
      {super.key,
      required this.loadObjects,
      required this.fireArmObjects,
      required this.index});
  List<Cartridge> loadObjects;
  List<FireArm> fireArmObjects;
  int index;

  @override
  State<LoadDetail> createState() => _LoadDetailState();
}

class _LoadDetailState extends State<LoadDetail> {
  @override
  Widget build(BuildContext context) {
    // setting to variables so I don't have to type all this out everytime
    // I reference .bullet.weight, etc..
    Bullet bullet = widget.loadObjects[widget.index].bullet;
    Powder powder = widget.loadObjects[widget.index].powder;
    Brass brass = widget.loadObjects[widget.index].brass;
    Primer primer = widget.loadObjects[widget.index].primer;
    Cartridge cartridge = widget.loadObjects[widget.index];

    void deleteNote(index, list) {
      list.removeAt(index);
      final newJson = rewrap.rewrap(widget.loadObjects, widget.fireArmObjects);
      save_json.writeJson(newJson);
      setState(() {});
    }

    Widget noteSliders(List<dynamic> list) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Slidable(
                endActionPane:
                    ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                    onPressed: ((context) {
                      deleteNote(index, list);
                    }),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.remove,
                    label: 'Delete',
                  )
                ]),
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            list[index].date,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(list[index].note),
                          )
                        ],
                      )
                    ],
                  ),
                ));
          });
    }

    Widget noteButton(int typeNote) {
      return ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NoteForm(
                          loadObjects: widget.loadObjects,
                          fireArmObjects: widget.fireArmObjects,
                          blankNote: Note(date: "", note: ""),
                          titleString: "New Note",
                          loadIndex: widget.index,
                          noteType: typeNote,
                        ))).then((value) => setState(() {}));
          },
          child: const Text("Add Note"));
    }

    Widget bulletInfo = Card(
      margin: EdgeInsets.all(5),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                        "Bullet: ${bullet.bulletWeight}gr ${bullet.bulletManufacture} ${bullet.bulletName}")
                  ],
                ),
                Row(
                  children: [
                    Text("Lot: ${bullet.bulletLotNumber}"),
                  ],
                ),
                Row(
                  children: [Text("Diameter: ${bullet.bulletDiameter}")],
                ),
                Row(
                  children: [
                    Text("G1 BC: ${bullet.g1bc}"),
                  ],
                ),
                Row(
                  children: [Text("G7 BC: ${bullet.g7bc}")],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [noteButton(0)],
            ),
          ],
        ),
        widget.loadObjects[widget.index].bullet.bulletNotes.isNotEmpty
            ? noteSliders(widget.loadObjects[widget.index].bullet.bulletNotes)
            : Container()
      ]),
    );

    Widget powderInfo = Card(
      margin: EdgeInsets.all(5),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                        "Powder: ${powder.powderManufacture} ${powder.powderName}")
                  ],
                ),
                Row(
                  children: [
                    Text("Lot: ${powder.powderLotNumber}"),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [noteButton(1)],
            ),
          ],
        ),
        widget.loadObjects[widget.index].powder.powderNotes.isNotEmpty
            ? noteSliders(widget.loadObjects[widget.index].powder.powderNotes)
            : Container(),
      ]),
    );

    Widget brassInfo = Card(
      margin: EdgeInsets.all(5),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                        "Brass: ${brass.brassManufacture} fired ${brass.numOfFirings} times")
                  ],
                ),
                Row(
                  children: [
                    Text("Lot: ${brass.brassLotNumber}"),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [noteButton(2)],
            ),
          ],
        ),
        widget.loadObjects[widget.index].brass.brassNotes.isNotEmpty
            ? noteSliders(widget.loadObjects[widget.index].brass.brassNotes)
            : Container(),
      ]),
    );

    Widget primerInfo = Card(
      margin: EdgeInsets.all(5),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                        "Brass: ${primer.primerManufacture} ${primer.primerName}")
                  ],
                ),
                Row(
                  children: [
                    Text("Lot: ${primer.primerLotNumber}"),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [noteButton(3)],
            ),
          ],
        ),
        widget.loadObjects[widget.index].primer.primerNotes.isNotEmpty
            ? noteSliders(widget.loadObjects[widget.index].primer.primerNotes)
            : Container(),
      ]),
    );

    Widget cartridgeInfo = Card(
      margin: EdgeInsets.all(5),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [Text("Charge Weight: ${cartridge.powderWeight}")],
                ),
                Row(
                  children: [Text("Trim Length: ${cartridge.trimLength}")],
                ),
                Row(
                  children: [
                    Text("Cartridge Over All Length: ${cartridge.coal}"),
                  ],
                ),
                Row(
                  children: [
                    Text("Cartridge Base To Ojive: ${cartridge.cbto}")
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [noteButton(4)],
            ),
          ],
        ),
        widget.loadObjects[widget.index].notes.isNotEmpty
            ? noteSliders(widget.loadObjects[widget.index].notes)
            : Container(),
      ]),
    );

    Widget testView = Card(
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TestForm(
                                    loadObjects: widget.loadObjects,
                                    fireArmObjects: widget.fireArmObjects,
                                    emptyTest: IncrementVarTest(
                                        varGroupList: [], smallestGroup: 0.0),
                                    index: widget.index,
                                    titleString: "Create Test",
                                    arrow: false)))
                        .then((value) => setState(() {}));
                  },
                  child: const Text("Add Test"))
            ],
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.loadObjects[widget.index].bullet.bulletCaliber)),
      body: SingleChildScrollView(
        child: Column(children: [
          bulletInfo,
          powderInfo,
          brassInfo,
          primerInfo,
          cartridgeInfo,
          testView,
        ]),
      ),
    );
  }
}
