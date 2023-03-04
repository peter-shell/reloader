import 'package:test/test.dart';
import 'package:measure_group/classes/class_cartridge.dart';

import 'package:measure_group/test/updated_data.dart' as cart;

void main() {
  final data = cart.testData['loads']![0];
  //print(cart);

  Cartridge cartridge = Cartridge.fromJson(data);

  var cartData = cartridge.toJson();

  test('check bullet.caliber', (() {
    expect("6.5 Creedmoor", cartridge.bullet.bulletCaliber);
  }));

  test('check powder.powderManufacture', (() {
    expect("Hodgedon", cartridge.powder.powderManufacture);
  }));

  test('check brass.powerNotes[o].note', (() {
    expect(
        "this is a brass note. It's a place to talk about your love for components.",
        cartridge.brass.brassNotes[0].note);
  }));

  test('check primer.powerNotes[o].note', (() {
    expect(
        "this is a primer note. It's a place to talk about your love for components.",
        cartridge.primer.primerNotes[0].note);
  }));

  test('compare json to object generated json', (() {
    expect(cartData, data);
  }));
}
