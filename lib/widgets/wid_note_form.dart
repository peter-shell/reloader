import 'dart:developer' as log;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';
import 'package:measure_group/classes/class_note.dart';
import 'package:measure_group/module/mod_wrap_obj_to_json.dart' as rewrap;
import 'package:measure_group/module/mod_save_json.dart' as save_json;

class NoteForm extends StatefulWidget {
  NoteForm(
      {super.key,
      required this.loadObjects,
      required this.fireArmObjects,
      required this.blankNote,
      required this.titleString,
      required this.loadIndex,
      required this.noteType});

  List<Cartridge> loadObjects;
  List<FireArm> fireArmObjects;
  Note blankNote;
  String titleString;
  int loadIndex;
  int noteType;
  // loadType {0=bullet, 1=powder, 2=brass, 3=primer, 4=cartridge}

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void insertNote() {
      switch (widget.noteType) {
        case 0:
          {
            widget.loadObjects[widget.loadIndex].bullet.bulletNotes
                .insert(0, widget.blankNote);
            break;
          }
        case 1:
          {
            widget.loadObjects[widget.loadIndex].powder.powderNotes
                .insert(0, widget.blankNote);
            break;
          }
        case 2:
          {
            widget.loadObjects[widget.loadIndex].brass.brassNotes
                .insert(0, widget.blankNote);
            break;
          }
        case 3:
          {
            widget.loadObjects[widget.loadIndex].primer.primerNotes
                .insert(0, widget.blankNote);
            break;
          }
        case 4:
          {
            widget.loadObjects[widget.loadIndex].notes
                .insert(0, widget.blankNote);
            break;
          }
        default:
          {
            log.log(
              'failed to create note; $e',
              name: 'wid_note_form',
            );
            break;
          }
      }

      final newJsonData =
          rewrap.rewrap(widget.loadObjects, widget.fireArmObjects);
      save_json.writeJson(newJsonData);
    }

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
                              //initialValue: widget.blankCartridge.powderWeight,
                              decoration: const InputDecoration(
                                  //hintText: "Ex: 41.5",
                                  labelText: "Date"),
                              onChanged: (value) {
                                widget.blankNote.date = value;
                              },
                            ),
                            TextFormField(
                              minLines: 5,
                              maxLines: 25,
                              decoration: const InputDecoration(
                                  //hintText: "Ex: 2.2",
                                  labelText: "Notes"),
                              onChanged: (value) {
                                widget.blankNote.note = value;
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
                    insertNote();
                    Navigator.pop(context);
                  },
                  // TODO: need to add function to package for cloud here
                  // build new object from forms, add to loadsList, convert
                  // lists to json, save, force reload
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Text('Finish'),
                )
              ],
            )),
      ),
    );
  }
}
