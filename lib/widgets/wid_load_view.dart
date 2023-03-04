import 'package:flutter/material.dart';
import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:measure_group/module/mod_wrap_obj_to_json.dart' as rewrap;
import 'package:measure_group/module/mod_save_json.dart' as save_json;
import 'package:measure_group/widgets/wid_bullet_form.dart';
import 'package:measure_group/widgets/wid_load_detail.dart';

class LoadsView extends StatefulWidget {
  LoadsView(
      {super.key, required this.loadObjects, required this.fireArmObjects});
  List<Cartridge> loadObjects;
  List<FireArm> fireArmObjects;

  @override
  State<LoadsView> createState() => _LoadsViewState();
}

class _LoadsViewState extends State<LoadsView> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      child: widget.loadObjects.isNotEmpty
          ? Expanded(
              child: ListView.builder(
                itemCount: widget.loadObjects.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: ((context) {
                            Cartridge updateCartridge =
                                widget.loadObjects.removeAt(index);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    // TODO: need to take care of back button here. the current cartridge is popped from
                                    // the list. Maybe editing in the list is appropriate, maybe forcing the user to move
                                    // through all the screens.
                                    builder: (context) => BulletForm(
                                          loadObjects: widget.loadObjects,
                                          fireArmObjects: widget.fireArmObjects,
                                          blankCartridge: updateCartridge,
                                          titleString: "Bullet Information",
                                          arrow: false,
                                        ))).then((value) => setState(() {}));
                          }),
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          icon: Icons.more_horiz,
                          label: 'Edit',
                        ),
                        SlidableAction(
                          // An action can be bigger than the others.

                          onPressed: ((context) {
                            widget.loadObjects.removeAt(index);
                            var newJsonData = rewrap.rewrap(
                                widget.loadObjects, widget.fireArmObjects);
                            save_json.writeJson(newJsonData);
                            setState(() {});
                          }),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Card(
                      margin: const EdgeInsets.all(2),
                      child: ListTile(
                        onTap: () {
                          // detailed view
                          // sends index
                          // int loadIndex = index;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoadDetail(
                                      loadObjects: widget.loadObjects,
                                      fireArmObjects: widget.fireArmObjects,
                                      index: index)));
                        },
                        leading: Text(
                            widget.loadObjects[index].bullet.bulletCaliber),
                        title: Text(
                            "${widget.loadObjects[index].bullet.bulletWeight}gr ${widget.loadObjects[index].bullet.bulletManufacture} ${widget.loadObjects[index].bullet.bulletName}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${widget.loadObjects[index].powderWeight} of ${widget.loadObjects[index].powder.powderName}"),
                            Text(
                                "${widget.loadObjects[index].brass.brassManufacture} brass with ${widget.loadObjects[index].primer.primerManufacture} ${widget.loadObjects[index].primer.primerName} primers"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : Container(),
    );
  }
}

void deleteCartridge(int index, List<Cartridge> loadObjects) {
  loadObjects.removeAt(index);
}
